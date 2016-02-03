From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Plain DFS (no voltage scaling)
Date: Wed, 3 Feb 2016 07:40:52 +0530
Message-ID: <20160203021052.GK31828@vireshk>
References: <56B11B67.3090600@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34900 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754270AbcBCCK4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 21:10:56 -0500
Received: by mail-pf0-f171.google.com with SMTP id 65so4544132pfd.2
        for <linux-pm@vger.kernel.org>; Tue, 02 Feb 2016 18:10:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B11B67.3090600@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 02-02-16, 22:11, Mason wrote:
> Hello,
> 
> I plan to enable the on-demand governor on the tango platform:
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi
> 
> I found the cpufreq-dt binding doc:
> 
> https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
> https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt
> 
> Something is not clear to me:
> 
> If my platform cannot scale the voltage, what information
> should I put in the voltage part of the DT?

Wouldn't matter if there is no regulator. i.e. you should keep 0, but
even if they have something non-zero, core code will ignore it. But
yeah, it makes sense to keep it zero.

-- 
viresh
