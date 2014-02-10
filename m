From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: 3.12: ethernet controller missing after resuming from suspend
 to RAM
Date: Mon, 10 Feb 2014 09:17:08 +0100
Message-ID: <52F88B04.2080309@gmail.com>
References: <52F2CC7B.80406@gmail.com> <55671594.HynIX0trOC@vostro.rjw.lan> <52F41DB8.3080802@gmail.com> <2087423.Qy7HQIx1X6@vostro.rjw.lan> <52F7CC8B.1020209@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:49250 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbaBJIQI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 10 Feb 2014 03:16:08 -0500
In-Reply-To: <52F7CC8B.1020209@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bastien Traverse <bastien.traverse@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Wu <lekensteyn@gmail.com>
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>

On 02/09/2014 07:44 PM, Bastien Traverse wrote:
> Le 07/02/2014 02:19, Rafael J. Wysocki a =C3=A9crit :
>> Please send the output of lspci -vv right before suspend and right a=
fter
>> the subsequent resume as attachments.
>=20
> You'll find them attached, but I got a strange error when I wanted to
> run it as root:
> $ sudo lspci -vv > lspci_vv_before
> pcilib: sysfs_read_vpd: read failed: Connection timed out
> $ sudo -i
> # lspci -vv
> pcilib: sysfs_read_vpd: read failed: Connection timed out
>=20
> So I only got the unpriviledge output.
>=20
> Some complementary lines from my journal:
>=20
> kernel: r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
> kernel: r8169 0000:03:00.2: can't disable ASPM; OS doesn't have ASPM =
control
> kernel: pcieport 0000:00:1c.3: driver skip pci_set_master, fix it!
> kernel: r8169 0000:03:00.2: irq 44 for MSI/MSI-X
> kernel: r8169 0000:03:00.2 eth0: RTL8411 at 0xffffc90016ed4000,
> 00:90:f5:d7:34:53, XID 08800800 IRQ 44
> kernel: r8169 0000:03:00.2 eth0: jumbo features [frames: 9200 bytes, =
tx
> checksumming: ko]
> kernel: rtsx_pci 0000:03:00.0: irq 45 for MSI/MSI-X
> kernel: rtsx_pci 0000:03:00.0: rtsx_pci_acquire_irq: pcr->msi_en =3D =
1,
> pci->irq =3D 45
> ...
>=20
> And one I thought of interest:
>=20
> kernel: rtsx_pci 0000:03:00.0: vpd r/w failed.  This is likely a
> firmware bug on this device.  Contact the card vendor for a firmware =
update.
>=20
> That came three times before suspend.
>=20
> Only two lines about hotplug, none special.
>=20
> Stripped journal attached for the suspend cycle.
>=20
>=20
> Le 07/02/2014 08:29, Francis Moreau a =C3=A9crit :
>> yeah, but calling this "fast resolution" is quite incorrect.
>>
>> I don't blame anyone for this and I'm quite happy that a workaround =
has
>> been found at last but calling this "fast resolution" is a bit funny
>> compare to the PITA it was to debug this.
>=20
> Sorry, I didn't mean to underestimate the amount of work you put in t=
hat
> bug resolution (actually it was the first time I heard of kernel
> bisection and was pretty impressed by how you led it).

No problem Bastien and don't be impressed by this :). Bisection thing i=
s
a mechanical work but can be useful sometimes when we, users, are lost
and have no clue on what's going on.

The real PITA in that case was to reboot more than 10 times the system
in order to test each suspicious commits on a live system.

Anyways, good luck, all my hopes are on you now :)

