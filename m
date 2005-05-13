From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC] Disabling Devices
Date: Fri, 13 May 2005 00:30:44 -0700
Message-ID: <200505130030.44565.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0505111458200.16579-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9239257216787885=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505111458200.16579-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============9239257216787885==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 11 May 2005 12:10 pm, Alan Stern wrote:
> On Wed, 11 May 2005, David Brownell wrote:
> 
> > On Monday 09 May 2005 11:06 am, Alan Stern wrote:
> > > There's an issue here that needs to be discussed explicitly.  How finely
> > > should the kernel allow userspace to control runtime power management?
> > > 
> > > ...
> > >     (B) Or should the kernel export a relatively small set of power 
> > > 	domains and a small set of primitives for each domain?  Like:
> > > 	suspend, turn off remote wakeup, go to full power, suspend
> > > 	after N seconds of inactivity?
> > > 
> > > ...
> > > 
> > > In general (A) most resembles what sysfs does right now.  I suspect that 
> > > (B) will be a better solution in the end.
> > 
> > Yes.
> 
> Assuming other people agree, the question becomes: What structures and 
> resources does the kernel need in order to implement and export these 
> power domains and primitives?

And for what purposes?  Different purposes tend to need different answers
for those other questions.


> > > Regarding Dave's comments about hdparm and xset dpms -- what matters most 
> > > about these interfaces is not that they are application-specific but that 
> > > they are ad-hoc. 
> > 
> > How does "application-specific" differ from "ad-hoc" though?
> > In practical terms; one is more pejorative than the other, but
> > how exactly does one measure a difference?
> 
> "Application-specific" refers to the fact that the interfaces are used (or
> are intended to be used) by only one or two applications; the term has
> nothing to do with kernel code. 

Actually it does; "application" is a pretty generic term, and
from the hardware perspective, the "application" often includes
things like OS software (which is different in each product).
It's not just different userspace programs or user interfaces.

So for example PM concepts exported through a driver stack can
be "application specific" ... different subsystems may need to
handle them differently, because of different requirements.


> "Ad-hoc" on the other hand describes the 
> way in which the kernel implements the interfaces.

This doesn't enlighten me in terms of objective measures.
Different applications imply different implementations,
and often different interfaces.  X11 is a network
protocol, so 'xset dpms' uses network messages.  But IDE
isn't, so "hdparm" uses IDE messages.


> > For example, the kernel doesn't know about X11 protocol at all,
> > or those particular IDE protocol requests.  And most folk would
> > probably say that it shouldn't need to ...
> 
> Isn't it true that with IDE drives, you tell the drive how long to wait 
> before doing an idle spindown?  So the kernel doesn't have to worry about 
> keeping track of when the timeout expires; the firmware takes care of it.  
> If the kernel _did_ need to keep track of the timeout then it _would_ 
> need to understand the IDE protocol for spinning down a disk.

That's my point.  The application in this case is "everything
accessing the IDE drive" and it involves both kernel components
(block driver) and userspace ones ("hdparm").  The IDE disk sure
can't tell the difference in where a request came from!

It's a good point that the firmware itself is another software
component.  In this case it's one with a standardized interface
to setting that spindown timer:  IDE messages, no driver model.


> > For new things, or things being generalized into kernel support,
> > I've no fundamental issue with using sysfs.  But for things that
> > are widely deployed today, I don't see much point in changing
> > interfaces.
> 
> There's no need to change the existing interfaces.  But we could add new
> interfaces so that all devices can be controlled in a uniform way, in
> addition to the application-specific ways they are controlled now.

There are lots of things we could do, yes.  Whether we should, or not,
is a question worth answering.  What's the benefit of a "more uniform"
way to do things?  Is there some problem being solved?

- Dave
 

--===============9239257216787885==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============9239257216787885==--
