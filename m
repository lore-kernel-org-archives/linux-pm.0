From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 12:17:41 +0200
Message-ID: <20070721101741.GD1902@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707161015490.3410-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0707162137220.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707162137220.19248@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> >Part of the problem here is that ACPI already has its own terminology,
> >and you're trying to invent a new one instead of using the existing
> >one.
> >
> >I agree, it would be good to have a non-ACPI-specific hibernation mode,
> >something which would look to ACPI like a normal shutdown.  But I'm not
> >so sure this is possible.
> 
> why would it not be possible?
> 
> >You have to understand that the ACPI spec is weird and complex.  The
> >mere fact that you have written a system image to disk changes the way
> >ACPI regards the shutdown procedure.  Even though you may treat all the
> >devices and the rest of the hardware exactly the same, it's a different
> >operation as far as ACPI is concerned, with different requirements.
> >
> >Yes, it's bizarre.  Why do you think so many people have complained so
> >vehemently about ACPI for all these years?
> 
> so let's act as if ACPI doesn't exist and make a suspend-to-disk that 
> works without it and looks to ACPI like a complete power off/on cycle (but 
> looks to the user like a suspend/resume cycle)

...if you act as if ACPI does not exist, you'll loose AC/battery power
status upon resume, and maybe more, because ACPI handles that.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
