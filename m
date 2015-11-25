From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/5] Documentation: devicetree: Add property for
 controlling power saving mode for the us5182 als sensor
Date: Tue, 24 Nov 2015 18:01:30 -0600
Message-ID: <20151125000130.GA21418@rob-hp-laptop>
References: <1448362792-5181-1-git-send-email-adriana.reus@intel.com>
 <1448362792-5181-3-git-send-email-adriana.reus@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1448362792-5181-3-git-send-email-adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 24, 2015 at 12:59:49PM +0200, Adriana Reus wrote:
> Add a property to allow changing the default power-saving mode.
> By default, at read raw the chip will activate and provide
> one measurent, then it will shut itself down. However, the
> chip can also work in "continuous" mode which may be more reliable
> but is also more power consuming.
> 
> Signed-off-by: Adriana Reus <adriana.reus-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/iio/light/us5182d.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/us5182d.txt b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> index 6f0a530..a619799 100644
> --- a/Documentation/devicetree/bindings/iio/light/us5182d.txt
> +++ b/Documentation/devicetree/bindings/iio/light/us5182d.txt
> @@ -7,13 +7,24 @@ Required properties:
>  Optional properties:
>  - upisemi,glass-coef: glass attenuation factor - compensation factor of
>                        resolution 1000 for material transmittance.
> +
>  - upisemi,dark-ths: array of 8 elements containing 16-bit thresholds (adc
>                      counts) corresponding to every scale.
> +
>  - upisemi,upper-dark-gain: 8-bit dark gain compensation factor(4 int and 4
>                             fractional bits - Q4.4) applied when light > threshold
> +
>  - upisemi,lower-dark-gain: 8-bit dark gain compensation factor(4 int and 4
>                             fractional bits - Q4.4) applied when light < threshold
>  
> +- upisemi,continuous: This chip has two power modes: one-shot (chip takes one
> +                      measurement and then shuts itself down) and continuous (
> +                      chip takes continuous measurements). The one-shot mode is
> +                      more power-friendly but the continuous mode may be more
> +                      reliable. If this property is specified the continuous
> +                      mode will be used instead of the default one-shot one for
> +                      raw reads.

I could imagine an OS may want to decide this on its own or use a 
mixture of the modes.

Rob
