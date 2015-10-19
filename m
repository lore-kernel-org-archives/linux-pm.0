From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V4] debugfs: Add debugfs_create_ulong()
Date: Mon, 19 Oct 2015 12:45:56 -0700
Message-ID: <20151019194556.GG10182@codeaurora.org>
References: <e5fab11bb5f5914783c5a8222d4d9e146593dc59.1445188352.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43947 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754499AbbJSTqE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 19 Oct 2015 15:46:04 -0400
Content-Disposition: inline
In-Reply-To: <e5fab11bb5f5914783c5a8222d4d9e146593dc59.1445188352.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On 10/18, Viresh Kumar wrote:
> Add debugfs_create_ulong() for the users of type 'unsigned long'. These
> will be 32 bits long on a 32 bit machine and 64 bits long on a 64 bit
> machine.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
