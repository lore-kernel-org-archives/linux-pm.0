From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] Disabling Devices
Date: Wed, 11 May 2005 15:10:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0505111458200.16579-100000@iolanthe.rowland.org>
References: <200505110704.40587.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============36159534461145793=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505110704.40587.david-b@pacbell.net>
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

--===============36159534461145793==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 11 May 2005, David Brownell wrote:

> On Monday 09 May 2005 11:06 am, Alan Stern wrote:
> > There's an issue here that needs to be discussed explicitly.  How finely
> > should the kernel allow userspace to control runtime power management?
> > 
> > ...
> >     (B) Or should the kernel export a relatively small set of power 
> > 	domains and a small set of primitives for each domain?  Like:
> > 	suspend, turn off remote wakeup, go to full power, suspend
> > 	after N seconds of inactivity?
> > 
> > ...
> > 
> > In general (A) most resembles what sysfs does right now.  I suspect that 
> > (B) will be a better solution in the end.
> 
> Yes.

Assuming other people agree, the question becomes: What structures and 
resources does the kernel need in order to implement and export these 
power domains and primitives?


> > Regarding Dave's comments about hdparm and xset dpms -- what matters most 
> > about these interfaces is not that they are application-specific but that 
> > they are ad-hoc. 
> 
> How does "application-specific" differ from "ad-hoc" though?
> In practical terms; one is more pejorative than the other, but
> how exactly does one measure a difference?

"Application-specific" refers to the fact that the interfaces are used (or
are intended to be used) by only one or two applications; the term has
nothing to do with kernel code.  "Ad-hoc" on the other hand describes the
way in which the kernel implements the interfaces.

> For example, the kernel doesn't know about X11 protocol at all,
> or those particular IDE protocol requests.  And most folk would
> probably say that it shouldn't need to ...

Isn't it true that with IDE drives, you tell the drive how long to wait 
before doing an idle spindown?  So the kernel doesn't have to worry about 
keeping track of when the timeout expires; the firmware takes care of it.  
If the kernel _did_ need to keep track of the timeout then it _would_ 
need to understand the IDE protocol for spinning down a disk.

> For new things, or things being generalized into kernel support,
> I've no fundamental issue with using sysfs.  But for things that
> are widely deployed today, I don't see much point in changing
> interfaces.

There's no need to change the existing interfaces.  But we could add new
interfaces so that all devices can be controlled in a uniform way, in
addition to the application-specific ways they are controlled now.

Alan Stern


--===============36159534461145793==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============36159534461145793==--
