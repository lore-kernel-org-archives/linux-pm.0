From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCHv v3] power: Include additional information in pm_print_times
Date: Sun, 23 Jun 2013 13:24:01 +0200
Message-ID: <1435015.6FrhLQ9OH0@vostro.rjw.lan>
References: <1371497795-20084-1-git-send-email-shuah.kh@samsung.com> <2722061.UXbT4p7DY0@vostro.rjw.lan> <1371984080.3137.41.camel@joe-AO722>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:47883 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751293Ab3FWLOh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 23 Jun 2013 07:14:37 -0400
In-Reply-To: <1371984080.3137.41.camel@joe-AO722>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Joe Perches <joe@perches.com>
Cc: Shuah Khan <shuah.kh@samsung.com>, pavel@ucw.cz, len.brown@intel.com, gregkh@linuxfoundation.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, shuahkhan@gmail.com

On Sunday, June 23, 2013 03:41:20 AM Joe Perches wrote:
> On Sun, 2013-06-23 at 12:35 +0200, Rafael J. Wysocki wrote:
> > On Sunday, June 23, 2013 03:16:30 AM Joe Perches wrote:
> > > On Sun, 2013-06-23 at 12:22 +0200, Rafael J. Wysocki wrote:
> > > > On Sunday, June 23, 2013 03:03:31 AM Joe Perches wrote:
> > > > > On Sun, 2013-06-23 at 12:07 +0200, Rafael J. Wysocki wrote:
> > > > > > On Saturday, June 22, 2013 06:05:50 PM Joe Perches wrote:
> > > > > > > If any script needs something stable it should
> > > > > > > depend on information available through other
> > > > > > > sources like trace or proc or sysfs.
> > > > > > 
> > > > > > That is clearly impossible in this particular case, though.
> > > > > 
> > > > > Why couldn't this printk be converted into an equivalent tracepoint?
> > > > 
> > > > Well, why wouldn't you try to do that?
> > > 
> > > Why should I?
> >
> > Because you're arguing that it should be done.
> >
> > If you think that it's better to use tracepoints here, please implement those
> > tracepoints and show everyone that they are really better than what we have.
> 
> Nope, you're arguing that dmesg output, known to be non-stable,
> should not have this particular message changed.
> 
> You stated "<it's> clearly impossible".  I do dispute that.

And what I meant by that was "there are no tracepoints, sysfs attributes etc.
those tools can use to get the information they need".  Which is a fact of
life.

> If you need something stable, you shouldn't use dmesg,
> That's a simple statement, not anything else.
> 
> Right now, I don't care if this particular message changes.
> I'm not doing any PM testing or timing at the moment.
> 
> > Till then, we'll use what's already there.
> 
> Fine by me.  It's up to Shuah Khan to get a patch accepted.

Well, precisely.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
