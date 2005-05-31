From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC] Add some hooks to generic suspend code
Date: Tue, 31 May 2005 23:25:56 +0200
Message-ID: <20050531212556.GA14968@elf.ucw.cz>
References: <1117524577.5826.35.camel@gaston>
	<20050531101344.GB9614@elf.ucw.cz>
	<1117550660.5826.42.camel@gaston>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============47899894677979193=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1117550660.5826.42.camel@gaston>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============47899894677979193==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > While consolidating the powermac suspend to ram and suspend to disk
> > > implementations to properly use the new framework in kernel/power, among
> > > others, I ended up with the need of adding various callbacks to
> > > kernel/power/main.c. Here is a patch adding & documenting those.
> > > 
> > > The reasons I need them are:
> > > 
> > > 	/* Call before process freezing. If returns 0, then no freeze
> > > 	 * should be done, if 1, freeze, negative -> error
> > > 	 */
> > > 	int (*pre_freeze)(suspend_state_t state);
> > > 
> > > I'm using that one for calling my "old style" notifiers (they are beeing phased
> > > out but I still have a couple of drivers using them). The reason I do that here
> > > is because that's how my APM emulation hooks, and that code interacts with userland
> > > (to properly signal things like X of the suspend process), so I need to do that
> > > before we freeze processes.
> > 
> > This should not be needed in future, right? Could it be marked
> > deprecated or something?
> 
> Not really ... I need to notify userland before we freeze processes.

Why do you need it? Do you initiate suspend without userland asking
you to?

Anyway, it should not be arch-dependend. We need one good mechanism of
notifying userland, not one per architecture.

> > > 	/* called after unfreezing userland */
> > > 	void (*post_freeze)(suspend_state_t state);
> > > 
> > > That one is the mirror of pre-freeze, gets called after userland has been re-enabled,
> > > it also calls my old-style notifiers, which includes APM emulation, which is important
> > > for sending the APM wakeup events to things like X.
> > 
> > Could this be marked deprecated, too?
> > 
> > Alternatively, proper way of notifying X (etc) should be created, and
> > done from generic code....
> 
> Sure, ideally. However, existing X knows how to deal with APM events,
> and thus APM emulation is an important thing to get something that
> works. Pne thing I should do is consolidate PPC APM emu with ARM one as
> I think Russell improve my stuff significantly.

Perhaps we need apm emulation on i386, too?
									Pavel

--===============47899894677979193==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============47899894677979193==--
