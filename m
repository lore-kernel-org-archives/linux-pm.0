From: Peter Rosin <peda@axentia.se>
Subject: Re: [PATCH v8 5/9] i2c: mux: pca954x: Return error if
 irq_create_mapping fails
Date: Tue, 18 Jul 2017 22:41:49 +0200
Message-ID: <418700bb-0c21-eed2-1342-66cfa74e72e2@axentia.se>
References: <1500365984-61404-1-git-send-email-preid@electromag.com.au>
 <1500365984-61404-6-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <1500365984-61404-6-git-send-email-preid@electromag.com.au>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>, wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, benjamin.tissoires@redhat.com, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Really minor nits, don't respin over this, but if you do respin over
something else, please fix these as well.

On 2017-07-18 10:19, Phil Reid wrote:
> irq_create_mapping can return an error, report error to log and return.
> Cleanup will occur inprobe function when an error is returned.

s/inprobe/in the probe/

> 
> Suggested-by: Peter Rosin <peda@axentia.se>
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  drivers/i2c/muxes/i2c-mux-pca954x.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
> index 9867720..0594775 100644
> --- a/drivers/i2c/muxes/i2c-mux-pca954x.c
> +++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
> @@ -309,6 +309,10 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
>  
>  	for (c = 0; c < data->chip->nchans; c++) {
>  		irq = irq_create_mapping(data->irq, c);
> +		if (irq <= 0) {

irq_create_mapping returns an unsigned int, so I'd write that as

		if (!irq) {

Either way,

Acked-by: Peter Rosin <peda@axentia.se>

Cheers,
Peter

> +			dev_err(&client->dev, "failed irq create map\n");
> +			return -EINVAL;
> +		}
>  		irq_set_chip_data(irq, data);
>  		irq_set_chip_and_handler(irq, &pca954x_irq_chip,
>  			handle_simple_irq);
> 
