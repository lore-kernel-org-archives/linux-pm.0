From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Re: Why is there a requirement to suspend to a swap device (and not
 any device)?
Date: Sun, 5 May 2013 08:58:11 -0400
Message-ID: <CAKb7UvjG6QWvBHWKPOfcvt2zr04vqRvTUBNWZ-Z_ioPsNDcygg@mail.gmail.com>
References: <CAKb7UvhTEiee-p8-3OVaAXMBPWL0F7SBAHzyLEpUYCq_o_u2RA@mail.gmail.com>
	<1404546.uCVdAbM0si@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:61413 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750997Ab3EEM6N (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 5 May 2013 08:58:13 -0400
Received: by mail-bk0-f49.google.com with SMTP id e19so1250458bku.22
        for <linux-pm@vger.kernel.org>; Sun, 05 May 2013 05:58:11 -0700 (PDT)
In-Reply-To: <1404546.uCVdAbM0si@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@vger.kernel.org

On Sun, May 5, 2013 at 7:35 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Saturday, May 04, 2013 03:15:53 PM Ilia Mirkin wrote:
>> Hello,
>
> Hi,
>
>> I haven't really dived into the code too deeply, but why is there a
>> requirement to suspend to a swap device in swsusp_swap_check? I don't
>> have any swap devices, and I had prepared a device precisely for the
>> purpose of suspending to disk. But even if I did have a swap device,
>> it seems like the process should allow for me to pick some random
>> other device. (The reason I'm avoiding swap devices is because I'm
>> concerned with wearing out the SSD unnecessarily.)
>
> You can hibernate to either a swap device or a swap file, see
> Documentation/power/swsusp-and-swap-files.txt.

Right, but I'm avoiding swap entirely due to concern of wearing out my
SSD with unnecessary writes. I don't think a swap file would be any
better in that respect than a device (probably worse due to various FS
overhead).

>
>> Is it just a simple limitation in one or two places for safety, or is
>> the assumption that it's a swap device throughout the suspend-to-disk
>> logic? Would a patch to remove the limitation be considered?
>
> The requirement to use swap is actually essential and wouldn't be easy to
> change.  Also there isn't much reason for that, as you can use swap files
> anyway.

I see. Thanks for the info. There must be something I'm missing that
ties swsusp to swap so tightly... time to read more code :) (Oh, is it
because on image restore you just let the data fault in from swap
rather than eagerly copying it back?)

For now I'm just going to do swapon <thedev>; echo -n disk >
/sys/power/state; swapoff <thedev>.

  -ilia
