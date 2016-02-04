From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: Plain DFS (no voltage scaling)
Date: Thu, 4 Feb 2016 08:53:53 +0530
Message-ID: <20160204032353.GQ3469@vireshk>
References: <56B11B67.3090600@free.fr>
 <20160203021052.GK31828@vireshk>
 <56B21E2E.1070606@free.fr>
 <20160203161428.GJ3469@vireshk>
 <56B24634.6060001@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34663 "EHLO
	mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965331AbcBDDX4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Feb 2016 22:23:56 -0500
Received: by mail-pf0-f173.google.com with SMTP id o185so28767432pfb.1
        for <linux-pm@vger.kernel.org>; Wed, 03 Feb 2016 19:23:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <56B24634.6060001@free.fr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mason <slash.tmp@free.fr>
Cc: Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ARM <linux-arm-kernel@lists.infradead.org>

On 03-02-16, 19:25, Mason wrote:
> The sunxi guys pointed me in the right direction.
> 
> http://lxr.free-electrons.com/source/arch/arm/mach-sunxi/sunxi.c#L20
> 
> Why isn't there a compatible string like other drivers?
> 
> Such as
>   compatible = "cpufreq-dt"
> which would enable cpufreq on the platform?

Because DT can't have nodes for virtual devices :(

-- 
viresh
