From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Fri, 23 Dec 2005 10:20:32 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512231018040.15462-100000@netrider.rowland.org>
References: <200512222252.55553.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============99487976746659301=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512222252.55553.dtor_core@ameritech.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============99487976746659301==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 22 Dec 2005, Dmitry Torokhov wrote:

> On Thursday 22 December 2005 22:49, Patrick Mochel wrote:
> > 
> > On Thu, 22 Dec 2005, Alan Stern wrote:
> > 
> > > I'm not so sure this approach really qualifies as a "hack".  If a driver
> > > doesn't have explicit support for suspend/resume, the best way to quiesce
> > > it is to unbind it.  The only alternative is to fail all of its I/O
> > > requests, which seems much less reliable.
> > 
> > Hmm, the best way to queisce it seems to be to fix the driver. Sure, that
> > doesn't solve your problems now, but that is the ideal solution, no? Until
> > then, band-aids like unbinding the device from the driver is only a remedy
> > to a symptom; not a cure..
> >
> 
> Quite often unbinding is easiest and also correct way. I would love to be
> able to just unbind serio port/input device and have it recreated later.
> Unfortunately X/GPM do not [yet?] support hotplugging of devices so kernel
> has to compensate.

I agree with Dmitry.  Many drivers don't need to do anything special for 
suspend, or only need to cancel an outstanding input request.  Rather than 
go through every single driver and add a minimal (and possibly erroneous) 
suspend routine, it's much easier just to unbind these drivers.

Alan Stern


--===============99487976746659301==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============99487976746659301==--
