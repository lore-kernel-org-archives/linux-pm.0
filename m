From: Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH v2 09/25] iio: adc: axp20x_adc: map acin_i and acin_v
Date: Sat, 28 Jan 2017 14:51:13 +0000
Message-ID: <cff80632-3988-975f-3cbb-df5cacec78dc@kernel.org>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
 <20170127085458.18270-10-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170127085458.18270-10-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>, knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com, wens@csie.org, sre@kernel.org, linux@armlinux.org.uk, maxime.ripard@free-electrons.com, lee.jones@linaro.org
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, bonbons@linux-vserver.org, icenowy@aosc.xyz, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 27/01/17 08:54, Quentin Schulz wrote:
> This maps the IIO channels acin_i and acin_v (respectively exposing the
> current current and voltage measures of the AC power supply) to the AC
> power supply driver.
> 
> Only the AXP20X PMICs have these ADC channels and thus they are only
> mapped for this version of the PMIC.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
> 
> added in v2
> 
>  drivers/iio/adc/axp20x_adc.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index bacde92..14f4ec0 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -104,6 +104,14 @@ static struct iio_map axp20x_maps[] = {
>  		.consumer_dev_name = "axp20x-usb-power-supply",
>  		.consumer_channel = "vbus_i",
>  		.adc_channel_label = "vbus_i",
> +	}, {
> +		.consumer_dev_name = "axp20x-ac-power-supply",
> +		.consumer_channel = "acin_v",
> +		.adc_channel_label = "acin_v",
> +	}, {
> +		.consumer_dev_name = "axp20x-ac-power-supply",
> +		.consumer_channel = "acin_i",
> +		.adc_channel_label = "acin_i",
>  	}, { /* sentinel */ }
>  };
>  
> 
