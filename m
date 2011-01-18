From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Resume from Memory very slow on 2.6.37+
Date: Tue, 18 Jan 2011 13:19:26 +0800
Message-ID: <AANLkTikB1f6QFO8nP3DDV+2JF2HWaaDao4N5b1XYBJL___45959.3343585313$1295328123$gmane$org@mail.gmail.com>
References: <AANLkTimBEnKTuR5aQyXvpZX8grQPw1eCaVgP-k9yBXhv@mail.gmail.com>
	<201101180114.42664.rjw@sisk.pl>
	<AANLkTi=nGmW=3XGRzxJ1avbz-PcE_QSdVBddOM1yMiBh@mail.gmail.com>
	<201101180235.59498.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201101180235.59498.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, Jack Steiner <steiner@sgi.com>, Linus Torvalds <torvalds@linux-foundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 18, 2011 at 9:35 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Do you have CONFIG_RCU_CPU_STALL_DETECTOR set? =A0If not, please set it. =
=A0Then,
> set CONFIG_RCU_CPU_STALL_TIMEOUT to something like 10 (in either case), r=
un
> a suspend-resume cycle and see if there are any CPU stalls reported in the
> logs.

Configured and see nothing specific. The 30 seconds delays is
indicated below in the dmesg at resume ...

2011-01-18T13:00:48.399866+08:00 boston kernel: PM: early resume of
devices complete after 50.816 msecs
2011-01-18T13:00:48.399868+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399871+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399874+08:00 boston kernel: i915 0000:00:02.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399877+08:00 boston kernel: i915 0000:00:02.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399879+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
PCI INT D -> GSI 23 (level, low) -> IRQ 23
2011-01-18T13:00:48.399882+08:00 boston kernel: i915 0000:00:02.0:
setting latency timer to 64
2011-01-18T13:00:48.399884+08:00 boston kernel: ehci_hcd 0000:00:1a.0:
setting latency timer to 64
2011-01-18T13:00:48.399887+08:00 boston kernel: HDA Intel
0000:00:1b.0: PCI INT B -> GSI 17 (level, low) -> IRQ 17
2011-01-18T13:00:48.399889+08:00 boston kernel: HDA Intel
0000:00:1b.0: setting latency timer to 64
2011-01-18T13:00:48.399892+08:00 boston kernel: HDA Intel
0000:00:1b.0: irq 41 for MSI/MSI-X
2011-01-18T13:00:48.399894+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399898+08:00 boston kernel: pci 0000:00:1e.0:
setting latency timer to 64
2011-01-18T13:00:48.399901+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
power state changed by ACPI to D0
2011-01-18T13:00:48.399904+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
PCI INT D -> GSI 19 (level, low) -> IRQ 19
2011-01-18T13:00:48.399906+08:00 boston kernel: ehci_hcd 0000:00:1d.0:
setting latency timer to 64
2011-01-18T13:00:48.399941+08:00 boston kernel: ahci 0000:00:1f.2:
setting latency timer to 64
2011-01-18T13:00:48.399943+08:00 boston kernel: sd 0:0:0:0: [sda] Starting =
disk
2011-01-18T13:00:48.399946+08:00 boston kernel: ioremap error for
0xbb77e000-0xbb781000, requested 0x10, got 0x0
2011-01-18T13:00:48.399949+08:00 boston kernel: ata1: SATA link up 3.0
Gbps (SStatus 123 SControl 300)
2011-01-18T13:00:48.399953+08:00 boston kernel: ata1.00: ACPI cmd
ef/02:00:00:00:00:a0 (unknown) succeeded
2011-01-18T13:00:48.399955+08:00 boston kernel: ata1.00: ACPI cmd
f5/00:00:00:00:00:a0 (unknown) filtered out
2011-01-18T13:00:48.399958+08:00 boston kernel: ata1.00: ACPI cmd
ef/10:03:00:00:00:a0 (unknown) filtered out
2011-01-18T13:00:48.399961+08:00 boston kernel: ata1.00: ACPI cmd
ef/02:00:00:00:00:a0 (unknown) succeeded
2011-01-18T13:00:48.399963+08:00 boston kernel: ata1.00: ACPI cmd
f5/00:00:00:00:00:a0 (unknown) filtered out
2011-01-18T13:00:48.399966+08:00 boston kernel: ata1.00: ACPI cmd
ef/10:03:00:00:00:a0 (unknown) filtered out
2011-01-18T13:00:48.399968+08:00 boston kernel: ata1.00: configured for UDM=
A/100
2011-01-18T13:00:48.399970+08:00 boston kernel: ata5: SATA link down
(SStatus 0 SControl 300)
2011-01-18T13:00:48.399973+08:00 boston kernel: ata6: SATA link down
(SStatus 0 SControl 300)
2011-01-18T13:00:48.399975+08:00 boston kernel: PM: resume of devices
complete after 407.508 msecs
<=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D 30 seconds delays here =3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>
2011-01-18T13:00:48.399977+08:00 boston kernel: Restarting tasks ... done.


>> Now I have another problem which might be totally unrelated. Just
>> realized that my notebook can't suspend to "disk" ... used to work
>> last week. So, something has changed as well. May be someone has
>> already reported/fixed this.
>
> Not that I know of. =A0What do you mean by "can't suspend"?


echo platform >/sys/power/disk; echo disk >/sys/power/state

Last line I see is ... "Suspending console(s) (use no_console_suspend
to debug)" .. and activity after that.


Thanks,
Jeff
