From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH RFC] Add cpufreq support
Date: Mon, 8 Feb 2016 18:11:27 +0530
Message-ID: <20160208124127.GF8294@vireshk>
References: <56B4D4BE.2040008@free.fr>
 <2425296.hvcP5NDLXy@wuerfel>
 <20160208123111.GE8294@vireshk>
 <45004963.Im3DmqJ5ez@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:33304 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750905AbcBHMla (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Feb 2016 07:41:30 -0500
Received: by mail-pf0-f177.google.com with SMTP id q63so5559731pfb.0
        for <linux-pm@vger.kernel.org>; Mon, 08 Feb 2016 04:41:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <45004963.Im3DmqJ5ez@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Mason <slash.tmp@free.fr>, linux-pm <linux-pm@vger.kernel.org>

On 08-02-16, 13:34, Arnd Bergmann wrote:
> Maybe add a opp-v3 compatible string?

How will that help?

The problem was that the compatibility string of "opp-v2" specifies
the way we need to parse the bindings and shouldn't be (ab)used to
probe a driver like cpufreq-dt. And so we got stuck.

> I really don't care what you
> match on, as long we don't need any code in arch/arm/ to create a
> device we don't need.

Sure.

> Don't add the device to DT, we really don't want that.

I agree.

> If there
> is too much opposition to looking at the cpus nodes in the initcall,

I didn't get this one, what can we do by looking at CPUs nodes ?

> start with a whitelist for known machines, that at least keeps the
> existing behavior.

That can be a valid solution I would say, but that separate driver
(cpufreq-dt-device.c) needs to be changed for every new platform.

-- 
viresh
