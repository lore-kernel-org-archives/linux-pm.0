From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Sun, 25 Dec 2005 22:53:30 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512252247460.15623-100000@netrider.rowland.org>
References: <20051225195239.GA1787@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============48787824096233279=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051225195239.GA1787@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============48787824096233279==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Sun, 25 Dec 2005, Pavel Machek wrote:

> > > It is not *that* bad, actually. In system suspend/resume cases, no new
> > > I/O requests can happen, because userspace is frozen. Because of
> > > runtime suspend, you should handle I/O errors properly, but you should
> > > handle I/O errors properly, anyway, so... looks like a solution to me.
> > 
> > You're right, it's not really all that bad.  Note however that in the PPC
> > implementation, Ben H. does not freeze userspace before suspend to RAM.
> 
> Perhaps he'll change his mind ;-))))).
> 
> Yep, for ppc and runtime power management, this is not really
> nice. But if someone forces our device into off state, perhaps
> returning errors to userspace is acceptable solution?

It should be.  Provided the driver doesn't get too confused.  With usblp 
that's not a problem.

> > > > 	Unbind usblp in lieu of suspending it.
> > > 
> > > If this can be done in reasonable ammount of not-too-ugly code, why
> > > not? I think that even Patrick can be convinced by nice patch.
> > 
> > This isn't very hard either.  A sample patch is given below.  I haven't 
> > tested it with vanilla 2.6.15-rc6, but a similar patch works okay on 
> > Greg's development tree.  Apart from the FIXMEs, it's not bad at
> > all.
> 
> Well, the FIXMEs look quite nasty to my untrained eye...

They're not as bad as they look.  The requirement about holding the extra
semaphore matters only for the hub driver; no other USB drivers care about
it AFAIK.  And of course the hub driver _does_ have suspend/resume
support, so the new code wouldn't affect it.

However, I will go ahead as you and Greg suggest.

Alan Stern


--===============48787824096233279==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============48787824096233279==--
