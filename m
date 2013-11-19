From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] power: Replace printks with dev_* and pr_* routines
Date: Tue, 19 Nov 2013 14:59:17 -0800
Message-ID: <20131119225917.GA12930@kroah.com>
References: <1384886818-11861-1-git-send-email-shuah.kh@samsung.com>
 <1384887205.17783.40.camel@joe-AO722>
 <528BB492.8090404@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:42360 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753026Ab3KSW7D (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Nov 2013 17:59:03 -0500
Content-Disposition: inline
In-Reply-To: <528BB492.8090404@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shuah Khan <shuah.kh@samsung.com>
Cc: Joe Perches <joe@perches.com>, len.brown@intel.com, pavel@ucw.cz, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Tue, Nov 19, 2013 at 11:57:22AM -0700, Shuah Khan wrote:
> On 11/19/2013 11:53 AM, Joe Perches wrote:
> > On Tue, 2013-11-19 at 11:46 -0700, Shuah Khan wrote:
> >> Replaced printks with dev_* and pr_* routines. Replacing printk in
> >> __suspend_report_result() will require passing in struct device *
> >> pointer from calling routines and this will require changes to
> >> external interface suspend_report_result() which is used by several
> >> drivers. Hence, this one instance is replaced by pr_err().
> > []
> >> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> > []
> >> @@ -1308,9 +1308,8 @@ int dpm_prepare(pm_message_t state)
> >>   				error = 0;
> >>   				continue;
> >>   			}
> >> -			printk(KERN_INFO "PM: Device %s not prepared "
> >> -				"for power transition: code %d\n",
> >> -				dev_name(dev), error);
> >> +			dev_info("PM: not prepared for power transition: ",
> >> +				 "code %d\n", error);
> >
> > Shuah, you have to make sure the files modified by
> > your patches compile successfully before sending
> > patches like this.
> >
> >
> 
> Oops. I did compile. Missed the warning. Sorry about that.

It should be an "error"...

It adds a codingstyle warning as well, so fix that up for the next
version please :)

greg k-h
