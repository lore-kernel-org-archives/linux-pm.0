From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for Feb 24
Date: Sun, 24 Feb 2008 21:00:45 +0100
Message-ID: <200802242100.46474.rjw__22237.9054096111$1203883466$gmane$org@sisk.pl>
References: <20080224162309.3e67dd22.sfr@canb.auug.org.au>
	<47C1B52B.3080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47C1B52B.3080104@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Winchester <kjwinchester@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, len.brown@intel.com, LKML <linux-kernel@vger.kernel.org>, pavel@suse.cz, linux-next@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 24 of February 2008, Kevin Winchester wrote:
> Stephen Rothwell wrote:
> > Hi all,

Hi,

> > I have created today's linux-next tree at
> > git://git.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.git.
> > =

> > You can see which trees have been included by looking in the Next/Trees
> > file in the source.  There are also quilt-import.log and merge.log files
> > in the Next directory.  Between each merge, the tree was built with
> > allmodconfig for both powerpc and x86_64.
> > =

> > There only one minor merge problem and a few build failures (the two in
> > Linus' tree have been fixed and the other reported).
> > =

> > We are up to 32 trees, more are welcome (even if they are currently
> > empty).
> > =

> > Status of my local build tests is at
> > http://kisskb.ellerman.id.au/kisskb/branch/9/.
> > =

> =

> I tried something with this tree that I haven't tried in a while - Suspend
> to RAM.  It has not often worked for me in the past with any tree, but
> normally there isn't any information in the log that indicates the cause =
of
> the failure.
> =

> Today was different - I attempted to suspend and resume from the console,
> and the machine did not come back up.  I found the following in my log -
> any help would be appreciated.
> =

> Feb 24 13:59:56 alekhine kernel: [  456.497875] PM: Syncing filesystems .=
.. done.
> Feb 24 14:00:20 alekhine kernel: [  456.507273] Freezing user space proce=
sses ... (elapsed 0.00 seconds) done.
> Feb 24 14:00:20 alekhine kernel: [  456.510447] Freezing remaining freeza=
ble tasks ... (elapsed 0.00 seconds) done.
> Feb 24 14:00:20 alekhine kernel: [  456.510754] ACPI: Preparing to enter =
system sleep state S3
> Feb 24 14:00:20 alekhine kernel: [  456.612370] Suspending console(s)
> Feb 24 14:00:20 alekhine kernel: [  456.616254] sd 3:0:0:0: [sda] Synchro=
nizing SCSI cache
> Feb 24 14:00:20 alekhine kernel: [  456.616521] sd 3:0:0:0: [sda] Stoppin=
g disk
> Feb 24 14:00:20 alekhine kernel: [  456.618221] ACPI: PCI interrupt for d=
evice 0000:00:11.5 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.630296] ACPI: PCI interrupt for d=
evice 0000:00:10.4 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.641085] ACPI: PCI interrupt for d=
evice 0000:00:10.3 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.651877] ACPI: PCI interrupt for d=
evice 0000:00:10.2 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.662716] ACPI: PCI interrupt for d=
evice 0000:00:10.1 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.673550] ACPI: PCI interrupt for d=
evice 0000:00:10.0 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.684385] ACPI: PCI interrupt for d=
evice 0000:00:0f.1 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.695056] ACPI: PCI interrupt for d=
evice 0000:00:0f.0 disabled
> Feb 24 14:00:20 alekhine kernel: [  456.705856] 5 locks held by bash/2929:
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  #0:  (&buffer->mutex){--=
..}, at: [<c018960c>] sysfs_write_file+0x25/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  #1:  (pm_mutex){--..}, a=
t: [<c0138c54>] enter_state+0xea/0x100
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  #2:  (pm_sleep_rwsem){--=
--}, at: [<c023c4b8>] device_suspend+0x25/0x251
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  #3:  (&data->update_lock=
#2){--..}, at: [<c029cb2b>] abituguru_suspend+0x13/0x18
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  #4:  (&vptr->lock){++..}=
, at: [<c0244665>] velocity_suspend+0x37/0x302
> Feb 24 14:00:20 alekhine kernel: [  456.705856] irq event stamp: 19374
> Feb 24 14:00:20 alekhine kernel: [  456.705856] hardirqs last  enabled at=
 (19373): [<c0326664>] __mutex_unlock_slowpath+0xd5/0xef
