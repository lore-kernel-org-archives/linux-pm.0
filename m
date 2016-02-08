From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Mon, 08 Feb 2016 14:10:31 +0100
Message-ID: <22002072.L04zy0K2AP@wuerfel>
References: <56B4D4BE.2040008@free.fr> <45004963.Im3DmqJ5ez@wuerfel> <20160208124127.GF8294@vireshk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([217.72.192.75]:62408 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752782AbcBHNK6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 08:10:58 -0500
In-Reply-To: <20160208124127.GF8294@vireshk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On Monday 08 February 2016 18:11:27 Viresh Kumar wrote:
> On 08-02-16, 13:34, Arnd Bergmann wrote:
> > Maybe add a opp-v3 compatible string?
> 
> How will that help?
> 
> The problem was that the compatibility string of "opp-v2" specifies
> the way we need to parse the bindings and shouldn't be (ab)used to
> probe a driver like cpufreq-dt. And so we got stuck.

I don't remember the exact discussion, but the compatible string is
exactly meant to do one thing: it tells you what you can or cannot do
with one device.

I had not realized that we don't even have a compatible string
for opp-v2, so if we are missing that, we obviously can't compare
against that string.

> > I really don't care what you
> > match on, as long we don't need any code in arch/arm/ to create a
> > device we don't need.
> 
> Sure.
> 
> > Don't add the device to DT, we really don't want that.
> 
> I agree.
> 
> > If there
> > is too much opposition to looking at the cpus nodes in the initcall,
> 
> I didn't get this one, what can we do by looking at CPUs nodes ?

I thought there was a compatible property in there that told us
whether the operating-points-v2/cooling-min-level/#cooling-cells/...
properties were considered valid.

> > start with a whitelist for known machines, that at least keeps the
> > existing behavior.
> 
> That can be a valid solution I would say, but that separate driver
> (cpufreq-dt-device.c) needs to be changed for every new platform.

Until we can agree on a way to describe in the DT whether the opp
properties are reliable or not.

	Arnd
