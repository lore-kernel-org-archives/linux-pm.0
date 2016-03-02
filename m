From: yu chen <yu.chen.surf@gmail.com>
Subject: Re: STI problem and workaround for Dell XPS 13 (Skylake, 2016) /
 Broadcom BCM4350
Date: Wed, 2 Mar 2016 21:08:18 +0800
Message-ID: <CADjb_WQwwGD4wQugeLf=2k7XjtPGt9o6vgqhMdLR+ALDhK7J+Q@mail.gmail.com>
References: <87h9gpp5rt.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:37162 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753434AbcCBNIT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 08:08:19 -0500
Received: by mail-wm0-f54.google.com with SMTP id p65so77028712wmp.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Mar 2016 05:08:18 -0800 (PST)
In-Reply-To: <87h9gpp5rt.fsf@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tamas Papp <tkpapp@gmail.com>
Cc: linux-pm@vger.kernel.org

On Wed, Mar 2, 2016 at 5:51 PM, Tamas Papp <tkpapp@gmail.com> wrote:
> Hi,
>
> I have a Dell XPS 13 (Skylake, 2016) and wanted to get STI working, so I
> followed the instructions at [1]. I found that the Broadcom wireless
> chip is waking the machine up from STI / freeze.
>
> A workaround is
>
> INTERFACE=wlp58s0
> ifconfig $INTERFACE down
> modprobe -r brcmfmac && echo freeze > /sys/power/state && modprobe brcmfmac
> ifconfig $INTERFACE up
>
> I thought I would ask whether I should report this as a bug, and if yes,
> where.
>
Some device drivers such as brcmac has the ability to wake the system
up,  you can
disable it by echo to /proc/acpi/wakeup IMO.
