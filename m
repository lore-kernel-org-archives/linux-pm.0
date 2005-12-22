From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 22 Dec 2005 12:52:18 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0512221213070.9577-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512220920500.10513-100000@netrider.rowland.org>
	<20051222143448.GB9800@elf.ucw.cz>
	<d120d5000512221020q1ccf79ecm1b6c70a06227c37c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============22259696304948395=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <d120d5000512221020q1ccf79ecm1b6c70a06227c37c@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: dtor_core@ameritech.net
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============22259696304948395==
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Thu, 22 Dec 2005, Dmitry Torokhov wrote:

> On 12/22/05, Pavel Machek <pavel@suse.cz> wrote:
> > Hi!
> >
> > > I recently worked on a patch to unbind USB drivers that don't have
> > > suspend/resume methods, and then rebind them when the system comes back
> > > up.  There was an unexpected effect: In some cases the unbind or rebind
> > > operations caused hotplug events, which started up new user processes at a
> > > time when everything was supposed to be frozen.  Obviously this is not a
> > > good thing.
> > >
> > > Is there some other way these sorts of events can be handled?  For
> > > instance, can the hotplug system be smart enough to delay creating the new
> > > processes?  Or can they be created already in a frozen state?
> >
> > There were some problems with this already... but I do not recall what
> > the solution was. lkml thread, IIRC. Were it PCMCIA cards or something
> > like that?
>
> It was serio layer. I just ensured that all hotplug events are
> generated from serio thread thus making sure that we won't see them
> during suspend.

PCMCIA recently had a similar issue. I can't find an archive for the
linux-pcmcia (@lists.infradead.org), but the thread was titled:
"uevent / call_usermoderrelated breakage on suspend to disk [Was: Re:
PCMCIA-related breakage on suspend to disk]"

Though, the pcmcia case was a bit different - the system would hang
because the artificial insertion events on resume.

My recommendation for the pcmcia case was that a subsystem shouldn't
attempt to discover new devices during the device resume sequence. It
should first deal with devices that are there (and bound to a driver).
Then, it should try to discard devices that still have objects, and
finally discover new devices that have been inserted.

The final two stages should, IMHO, happen after all other devices have
been resumed and userspace is running once again. Implementing this will
probably require a per-subsystem thread, leveraging existing code
(subsystem threads) if possible.

I feel the same about binding/unbinding devices from drivers. In itself,
it sounds like a hack, but I realize that USB devices are treated
specially during suspend/resume. For the sake of getting it working, I
would recommend also waiting until everything else is finished, then
process those devices to bind them to their drivers.


	Patrick


--===============22259696304948395==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============22259696304948395==--
