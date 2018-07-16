From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v3 0/3] regulator: bd9571mwv: Add support for toggle power switches
Date: Mon, 16 Jul 2018 10:58:22 +0200
Message-ID: <CAMuHMdUqPW8wv=nuvesBDXf7iVeY378oNBXERCzKLrbPZ1SzFg@mail.gmail.com>
References: <20180713154720.18316-1-geert+renesas@glider.be> <20180715165749.GA10023@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180715165749.GA10023@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Pavel,

On Sun, Jul 15, 2018 at 6:57 PM Pavel Machek <pavel@ucw.cz> wrote:
> > The ROHM BD9571MWV PMIC on the Renesas Salvator-X(S) and ULCB
> > development boards supports DDR Backup Power, which means that the DDR
> > power rails can be kept powered while the main SoC is powered down.
> >
> > This patch series extends the support for DDR backup mode (see commit
> > 6eb0bfae6973eb6a ("regulator: bd9571mwv: Add support for backup mode"))
> > to systems with toggle instead of momentary power switches.
> >
> > With a toggle power switch (or level signal), the following steps must
> > be followed exactly:
> >    1. Configure PMIC for backup mode, which changes the role of the
> >       power switch to a wake-up switch,
> >    2. Switch accessory power switch off, to prepare for system suspend,
> >       which is a manual step not controlled by software,
> >    3. Suspend system,
> >    4. Switch accessory power switch on, to resume.
> >
> > Unlike on systems with a momentary toggle switch, an additional step 2
> > must be performed in between step 1 and step 3.  Hence step 1 can no
> > longer be handled in the PMIC's suspend callback.
> >
> > This patch series allows performing step 1 when the user writes
> > "on" to the PMIC's "backup_mode" virtual file in sysfs, e.g.
> >
> >     echo on > /sys/bus/i2c/drivers/bd9571mwv/*/bd9571mwv-regulator*/backup_mode
>
> Do you expect more boards to have similar design?
>
> If so, we may want to have standard place in /sys/ not depending on
> i2c paths and driver names, but I believe such design is so... awkward
> that it is not going to appear anywhere else...?

I have no idea. The BD9571MWV PMIC supports two power switch wirings.
Only one of them is problematic for usability reasons.
The newer Renesas ULCB boards use the good wiring.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
