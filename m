From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Flames over -- Re: Which is simpler?
Date: Wed, 15 Feb 2006 10:56:01 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0602151049490.4598-100000@iolanthe.rowland.org>
References: <200602142141.10545.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98527638871829093=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200602142141.10545.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============98527638871829093==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Tue, 14 Feb 2006, Rafael J. Wysocki wrote:

> > Remember that it's always a bad idea to unplug a disk drive containing a
> > mounted filesystem.  With USB that's true even when your system is asleep!
> > The safest thing is to unmount all USB-based filesystems before suspending 
> > and remount them after resuming.
> 
> Still, this may be impossible if the box is suspending because of its
> battery running critical.

Yes.  When there's nothing you can do... do nothing.  :-)

> I'm afraid this behavior will cause support problems to appear in the long
> run.   [BTW, I wonder if it's USB-only, or some other subsystems behave
> in a similar way, like ieee1394 or external SATA.  And how about
> NFS/CIFS/whatever network filesystems mounted on the suspending box?]

Some networked filesystems may have this problem, for instance, if they 
rely on some sort of keep-alive to maintain a connection.  I don't know 
anything about 1394 or SATA.

> I think one solution to consider could be to add an abstract fs layer
> on top of the removable filesystem, like subfs in SuSE, with the ability
> to retain the user information accross device disconnects and to update
> the fs state from the actual device when it reappears in the system and
> to resolve possible conflicts (to a reasonable extent).

Maybe.  To me this seems an unavoidable policy decision that should be 
settled by one of the big Linux panjandrums.  Maybe someone can convince 
Andrew (or even Linus) to offer a ruling...

> > I'm not aware of any warnings about this in the documentation.  If you 
> > would like to add something, please go ahead.
> 
> I'm going to do this.  Can I use your explanation above?

Feel free to use it.

Alan Stern


--===============98527638871829093==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98527638871829093==--
