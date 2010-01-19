From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [Update][RFC][PATCH] PM / Runtime: Add sysfs switch
 for disabling device run-time PM
Date: Tue, 19 Jan 2010 10:40:22 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1001191035150.1437-100000__42348.7533735626$1263915689$gmane$org@iolanthe.rowland.org>
References: <201001182325.28094.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201001182325.28094.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 Jan 2010, Rafael J. Wysocki wrote:

> > Ouch.  This does nearly the same thing as the power/level attribute in
> > the USB subsystem, but in an incompatible and more complicated way.
> > 
> > The power/level attribute can contain either "on" or "auto", meaning
> > that the device is always on or that it is subject to automatic runtime
> > power management (autosuspend).
> 
> It looks like my "disable" is similar to "on", while my "enable" is similar to
> "auto".  I can use "auto" and "on" just fine.

Good.

> > Changing the setting from "auto" to "on" merely does sets a flag and does
> > pm_runtime_get_sync(); changing it from "on" to "auto" clears the flag and
> > does pm_runtime_put_sync().
> 
> We can do it almost this way in general, although I think the flag should be
> changed under the power.lock.

Yes.  I was using the device semaphore, but the power.lock is more 
appropriate here.

> Updated patch is appended.

Why change the name from "level" to "runtime"?

>  /*
> + *	runtime - Report/change current runtime PM setting of the device
> + *
> + *	Runtime power management of a device can be blocked with the help of
> + *	this attribute.  All devices have one of the following two values for
> + *	the power/runtime file:
> + *
> + *	 + "auto\n" to allow the device to be power managed at run time;
> + *	 + "on\n" to prevent the device from being power managemed at run time;

---------------------------------------------------------------^^  typo

Don't forget to add an entry to Documentation/ABI/testing/.

Alan Stern
