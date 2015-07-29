From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] bus: subsys: propagate errors from subsys interface's
 ->add_dev()
Date: Wed, 29 Jul 2015 15:37:43 -0700
Message-ID: <20150729223743.GA17250@kroah.com>
References: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org>
 <20150729211916.GA11972@kroah.com>
 <2867166.mZBGleMS1o@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43857 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754197AbbG2Who (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 18:37:44 -0400
Content-Disposition: inline
In-Reply-To: <2867166.mZBGleMS1o@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pi-cheng.chen@linaro.org

On Thu, Jul 30, 2015 at 01:01:21AM +0200, Rafael J. Wysocki wrote:
> On Wednesday, July 29, 2015 02:19:16 PM Greg KH wrote:
> > On Fri, Jun 26, 2015 at 02:32:47PM +0530, Viresh Kumar wrote:
> > > ->add_dev() may fail and the error returned from it can be useful for
> > > the caller.
> > > 
> > > For example, if some of the resources aren't ready yet and -EPROBE_DEFER
> > > is returned from ->add_dev(), then the owner of 'struct
> > > subsys_interface' may want to try probing again at a later point of
> > > time. And that requires a proper return value from ->add_dev().
> > > 
> > > Also, if we hit an error while registering subsys_interface, then we
> > > should stop proceeding further and rollback whatever has been done until
> > > then. Break part of subsys_interface_unregister() into another routine,
> > > which lets us call ->remove_dev() for all devices for which ->add_dev()
> > > is already called.
> > > 
> > > Cc: 3.3+ <stable@vger.kernel.org> # 3.3+
> > > Fixes: ca22e56debc5 ("driver-core: implement 'sysdev' functionality for regular devices and buses")
> > 
> > I don't see how this is a stable bug fix, what is resolved by it that
> > doesn't work today?  Is there some code that is expecting this
> > functionality that has never been present?
> > 
> > I'll go queue it up, but I don't think it is -stable material, but feel
> > free to change my mind.
> 
> There is a small problem with it that I've already pointed out to Viresh.
> 
> Namely, while changing subsys_interface_(un)register() to handle return
> values from ->add_dev(), it doesn't do the same thing in bus_probe_device()
> which I believe it should for consistency at least.

Oops, sorry, missed that response.  I'll go drop this patch then, thanks
for letting me know.

> But then, the question is whether or not the probing should fail and
> what if device_attach() returns 0 and one of the ->add_dev() callbacks
> returns an error.

That's a total mess...

Given that there are almost no uses of this api, I think people should
work it out before any more start to pop up :)

thanks,

greg k-h
