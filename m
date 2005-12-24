From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sat, 24 Dec 2005 10:11:13 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512241001500.23067-100000@netrider.rowland.org>
References: <20051223212827.GA17350@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============91772248061930251=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051223212827.GA17350@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============91772248061930251==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Fri, 23 Dec 2005, Greg KH wrote:

> On Fri, Dec 23, 2005 at 04:22:44PM -0500, Alan Stern wrote:
> > On Fri, 23 Dec 2005, Pavel Machek wrote:
> > 
> > > Well, if you can find some elegant solution in the core, I think thats
> > > the best way.
> > > 
> > > You could set system_state to "suspending" or something like that, and
> > > just if() out notifications in that case.
> > 
> > How about simply adding a call to try_to_freeze() somewhere inside 
> > kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
> > what I want, in theory.  The hotplug processes would get frozen before 
> > /sbin/hotplug is exec'ed.
> 
> On modern distros, /sbin/hotplug is set to NULL, so this isn't an issue.
> We use netlink to send the data out, so this might not even be a problem
> anymore...

Indeed it might not.  On my older FC3 system I end up with unwanted 
processes, but under FC4 that doesn't happen.  (Note however that even on 
the FC4 system, /sbin/hotplug is not empty and /proc/sys/kernel/hotplug 
does point to /sbin/hotplug.)

The ideal situation would be to have PF_FREEZE automatically set for every
new process created while userspace was frozen.  Kernel threads could
remove the flag and set PF_NOFREEZE if they wanted, while user processes
would automatically get frozen before returning to userspace.  This
approach would eliminate all the loopholes at once.

Alan Stern


--===============91772248061930251==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============91772248061930251==--
