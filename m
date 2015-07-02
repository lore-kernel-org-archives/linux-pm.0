From: Lina Iyer <lina.iyer@linaro.org>
Subject: Re: [PATCH RFC v2 09/16] arm: domain: Add platform callbacks for
 domain power on/off
Date: Thu, 2 Jul 2015 13:38:26 -0600
Message-ID: <20150702193826.GA885@linaro.org>
References: <1435374156-19214-1-git-send-email-lina.iyer@linaro.org>
 <1435374156-19214-10-git-send-email-lina.iyer@linaro.org>
 <CAMuHMdULThWEZmyLEK_9WeK6DSNhrQdiZQLWNhi1Q6dwZTkkMg@mail.gmail.com>
 <20150629163201.GA1524@linaro.org>
 <CAMuHMdWL09Loe2EFUMc-kRML7Ckn7a6G1_hvPnaqkDYnhkXjog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36495 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754039AbbGBTi3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jul 2015 15:38:29 -0400
Received: by pdcu2 with SMTP id u2so50999881pdc.3
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2015 12:38:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAMuHMdWL09Loe2EFUMc-kRML7Ckn7a6G1_hvPnaqkDYnhkXjog@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Kevin Hilman <khilman@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>, Krzysztof =?utf-8?Q?Koz=C5=82owski?= <k.kozlowski@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, msivasub@codeaurora.org, agross@codeaurora.org

On Tue, Jun 30 2015 at 09:10 -0600, Geert Uytterhoeven wrote:
>Hi Lina,
>
>On Mon, Jun 29, 2015 at 6:32 PM, Lina Iyer <lina.iyer@linaro.org> wrote:
>> On Mon, Jun 29 2015 at 07:36 -0600, Geert Uytterhoeven wrote:

>Perhaps the generic one can be optional, and provide helpers for common
>CPU operations? Then the platform-specific driver can handle all PM domains,
>and delegate to the generic CPU helpers where appropriate.
>
>Does that make sense?
>
Well it does. Thanks Geert. My RFC v1 [1] did exacly that. But, it didnt
fit into the big picture of things well.

Here is where we wanted to head towards, in the long run. Today, we have
CPU_PM for CPU runtime and we have runtime PM for others, we want to
unify and move to a generic runtime PM for the CPUs as well. To that
effort, we want to bring in generic code all into the fold of CPU
runtime PM and CPU domain runtime PM. A generic CPU PM domain with its
own genpd callback for ->power_on() and ->power_off() would help handle
the common power on/off stuff there and possibly call into GIC and
others that currently use CPU_PM from there.  So the common node needs
to be the handle of power on/off callbacks from the genpd, when all the
CPUs are entering idle or resuming.

With what you have suggested, the platform driver creates the genpd and
would pass the CPU genpd to the common code for common operations. (This
was what was done in [1]). The platform driver would set the power_on()
and power_off() callbacks and that would have to be overriden in order
handle common CPU domain suspend/resume activities. Overwriting members
of an object allocated by the platform driver, is something we should
avoid.

Or instead of allocating the memory in your platform driver for the CPU
genpd, you could query and get the genpd and then add your additions on
top. You could add other flags like GENPD_FLAG_PM_CLK, but *not*
overwrite the power on/off callbacks in the genpd. They still have to be
registered separately like in this patch. Again, not every elegant, IMO.

Another option, that might be cleaner, is that we could have a PM domain
for CPUs that would set up the compatibility flag to "arm,pd" and you
could nest that domain inside pd_a2sl and pd_a2kl.

pd_c4: c4@0 {
	[...]
	pd_a3sm: a3sm@20 {
		[...]
		pd_a2sl: a2sl@21 {
			reg = <21>;
			#power-domain-cells = <0>;
			pd_cpu_sl: pd1 { <-- Virtual PM domain
				#power-domain-cells = <0>;
			};
		};
	};
};

cpus {
	cpu0: cpu@0 {
		compatible = "arm,cortex-a15";
		power-domains = <&pd_cpu_sl>; <-- here we refer to the
						  virtual PM domain
		next-level-cache = <&L2_CA15>;
        };
	[...]
};

This the common code would get its own callbacks and when that genpd
powers off, the platform genpd would power down. But no new code is
needed in your platform driver. The benefit is that platform code and
generic CPU domain code may exist and act in parallel and may only be
related if specified in the DT and the problem with that approach is
that this virtual PM domain is not a h/w domain, hence specifying in DT
is questionable.

What do you think?

Thanks,
Lina

[1]. http://www.spinics.net/lists/arm-kernel/msg423430.html
