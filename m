From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] PM / OPP: Use snprintf() instead of sprintf()
Date: Tue, 5 Jan 2016 11:52:47 -0800
Message-ID: <20160105195247.GD22188@codeaurora.org>
References: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44651 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045AbcAETwt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Jan 2016 14:52:49 -0500
Content-Disposition: inline
In-Reply-To: <dd64d12079ec788d337b17840e54f0fc60d3b8ce.1451990751.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Viresh Kumar <vireshk@kernel.org>

On 01/05, Viresh Kumar wrote:
> sprintf() can access memory outside of the range of the character array,
> and is risky in some situations. The driver specified prop_name string
> can be longer than NAME_MAX here (only an attacker will do that though)
> and so blindly copying it into the character array of size NAME_MAX
> isn't safe. Instead we must use snprintf() here.
> 
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
