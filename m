From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V5] PM / OPP: Add debugfs support
Date: Wed, 11 Nov 2015 13:54:49 -0800
Message-ID: <20151111215449.GA15032@codeaurora.org>
References: <20151110193603.GA24116@codeaurora.org>
 <3fd43be545a4da4fb4e78d19e8e37e8e83f1512c.1447208688.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:60447 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751522AbbKKVyw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 11 Nov 2015 16:54:52 -0500
Content-Disposition: inline
In-Reply-To: <3fd43be545a4da4fb4e78d19e8e37e8e83f1512c.1447208688.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>

On 11/11, Viresh Kumar wrote:
> This patch adds debugfs support to OPP layer to export OPPs and their
> properties for all the devices.
> 
> This creates a top level directory: /sys/kernel/debug/opp and then
> device specific directories (based on device names) inside it. For
> example: 'cpu0', 'cpu1', etc..
> 
> If multiple devices share the OPP table, then the real directory is
> created only for the first device. For all others, links are created to
> the real directory.
> 
> Inside the device specific directory, a separate directory is created
> for each OPP. And within that files per opp property.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
