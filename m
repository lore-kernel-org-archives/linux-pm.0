From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2] debugfs: Add debugfs_create_ulong()
Date: Thu, 15 Oct 2015 12:42:18 +0530
Message-ID: <20151015071218.GD19018@linux>
References: <3a48d2bb4320bba82f91354d7165c300ef8108bd.1444402709.git.viresh.kumar@linaro.org>
 <69e3888403d23de9aadf3792be3c0bdce57495b0.1444410517.git.viresh.kumar@linaro.org>
 <20151014185102.GI26883@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34589 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753432AbbJOHMY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 15 Oct 2015 03:12:24 -0400
Received: by payp3 with SMTP id p3so31238912pay.1
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 00:12:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20151014185102.GI26883@codeaurora.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, arnd@arndb.de, linux-pm@vger.kernel.org, linux@arm.linux.org.uk, stern@rowland.harvard.edu

On 14-10-15, 11:51, Stephen Boyd wrote:
> On 10/09, Viresh Kumar wrote:
> > +struct dentry *debugfs_create_xlong(const char *name, umode_t mode,
> > +				    struct dentry *parent, unsigned long *value)
> > +{
> > +	return debugfs_create_file(name, mode, parent, value, &fops_xlong);
> 
> Were you going to refresh this on my debugfs_create_mode()
> patches? Otherwise the patch looks fine to me.

I thought you need to refresh your set as I posted this before you
have :)

-- 
viresh
