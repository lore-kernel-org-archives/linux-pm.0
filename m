From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/3] Suspend: Testing facility
Date: Sat, 3 Nov 2007 19:23:19 +0100
Message-ID: <20071103182319.GC13202__19732.2907661603$1194114249$gmane$org@elf.ucw.cz>
References: <200711012357.27797.rjw@sisk.pl> <200711012358.27919.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200711012358.27919.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Introduce /sys/power/pm_test_level attribute allowing one to test the suspend
> core code.  Namely, writing a number (1-5) to this file causes the suspend code
> to work in one of the test modes defined as follows:
> 
> 5 - test the freezing of processes
> 4 - test the freezing of processes and suspending of devices
> 3 - test the freezing of processes, suspending of devices and platform global
>     control methods
> 2 - test the freezing of processes, suspending of devices, platform global
>     control methods and the disabling of nonboot CPUs
> 1 - test the freezing of processes, suspending of devices, platform global
>     control methods, the disabling of nonboot CPUs and suspending of
>     platform/system devices
> 
> Then, if a suspend is started by normal means, the suspend core will perform
> its normal operations up to the point indicated by the test level.  Next, it
> will wait for 5 seconds and carry out the resume operations needed to transition
> the system back to the fully functional state.
> 
> Writing 0 to /sys/power/pm_test_level turns the testing off.  The current test
> level may be read from /sys/power/pm_test_level .
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK on whole series, but... should we also remove the old debugging
infrastructure? (Or did I just miss it?)
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
