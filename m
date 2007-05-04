From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re:
	suspend2 merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Fri, 4 May 2007 10:57:21 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0705041054520.3417-100000@iolanthe.rowland.org>
References: <20070503221848.GB13426@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070503221848.GB13426@elf.ucw.cz>
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
Cc: Johannes Berg <johannes@sipsolutions.net>, Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.linux-foundation.org, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Fri, 4 May 2007, Pavel Machek wrote:

> Hi!
> 
> > > > Well... the powerdown during hibernation... does not have _anything_
> > > > to do with snapshot/restore. It is really a very deep sleep; similar
> > > > to soft powerdown, but not quite.
> > 
> > Is this really a good idea?
> 
> We have no other choice. ACPI spec says we should use S4.

I haven't checked the spec, but I find it hard to believe.  What could 
possibly be wrong with using S5?  It works just fine for normal poweroff, 
with no wakeup devices enabled.  Provided you don't enable the wakeup 
devices during hibernation, why not use S5?

> Unfortunately if we do normal powerdown, we'll confuse ACPI BIOS.

We do normal powerdown whenever someone shuts off his computer without 
hibernating.  I haven't noticed any ACPI BIOS confusion from that...

Alan Stern
