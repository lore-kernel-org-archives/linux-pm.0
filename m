From: Evan Green <evgreen@chromium.org>
Subject: Re: [RFC] i2c: qup: Use the interconnect API
Date: Fri, 19 Oct 2018 10:37:35 -0700
Message-ID: <CAE=gft4BCgrPCf5UuhxMh8ORCk40C4tnFxWy-QQJ4ag+yObwvg@mail.gmail.com>
References: <20180920182903.19991-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920182903.19991-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: georgi.djakov@linaro.org
Cc: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org, rjw@rjwysocki.net, robh+dt@kernel.org, Michael Turquette <mturquette@baylibre.com>, khilman@baylibre.com, Vincent Guittot <vincent.guittot@linaro.org>, Saravana Kannan <skannan@codeaurora.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, amit.kucheria@linaro.org, seansw@qti.qualcomm.com, daidavid1@codeaurora.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, Alexandre Bailon <abailon@baylibre.com>, maxime.ripard@bootlin.com, Arnd Bergmann <arnd@arndb.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, wsa@the-dreams.de, linux-i2c@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 20, 2018 at 11:29 AM Georgi Djakov <georgi.djakov@linaro.org> wrote:
>
> The interconnect API provides an interface for consumer drivers to express
> their bandwidth needs in the SoC. This data is aggregated and the on-chip
> interconnect hardware is configured to the appropriate power/performance
> profile.
>
> Use the interconnect API to get() the path between the endpoints used for
> data transfers by the I2C QUP and report the needed bandwidth based on the
> i2c mode.
>
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
>
> This patch depends on the interconnect API: https://lkml.org/lkml/2018/8/31/444
>
> TODO: Use a macro for converting and rounding to icc units instead of
> converting between kilobits, kilobytes etc. in the consumer drivers.
>
>  drivers/i2c/busses/i2c-qup.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/drivers/i2c/busses/i2c-qup.c b/drivers/i2c/busses/i2c-qup.c
> index c86c3ae1318f..436747a74dc6 100644
> --- a/drivers/i2c/busses/i2c-qup.c
> +++ b/drivers/i2c/busses/i2c-qup.c
> @@ -14,6 +14,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/err.h>
>  #include <linux/i2c.h>
> +#include <linux/interconnect.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> @@ -280,6 +281,11 @@ struct qup_i2c_dev {
>         void (*read_rx_fifo)(struct qup_i2c_dev *qup);
>         /* function to write tags in tx fifo for i2c read transfer */
>         void (*write_rx_tags)(struct qup_i2c_dev *qup);
> +
> +       /* frequency mode standard */
> +       u32                     clk_freq;
> +       /* interconnect path to scale according to bandwidth needs */
> +       struct icc_path         *path;
>  };
>
>  static irqreturn_t qup_i2c_interrupt(int irq, void *dev)
> @@ -1657,6 +1663,16 @@ static void qup_i2c_disable_clocks(struct qup_i2c_dev *qup)
>         clk_disable_unprepare(qup->pclk);
>  }
>
> +static void qup_i2c_enable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, qup->clk_freq / 8000);

So this specifies an average bandwidth of zero, and a peak bandwidth
of freq / 8000? Can you explain why that is the right choice?
Also, where is this 8000 coming from? Can that be a define, and
possibly explained?

> +}
> +
> +static void qup_i2c_disable_icc(struct qup_i2c_dev *qup)
> +{
> +       icc_set(qup->path, 0, 0);
> +}
> +