> Feb 24 14:00:20 alekhine kernel: [  456.705856] hardirqs last disabled at=
 (19374): [<c0327bca>] _spin_lock_irqsave+0xf/0x3c
> Feb 24 14:00:20 alekhine kernel: [  456.705856] softirqs last  enabled at=
 (18484): [<c011e6ba>] __do_softirq+0x99/0x9e
> Feb 24 14:00:20 alekhine kernel: [  456.705856] softirqs last disabled at=
 (18479): [<c0104f15>] do_softirq+0x58/0xa8
> Feb 24 14:00:20 alekhine kernel: [  456.705856] Pid: 2929, comm: bash Not=
 tainted 2.6.25-rc2-next-20080224 #58
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01177c7>] __schedule_=
bug+0x58/0x5f
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0325b43>] schedule+0x=
67/0x3b3

Well, could you check what's at schedule+0x67, please?

> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0121c39>] ? __mod_tim=
er+0x8d/0x98
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0326043>] schedule_ti=
meout+0x73/0x91
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c012185c>] ? process_t=
imeout+0x0/0xa
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0326075>] schedule_ti=
meout_uninterruptible+0x14/0x16
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0121c54>] msleep+0x10=
/0x16
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01e0e51>] pci_set_pow=
er_state+0x17f/0x200
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0244917>] velocity_su=
spend+0x2e9/0x302

velocity_suspend() seems to be at fault.

At the moment I have to take care of some more urgent things, I'll have a l=
ook
at it tomorrow.

> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0133854>] ? mark_held=
_locks+0x4e/0x66
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0326664>] ? __mutex_u=
nlock_slowpath+0xd5/0xef
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01339dd>] ? trace_har=
dirqs_on+0xe5/0x120
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01e249e>] pci_device_=
suspend+0x1b/0x4b
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c023c625>] device_susp=
end+0x192/0x251
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0138a7a>] suspend_dev=
ices_and_enter+0x3d/0xe0
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0138c1c>] enter_state=
+0xb2/0x100
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0138cfe>] state_store=
+0x94/0xac
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0138c6a>] ? state_sto=
re+0x0/0xac
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01d50c5>] kobj_attr_s=
tore+0x1a/0x22
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c018969f>] sysfs_write=
_file+0xb8/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01895e7>] ? sysfs_wri=
te_file+0x0/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c01597d7>] vfs_write+0=
x88/0xf8
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0159c6e>] sys_write+0=
x3b/0x60
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  [<c0102bfa>] sysenter_pa=
st_esp+0x5f/0xa5
> Feb 24 14:00:20 alekhine kernel: [  456.705856]  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Feb 24 14:00:20 alekhine kernel: [  456.716732] =

> Feb 24 14:00:20 alekhine kernel: [  456.716732] =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Feb 24 14:00:20 alekhine kernel: [  456.716732] [ INFO: inconsistent lock=
 state ]
> Feb 24 14:00:20 alekhine kernel: [  456.716732] 2.6.25-rc2-next-20080224 =
#58
> Feb 24 14:00:20 alekhine kernel: [  456.716732] -------------------------=
--------
> Feb 24 14:00:20 alekhine kernel: [  456.716732] inconsistent {in-hardirq-=
W} -> {hardirq-on-W} usage.
> Feb 24 14:00:20 alekhine kernel: [  456.716732] bash/2929 [HC0[0]:SC0[0]:=
HE1:SE1] takes:
> Feb 24 14:00:20 alekhine kernel: [  456.716732]  (&vptr->lock){++..}, at:=
 [<c0244665>] velocity_suspend+0x37/0x302
