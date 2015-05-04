From: Yu Chen <yu.c.chen@intel.com>
Subject: Re: [4.1-rc1][Hibernation failed]  bisect result  included
Date: Mon, 04 May 2015 15:50:39 +0800
Message-ID: <554724CF.5010902@intel.com>
References: <36DF59CE26D8EE47B0655C516E9CE6402CA0E2@SHSMSX101.ccr.corp.intel.com> <1843682.KATYecaz4u@merkaba>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11084 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbbEDHqV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 4 May 2015 03:46:21 -0400
In-Reply-To: <1843682.KATYecaz4u@merkaba>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Martin Steigerwald <martin@lichtvoll.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "dehrenberg@chromium.org" <dehrenberg@chromium.org>, "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>

On 05/04/2015 02:24 AM, Martin Steigerwald wrote:
> Am Sonntag, 3. Mai 2015, 15:54:39 schrieb Chen, Yu C:
>> Hi,all,
>
> Hello!
>
>> When we are doing QA test, a hibernation failor was found on latest =
kernel 4.1-rc1,
>> resume from hibernation failed with the following error:
>>
>> PM: Hibernation image not present or could not be loaded.
>>
>> Bisect shows following commit might trigger this problem:
>> commit 283e7ad0241155710f99a9f39d13313a53336926
>>
>> The  reason for failor is that, some distribution use klibc in initr=
d
>> to restore the image, and klibc will provide kernel with the device
>> format of major:minor:offset,
>> for example, 8:3:0 represents a swap partition, and klibc will
>> echo 8:3:0 > /sys/power/resume to resume the system manually.
>> However in current implementation, format of 8:3:0 will be regarded
>> as an invalid device, so restoring from hibernation failed.
>>
>> Do we need to add support for device format like 8:3:0?
>> I'm happy to debug more specifically if you can let me know what
>> would be of use, and I've also attached a temporary patch
>> for this problem, not sure if it is suitable,  thanks.
>
> Wow, great.
>
> I just reported this as well, but you bisected it already.
>
Oh, I saw your thread :)
> So seems Debian=B4s initramfs uses klibc. Appears so:
>
The place where klibc stores the major:minor:offset to sysfs is:
klibc/usr/kinit/resume/resumelib.c: resume

> https://wiki.debian.org/initramfs
>
> merkaba:/boot> lsinitramfs -l initrd.img-4.0.1-tp520-btrfs-trim-norac=
e+ | egrep "klibc|libc.so"
> -rwxr-xr-x   1 root     root      1729984 Apr 15 02:01 lib/x86_64-lin=
ux-gnu/libc.so.6
> -rwxr-xr-x   1 root     root        71416 Oct  5  2014 lib/klibc-IpHG=
KKbZiB_yZ7GPagmQz2GwVAQ.so
>
> It seems to contain a glibc as well.
>
> Ciao,
>

