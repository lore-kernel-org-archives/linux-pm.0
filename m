From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 12/17] cpufreq: dt: Pass regulator name to the OPP core
 for V1 bindings
Date: Mon, 11 Jan 2016 17:53:29 -0800
Message-ID: <20160112015328.GQ22188@codeaurora.org>
References: <cover.1450777582.git.viresh.kumar@linaro.org>
 <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43259 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761751AbcALBxb (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 11 Jan 2016 20:53:31 -0500
Content-Disposition: inline
In-Reply-To: <981905b802879bff26d839b0aab19ad67a3aa1ff.1450777582.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, nm@ti.com

On 12/22, Viresh Kumar wrote:
> OPP core can handle the regulators by itself, and it allocates the
> regulator based on device's name. But for older V1 bindings, many DT
> files have used names like 'cpu-supply' instead of 'cpu0-supply'.
> 
> The cpufreq-dt driver needs to tell the right name of the regulator in
> this case to the OPP core.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This whole patch is confusing to me because old style was to be
cpu0-supply, and new style is cpu-supply.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
