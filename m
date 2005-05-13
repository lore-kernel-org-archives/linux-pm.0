From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Disabling Devices
Date: Fri, 13 May 2005 11:40:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0505131109310.4924-100000@iolanthe.rowland.org>
References: <200505130030.44565.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============79823285831235979=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505130030.44565.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============79823285831235979==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 13 May 2005, David Brownell wrote:

> > "Application-specific" refers to the fact that the interfaces are used (or
> > are intended to be used) by only one or two applications; the term has
> > nothing to do with kernel code. 
> 
> Actually it does; "application" is a pretty generic term, and
> from the hardware perspective, the "application" often includes
> things like OS software (which is different in each product).
> It's not just different userspace programs or user interfaces.

That's true, but I'm interested in doing Linux kernel development.  Hence 
I use the OS's perspective, according to which an application is a user 
program.

> > "Ad-hoc" on the other hand describes the 
> > way in which the kernel implements the interfaces.
> 
> This doesn't enlighten me in terms of objective measures.
> Different applications imply different implementations,
> and often different interfaces.  X11 is a network
> protocol, so 'xset dpms' uses network messages.  But IDE
> isn't, so "hdparm" uses IDE messages.

You're mixing things up here.  Sure the xset program uses X protocol
messages over a network.  But the X server then carries out the display
power management request either by calling through some OS interface or by
writing directly to the hardware (actually I don't know which).  
Likewise, hdparm doesn't send IDE messages directly to the hardware -- it
uses ioctl to ask the kernel to send the messages for it.  The ioctl and
related kernel interfaces are the ad-hoc ones.

(Surely you can't argue with that!  ioctl is notorious for being ad-hoc.)

> That's my point.  The application in this case is "everything
> accessing the IDE drive" and it involves both kernel components
> (block driver) and userspace ones ("hdparm").  The IDE disk sure
> can't tell the difference in where a request came from!

I disagree.  The application in this case is hdparm.  The kernel is 
separate from the application.  If my viewpoint differs from yours it's 
because I'm working on the Linux kernel, not on disk drive development!

> It's a good point that the firmware itself is another software
> component.  In this case it's one with a standardized interface
> to setting that spindown timer:  IDE messages, no driver model.

True again, but the firmware isn't an application.  And in general we
don't want to have applications talking directly to the firmware; we want
them to talk to device drivers, which means involving the driver model.

(To be honest, I really dislike this use of the word "application".  It's 
short for "application program", which implies some sort of distinction: 
application program vs. utility program vs. system-management program vs. 
program-development program vs...  From the kernel's point of view there's 
just user programs, no more and no less.  Equally detestable is the use 
of "folder" to mean "directory".  Is Apple to blame for all of this?)


> > There's no need to change the existing interfaces.  But we could add new
> > interfaces so that all devices can be controlled in a uniform way, in
> > addition to the application-specific ways they are controlled now.
> 
> There are lots of things we could do, yes.  Whether we should, or not,
> is a question worth answering.  What's the benefit of a "more uniform"
> way to do things?  Is there some problem being solved?

The benefit is for people who write the userspace programs for doing power 
management.  It makes their life much easier if they have a uniform way of 
knowing what power domains are available, what operations are available 
for each domain, and how those operations are carried out.

If you're only concerned about managing a couple of different kinds of 
subsystem (like the display and the IDE drives), then yes, it's okay for 
each to have its own idiosyncratic way of doing things.  For a more 
generalized setting this is something to avoid.

It might even make life easier for kernel programmers to have a single 
unified framework for doing power management.  This doesn't have to mean 
that every driver does exactly the same things as every other driver.

Alan Stern


--===============79823285831235979==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============79823285831235979==--
