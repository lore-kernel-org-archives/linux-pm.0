From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH] debugfs: Add debugfs_create_ulong()
Date: Fri, 9 Oct 2015 09:39:41 -0700
Message-ID: <20151009163941.GQ26883@codeaurora.org>
References: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49423 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757049AbbJIQjo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 9 Oct 2015 12:39:44 -0400
Content-Disposition: inline
In-Reply-To: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On 10/09, Viresh Kumar wrote:
> @@ -87,6 +89,8 @@ struct dentry *debugfs_create_x32(const char *name, umode_t mode,
>  				  struct dentry *parent, u32 *value);
>  struct dentry *debugfs_create_x64(const char *name, umode_t mode,
>  				  struct dentry *parent, u64 *value);
> +struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
> +				    struct dentry *parent, unsigned long *value);

Where is this function defined? The non-x version looks ok.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
