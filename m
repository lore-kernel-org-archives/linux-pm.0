From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [for-next PATCH V2] PM / devfreq: Add sysfs node to expose available frequencies
Date: Wed, 31 Oct 2012 10:15:51 +0100
Message-ID: <1711506.ZFBefezGp9@vostro.rjw.lan>
References: <3578820.552041351649466344.JavaMail.weblogic@epv6ml03>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:48105 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933199Ab2JaJLr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 31 Oct 2012 05:11:47 -0400
In-Reply-To: <3578820.552041351649466344.JavaMail.weblogic@epv6ml03>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: Nishanth Menon <nm@ti.com>, linux-pm <linux-pm@vger.kernel.org>, Rajagopal Venkat <rajagopal.venkat@linaro.org>, =?utf-8?B?67CV6rK966+8?= <kyungmin.park@samsung.com>, Kevin Hilman <khilman@ti.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wednesday, October 31, 2012 02:11:06 AM MyungJoo Ham wrote:
> > On Friday, October 26, 2012 06:16:36 AM MyungJoo Ham wrote:
> > > > devfreq governors such as ondemand are controlled by a min and
> > > > max frequency, while governors like userspace governor allow us
> > > > to set a specific frequency.
> > > > However, for the same specific device, depending on the SoC, the
> > > > available frequencies can vary.
> > > > 
> > > > So expose the available frequencies as a snapshot over sysfs to
> > > > allow informed decisions.
> > > > 
> > > > This was inspired by cpufreq framework's equivalent for similar
> > > > usage sysfs node: scaling_available_frequencies.
> > > > 
> > > > Cc: Rajagopal Venkat <rajagopal.venkat@linaro.org>
> > > > Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> > > > Cc: Kyungmin Park <kyungmin.park@samsung.com>
> > > > Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
> > > > Cc: Kevin Hilman <khilman@ti.com>
> > > > Cc: linux-pm@vger.kernel.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > 
> > > > Signed-off-by: Nishanth Menon <nm@ti.com>
> > > 
> > > Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> > 
> > Are you going to handle this patch?
> 
> Yes, I've just setup the git repository this week
> and I'm willing to handle this one.
> 
> It is applied at
> http://git.kernel.org/?p=linux/kernel/git/mzx/devfreq.git;a=shortlog;h=refs/heads/for-rafael

OK

Please let me know when you want me to pull from your tree.

Please also note that the release of v3.7-rc6 is the deadline for non-bugfix
changes targeted at v3.8. :-)

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
