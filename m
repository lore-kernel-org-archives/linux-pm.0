From: Martin Steigerwald <martin@lichtvoll.de>
Subject: Re: [4.1-rc1][Hibernation failed]  bisect result  included
Date: Sun, 03 May 2015 20:24:04 +0200
Message-ID: <1843682.KATYecaz4u@merkaba>
References: <36DF59CE26D8EE47B0655C516E9CE6402CA0E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mondschein.lichtvoll.de ([194.150.191.11]:50298 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751035AbbECSYH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 3 May 2015 14:24:07 -0400
In-Reply-To: <36DF59CE26D8EE47B0655C516E9CE6402CA0E2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Chen, Yu C" <yu.c.chen@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "dehrenberg@chromium.org" <dehrenberg@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>

Am Sonntag, 3. Mai 2015, 15:54:39 schrieb Chen, Yu C:
> Hi,all,

Hello!

> When we are doing QA test, a hibernation failor was found on latest k=
ernel 4.1-rc1,
> resume from hibernation failed with the following error:
>=20
> PM: Hibernation image not present or could not be loaded.
>=20
> Bisect shows following commit might trigger this problem:
> commit 283e7ad0241155710f99a9f39d13313a53336926
>=20
> The  reason for failor is that, some distribution use klibc in initrd
> to restore the image, and klibc will provide kernel with the device=20
> format of major:minor:offset,
> for example, 8:3:0 represents a swap partition, and klibc will
> echo 8:3:0 > /sys/power/resume to resume the system manually.
> However in current implementation, format of 8:3:0 will be regarded=20
> as an invalid device, so restoring from hibernation failed.
>=20
> Do we need to add support for device format like 8:3:0?
> I'm happy to debug more specifically if you can let me know what=20
> would be of use, and I've also attached a temporary patch=20
> for this problem, not sure if it is suitable,  thanks.

Wow, great.

I just reported this as well, but you bisected it already.

So seems Debian=B4s initramfs uses klibc. Appears so:

https://wiki.debian.org/initramfs

merkaba:/boot> lsinitramfs -l initrd.img-4.0.1-tp520-btrfs-trim-norace+=
 | egrep "klibc|libc.so"
-rwxr-xr-x   1 root     root      1729984 Apr 15 02:01 lib/x86_64-linux=
-gnu/libc.so.6
-rwxr-xr-x   1 root     root        71416 Oct  5  2014 lib/klibc-IpHGKK=
bZiB_yZ7GPagmQz2GwVAQ.so

It seems to contain a glibc as well.

Ciao,
--=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
