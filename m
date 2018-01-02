From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 00/12] account for const type of of_device_id.data
Date: Tue,  2 Jan 2018 14:27:56 +0100
Message-ID: <1514899688-27844-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-iio@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lars-Peter Clausen <lars@metafoo.de>, Hartmut Knaack <knaack.h@gmx.de>, linux-mtd@lists.infradead.org, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Maintain const annotations when putting values into the data field of
an of_device_id structure, and afterwards when extracting them from
the data field of such a structure.

This was done using the following semantic patch:
(http://coccinelle.lip6.fr/)

// <smpl>
@r@
identifier i,j;
const struct j *m;
struct i *y;
type T;
expression x,e;
position p;
@@

(
y =@p (T)(of_device_get_match_data(...));
|
x = of_match_node(...);
... when != x = e
(
m = e;
|
y =@p (T)(x->data);
)
)

@s@
identifier r.i,j;
@@

const struct i j = { ... };

@t depends on s disable optional_qualifier@
expression e;
identifier r.i,x,j,n;
struct j *m;
struct i *e1;
position any r.p;
type T;
@@

(
+const
struct i *x;
<+...
(
x =@p 
-   (T)(e)
+   e
|
x =@p e
)
...+>
|
m->@e1 n =@p 
-   (T)(e)
+   e
|
m->@e1 n =@p e
)

@disable optional_qualifier@
identifier t.j,t.n,r.i;
@@

struct j {
  ...
+ const
  struct i *n;
  ...
}

@@
identifier x,s.j;
type T;
@@

struct of_device_id x[] = { ...,
  { .data =
-           (T)
            &j, }, ...};

// </smpl>

---

 drivers/i2c/busses/i2c-rk3x.c               |   16 ++++++++--------
 drivers/iio/common/ssp_sensors/ssp.h        |    2 +-
 drivers/iio/common/ssp_sensors/ssp_dev.c    |    2 +-
 drivers/mtd/spi-nor/fsl-quadspi.c           |    8 ++++----
 drivers/pci/dwc/pcie-qcom.c                 |    4 ++--
 drivers/pinctrl/mvebu/pinctrl-armada-37xx.c |    4 ++--
 drivers/pinctrl/pinctrl-at91-pio4.c         |    4 ++--
 drivers/pinctrl/pinctrl-axp209.c            |    2 +-
 drivers/power/avs/rockchip-io-domain.c      |   24 ++++++++++++------------
 drivers/power/reset/at91-sama5d2_shdwc.c    |    4 ++--
 drivers/power/supply/axp20x_ac_power.c      |    8 ++++----
 drivers/spi/spi-fsl-dspi.c                  |    7 +++----
 drivers/spi/spi-sirf.c                      |    4 ++--
 13 files changed, 44 insertions(+), 44 deletions(-)
