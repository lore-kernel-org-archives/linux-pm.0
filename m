From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Unreliable hibernation on Lenovo x230 (regression)
Date: Fri, 3 Apr 2015 18:40:35 +0200
Message-ID: <20150403164035.GA17177@amd>
References: <20150401214743.20fbe2c5@porcupinefactory.org>
 <20150402152805.GA17021@amd>
 <20150403175825.79816fea@porcupinefactory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42043 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbbDCQki (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 3 Apr 2015 12:40:38 -0400
Content-Disposition: inline
In-Reply-To: <20150403175825.79816fea@porcupinefactory.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rhn <kebuac.rhn@porcupinefactory.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, joeyli.kernel@gmail.com, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>

Hi!

> > > Between kernel 3.16 and 3.17, a regression has been introduced where the first hibernation after regular shutdown always fails to resume. Subsequent hibernations succeed.
> > > 
> > > The system is a Lenovo x230 with Intel i5, booting with EFI, with the hibernate partition located on a secondary SSD drive. Installed system is Fedora 20, hibernation and reboots were issued using the KDE shutdown dialog.
> > > 
> > > I have tracked the problem to first appear in the commit
> > > e67ee10190e69332f929bdd6594a312363321a66	Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'
> > > 
> > > The problem itself manifests in dmesg as follows (system was first
> > > restarted, then hibernated - this log is from the subsequent
> > resume):
> > 
> > Ok, can you try to disable cpufreq and cpuidle, and then try if it
> > reproduces?
> > 
> > At that point, this is the candidate:
> > 
> > commit e67ee10190e69332f929bdd6594a312363321a66
> > Merge: 21c806d 84c91b7 39c8bba 372ba8c
> > Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Date:   Mon Aug 11 23:19:48 2014 +0200
> > 
> >     Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'
> > 
> >     * pm-sleep:
> >           PM / hibernate: avoid unsafe pages in e820 reserved regions
> > 
> > ...
> > Alternatively, you can just try to revert
> > 
> > commit 84c91b7ae07c62cf6dee7fde3277f4be21331f85
> > Author: Lee, Chun-Yi <joeyli.kernel@gmail.com>
> > Date:   Mon Aug 4 23:23:21 2014 +0800
> > 
> >     PM / hibernate: avoid unsafe pages in e820 reserved regions
> > 
> >     When the machine doesn't well handle the e820 persistent when
> >     hibernate
> >         resuming, then it may cause page fault when writing image to
> >     snapshot
> >         buffer:
> > 
> > 
> > ...
> > 
> > Thanks,
> > 									Pavel
> 
> I tried to disable CONFIG_CPU_IDLE and CONFIG_CPU_FREQ, however for some reason I could only disable CONFIG_CPU_FREQ.
> 
> The bug persisted.
> 
> Reverting the commit 84c91b7 on top of e67ee10 fixes the problem.

Ok, I guess next steps would be verify if 4.0 has the problem, and if
revert of 84c91b7 there fixes it, too... maybe we should revert it for
4.0?


									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
