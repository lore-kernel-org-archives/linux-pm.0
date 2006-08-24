From: Pavel Machek <pavel@suse.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 24 Aug 2006 10:03:00 +0200
Message-ID: <20060824080300.GG1952@elf.ucw.cz>
References: <EA12F909C0431D458B9D18A176BEE4A50745BBF5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <EA12F909C0431D458B9D18A176BEE4A50745BBF5@dlee02.ent.ti.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > > I guess it just defines an appropriate policy. You can call it
> > > 'usb_mp3' if you wish ;)
> > > I don't think it's too embedded-specific.
> > =

> > Well, it leads to exponential number of policies -- not nice. Having
> > usb_mp3_fileserver_webserver is not nice.
> =

> To some extent having lots of specific policies in the embedded space is
> inevitable.  The hardware is very tightly coupled.  You may have

Maybe. But you certainly do not have to export that uglyness to
userspace.

> I have some notion that a policy manager can create a state with simple
> & general names like fast, medium, slow (whatever) which is the
> interface in which applications might speak.  A complex policy
> manager

...which is very bad interface for applications. See my other
mail. Applications should not have to play with fast/medium/slow,
explicitely. Instead, on opening /dev/dsp, you should power up the
sound system (and maybe adjust cpu frequency if
neccessary). Application should not have to do echo fast > somewhere
before opening /dev/dsp.

								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
