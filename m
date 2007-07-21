From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Hibernation considerations
Date: Sat, 21 Jul 2007 12:25:20 +0200
Message-ID: <20070721102520.GE1902__24049.7566563592$1185013642$gmane$org@elf.ucw.cz>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
	<200707171802.30903.rjw@sisk.pl>
	<Pine.LNX.4.64.0707170959160.2467@asgard.lang.hm>
	<200707172150.44417.rjw@sisk.pl>
	<Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707171302430.2467@asgard.lang.hm>
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

> from my point of view the ACPI S4 sleep mode has far more in common with 
> suspend-to-ram then with the suspend-to-disk that I'm talking about
> 
> non-ACPI hibernate
> 
>   since the box powers off
>     it uses zero power while suspended
>     another OS could be run before a resume
>     hardware can be swapped, suspend image could be sent around the world 
>     to be restored on another system.
>     restore makes no assumptions about the state of the hardware when it is 
>     restored
>     restore is slower (full BIOS boot is required)
>   should be able to work on just about any hardware (the limit is the 
>   ability to initialize the devices)

So it will be break at least battery status and "AC plugged in"
status, because those are handled by ACPI and we do not know how to
control them by hand.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
