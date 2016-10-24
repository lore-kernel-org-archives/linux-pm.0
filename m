From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 4/4] cpufreq: pxa: convert to clock API
Date: Mon, 24 Oct 2016 09:03:41 +0530
Message-ID: <20161024033341.GA24749@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-5-git-send-email-robert.jarzmik@free.fr>
 <20161018114025.GD11471@vireshk-i7>
 <877f902hh6.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33470 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755702AbcJXDdq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 23 Oct 2016 23:33:46 -0400
Received: by mail-pf0-f177.google.com with SMTP id 128so90090832pfz.0
        for <linux-pm@vger.kernel.org>; Sun, 23 Oct 2016 20:33:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <877f902hh6.fsf@belgarion.home>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 22-10-16, 23:37, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> > On 15-10-16, 21:57, Robert Jarzmik wrote:
> >> As the clock settings have been introduced into the clock pxa drivers,
> >> which are now available to change the CPU clock by themselves, remove
> >> the clock handling from this driver, and rely on pxa clock drivers.
> >> 
> >> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
> >> ---
> >> Since v1: added !OF Kconfig dependency
> >> ---
> >>  drivers/cpufreq/Kconfig.arm      |   2 +-
> >>  drivers/cpufreq/pxa2xx-cpufreq.c | 191 ++++++++-------------------------------
> >>  2 files changed, 40 insertions(+), 153 deletions(-)
> >
> > Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> Okay, after some more testing, I'd like to remove the !OF for next iteration.
> The reason is that I have a usecase where I have a single kernel image with
> devictree support (ie CONFIG_OF=y), but with support for both devicetree and
> legacy platforms. In this case, a platform such as lubbock can boot :
>  - with devicetree
>  - with legacy arch/arm/mach-pxa/lubbock.c
> 
> In this kernel, the !OF Kconfig prevents the legacy version from working, as
> pxa2xx-cpufreq is descarded even if it is needed in the legacy version.
> 
> Therefore, I'd like to respin without this !OF.

I imagined this case last week as well :)

No issues.

-- 
viresh
