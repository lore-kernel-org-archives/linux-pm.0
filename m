From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH -next] PM / OPP: Make _find_opp_table_unlocked() static
Date: Mon, 6 Feb 2017 15:00:01 -0800
Message-ID: <20170206230001.GK25384@codeaurora.org>
References: <20170206142955.790-1-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50884 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752477AbdBFXAF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 6 Feb 2017 18:00:05 -0500
Content-Disposition: inline
In-Reply-To: <20170206142955.790-1-weiyj.lk@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wei Yongjun <weiyj.lk@gmail.com>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Wei Yongjun <weiyongjun1@huawei.com>, linux-pm@vger.kernel.org

On 02/06, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> Fixes the following sparse warning:
> 
> drivers/base/power/opp/core.c:49:18: warning:
>  symbol '_find_opp_table_unlocked' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
