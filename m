From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.21-rc1: known regressions (v2) (part 1)
Date: Mon, 19 Mar 2007 16:32:22 +0100
Message-ID: <20070319153222.GF1915@elf.ucw.cz>
References: <Pine.LNX.4.64.0702202043280.4043@woody.linux-foundation.org> <20070226220152.GA29575@stusta.de> <20070228211318.GB4301@mellanox.co.il> <b6a2187b0702281945n5f62a6b5w1c535de3ef9aaa8f@mail.gmail.com> <20070305000421.GF3441@stusta.de> <b6a2187b0703051732v79a532f6mbf0d3da857a914e6@mail.gmail.com> <b6a2187b0703060403o48130853m9393df70160303c1@mail.gmail.com> <20070306120808.GA9537@mellanox.co.il> <b6a2187b0703060412l66fe8db8l12e5403821d1438b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6a2187b0703060412l66fe8db8l12e5403821d1438b@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeff Chua <jeff.chua.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.osdl.org, Ingo Molnar <mingo@elte.hu>, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


> >> > > > I have the same problem on my IBM X60s on rc1 and rc2. Can't resume
> >> > > > from RAM, can't suspend to disk. It is possible to revert all the
> >> > > > changes to ACPI and test it?
> >> > >
> >> > > This is with CONFIG_KVM=n?
> >> >
> >> > Yes.
> >>
> >> I've tried with CONFIG_KVM=n and CONFIG_KVM=y and both does not suspend.
> >
> >Do you mean that they "do not resume after suspend"?
> 
> I can't even suspend to disk/ram. It just hangs and the lights just
> blink and everything else hangs. With 2.6.20, it works fine.

Turn up console loglevel, and see where it hangs...

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
