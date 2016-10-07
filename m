From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND PATCH v2 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
 driver for Broadcom STB SoCs
Date: Fri, 7 Oct 2016 09:11:33 +0530
Message-ID: <20161007034133.GB3954@vireshk-i7>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-3-git-send-email-mmayer@broadcom.com>
 <20161005032509.GG4664@vireshk-i7>
 <CAGt4E5s9UBam4RKsq3k1P77-81NR-8AeQi==7dBNnp37xxtr_g@mail.gmail.com>
 <20161006040139.GA17619@vireshk-i7>
 <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
 <20161006210459.GA19063@lbrmn-mmayer.ric.broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161006210459.GA19063-opzSsqMRwNylyEujtbL6/5Ym1tgvmhRUMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Markus Mayer <mmayer-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "Rafael J . Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Broadcom Kernel List <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Device Tree List <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Power Management List <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 06-10-16, 14:04, Markus Mayer wrote:
> Unfortunately, I'll have to take back one agreed-upon change.
> 
> In this piece of code, brcm_avs_is_firmware_loaded() has to come after
> requesting the IRQ.
> 
> 
> 	priv->base = __map_region(BRCM_AVS_CPU_DATA);
> 	if (!priv->base) {
> 		dev_err(dev, "Couldn't find property %s in device tree.\n",
> 			BRCM_AVS_CPU_DATA);
> 		return -ENOENT;
> 	}
> 
> 	priv->avs_intr_base = __map_region(BRCM_AVS_CPU_INTR);
> 	if (!priv->avs_intr_base) {
> 		dev_err(dev, "Couldn't find property %s in device tree.\n",
> 			BRCM_AVS_CPU_INTR);
> 		ret = -ENOENT;
> 		goto unmap_base;
> 	}
> 
> 	host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
> 	if (host_irq < 0) {
> 		dev_err(dev, "Couldn't find interrupt %s -- %d\n",
> 			BRCM_AVS_HOST_INTR, host_irq);
> 		ret = host_irq;
> 		goto unmap_intr_base;
> 	}
> 
> 	ret = devm_request_irq(dev, host_irq, irq_handler, IRQF_TRIGGER_RISING,
> 			       BRCM_AVS_HOST_INTR, priv);
> 	if (ret) {
> 		dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
> 			BRCM_AVS_HOST_INTR, host_irq, ret);
> 		goto unmap_intr_base;
> 	}
> 
> 	if (brcm_avs_is_firmware_loaded(priv))
> 		return 0;
> 
> The reason being that we need to be ready to receive interrupts from the
> co-processor to tell us the GET_PMAP command completed.
> brcm_avs_is_firmware_loaded() issues the GET_PMAP command to ensure the
> firmware supports it. If I try to run brcm_avs_is_firmware_loaded() before
> setting up interrupts, I get a timeout in the driver -- because it never
> receives the interrupt saying the command is done.
> 
> And I have to check the firmware supports the GET_PMAP command, because it
> is possible for somebody to choose to run a firmware that does not support
> DVFS, even though the hardware would support it.

Fair enough.

> Okay, I looked some more and compared it to what cpufreq-dt is doing to
> initialize. That lead me onto the right track. They simply do things they
> only want done once via the driver's probe function rather than CPUfreq's
> init function. So, I broke my initialization code up into two parts. 

I wanted to suggest that earlier, but then didn't do it :)

> Everything up to checking if the firmware is loaded is now being called from
> brcm_avs_cpufreq_probe(). The frequency table code is still being called
> from brcm_avs_cpufreq_init().

Looks fine.

> That means that if the initial hardware checks fail, it won't try again.

Yeah, but if init fails for some reason, then it will get called again for other
CPUs. Which is of course the right thing IMO.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
