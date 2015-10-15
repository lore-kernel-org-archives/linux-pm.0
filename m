From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V2] debugfs: Add debugfs_create_ulong()
Date: Thu, 15 Oct 2015 11:25:55 -0700
Message-ID: <20151015182555.GI4558@codeaurora.org>
References: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
 <69e3888403d23de9aadf3792be3c0bdce57495b0.1444410517.git.viresh.kumar@linaro.org>
 <20151014185102.GI26883@codeaurora.org>
 <20151015071218.GD19018@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44369 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751889AbbJOSZ5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 14:25:57 -0400
Content-Disposition: inline
In-Reply-To: <20151015071218.GD19018@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On 10/15, Viresh Kumar wrote:
> On 14-10-15, 11:51, Stephen Boyd wrote:
> > On 10/09, Viresh Kumar wrote:
> > > +struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
> > > +				    struct dentry *parent, unsigned long *value)
> > > +{
> > > +	return debugfs_create_file(name, mode, parent, value, &fops_xlong);
> > 
> > Were you going to refresh this on my debugfs_create_mode()
> > patches? Otherwise the patch looks fine to me.
> 
> I thought you need to refresh your set as I posted this before you
> have :)
> 

:)

Well this patch is creating xlong without any
read-only/write-only ops, so it has the same potential problems
as what the debugfs_create_mode() series was fixing. I'm fine
either way though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
