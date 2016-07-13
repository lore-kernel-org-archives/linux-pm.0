From: Chen Yu <yu.c.chen@intel.com>
Subject: Re: [PATCH] PM / hibernate: Introduce snapshot test mode for
 hibernation
Date: Wed, 13 Jul 2016 18:20:05 +0800
Message-ID: <578615D5.3060501@intel.com>
References: <1467873658-31986-1-git-send-email-yu.c.chen@intel.com>
 <20160713095005.GA27870@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160713095005.GA27870@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Pavel,
thanks for your reply,

On 2016=E5=B9=B407=E6=9C=8813=E6=97=A5 17:50, Pavel Machek wrote:
> On Thu 2016-07-07 14:40:58, Chen Yu wrote:
>> This mode is to verify if the snapshot data written to
>> swap device can be successfully restored to memory. It
>> is useful to ease the debugging process on hibernation,
>> since this mode can not only bypass the BIOSen/bootloader,
>> but also the system re-initialization.
>>
>> For example:
>> $ sudo echo snapshot > /sys/power/disk
>> $ sudo echo disk > /sys/power/state
>>
>> /* manual resume.*/
>> $ sudo echo 8:3 > /sys/power/resume
> Your examples will not work, will they?
It works on my platform, although I did not tested it for too many roun=
ds.
And here's a revised version of v2, which introduced a new test mode
in pm_test, thus users do not need to run a manual resume.
https://patchwork.kernel.org/patch/9226837/
>
> This is also quite tricky/dangerous. If you do this with filesystems
> mounted R/W, it is "good bye, filesystems".
Ah, yes, this is quite tricky, maybe we can use this option as a debug=20
method,
for example, boot with rootfs =3D initrd, without mounting any disks,
and then swapon the swap device, and do a testing. This should be safer=
?
>
> I guess updating documentation would be welcome from my side,
> otherwise it should be ok.
OK, I'll  update the documents.
>
> Acked-by: Pavel Machek <pavel@ucw.cz>
thanks.
>
> Best regards,
> 								Pavel
>
