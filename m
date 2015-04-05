From: joeyli <jlee@suse.com>
Subject: Re: Unreliable hibernation on Lenovo x230 (regression)
Date: Sun, 5 Apr 2015 15:26:13 +0800
Message-ID: <20150405072613.GD27614@linux-rxt1.site>
References: <20150401214743.20fbe2c5@porcupinefactory.org>
 <20150402152805.GA17021@amd>
 <20150403175825.79816fea@porcupinefactory.org>
 <3344848.SIHh1OazTO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3344848.SIHh1OazTO@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: rhn <kebuac.rhn@porcupinefactory.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, joeyli.kernel@gmail.com, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 03, 2015 at 11:43:30PM +0200, Rafael J. Wysocki wrote:
> On Friday, April 03, 2015 05:58:25 PM rhn wrote:
> > On Thu, 2 Apr 2015 17:28:05 +0200
> > Pavel Machek <pavel@ucw.cz> wrote:
> > 
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
> > I tried to disable CONFIG_CPU_IDLE and CONFIG_CPU_FREQ, however for some reason I could only disable CONFIG_CPU_FREQ.
> > 
> > The bug persisted.
> > 
> > Reverting the commit 84c91b7 on top of e67ee10 fixes the problem.
> > 
> > I created a copy of the bug report here: https://bugzilla.kernel.org/show_bug.cgi?id=96111
> 
> Please check if 4.0-rc6 still has the problem and if reverting the commit in
> question on top of it fixes the problem too.
> 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

I think just revert 84c91b7ae until Yinghai Lu's patches merged to v4.1.                                                                                                                 
I will resend 84c91b7ae patch until Yinghai Lu's patches merged.                                                                                                                         
                                                                                                                                                                                         
                                                                                                                                                                                         
Regards                                                                                                                                                                                  
Joey Lee
