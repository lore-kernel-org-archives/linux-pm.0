From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Wed, 6 Oct 2010 16:08:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010061606330.2047-100000__20323.2964886867$1286395794$gmane$org@iolanthe.rowland.org>
References: <201010062108.00366.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010062108.00366.rjw@sisk.pl>
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
Cc: samu.p.onkalo@nokia.com, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, ext Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 6 Oct 2010, Rafael J. Wysocki wrote:

> > Mobile folks wish to power down some devices (most often input -
> > touchscreen, keypad) under certain circumstances to save power.
> > So far they were doing that by adding "disable" hook to individual
> > drivers and while I did allow that in for some devices I feel that we
> > need more standardised solution, preferably one that could re-use
> > existing PM hooks in drivers.
> 
> There's no interface for that at the PM core level, but I think we should
> add it, perhaps in analogy to the autosuspend one.  Namely, we can add a
> flag for drivers who want to make their suspend/resume callbacks to be
> reachable directly from user space.  Setting that flag would enable a sysfs
> attribute in /sys/devices/.../power/ allowing user space to invoke
> pm_runtime_suspend() and pm_runtime_resume() for the given device.

We already have power/control.  If the subsystem sets it to "on" by 
default and the driver suspends the device whenever it is idle, then 
userspace can control the power level by writing "auto" or "on" to 
power/control.

Alan Stern
