From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: Question about runtime pm status issue
Date: Mon, 29 Oct 2012 22:52:15 +0800
Message-ID: <508E981F.1030706@gmail.com>
References: <508E889C.6070009@gmail.com> <CACVXFVMZi7_uSsL0_0Sc=Nmkc4OMwogtiRB3v=uJY2LF1UYS3A@mail.gmail.com> <508E95FA.5070906@gmail.com> <CACVXFVOV2JBvPj-AnOYo6HELCYDthOfM1Qb54=BezNAikfL9OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:65220 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071Ab2J2Owm (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 29 Oct 2012 10:52:42 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr4so4313081pbb.19
        for <linux-pm@vger.kernel.org>; Mon, 29 Oct 2012 07:52:42 -0700 (PDT)
In-Reply-To: <CACVXFVOV2JBvPj-AnOYo6HELCYDthOfM1Qb54=BezNAikfL9OA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ming Lei <tom.leiming@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@vger.kernel.org>

On 2012=E5=B9=B410=E6=9C=8829=E6=97=A5 22:50:37, Ming Lei wrote:
> On Mon, Oct 29, 2012 at 10:43 PM, Lan Tianyu <lantianyu1986@gmail.com=
> wrote:
>
>> I have umount the disk and there is no user of the device since its
>> usage_count
>> become zero.
>
> Looks runtime PM of usb mass storage works well on my box with
> 3.7.0-rc3-next-20121029, maybe you can enable trace event on
> runtime PM to see what happened.
>
Ok. Thanks.
>
> Thanks



--
Best regards
Tianyu Lan
