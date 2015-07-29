From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] bus: subsys: propagate errors from subsys interface's ->add_dev()
Date: Thu, 30 Jul 2015 01:29:01 +0200
Message-ID: <2113628.vmLC8GdsGl@vostro.rjw.lan>
References: <aff842c23841a8e61ac17e58fc27c99e052e338b.1435308918.git.viresh.kumar@linaro.org> <2867166.mZBGleMS1o@vostro.rjw.lan> <20150729223743.GA17250@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53152 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752911AbbG2XCF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jul 2015 19:02:05 -0400
In-Reply-To: <20150729223743.GA17250@kroah.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, pi-cheng.chen@linaro.org

On Wednesday, July 29, 2015 03:37:43 PM Greg KH wrote:
> On Thu, Jul 30, 2015 at 01:01:21AM +0200, Rafael J. Wysocki wrote:
> > On Wednesday, July 29, 2015 02:19:16 PM Greg KH wrote:
> > > On Fri, Jun 26, 2015 at 02:32:47PM +0530, Viresh Kumar wrote:
> > > > ->add_dev() may fail and the error returned from it can be useful for
> > > > the caller.
> > > > 
> > > > For example, if some of the resources aren't ready yet and -EPROBE_DEFER
> > > > is returned from ->add_dev(), then the owner of 'struct
> > > > subsys_interface' may want to try probing again at a later point of
> > > > time. And that requires a proper return value from ->add_dev().
> > > > 
> > > > Also, if we hit an error while registering subsys_interface, then we
> > > > should stop proceeding further and rollback whatever has been done until
> > > > then. Break part of subsys_interface_unregister() into another routine,
> > > > which lets us call ->remove_dev() for all devices for which ->add_dev()
> > > > is already called.
> > > > 
> > > > Cc: 3.3+ <stable@vger.kernel.org> # 3.3+
> > > > Fixes: ca22e56debc5 ("driver-core: implement 'sysdev' functionality for regular devices and buses")
> > > 
> > > I don't see how this is a stable bug fix, what is resolved by it that
> > > doesn't work today?  Is there some code that is expecting this
> > > functionality that has never been present?
> > > 
> > > I'll go queue it up, but I don't think it is -stable material, but feel
> > > free to change my mind.
> > 
> > There is a small problem with it that I've already pointed out to Viresh.
> > 
> > Namely, while changing subsys_interface_(un)register() to handle return
> > values from ->add_dev(), it doesn't do the same thing in bus_probe_device()
> > which I believe it should for consistency at least.
> 
> Oops, sorry, missed that response.  I'll go drop this patch then, thanks
> for letting me know.
> 
> > But then, the question is whether or not the probing should fail and
> > what if device_attach() returns 0 and one of the ->add_dev() callbacks
> > returns an error.
> 
> That's a total mess...
> 
> Given that there are almost no uses of this api, I think people should
> work it out before any more start to pop up :)

cpufreq is one of the users and that's where the problem is, but in my opinion
it should be addressed in a different way.

But while we are at it, should the ->add_dev and ->remove_dev callbacks in
struct subsys_interface return an int if their return values are always
ignored?  Maybe it would be better to redefine them to be void to make it clear
that they can't fail?

Thanks,
Rafael

