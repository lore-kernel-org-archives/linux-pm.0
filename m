From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2] debugfs: Add debugfs_create_ulong()
Date: Wed, 14 Oct 2015 11:51:02 -0700
Message-ID: <20151014185102.GI26883@codeaurora.org>
References: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
 <69e3888403d23de9aadf3792be3c0bdce57495b0.1444410517.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <69e3888403d23de9aadf3792be3c0bdce57495b0.1444410517.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu
List-Id: linux-pm@vger.kernel.org

On 10/09, Viresh Kumar wrote:
> +struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
> +				    struct dentry *parent, unsigned long *value)
> +{
> +	return debugfs_create_file(name, mode, parent, value, &fops_xlong);

Were you going to refresh this on my debugfs_create_mode()
patches? Otherwise the patch looks fine to me.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
