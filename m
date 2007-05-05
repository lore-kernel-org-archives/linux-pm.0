From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Sat, 5 May 2007 11:52:06 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705051149360.1976-100000@netrider.rowland.org>
References: <200705042353.52409.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200705042353.52409.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Pekka Enberg <penberg@cs.helsinki.fi>, Pavel Machek <pavel@ucw.cz>, Johannes Berg <johannes@sipsolutions.net>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 May 2007, Rafael J. Wysocki wrote:

> > Plus, it may have some parts related to the communications with operating
> > system (*)... I guess we need to save those, and parts related to hw
> > state... where your suggestion makes sense.
> 
> If they are accessible to us, then we can, but what if they aren't (eg. the
> state information is stored in the embedded controller, can only be read with
> the help of some AML invocations and cannot be changed from the OS level)?
> 
> > (*) and yes, there probably are such parts. If we set backlight to
> > 20%, we'll be confused if it is 100% after resume... we probably could
> > handle those one-by-one...
> 
> *If* we reinitialize devices *and* ACPI from scratch after restoring the image,
> we'll discard the old value (20%) and read the new value (100%) from the BIOS.
> The problems occur, IMO, because we try to be smart and use the BIOS
> after the resume as though we'd resumed from a real suspend (eg. s2ram).
> 
> Which is natural, if we use the same set of .resume() callbacks for both cases.

Agreed, these all sound like problems in the ACPI driver's implementation 
of suspend and resume.  Problems that are caused (at least in part) by the 
fact that the PM core doesn't tell the driver whether it's doing
suspend-to-RAM vs. hibernation.  Once that is straighened out, everything 
else should become much simpler.

Alan Stern
