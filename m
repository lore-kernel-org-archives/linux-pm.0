From: abailon@baylibre.com
Subject: [RFC PATCH 0/2] iMX7ULP interconnect framework
Date: Sat, 17 Nov 2018 12:19:03 +0100
Message-ID: <20181117111905.29091-1-abailon@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Bailon <abailon@abailon.com>
List-Id: linux-pm@vger.kernel.org

From: Alexandre Bailon <abailon@abailon.com>

The goal of this patchset is to use the interconnect framework
for iMX7ULP SoC.
This is sent as a RFC because I think the driver could be more generic,
and, I had some issues with the clocks and I know the way I dealt with
it is probably not the best one.
In addition, this patchset has been written and tested on older kernel
(4.9), and I don't expect it to applies / works on upstream kernel
(the support of SoC itself is still not there).

There are two interconnects, NIC0 and NIC1:

     //==============================\\
     || --------------------          ||
     \\=|m0              s0|=         ||
       =|m1              s1|===\\     ||
       =|m2     NIC0     s2|=   ||    ||
       =|m3                |    ||    ||
       =|m4                |    ||    ||
        --------------------    ||    ||
            //=================//     ||      
            ||  --------------------  ||
            \\==|m0              s0|=//
               =|m1              s1|=
               =|m2    NIC1      s2|=
               =|m3              s4|=
               =|m4              s5|=
               =|m5                |
                --------------------

     -------          -------          
NIC0 | DIV | NIC0 DIV | DIV | NIC1 DIV 
-----|     |----------|     |---------
     -------          -------

Although NIC0 and NIC1 are interconnected, some requests could apply to
only one of them. This could cause some issues with clock.
Basically, scaling the frequency of NIC0 will also scale the frequency of
NIC1, so we have to update both of them.
Simillarly, updating the frequency of NIC1 may also require to change NIC0
frequency.
In order to easily deal with it, the driver create only one device for the
two interconnects, and update clock frequency of both interconnects at same
time, when the last node is reached.

Ideally, we would have two device, which would make the driver more
generic, but currently, I'm not sure how to make sure that the clocks are
always at the expected frequency. Doing that would give us the possiblity to
use the driver for other iMX SoC (would just require to add the bus topology 
for that SoC).

Alexandre Bailon (2):
  Add support of imx7ulp to interconnect framework
  dt-bindings: interconnect: Document imx7ulp interconnect bindings

 .../bindings/interconnect/imx7ulp.txt         |  17 +
 drivers/interconnect/Kconfig                  |   1 +
 drivers/interconnect/Makefile                 |   1 +
 drivers/interconnect/imx/Kconfig              |   9 +
 drivers/interconnect/imx/Makefile             |   1 +
 drivers/interconnect/imx/imx7ulp.c            | 369 ++++++++++++++++++
 6 files changed, 398 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/imx7ulp.txt
 create mode 100644 drivers/interconnect/imx/Kconfig
 create mode 100644 drivers/interconnect/imx/Makefile
 create mode 100644 drivers/interconnect/imx/imx7ulp.c

-- 
2.18.1
