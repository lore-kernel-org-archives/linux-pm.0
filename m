From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 0/8] ARM: dts: Add operating-points-v2 tables for TI
 platforms
Date: Thu, 19 May 2016 10:17:44 +0530
Message-ID: <20160519044744.GE32001@vireshk-i7>
References: <cover.1463606963.git.d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33609 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750739AbcESErr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 00:47:47 -0400
Received: by mail-pa0-f47.google.com with SMTP id xk12so24898727pac.0
        for <linux-pm@vger.kernel.org>; Wed, 18 May 2016 21:47:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <cover.1463606963.git.d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Yegor Yefremov <yegorslists@googlemail.com>

On 18-05-16, 18:36, Dave Gerlach wrote:
> Hi,
> This series adds operating-points-v2 tables for am335x, am437x, dra7xx,
> and am57xx based platforms along with some support patches so that we
> can enable more OPPs for the CPU on these platforms.
> 
> These patches rely on the ti-cpufreq series sent here [1] and provide
> opp-supported-hw data for each OPP so that only the appropriate OPPs
> for a specific piece of silicon get enabled.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
