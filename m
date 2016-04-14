From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V3 1/2] thermal: generic-adc: Add DT binding for ADC
 based thermal sensor
Date: Thu, 14 Apr 2016 12:35:40 -0500
Message-ID: <20160414173540.GA23807@rob-hp-laptop>
References: <1460644878-19943-1-git-send-email-ldewangan@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460644878-19943-1-git-send-email-ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 14, 2016 at 08:11:17PM +0530, Laxman Dewangan wrote:
> Sometimes, thermal sensors like NCT thermistors are connected to
> the ADC channel. The temperature is read by reading the voltage
> across the sensor resistance via ADC and referring the lookup
> table for ADC value to temperature.
> 
> Add DT binding doc for the ADC based thermal sensor driver to
> detail the DT property and provide the example for how to use it.
> 
> Signed-off-by: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> ---
> Changes from V1:
> - Make the lookup table to two dimensional instead of single array of linear
>   step of temperature.
> - Remove detailing of IIO frameowrk and drivers.
> - Added proper braces, indenting and labels.
> 
> Changes from V2:
> - Handle comment from Rob for detailing the first and second value of the array
>   and remove @ in the node name.
> 
>  .../bindings/thermal/thermal-generic-adc.txt       | 89 ++++++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/thermal/thermal-generic-adc.txt

Acked-by: Rob Herring <rob-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
