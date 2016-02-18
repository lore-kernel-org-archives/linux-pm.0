From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 2/2] PM / OPP: Rename structures for clarity
Date: Thu, 18 Feb 2016 14:08:41 -0800
Message-ID: <20160218220841.GM4847@codeaurora.org>
References: <a2e646290fdc966d8126176bae51bc648a4eddf8.1455612454.git.viresh.kumar@linaro.org>
 <e9363b2c42e7082b442c81d96d572c4323559cf0.1455612454.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56287 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423513AbcBRWIo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Feb 2016 17:08:44 -0500
Content-Disposition: inline
In-Reply-To: <e9363b2c42e7082b442c81d96d572c4323559cf0.1455612454.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 02/16, Viresh Kumar wrote:
> Stephen pointed out recently, that few structures always confuse him as
> they aren't named properly. And this patch tries to address that:
> 
> Names are updated as:
> - device_opp or dev_opp -> opp_table
> - dev_opp_list -> opp_tables
> - dev_opp_list_lock -> opp_table_lock
> - device_list_opp -> opp_device (it was never a list, but a structure)
> - list_dev -> opp_dev
> - And similar changes in comments and function names as well.
> 
> This also fixes checkpatch warnings that were generated with this patch.
> 
> No functional changes.
> 
> Suggested-by: Stephen Boyd <sboyd@codeaurora.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
