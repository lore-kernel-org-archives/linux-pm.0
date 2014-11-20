From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/3] PM / Domains: Add initial PM clock support to genpd
Date: Thu, 20 Nov 2014 11:23:28 +0100
Message-ID: <CAPDyKFp=+e_C8c_9-syYEw7wNom3KgdOaNnGSUk+f52xSohqNg@mail.gmail.com>
References: <1416405638-18812-1-git-send-email-ulf.hansson@linaro.org>
	<7hk32qu2w3.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:44643 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778AbaKTKX3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Nov 2014 05:23:29 -0500
Received: by mail-ob0-f169.google.com with SMTP id vb8so2019128obc.0
        for <linux-pm@vger.kernel.org>; Thu, 20 Nov 2014 02:23:28 -0800 (PST)
In-Reply-To: <7hk32qu2w3.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, Russell King <linux@arm.linux.org.uk>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Arnd Bergmann <arnd@arndb.de>

On 20 November 2014 01:33, Kevin Hilman <khilman@kernel.org> wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
>
>> It's quite common for PM domains to use PM clocks. Typically from SOC specific
>> code, the per device PM clock list is created and pm_clk_suspend|resume() are
>> invoked to handle clock gating/ungating.
>>
>> A step towards consolidation is to integrate PM clock support into genpd, which
>> is what this patchset does.
>>
>> In this initial step, the calls to the pm_clk_suspend|resume() are handled
>> within genpd, but the per device PM clock list still needs to be created from
>> SOC specific code. It seems reasonable to have gendp to handle that as well, but
>> that left to future patchsets to address.
>
> I think we need to get rid of the SoC specific code already.  For
> example, we're already seeing SoCs where the arm32 core is being
> replaced by an arm64 core but the other IPs, and power-domain logic is
> staying more or less the same.
>
>> It's not every users of genpd that are keen on using PM clocks thus we need
>> to provide this a configuration option for genpd.
>
> Or more likely, probably some compatible string, or property in the
> domain node.  Grygorii, Arnd and myself were discussing this elsewhere
> in the context of the TI Keystone2 PM domain support[1].

Thanks for pointing that out. It was actually the reason to why I
posted this patchset now, I have been keeping the patches locally in
my tree for too long. :-)

Let me comment of that thread, instead of here.

Kind regards
Uffe
