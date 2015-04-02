From: rhn <kebuac.rhn@porcupinefactory.org>
Subject: Re: Unreliable hibernation on Lenovo x230 (regression)
Date: Thu, 2 Apr 2015 20:12:00 +0200
Message-ID: <20150402201200.1cf003f7@porcupinefactory.org>
References: <20150401214743.20fbe2c5@porcupinefactory.org>
	<20150402152805.GA17021@amd>
	<20150402165054.GD2320@linux-rxt1.site>
	<20150402172221.GE2320@linux-rxt1.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 178.212.147.28.siec.idealan.pl ([178.212.147.28]:52210 "EHLO
	porcupinefactory.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752692AbbDBSME (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Apr 2015 14:12:04 -0400
In-Reply-To: <20150402172221.GE2320@linux-rxt1.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: joeyli <jlee@suse.com>
Cc: Pavel Machek <pavel@ucw.cz>, rhn <kebuac.rhn@porcupinefactory.org>, kernel list <linux-kernel@vger.kernel.org>, joeyli.kernel@gmail.com, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

On Fri, 3 Apr 2015 01:22:21 +0800
joeyli <jlee@suse.com> wrote:

> On Fri, Apr 03, 2015 at 12:50:54AM +0800, joeyli wrote:
> > Hi, 
> > 
> > On Thu, Apr 02, 2015 at 05:28:05PM +0200, Pavel Machek wrote:
> > > On Wed 2015-04-01 21:47:43, rhn wrote:
> > > > Hello,
> > > > 
> > > > Between kernel 3.16 and 3.17, a regression has been introduced where the first hibernation after regular shutdown always fails to resume. Subsequent hibernations succeed.
> > > > 
> > > > The system is a Lenovo x230 with Intel i5, booting with EFI, with the hibernate partition located on a secondary SSD drive. Installed system is Fedora 20, hibernation and reboots were issued using the KDE shutdown dialog.
> > > > 
> > > > I have tracked the problem to first appear in the commit
> > > > e67ee10190e69332f929bdd6594a312363321a66	Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'
> > > > 
> > > > The problem itself manifests in dmesg as follows (system was first
> > > > restarted, then hibernated - this log is from the subsequent
> > > resume):
> > > 
> > > Ok, can you try to disable cpufreq and cpuidle, and then try if it
> > > reproduces?
> > > 
> > > At that point, this is the candidate:
> > > 
> > > commit e67ee10190e69332f929bdd6594a312363321a66
> > > Merge: 21c806d 84c91b7 39c8bba 372ba8c
> > > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Date:   Mon Aug 11 23:19:48 2014 +0200
> > > 
> > >     Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'
> > > 
> > >     * pm-sleep:
> > >           PM / hibernate: avoid unsafe pages in e820 reserved regions
> > > 
> > > ...
> > > Alternatively, you can just try to revert
> > > 
> > > commit 84c91b7ae07c62cf6dee7fde3277f4be21331f85
> > > Author: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > > Date:   Mon Aug 4 23:23:21 2014 +0800
> > > 
> > >     PM / hibernate: avoid unsafe pages in e820 reserved regions
> > > 
> > >     When the machine doesn't well handle the e820 persistent when
> > >     hibernate
> > >         resuming, then it may cause page fault when writing image to
> > >     snapshot
> > >         buffer:
> > > 
> > > 
> > > ...
> > > 
> > > Thanks,
> > > 									Pavel
> > 
> > Before revert 84c91b7ae patch, please check does there have log similar as
> > following in dmesg when hibernate resume fail?
> > 
> > [   24.349777] PM: 0xab9bc000 in e820 nosave region: [mem 0xab9bc000-0xab9c2fff]
> > 
> > The address may different, by you should see "e820 nosave region" log. Otherwise
> > we got another problem.
> >
> 
> Forgot to mention, please add "debug no_console_suspend=1 loglevel=9" to kernel
> parameter then try to reproduce issue and look at dmesg.
> 
> 
> Thanks a lot!
> Joey Lee 

Yes, it's present in dmesg when hibernate fails (default kernel params):
[    3.138824] PM: 0x9d3d3000 in e820 nosave region: [mem 0x9d3d3000-0x9d3d3fff]

I probably didn't make it clear - the top dmesg in my original message was from failed resume.

Cheers,
rhn
