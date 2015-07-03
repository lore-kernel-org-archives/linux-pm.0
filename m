From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH RFC v2 09/16] arm: domain: Add platform callbacks for
 domain power on/off
Date: Fri, 3 Jul 2015 13:36:22 +0200
Message-ID: <CAMuHMdWQRy2RMfyeyNz=6AgTDem67a1VogN3RWSJ1Y+9yNFx6g@mail.gmail.com>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
	<1435374156-19214-10-git-send-email-lina.iyer@linaro.org>
	<CAMuHMdULThWEZmyLEK_9WeK6DSNhrQdiZQLWNhi1Q6dwZTkkMg@mail.gmail.com>
	<20150629163201.GA1524@linaro.org>
	<CAMuHMdWL09Loe2EFUMc-kRML7Ckn7a6G1_hvPnaqkDYnhkXjog@mail.gmail.com>
	<20150702193826.GA885@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f53.google.com ([209.85.218.53]:35571 "EHLO
	mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754858AbbGCLgW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Jul 2015 07:36:22 -0400
Received: by oihr66 with SMTP id r66so20431483oih.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2015 04:36:22 -0700 (PDT)
In-Reply-To: <20150702193826.GA885@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>

Hi Lina,

On Thu, Jul 2, 2015 at 9:38 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
> On Tue, Jun 30 2015 at 09:10 -0600, Geert Uytterhoeven wrote:
>> On Mon, Jun 29, 2015 at 6:32 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>>> On Mon, Jun 29 2015 at 07:36 -0600, Geert Uytterhoeven wrote:
>
>> Perhaps the generic one can be optional, and provide helpers for common
>> CPU operations? Then the platform-specific driver can handle all PM
>> domains,
>> and delegate to the generic CPU helpers where appropriate.
>>
>> Does that make sense?
>>
> Well it does. Thanks Geert. My RFC v1 [1] did exacly that. But, it didnt
> fit into the big picture of things well.
>
> Here is where we wanted to head towards, in the long run. Today, we have
> CPU_PM for CPU runtime and we have runtime PM for others, we want to
> unify and move to a generic runtime PM for the CPUs as well. To that
> effort, we want to bring in generic code all into the fold of CPU
> runtime PM and CPU domain runtime PM. A generic CPU PM domain with its
> own genpd callback for ->power_on() and ->power_off() would help handle
> the common power on/off stuff there and possibly call into GIC and
> others that currently use CPU_PM from there.  So the common node needs
> to be the handle of power on/off callbacks from the genpd, when all the
> CPUs are entering idle or resuming.

Agreed.

> With what you have suggested, the platform driver creates the genpd and
> would pass the CPU genpd to the common code for common operations. (This
> was what was done in [1]). The platform driver would set the power_on()
> and power_off() callbacks and that would have to be overriden in order
> handle common CPU domain suspend/resume activities. Overwriting members
> of an object allocated by the platform driver, is something we should
> avoid.

Instead of letting the generic code override the .power_{on,off}() callbacks,
the platform code could call the generic CPU-related methods from its own
.power_{on,off}() callbacks?

struct rmobile_pm_domain already has .suspend() and .resume() methods.
The former is used to e.g. prevent the PM domains containing CPUs to be
powered down (in the absence of cpuidle integration). That requires scanning
the DT for CPUs, and it would indeed be good to have that scanning support
in generic code.
The latter became unused after the removal of sh7372 support, which did have
some cpuidle integration.

> Or instead of allocating the memory in your platform driver for the CPU
> genpd, you could query and get the genpd and then add your additions on
> top. You could add other flags like GENPD_FLAG_PM_CLK, but *not*
> overwrite the power on/off callbacks in the genpd. They still have to be
> registered separately like in this patch. Again, not every elegant, IMO.

Just wondering, can I set up the .attach_dev() and .detach_dev()?

Actually, for R-Mobile hardware I don't have a need to set GENPD_FLAG_PM_CLK
or .attach_dev() and .detach_dev() for CPU PM domains, as they are only
needed for devices with MSTP clocks. CPU and L2 cache don't have these,
and there are no other devices in e.g. a3sm and a2sl.

The GIC has an MSTP clock, but it's part of a different power domain.

> Another option, that might be cleaner, is that we could have a PM domain
> for CPUs that would set up the compatibility flag to "arm,pd" and you
> could nest that domain inside pd_a2sl and pd_a2kl.
>
> pd_c4: c4@0 {
>         [...]
>         pd_a3sm: a3sm@20 {
>                 [...]
>                 pd_a2sl: a2sl@21 {
>                         reg = <21>;
>                         #power-domain-cells = <0>;
>                         pd_cpu_sl: pd1 { <-- Virtual PM domain
>                                 #power-domain-cells = <0>;
>                         };
>                 };
>         };
> };
>
> cpus {
>         cpu0: cpu@0 {
>                 compatible = "arm,cortex-a15";
>                 power-domains = <&pd_cpu_sl>; <-- here we refer to the
>                                                   virtual PM domain
>                 next-level-cache = <&L2_CA15>;
>        };
>         [...]
> };
>
> This the common code would get its own callbacks and when that genpd
> powers off, the platform genpd would power down. But no new code is
> needed in your platform driver. The benefit is that platform code and
> generic CPU domain code may exist and act in parallel and may only be
> related if specified in the DT and the problem with that approach is
> that this virtual PM domain is not a h/w domain, hence specifying in DT
> is questionable.

Indeed, I don't like this option, as the DT would no longer describe HW,
but the Linux implementation.

So let's continue with your approach, and see how it turns out. We can
always change and improvide code, while changing DT is more complicated.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
