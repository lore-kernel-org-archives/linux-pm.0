From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: s2ram slow (radeon) / failing (usb)
Date: Sun, 2 May 2010 18:04:10 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1005021759260.30701-100000__37607.1103186861$1272837893$gmane$org@netrider.rowland.org>
References: <201005022216.05641.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201005022216.05641.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Kosina <jkosina@suse.cz>, Bruno =?utf-8?q?Pr=C3=A9mont?= <bonbons@linux-vserver.org>, USB list <linux-usb@vger.kernel.org>, Kernel development list <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2 May 2010, Rafael J. Wysocki wrote:

> On Sunday 02 May 2010, Bruno Pr=C3=A9mont wrote:
> > On Sun, 02 May 2010 Alan Stern <stern@rowland.harvard.edu> wrote:
> > > On Sun, 2 May 2010, Bruno [UTF-8] Pr=C3=A9mont wrote:
> > > > On a IEI Kino 690S1 I'm having a hard time to get s2ram running.
> > > > It freezes during device suspend (unless I rmmod everything USB
> > > > related) - usb fails even in pm_test case 'devices'.
> > > > =

> > > > When the system is able to suspend it takes an eternity (more than 3
> > > > minutes to wake-up, the radeon apparently being responsible for qui=
te
> > > > a big share of that slowness.
> > > > =

> > > > =

> > > > During resume early it looks like every PCI access needs about a se=
cond,
> > > > and there are a few cases where during lots of seconds nothing seem=
s to
> > > > happen and the first event following is related to radeon.
> > > > =

> > > > The kernel used is todays Linus's tree at commit be1066bbcd443a65df=
312fdecea7e4959adedb45
> > > > with Dave's drm-linus and drm-radeon-testing applied on top.
> > > > =

> > > > Note, I've not been able to suspend to RAM properly recently (last =
one
> > > > that worked correctly but resumed without graphics was some-when du=
ring
> > > > 2.6.2x, before KMS)
> > > > Since then the system would either fail suspend or resume.
> > > > =

> > > > Manual changes I applied in order to find out some context informat=
ion:
> > > > - add a few debugging printk's to ata/ahci as that was the last ent=
ry
> > > >   on serial console for freezing suspends (that one succeeded but
> > > >   following step never completed, from suspend_prepare that would h=
ave
> > > >   been USB =3D> unload usb before suspend)
> > > > - strip "if EMBEDED" from CONFIG_SERIAL_8250_PNP and disabled it so=
 serial
> > > >   console would continue working as long as possible and output sus=
pend
> > > >   progress (resume output happens only very late)
> > > > =

> > > > Is there some additional information I could gather in order do help
> > > > improving s2ram on this system?
> > > > - get it to suspend with usb loaded (ohci + ehci)
> > > > - get it to resume a reasonable speed
> > > =

> > > There's no way to fix the USB problem without knowing what goes wrong=
.  =

> > > Let's see how far you get before the system freezes on a kernel with =

> > > CONFIG_USB_DEBUG enabled.
> > =

> > Am I missing something?
> > =

> > I've enabled CONFIG_USB_DEBUG but don't see any additional module param=
eter
> > nor anything extra to toggle and I don't get more output than without i=
t.
> > =

> > Device suspend (pm_test =3D device) works well when there is no USB dev=
ice
> > connected, but with USB keyboard I get the freeze (though the keyboard
> > is still usable, e.g. CAPS key works and I can issue SYSRQ commands).
> > =

> > When I issue sysreq-t, I find the following suspicious entry:
> > [  669.112505] usbhid_resume D ffff88007a085fd8     0  1145      2 0x00=
000000
> > [  669.112505]  ffff88007a085e20 0000000000000046 ffff88007a085fd8 ffff=
88007c536820
> > [  669.112505]  ffff88007a085fd8 ffff88007a085fd8 00000000000129c0 0000=
0000000129c0
> > [  669.112505]  ffff88007c536820 ffff88007cf3f040 ffff88007a085fd8 ffff=
88007a085fd8
> > [  669.112505] Call Trace:
> > [  669.112505]  [<ffffffff8105d765>] refrigerator+0x95/0xf0
> > [  669.112505]  [<ffffffff81051a16>] worker_thread+0xc6/0x1e0
> > [  669.112505]  [<ffffffff81055e90>] ? autoremove_wake_function+0x0/0x40
> > [  669.112505]  [<ffffffff81051950>] ? worker_thread+0x0/0x1e0
> > [  669.112505]  [<ffffffff810559be>] kthread+0x8e/0xa0
> > [  669.112505]  [<ffffffff81003a94>] kernel_thread_helper+0x4/0x10
> > [  669.112505]  [<ffffffff81055930>] ? kthread+0x0/0xa0
> > [  669.112505]  [<ffffffff81003a90>] ? kernel_thread_helper+0x0/0x10
> > =

> > Except for that one there are a few async/* tasks waiting.
> =

> It looks like the freezer fails on your system.

To me it suggests that a kernel thread is needed during system resume
even though it is still frozen, rather like the problem with
del_gendisk.  Jiri, could the usbhid_resume thread cause a hang in
this way?

Alan Stern
