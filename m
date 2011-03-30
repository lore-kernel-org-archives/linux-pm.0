From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Wed, 30 Mar 2011 17:19:54 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1103301707210.2085-100000__25794.7062993937$1301577970$gmane$org@iolanthe.rowland.org>
References: <201103302202.04025.rjw@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103302202.04025.rjw@suse.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@suse.com>
Cc: akpm@linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jiri Slaby <jirislaby@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 30 Mar 2011, Rafael J. Wysocki wrote:

> > Rafael, this does seem to be a general problem.  Suppose a new device
> > gets connected while the system is suspended.  How is the driver's
> > probe method supposed to cope if it gets called while userspace is
> > still frozen but it needs to load some firmware?
> > 
> > Is the answer that probing should always be delayed until after tasks
> > are thawed?  There must be lots of subsystems which would have trouble 
> > doing that, although we ought to be able to implement delayed probing 
> > from within the driver core easily enough.
> 
> I don't know how to solve that.
> 
> First off, the prepare routines of drivers that need to load firmware during
> resume probably should preload the firmware for the devices present during the
> suspend.

That's okay for drivers that are bound to a device before the suspend 
starts.  But we also need to handle new devices added while the system 
was asleep.

> Second, I don't generally think drivers should probe for devices during resume.
> I guess the delayed probing would be the cleanest appoach here.

Here's the difficulty.  Normally the USB subsystem does use delayed
probing -- in fact, probing is done in a freezable thread.  However
this is a special case.  Not all USB drivers support suspend/resume;
those that don't get unbound during suspend and then rebound during
resume.  The rebinding occurs in the "complete" phase of the resume,
before tasks are thawed.

I suppose the rebinding could be delayed.  It would be better to fix
the USB DVB drivers, though, by adding PM support.  But there's a bunch
of them in drivers/media/dvb/dvb-usb, and AFAICS they would all need to
be fixed.  And I have no idea of what changes they would need.

Do you have any better suggestions?

Alan Stern
