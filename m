From: Markus Mayer <mmayer@broadcom.com>
Subject: Re: [RESEND PATCH v2 2/3] cpufreq: brcmstb-avs-cpufreq: AVS CPUfreq
 driver for Broadcom STB SoCs
Date: Thu, 6 Oct 2016 14:04:59 -0700
Message-ID: <20161006210459.GA19063@lbrmn-mmayer.ric.broadcom.com>
References: <1475272561-8446-1-git-send-email-mmayer@broadcom.com>
 <1475272561-8446-3-git-send-email-mmayer@broadcom.com>
 <20161005032509.GG4664@vireshk-i7>
 <CAGt4E5s9UBam4RKsq3k1P77-81NR-8AeQi==7dBNnp37xxtr_g@mail.gmail.com>
 <20161006040139.GA17619@vireshk-i7>
 <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAGt4E5sWLbGO7b7mX5CHKRDbtp5iqaapbV=YUJbRVHyCeJL8nQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>, Device Tree List <devicetree@vger.kernel.org>, Power Management List <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 06, 2016 at 07:51:59AM -0700, Markus Mayer wrote:
> On 5 October 2016 at 21:01, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Thanks for accepting all the comments :)

Unfortunately, I'll have to take back one agreed-upon change.

In this piece of code, brcm_avs_is_firmware_loaded() has to come after
requesting the IRQ.


	priv->base = __map_region(BRCM_AVS_CPU_DATA);
	if (!priv->base) {
		dev_err(dev, "Couldn't find property %s in device tree.\n",
			BRCM_AVS_CPU_DATA);
		return -ENOENT;
	}

	priv->avs_intr_base = __map_region(BRCM_AVS_CPU_INTR);
	if (!priv->avs_intr_base) {
		dev_err(dev, "Couldn't find property %s in device tree.\n",
			BRCM_AVS_CPU_INTR);
		ret = -ENOENT;
		goto unmap_base;
	}

	host_irq = platform_get_irq_byname(pdev, BRCM_AVS_HOST_INTR);
	if (host_irq < 0) {
		dev_err(dev, "Couldn't find interrupt %s -- %d\n",
			BRCM_AVS_HOST_INTR, host_irq);
		ret = host_irq;
		goto unmap_intr_base;
	}

	ret = devm_request_irq(dev, host_irq, irq_handler, IRQF_TRIGGER_RISING,
			       BRCM_AVS_HOST_INTR, priv);
	if (ret) {
		dev_err(dev, "IRQ request failed: %s (%d) -- %d\n",
			BRCM_AVS_HOST_INTR, host_irq, ret);
		goto unmap_intr_base;
	}

	if (brcm_avs_is_firmware_loaded(priv))
		return 0;

The reason being that we need to be ready to receive interrupts from the
co-processor to tell us the GET_PMAP command completed.
brcm_avs_is_firmware_loaded() issues the GET_PMAP command to ensure the
firmware supports it. If I try to run brcm_avs_is_firmware_loaded() before
setting up interrupts, I get a timeout in the driver -- because it never
receives the interrupt saying the command is done.

And I have to check the firmware supports the GET_PMAP command, because it
is possible for somebody to choose to run a firmware that does not support
DVFS, even though the hardware would support it.

> >> Is there an easy way for me to know via the framework whether init is
> >> being called for the first time vs. init is being called on a
> >> different core after a previous attempt to initialize on another core
> >> failed?
> >>
> >> I could use a driver-global variable for the driver to remember if it
> >> has been initialized, but that seems a bit hacky.
> >
> > You don't really need to have any special code here, specially for the case that
> > may never get hit. For example, if we fail to initialize something for CPU0,
> > cpufreq core will try calling this routine for other CPUs as well. I don't think
> > there is anything wrong in letting cpufreq core trying that. Why stop it or
> > return early? It wouldn't happen normally, unless there is a bug in there.
> 
> During early development, when the driver couldn't fully register, I
> would see the init() function called four times, i.e. once for each
> core. If the first call succeeded, that was it. It would only get
> called once. But if it failed, all cores would try to register. And I
> wanted to avoid spilling the same error message four times.
> 
> I'll look at that again. It may have had something to do with how the
> driver worked back then. If it doesn't happen anymore, I'll just get
> rid of this code.

Okay, I looked some more and compared it to what cpufreq-dt is doing to
initialize. That lead me onto the right track. They simply do things they
only want done once via the driver's probe function rather than CPUfreq's
init function. So, I broke my initialization code up into two parts. 
Everything up to checking if the firmware is loaded is now being called from
brcm_avs_cpufreq_probe(). The frequency table code is still being called
from brcm_avs_cpufreq_init().

That means that if the initial hardware checks fail, it won't try again.

Regards,
-Markus
