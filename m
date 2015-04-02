From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Unreliable hibernation on Lenovo x230 (regression)
Date: Thu, 2 Apr 2015 17:28:05 +0200
Message-ID: <20150402152805.GA17021@amd>
References: <20150401214743.20fbe2c5@porcupinefactory.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150401214743.20fbe2c5@porcupinefactory.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rhn <kebuac.rhn@porcupinefactory.org>, kernel list <linux-kernel@vger.kernel.org>, joeyli.kernel@gmail.com
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On Wed 2015-04-01 21:47:43, rhn wrote:
> Hello,
> 
> Between kernel 3.16 and 3.17, a regression has been introduced where the first hibernation after regular shutdown always fails to resume. Subsequent hibernations succeed.
> 
> The system is a Lenovo x230 with Intel i5, booting with EFI, with the hibernate partition located on a secondary SSD drive. Installed system is Fedora 20, hibernation and reboots were issued using the KDE shutdown dialog.
> 
> I have tracked the problem to first appear in the commit
> e67ee10190e69332f929bdd6594a312363321a66	Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'
> 
> The problem itself manifests in dmesg as follows (system was first
> restarted, then hibernated - this log is from the subsequent
resume):

Ok, can you try to disable cpufreq and cpuidle, and then try if it
reproduces?

At that point, this is the candidate:

commit e67ee10190e69332f929bdd6594a312363321a66
Merge: 21c806d 84c91b7 39c8bba 372ba8c
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Aug 11 23:19:48 2014 +0200

    Merge branches 'pm-sleep', 'pm-cpufreq' and 'pm-cpuidle'

    * pm-sleep:
          PM / hibernate: avoid unsafe pages in e820 reserved regions

...
Alternatively, you can just try to revert

commit 84c91b7ae07c62cf6dee7fde3277f4be21331f85
Author: Lee, Chun-Yi <joeyli.kernel@gmail.com>
Date:   Mon Aug 4 23:23:21 2014 +0800

    PM / hibernate: avoid unsafe pages in e820 reserved regions

    When the machine doesn't well handle the e820 persistent when
    hibernate
        resuming, then it may cause page fault when writing image to
    snapshot
        buffer:


...

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
