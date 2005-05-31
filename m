From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Wed, 01 Jun 2005 09:31:49 +1000
Message-ID: <1117582309.5826.60.camel@gaston>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz> <1117550660.5826.42.camel@gaston>
	<20050531212556.GA14968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============58140433904559785=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050531212556.GA14968@elf.ucw.cz>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============58140433904559785==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


> Why do you need it? Do you initiate suspend without userland asking
> you to?

Because there is an existing API, via /dev/apm_bios, and that's all X
understands ! And because I've always done that ;)

> Anyway, it should not be arch-dependend. We need one good mechanism of
> notifying userland, not one per architecture.

We need to define a new mecanism, I think. In the meantime, my APM
emulation works though and I won't drop it. 

> > > > 	/* called after unfreezing userland */
> > > > 	void (*post_freeze)(suspend_state_t state);
> > > > 
> > > > That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
> > > > it also calls my old-style notifiers, which includes APM emulation, which is important
> > > > for sending the APM wakeup events to things like X.
> > > 
> > > Could this be marked deprecated, too?
> > > 
> > > Alternatively, proper way of notifying X (etc) should be created, and
> > > done from generic code....
> > 
> > Sure, ideally. However, existing X knows how to deal with APM events,
> > and thus APM emulation is an important thing to get something that
> > works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> > I think Russell improve my stuff significantly.
> 
> Perhaps we need apm emulation on i386, too?

Maybe. It may help in some cases.

Ben.



--===============58140433904559785==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============58140433904559785==--
