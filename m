From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: what handles disk drive(s) shutdown?
Date: Fri, 10 Feb 2006 15:08:26 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0602101507470.23838@shark.he.net>
References: <Pine.LNX.4.58.0602091407590.7095@shark.he.net>
	<20060210225605.GB1952@elf.ucw.cz>
	<Pine.LNX.4.58.0602101457460.23838@shark.he.net>
	<20060210230633.GB1947@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060210230633.GB1947@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Sat, 11 Feb 2006, Pavel Machek wrote:

> On P=E1 10-02-06 14:59:58, Randy.Dunlap wrote:
> > On Fri, 10 Feb 2006, Pavel Machek wrote:
> >
> > > Hi!
> > >
> > > > in Documentation/power/devices.txt, I read:
> > > >
> > > > <quote>
> > > > System shutdown -- at least disks need to be spun down, or data m=
ay be
> > > > lost. Quiesce devices, just to make life easier for BIOS. event =3D
> > > > FREEZE, flags =3D SYSTEM_SHUTDOWN
> > > > </quote>
> > > >
> > > > Is this actually done somewhere?  I can't find /SYSTEM_SHUTDOWN/
> > > > in any kernel .h or .c files.
> > >
> > > I think we do FREEZE during shutdown, but flags never got
> > > implemented. It seems nobody really needs them, so...
> >
> > I'm not particular about the flags, but I do have a case of
> > needing to do what the comment describes:  spin down disks
> > during shutdown.  Can anyone suggest how that should be done?
> >
> > [I'm currently adding code to use register_reboot_notifier()
> > and keeping a table of SATA/PATA controllers/channels for use
> > at shutdown...]
>
> No, that is not the right way.
>
> void kernel_shutdown_prepare(enum system_states state)
> {
>         notifier_call_chain(&reboot_notifier_list,
>                 (state =3D=3D SYSTEM_HALT)?SYS_HALT:SYS_POWER_OFF, NULL=
);
>         system_state =3D state;
>         device_shutdown();
> }
>
> device_shutdown() should do it, AFAICT.
>
> If you want to listen to such event, you should just register your
> driver with sysfs and implement .suspend() method. But I believe PATA
> does that already...

I walked thru that code path and didn't see it happening.
And for PATA, please expect libata, not legacy drivers/ide/.

--=20
~Randy
