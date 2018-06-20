From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 1/2] PM / wakeup: Add callback for wake-up change notification
Date: Wed, 20 Jun 2018 10:02:41 +0200
Message-ID: <2523505.Jaak4fIuPm@aspire.rjw.lan>
References: <20180619135518.8990-1-geert+renesas@glider.be> <CAJZ5v0gGuTDCf8Bsefyj5R6mF=SXZDrt7JacNU5vBZOf84QsvA@mail.gmail.com> <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWgdsSS7qcfPmHnvL-XmXzyoS=bMGgc6q0urcvO5upWvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 19, 2018 5:22:06 PM CEST Geert Uytterhoeven wrote:
> Hi Rafael,
> 
> On Tue, Jun 19, 2018 at 4:48 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Tue, Jun 19, 2018 at 3:55 PM, Geert Uytterhoeven
> > <geert+renesas@glider.be> wrote:
> > > Add a callback to inform a device that its wake-up setting has been
> > > changed.  This allows a device to synchronize device configuration with
> > > an external user action.
> > >
> > > E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> > > switch, the system suspend/resume procedure is:
> > >   1. Configure PMIC for DDR backup mode (by software), which changes the
> > >      role of the accessory power switch from a power to a wake-up
> > >      switch,
> > >   2. Switch accessory power switch off (manually), to prepare for system
> > >      suspend,
> > >   3. Suspend system (by software),
> > >   4. Switch accessory power switch on (manually), to wake up the system.
> > >
> > > As step 2 involves a manual operation, step 1 cannot be combined
> > > with step 3 and performed in the PMIC's suspend callback (unlike on
> > > systems with a momentary power switch).
> > >
> > > Adding the new callback allows to move step 1 to the new callback, to be
> > > performed in response to the user writing "enabled" to the PMIC's
> > > "wakeup" virtual file in sysfs.
> >
> > I still don't quite understand this TBH.
> >
> > In particular, why do you want a write to "wakeup" trigger this
> > instead of having a special sysfs attr for that exposed by your PMIC
> > driver?
> 
> In v1 (https://patchwork.kernel.org/patch/9996567/), I had a
> driver-specific "backup_mode" sysfs file.
> In v2 and later of the driver series (https://lkml.org/lkml/2018/4/18/345),
> I changed that to use the standard "wakeup" file in sysfs, in response to
> a comment from Mark Brown.

Well, I'm not convinced that this is the right approach, though.

> > Writing "enabled" to "wakeup" for the PMIC should enable the PMIC
> > itself to wake up the system, which isn't quite the case, or is it?
> 
> Actually the PMIC cannot wake up the system if backup mode is not enabled.

That doesn't really matter.  "enabled" in "wakeup" only means that user space
allows the device to wake up the system from sleep, but it still may not be
able to do that for certain reasons (like in this case).  By adding this
callback you're changing the meaning of the attribute.

> When suspending the system (PSCI suspend) without enabling backup mode
> first, the system will just crash (which cannot be distinguished from being
> suspended, as PSCI doesn't support any other wake-up sources anyway[*] ;-)
> So in that sense writing "enabled" to the "wakeup" file does enable the
> PMIC to wake up the system.
> 
> Do you still prefer a driver-specific sysfs file?

Yes, I do.

Thanks,
Rafael
