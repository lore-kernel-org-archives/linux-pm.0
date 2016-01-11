From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/17] PM / OPP: Introduce APIs to transition OPPs
Date: Mon, 11 Jan 2016 21:58:10 +0530
Message-ID: <20160111162810.GE1084@ubuntu>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35582 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757612AbcAKQ2P (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 11:28:15 -0500
Received: by mail-pa0-f42.google.com with SMTP id ho8so62784649pac.2
        for <linux-pm@vger.kernel.org>; Mon, 11 Jan 2016 08:28:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <cover.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>, Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 22-12-15, 15:46, Viresh Kumar wrote:
> This patchset add APIs in OPP layer to allow OPPs transitioning from
> within OPP layer. Currently all OPP users need to replicate the same
> code to switch between OPPs. While the same can be handled easily by
> OPP-core.
> 
> The first Eight patches update the OPP core to introduce the new APIs
> and the next Nine patches update cpufreq-dt for the same.

Stephen,

Ping !!

(In case you missed this thread)

-- 
viresh
