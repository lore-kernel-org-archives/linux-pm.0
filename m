From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 22:50:28 +0200
Message-ID: <200705042250.29760.rjw@sisk.pl>
References: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.linux-foundation.org, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Friday, 4 May 2007 16:57, Alan Stern wrote:
> On Fri, 4 May 2007, Pavel Machek wrote:
> 
> > Hi!
> > 
> > > > > Well... the powerdown during hibernation... does not have _anything_
> > > > > to do with snapshot/restore. It is really a very deep sleep; similar
> > > > > to soft powerdown, but not quite.
> > > 
> > > Is this really a good idea?
> > 
> > We have no other choice. ACPI spec says we should use S4.
> 
> I haven't checked the spec, but I find it hard to believe.  What could 
> possibly be wrong with using S5?  It works just fine for normal poweroff, 
> with no wakeup devices enabled.  Provided you don't enable the wakeup 
> devices during hibernation, why not use S5?

I think the problem is the "reinitialize from scratch after the resume" part.

If we're waking up from the hibernation, device drivers should reinitialize
their devices, but if we're waking up from a suspend (eg. s2ram), it would be
wrong to reinitialize, for example, the ACPI subsystem from scratch.  Now,
the problem is that the drivers (including ACPI drivers) cannot tell whether
the resume is from hibernation or from suspend so they try to do something
"generic".  This may lead to having the system not fully functional after the
resume from hibernation if we don't tell the ACPI BIOS that we're hibernating
(by entering the S4 state instead of S5).

> > Unfortunately if we do normal powerdown, we'll confuse ACPI BIOS.
> 
> We do normal powerdown whenever someone shuts off his computer without 
> hibernating.  I haven't noticed any ACPI BIOS confusion from that...

In fact, I think, the BIOS isn't confused, but it may preserve some state
information that the OS can use later on.  By entering S4 we tell the BIOS
to tell the "next" kernel that we've hibernated and to preserve some
configuration information for it.  If this information is not present, our own
ACPI drivers get confised during the resume.

To prevent this from happening, we need a separate set of hibernation callbacks
in device drivers.

Greetings,
Rafael
