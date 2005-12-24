From: Greg KH <greg@kroah.com>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sat, 24 Dec 2005 09:02:13 -0800
Message-ID: <20051224170213.GA29138@kroah.com>
References: <20051223212827.GA17350@kroah.com>
	<Pine.LNX.4.44L0.0512241001500.23067-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============018449121724503303=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512241001500.23067-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Nigel Cunningham <ncunningham@cyclades.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============018449121724503303==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 24, 2005 at 10:11:13AM -0500, Alan Stern wrote:
> On Fri, 23 Dec 2005, Greg KH wrote:
> 
> > On Fri, Dec 23, 2005 at 04:22:44PM -0500, Alan Stern wrote:
> > > On Fri, 23 Dec 2005, Pavel Machek wrote:
> > > 
> > > > Well, if you can find some elegant solution in the core, I think thats
> > > > the best way.
> > > > 
> > > > You could set system_state to "suspending" or something like that, and
> > > > just if() out notifications in that case.
> > > 
> > > How about simply adding a call to try_to_freeze() somewhere inside 
> > > kernel/kmod.c:____call_usermodehelper()?  That ought to do pretty much 
> > > what I want, in theory.  The hotplug processes would get frozen before 
> > > /sbin/hotplug is exec'ed.
> > 
> > On modern distros, /sbin/hotplug is set to NULL, so this isn't an issue.
> > We use netlink to send the data out, so this might not even be a problem
> > anymore...
> 
> Indeed it might not.  On my older FC3 system I end up with unwanted 
> processes, but under FC4 that doesn't happen.  (Note however that even on 
> the FC4 system, /sbin/hotplug is not empty and /proc/sys/kernel/hotplug 
> does point to /sbin/hotplug.)

I said "modern" :)
Rawhide should have this set to NULL, as well as SuSE, Gentoo unstable
and Debian unstable.

thanks,

greg k-h

--===============018449121724503303==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============018449121724503303==--
