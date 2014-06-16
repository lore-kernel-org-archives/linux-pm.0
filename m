From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: v3.16-rc1 regression? unexpected usb_autopm_get_interface error
Date: Mon, 16 Jun 2014 17:15:46 +0200
Message-ID: <874mzkga1p.fsf@nemi.mork.no>
References: <Pine.LNX.4.44L0.1406161106470.1292-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:43122 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255AbaFPPos convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jun 2014 11:44:48 -0400
In-Reply-To: <Pine.LNX.4.44L0.1406161106470.1292-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 16 Jun 2014 11:08:54 -0400 (EDT)")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Dan Williams <dan.j.williams@intel.com>, USB list <linux-usb@vger.kernel.org>, Linux-pm mailing list <linux-pm@vger.kernel.org>

Alan Stern <stern@rowland.harvard.edu> writes:
> On Mon, 16 Jun 2014, Bj=C3=B8rn Mork wrote:
>> Bj=C3=B8rn Mork <bjorn@mork.no> writes:
>>=20
>> > So the problem is related to runtime suspend before first use. I
>> > strongly suspect=20
>> >
>> >  aae4518b3124 PM / sleep: Mechanism to avoid resuming runtime-susp=
ended devices unnecessarily
>>=20
>> Nope, that was not it. So if blind guessing isn't going to work, the=
n I
>> guess there is no way around a bisect :-)
>
> You could simply wait for someone who knows the code to answer the=20
> question.  :-)

Wait? Do I look like I'm patient :-)

Besides, it was actually relieving to bisect a reliably reproducible
non-crashing bug for once ;-)

> I'm pretty sure this resulted from one of Dan Williams's changes to U=
SB=20
> port runtime PM.  A whole bunch of them were added in 3.15-rc1.

You are *so* much better at guessing than me:

9262c19d14c433a6a1ba25c3ff897cb89e412309 is the first bad commit
commit 9262c19d14c433a6a1ba25c3ff897cb89e412309
Author: Dan Williams <dan.j.williams@intel.com>
Date:   Tue May 20 18:08:12 2014 -0700

    usb: disable port power control if not supported in wHubCharacteris=
tics
   =20
    A hub indicates whether it supports per-port power control via the
    wHubCharacteristics field in its descriptor.  If it is not supporte=
d
    a hub will still emulate ClearPortPower(PORT_POWER) requests by
    stopping the link state machine.  However, since this does not save
    power do not bother suspending.
   =20
    This also consolidates support checks into a
    hub_is_port_power_switchable() helper.
   =20
    Acked-by: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

:040000 040000 d4a0ba9da62e47951b60332f69d73931727ecab9 faf9138355178ac=
da4bd0bb0077c520bf46bb10c M      drivers


And the "git bisect log":

# bad: [7171511eaec5bf23fb06078f59784a3a0626b38f] Linux 3.16-rc1
# good: [1860e379875dfe7271c649058aeddffe5afd9d0d] Linux 3.15
git bisect start 'v3.16-rc1' 'v3.15'
# bad: [aaeb2554337217dfa4eac2fcc90da7be540b9a73] Merge branch 'v4l_for=
_linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-=
media into next
git bisect bad aaeb2554337217dfa4eac2fcc90da7be540b9a73
# good: [5142c33ed86acbcef5c63a63d2b7384b9210d39f] Merge tag 'staging-3=
=2E16-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/stag=
ing into next
git bisect good 5142c33ed86acbcef5c63a63d2b7384b9210d39f
# bad: [b05d59dfceaea72565b1648af929b037b0f96d7f] Merge tag 'for-linus'=
 of git://git.kernel.org/pub/scm/virt/kvm/kvm into next
git bisect bad b05d59dfceaea72565b1648af929b037b0f96d7f
# bad: [e13cccfd86481bd4c0499577f44c570d334da79b] Merge tag 'spi-v3.16'=
 of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi into next
git bisect bad e13cccfd86481bd4c0499577f44c570d334da79b
# bad: [4a95b1fce97756d0333f8232eb7ed6974e93b054] usb: hub_handle_remot=
e_wakeup() only exists for CONFIG_PM=3Dy
git bisect bad 4a95b1fce97756d0333f8232eb7ed6974e93b054
# good: [54969ed6c4d0b9eb7fa68a909be231f383f0c406] usb: ohci-exynos: Us=
e struct device instead of platform_device
git bisect good 54969ed6c4d0b9eb7fa68a909be231f383f0c406
# good: [0943d8ead30e9474034cc5e92225ab0fd29fd0d4] USB: cdc-acm: use tt=
y-port dtr_rts
git bisect good 0943d8ead30e9474034cc5e92225ab0fd29fd0d4
# good: [657d898a9320a7cdb9b94565d75ecf75c25cbf0a] usb: usb5303: add su=
pport for reference clock specified in device tree
git bisect good 657d898a9320a7cdb9b94565d75ecf75c25cbf0a
# bad: [5c79a1e303363d46082408fd306cdea6d33013fc] usb: introduce port s=
tatus lock
git bisect bad 5c79a1e303363d46082408fd306cdea6d33013fc
# bad: [d8521afe35862f4fbe3ccd6ca37897c0a304edf3] usb: assign default p=
eer ports for root hubs
git bisect bad d8521afe35862f4fbe3ccd6ca37897c0a304edf3
# good: [342a74934197386e065e8ef00014e6f0cb5effe6] usb: pci_quirks: fix=
 sparse 'symbol not declared' warning
git bisect good 342a74934197386e065e8ef00014e6f0cb5effe6
# bad: [9262c19d14c433a6a1ba25c3ff897cb89e412309] usb: disable port pow=
er control if not supported in wHubCharacteristics
git bisect bad 9262c19d14c433a6a1ba25c3ff897cb89e412309
# good: [600856c231ccb0cbf8afcf09066a8ab2a93ab03d] USB: mutual exclusio=
n for resetting a hub and power-managing a port
git bisect good 600856c231ccb0cbf8afcf09066a8ab2a93ab03d




Bj=C3=B8rn
