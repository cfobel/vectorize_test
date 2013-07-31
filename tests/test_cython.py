from vectorize_test.exts import test_func
import numpy as np


def star_plus_from_elements(net_block_count, net_elements, beta, out):
    out[:] = np.sqrt(net_elements[:, 1, :] - (net_elements[:, 0, :] *
                                              net_elements[:, 0, :]) /
                     net_block_count + beta)


def main(net_count):
    net_elements = np.empty((2, 2, net_count), dtype='f')
    net_elements[0, 0, :] = 5
    net_elements[0, 1, :] = 100
    net_elements[1, 0, :] = 10
    net_elements[1, 1, :] = 200
    return net_elements


if __name__ == '__main__':
    net_count = 100000
    net_elements = main(net_count)

    c_net_costs = np.zeros((2, net_count), dtype='f')
    star_plus_from_elements(1, net_elements, 0.9, c_net_costs)