> Feb 24 14:00:20 alekhine kernel: [  456.716732] {in-hardirq-W} state was =
registered at:
> Feb 24 14:00:20 alekhine kernel: [  456.716732]   [<c013416b>] __lock_acq=
uire+0x3ac/0xb43
> Feb 24 14:00:20 alekhine kernel: [  456.716732]   [<c0134963>] lock_acqui=
re+0x61/0x7d
> Feb 24 14:00:20 alekhine kernel: [  456.716732]   [<c0243940>] velocity_i=
ntr+0x24/0x579
> Feb 24 14:00:20 alekhine kernel: [  456.716732]   [<c03279fb>] _spin_lock=
+0x23/0x32
> Feb 24 14:00:20 alekhine kernel: [  456.716732]   [<c0243940>] velocity_i=
ntr+0x24/0x579
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c0243940>] velocity_i=
ntr+0x24/0x579
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c02ca5e1>] snd_via823=
3_interrupt+0xdc/0xe7
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c013a884>] handle_fas=
teoi_irq+0x95/0xab
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c01398b3>] handle_IRQ=
_event+0x1a/0x46
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c013a88d>] handle_fas=
teoi_irq+0x9e/0xab
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c013a7ef>] handle_fas=
teoi_irq+0x0/0xab
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<c0105010>] do_IRQ+0xa=
b/0xd4
> Feb 24 14:00:20 alekhine kernel: [  456.716733]   [<ffffffff>] 0xffffffff
> Feb 24 14:00:20 alekhine kernel: [  456.716733] irq event stamp: 19374
> Feb 24 14:00:20 alekhine kernel: [  456.716733] hardirqs last  enabled at=
 (19373): [<c0326664>] __mutex_unlock_slowpath+0xd5/0xef
> Feb 24 14:00:20 alekhine kernel: [  456.716733] hardirqs last disabled at=
 (19374): [<c0327bca>] _spin_lock_irqsave+0xf/0x3c
> Feb 24 14:00:20 alekhine kernel: [  456.716733] softirqs last  enabled at=
 (18484): [<c011e6ba>] __do_softirq+0x99/0x9e
> Feb 24 14:00:20 alekhine kernel: [  456.716733] softirqs last disabled at=
 (18479): [<c0104f15>] do_softirq+0x58/0xa8
> Feb 24 14:00:20 alekhine kernel: [  456.716733] =

> Feb 24 14:00:20 alekhine kernel: [  456.716733] other info that might hel=
p us debug this:
> Feb 24 14:00:20 alekhine kernel: [  456.716733] 5 locks held by bash/2929:
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  #0:  (&buffer->mutex){--=
..}, at: [<c018960c>] sysfs_write_file+0x25/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  #1:  (pm_mutex){--..}, a=
t: [<c0138c54>] enter_state+0xea/0x100
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  #2:  (pm_sleep_rwsem){--=
--}, at: [<c023c4b8>] device_suspend+0x25/0x251
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  #3:  (&data->update_lock=
#2){--..}, at: [<c029cb2b>] abituguru_suspend+0x13/0x18
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  #4:  (&vptr->lock){++..}=
, at: [<c0244665>] velocity_suspend+0x37/0x302
> Feb 24 14:00:20 alekhine kernel: [  456.716733] =

