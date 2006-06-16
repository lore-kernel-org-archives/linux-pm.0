From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 11:45:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606161135280.5498@g5.osdl.org>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
	<200606160704.34093.david-b@pacbell.net>
	<Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606161114110.5498@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org



On Fri, 16 Jun 2006, Linus Torvalds wrote:
> =

> ie I think it's literally an "outl()" followed by a "udelay()", and there =

> is basically _zero_ room for problems. The "unfreeze" is then just =

> setting the "run controller" bit again.

Something like

	/*
	 * Used to temporarily stop all activity.
	 */
	static void freeze_uhci(struct uhci_hcd *uhci)
	{
		u16 cmd;

		if (uhci->is_stopped)
			return;
		cmd =3D inw(uhci->io_addr + USBCMD) & ~USBCMD_RS;
		outw(cmd, uhci->io_addr + USBCMD);
		udelay(1);
	}

	static void unfreeze_uhci(struct uhci_hcd *uhci)
	{
		u16 cmd;
		if (uhci->is_stopped)
			return;
		cmd =3D inw(uhci->io_addr + USBCMD) | USBCMD_RS;
		outw(cmd, uhci->io_addr + USBCMD);
	}

would seem to be enough, if the caller also guarantees that interrupts are =

off during this (which you'd also want regardless, I assume).

For a number of simple devices, just disabling interrupts guarantees that =

they won't do anything, but busmasters obviously need to be told to stop =

their BM engine (which is what the above should do for UHCI).

Of course, these days EHCI etc is probably more interesting than UHCI, but =

I only personally worked with UHCI, so I don't know the details, but I =

assume it has a similar "run" bit in some command register.

My point is, this has nothing to do with _suspending_ the device.

		Linus
