From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Mon, 08 Feb 2016 14:45:23 +0100
Message-ID: <7910928.pmJjZiV1Lk@wuerfel>
References: <56B4D4BE.2040008@free.fr> <22002072.L04zy0K2AP@wuerfel> <20160208131625.GI8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:62964 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751486AbcBHNvA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:51:00 -0500
In-Reply-To: <20160208131625.GI8294@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On Monday 08 February 2016 18:46:25 Viresh Kumar wrote:
> On 08-02-16, 14:10, Arnd Bergmann wrote:
> > I don't remember the exact discussion, but the compatible string is
> > exactly meant to do one thing: it tells you what you can or cannot do
> > with one device.
> 
> Yeah, and many people argued that we can't add two values to that
> string like: "cpufreq-dt" and "cpufreq-big-little" for same kind of
> OPP bindings, as a different compatible string should be required only
> if there is a difference in the bindings.
> 
> For example, if a platform (like ST did recently) adds more
> platform-specific properties, then they can define a new value of
> those strings.
>
> > I had not realized that we don't even have a compatible string
> > for opp-v2, so if we are missing that, we obviously can't compare
> > against that string.
> 
> The binding says that we can have a string, but its not compulsory
> yet. Its only used by STM as they have some specific properties of
> their own.

Right, so when those properties are required for that machine,
that makes it incompatible with the generic driver, and it should
really have its own compatible string.

That's why I said we could introduce a 'v3' with the meaning
it should have had to start with: compatible means actually
compatible with the driver.

I guess we could also start a blacklist and list all machines
that are not compatible with the generic binding before falling
back to using that driver.

> > I thought there was a compatible property in there that told us
> > whether the operating-points-v2/cooling-min-level/#cooling-cells/...
> > properties were considered valid.
> 
> Yeah, "OPP-v2" DT node can have a compatible string, which isn't
> compulsory as of now, but because of the reasons mentioned earlier, we
> can't use it to differentiate between drivers that use exactly same
> version of bindings.

Right, unless we introduce a new compatible string for future machines.

	Arnd