> Feb 24 14:00:20 alekhine kernel: [  456.716733] stack backtrace:
> Feb 24 14:00:20 alekhine kernel: [  456.716733] Pid: 2929, comm: bash Not=
 tainted 2.6.25-rc2-next-20080224 #58
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0132d3b>] print_usage=
_bug+0x10d/0x11a
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c013361f>] mark_lock+0=
x1f1/0x3d8
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0133854>] mark_held_l=
ocks+0x4e/0x66
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0327ec3>] ? _spin_unl=
ock_irq+0x22/0x42
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01339c7>] trace_hardi=
rqs_on+0xcf/0x120
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0327ec3>] _spin_unloc=
k_irq+0x22/0x42
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0117322>] finish_task=
_switch+0x46/0x7d
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01172dc>] ? finish_ta=
sk_switch+0x0/0x7d
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0325e39>] schedule+0x=
35d/0x3b3
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0121c39>] ? __mod_tim=
er+0x8d/0x98
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0326043>] schedule_ti=
meout+0x73/0x91
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c012185c>] ? process_t=
imeout+0x0/0xa
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0326075>] schedule_ti=
meout_uninterruptible+0x14/0x16
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0121c54>] msleep+0x10=
/0x16
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01e0e51>] pci_set_pow=
er_state+0x17f/0x200
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0244917>] velocity_su=
spend+0x2e9/0x302
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0133854>] ? mark_held=
_locks+0x4e/0x66
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0326664>] ? __mutex_u=
nlock_slowpath+0xd5/0xef
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01339dd>] ? trace_har=
dirqs_on+0xe5/0x120
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01e249e>] pci_device_=
suspend+0x1b/0x4b
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c023c625>] device_susp=
end+0x192/0x251
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0138a7a>] suspend_dev=
ices_and_enter+0x3d/0xe0
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0138c1c>] enter_state=
+0xb2/0x100
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0138cfe>] state_store=
+0x94/0xac
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0138c6a>] ? state_sto=
re+0x0/0xac
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01d50c5>] kobj_attr_s=
tore+0x1a/0x22
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c018969f>] sysfs_write=
_file+0xb8/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01895e7>] ? sysfs_wri=
te_file+0x0/0xe3
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c01597d7>] vfs_write+0=
x88/0xf8
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0159c6e>] sys_write+0=
x3b/0x60
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  [<c0102bfa>] sysenter_pa=
st_esp+0x5f/0xa5
> Feb 24 14:00:20 alekhine kernel: [  456.716733]  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Feb 24 14:00:20 alekhine kernel: [  456.729170] Intel machine check archi=
tecture supported.
> Feb 24 14:00:20 alekhine kernel: [  456.729170] Intel machine check repor=
ting enabled on CPU#0.
> Feb 24 14:00:20 alekhine kernel: [  456.733181] Velocity is AUTO mode
> Feb 24 14:00:20 alekhine kernel: [  456.733182] ACPI: PCI Interrupt 0000:=
00:0f.0[B] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 20
> Feb 24 14:00:20 alekhine kernel: [  456.733184] ACPI: PCI Interrupt 0000:=
00:0f.1[A] -> Link [ALKA] -> GSI 20 (level, low) -> IRQ 20
> Feb 24 14:00:20 alekhine kernel: [  456.733185] ACPI: PCI Interrupt 0000:=
00:10.0[A] -> GSI 21 (level, low) -> IRQ 21
> Feb 24 14:00:20 alekhine kernel: [  456.733185] usb usb2: root hub lost p=
ower or was reset
> Feb 24 14:00:20 alekhine kernel: [  456.744080] ACPI: PCI Interrupt 0000:=
00:10.1[A] -> GSI 21 (level, low) -> IRQ 21
> Feb 24 14:00:20 alekhine kernel: [  456.744080] usb usb3: root hub lost p=
ower or was reset
> Feb 24 14:00:20 alekhine kernel: [  456.754997] ACPI: PCI Interrupt 0000:=
00:10.2[B] -> GSI 21 (level, low) -> IRQ 21
> Feb 24 14:00:20 alekhine kernel: [  456.754997] usb usb4: root hub lost p=
ower or was reset
> Feb 24 14:00:20 alekhine kernel: [  456.765914] ACPI: PCI Interrupt 0000:=
00:10.3[B] -> GSI 21 (level, low) -> IRQ 21
> Feb 24 14:00:20 alekhine kernel: [  456.765914] usb usb5: root hub lost p=
ower or was reset
> Feb 24 14:00:20 alekhine kernel: [  456.776818] ACPI: PCI Interrupt 0000:=
00:10.4[C] -> GSI 21 (level, low) -> IRQ 21
> Feb 24 14:00:20 alekhine kernel: [  456.787745] ACPI: PCI Interrupt 0000:=
00:11.5[C] -> GSI 22 (level, low) -> IRQ 22
> Feb 24 14:00:20 alekhine kernel: [  456.789881] ACPI: PCI Interrupt 0000:=
01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
> Feb 24 14:00:20 alekhine kernel: [  456.789961] sd 3:0:0:0: [sda] Startin=
g disk
> Feb 24 14:00:20 alekhine kernel: [  457.031803] ata3.01: ACPI cmd ef/03:0=
c:00:00:00:b0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  457.031803] ata3.01: ACPI cmd ef/03:4=
2:00:00:00:b0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  457.185224] ata3.00: ACPI cmd ef/03:0=
c:00:00:00:a0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  457.185224] ata3.00: ACPI cmd ef/03:4=
2:00:00:00:a0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  457.340841] ata3.00: configured for U=
DMA/33
> Feb 24 14:00:20 alekhine kernel: [  457.528347] ata3.01: configured for U=
DMA/33
> Feb 24 14:00:20 alekhine kernel: [  460.975795] ata4.00: ACPI cmd ef/03:0=
c:00:00:00:a0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  460.975795] ata4.00: ACPI cmd ef/03:4=
5:00:00:00:a0 filtered out
> Feb 24 14:00:20 alekhine kernel: [  460.978040] ata4.00: configured for U=
DMA/100
> Feb 24 14:00:20 alekhine kernel: [  460.981191] sd 3:0:0:0: [sda] 1563014=
88 512-byte hardware sectors (80026 MB)
> Feb 24 14:00:20 alekhine kernel: [  460.981191] sd 3:0:0:0: [sda] Write P=
rotect is off
> Feb 24 14:00:20 alekhine kernel: [  460.981191] sd 3:0:0:0: [sda] Write c=
ache: enabled, read cache: enabled, doesn't support DPO or FUA
> Feb 24 14:00:20 alekhine kernel: [  461.524370] Restarting tasks ... <6>u=
sb 2-1: USB disconnect, address 2
> Feb 24 14:00:20 alekhine kernel: [  461.569374] done.
> Feb 24 14:00:21 alekhine kernel: [  461.755858] usb 2-1: new low speed US=
B device using uhci_hcd and address 4
> Feb 24 14:00:21 alekhine kernel: [  461.915256] usb 2-1: configuration #1=
 chosen from 1 choice
