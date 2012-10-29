From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: Question about runtime pm status issue
Date: Mon, 29 Oct 2012 22:43:06 +0800
Message-ID: <508E95FA.5070906@gmail.com>
References: <508E889C.6070009@gmail.com> <CACVXFVMZi7_uSsL0_0Sc=Nmkc4OMwogtiRB3v=uJY2LF1UYS3A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34064 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714Ab2J2OnS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Oct 2012 10:43:18 -0400
Received: by mail-pa0-f46.google.com with SMTP id hz1so3473622pad.19
        for <linux-pm@vger.kernel.org>; Mon, 29 Oct 2012 07:43:17 -0700 (PDT)
In-Reply-To: <CACVXFVMZi7_uSsL0_0Sc=Nmkc4OMwogtiRB3v=uJY2LF1UYS3A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@vger.kernel.org>

=E4=BA=8E 2012/10/29 22:20, Ming Lei =E5=86=99=E9=81=93:
> On Mon, Oct 29, 2012 at 9:46 PM, Lan Tianyu <lantianyu1986@gmail.com>=
 wrote:
>> hi Rafael, Alan:
>>          I recently meet a problem that I enable a usb disk's runtim=
e auto autosuspend,
>> set power/autosuspend_delay_ms to be 100 and make its usage_count to=
 be 0. But after
>> a long time, the disk's runtime status always is active. From my vie=
w, the
>> disk's status
>> should be "suspend" after the usage_count being 0 and delay timeout.=
 If my
>> opinion was
>> wrong, please corrent me. Thanks.
>
> Please try to umount the disk to see if it can be auto suspended.
>
I have umount the disk and there is no user of the device since its usa=
ge_count
become zero.
>
> Thanks,
>

--=20
Best regards
Tianyu Lan
