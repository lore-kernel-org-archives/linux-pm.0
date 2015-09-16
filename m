From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: Pull Request for PM / devfreq, 4.3 RCx
Date: Wed, 16 Sep 2015 03:04:48 +0200
Message-ID: <3115429.14S40JYdX6@vostro.rjw.lan>
References: <882046565.1068551442280819125.JavaMail.weblogic@ep2mlwas05a>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:47810 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752906AbbIPAgr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 15 Sep 2015 20:36:47 -0400
In-Reply-To: <882046565.1068551442280819125.JavaMail.weblogic@ep2mlwas05a>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "javi.merino@arm.com" <javi.merino@arm.com>, "yexl@marvell.com" <yexl@marvell.com>, =?utf-8?B?7LWc7LCs7Jqw?= <cw00.choi@samsung.com>

On Tuesday, September 15, 2015 01:33:40 AM MyungJoo Ham wrote:
> > On Saturday, September 12, 2015 12:20:31 AM Rafael J. Wysocki wrote:
> > > On Friday, September 11, 2015 06:11:29 AM MyungJoo Ham wrote:
> > > > The following changes since commit 64291f7db5bd8150a74ad2036f1037e6a0428df2:
> > > > 
> > > >   Linux 4.2 (2015-08-30 11:34:09 -0700)
> > > > 
> > > > are available in the git repository at:
> > > > 
> > > >   https://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git for-rafael
> > > > 
> > > > for you to fetch changes up to 5f25f066f75a67835abb5e400471a27abd09395b:
> > > > 
> > > >   PM / devfreq: Fix incorrect type issue. (2015-09-11 14:23:30 +0900)
> > > > 
> > > > ----------------------------------------------------------------
> > > > Pull Request of Devfreq for Linux 4.3 / PM
> > > 
> > > I've just sent my second pull request for 4.3-rc1 to Linus and I won't be able
> > > to sent another one before the -rc1 is out.  Had I received this two days ago,
> > > it would have made it just fine.
> > > 
> > > I'll pull it on Monday.
> > 
> > Pulled, but got a conflict.
> > 
> > Please check the conflict resolution my bleeding-edge branch and let me know
> > if that's not the right one.
> > 
> > Thanks,
> > Rafael
> > 
> 
> Diff shows no differences in devfreq related files and
> each commit is intact. I guess it is simply because pm-devfreq
> had old commits not included in 4.2.
> 
> So, that's the right one.

OK, thanks!

Rafael