> Feb 24 14:00:21 alekhine kernel: [  461.955599] input: Logitech USB Mouse=
 as /devices/pci0000:00/0000:00:10.0/usb2/2-1/2-1:1.0/input/input5
> Feb 24 14:00:21 alekhine kernel: [  461.979344] input: USB HID v1.10 Mous=
e [Logitech USB Mouse] on usb-0000:00:10.0-1
> Feb 24 14:00:21 alekhine kernel: [  461.979553] usb 2-2: USB disconnect, =
address 3
> Feb 24 14:00:21 alekhine kernel: [  462.236114] usb 2-2: new low speed US=
B device using uhci_hcd and address 5
> Feb 24 14:00:21 alekhine kernel: [  462.405538] usb 2-2: configuration #1=
 chosen from 1 choice
> Feb 24 14:00:21 alekhine kernel: [  462.439929] input: Microsoft Microsof=
t=AE Digital Media Pro Keyboard as /devices/pci0000:00/0000:00:10.0/usb2/2-=
2/2-2:1.0/input/input6
> Feb 24 14:00:21 alekhine kernel: [  462.463834] input: USB HID v1.11 Keyb=
oard [Microsoft Microsoft=AE Digital Media Pro Keyboard] on usb-0000:00:10.=
0-2
> Feb 24 14:00:21 alekhine kernel: [  462.492181] input: Microsoft Microsof=
t=AE Digital Media Pro Keyboard as /devices/pci0000:00/0000:00:10.0/usb2/2-=
2/2-2:1.1/input/input7
> Feb 24 14:00:21 alekhine kernel: [  462.517592] input: USB HID v1.11 Devi=
ce [Microsoft Microsoft=AE Digital Media Pro Keyboard] on usb-0000:00:10.0-2
