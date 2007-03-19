From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Mon, 19 Mar 2007 22:23:29 +0100
Message-ID: <200703192223.31222.rjw@sisk.pl>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <b6a2187b0703060412l66fe8db8l12e5403821d1438b@mail.gmail.com> <20070319153222.GF1915@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20070319153222.GF1915@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, 19 March 2007 16:32, Pavel Machek wrote:
> 
> > >> > > > I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> > >> > > > from RAM, can't suspend to disk. It is possible to revert all the
> > >> > > > changes to ACPI and test it?
> > >> > >
> > >> > > This is with CONFIG_KVM=n?
> > >> >
> > >> > Yes.
> > >>
> > >> I've tried with CONFIG_KVM=n and CONFIG_KVM=y and both does not suspend.
> > >
> > >Do you mean that they "do not resume after suspend"?
> > 
> > I can't even suspend to disk/ram. It just hangs and the lights just
> > blink and everything else hangs. With 2.6.20, it works fine.
> 
> Turn up console loglevel, and see where it hangs...

I think CONFIG_DISABLE_CONSOLE_SUSPEND would have to be set for this purpose
too.

Greetings,
Rafael
