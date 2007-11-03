From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 1/3] Suspend: Testing facility
Date: Sat, 3 Nov 2007 19:54:00 +0100
Message-ID: <200711031954.01644.rjw__35073.5290827744$1194115102$gmane$org@sisk.pl>
References: <200711012357.27797.rjw@sisk.pl> <200711012358.27919.rjw@sisk.pl>
	<20071103182319.GC13202@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20071103182319.GC13202@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday, 3 November 2007 19:23, Pavel Machek wrote:
> Hi!
> 
> > Introduce /sys/power/pm_test_level attribute allowing one to test the suspend
> > core code.  Namely, writing a number (1-5) to this file causes the suspend code
> > to work in one of the test modes defined as follows:
> > 
> > 5 - test the freezing of processes
> > 4 - test the freezing of processes and suspending of devices
> > 3 - test the freezing of processes, suspending of devices and platform global
> >     control methods
> > 2 - test the freezing of processes, suspending of devices, platform global
> >     control methods and the disabling of nonboot CPUs
> > 1 - test the freezing of processes, suspending of devices, platform global
> >     control methods, the disabling of nonboot CPUs and suspending of
> >     platform/system devices
> > 
> > Then, if a suspend is started by normal means, the suspend core will perform
> > its normal operations up to the point indicated by the test level.  Next, it
> > will wait for 5 seconds and carry out the resume operations needed to transition
> > the system back to the fully functional state.
> > 
> > Writing 0 to /sys/power/pm_test_level turns the testing off.  The current test
> > level may be read from /sys/power/pm_test_level .
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> ACK on whole series, but... should we also remove the old debugging
> infrastructure? (Or did I just miss it?)

Well, I don't want to remove it just yet, but it's going to be deprecated.

Also, after Johannes' remark I thought it wouldn't be a good idea to export the
bare test levels to the user.  For this reason I reworked the patches to use
strings instead of numbers for the test setting (the attribute is now called
"pm_test" and is used in a similar way to "disk").

I'll post the reworked series as soon as I update the changelogs and docs.

Greetings,
Rafael
