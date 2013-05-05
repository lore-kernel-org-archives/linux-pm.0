From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why is there a requirement to suspend to a swap device (and not any device)?
Date: Sun, 05 May 2013 22:26:23 +0200
Message-ID: <2810404.oMYY0b1d0o@vostro.rjw.lan>
References: <CAKb7UvhTEiee-p8-3OVaAXMBPWL0F7SBAHzyLEpUYCq_o_u2RA@mail.gmail.com> <1404546.uCVdAbM0si@vostro.rjw.lan> <CAKb7UvjG6QWvBHWKPOfcvt2zr04vqRvTUBNWZ-Z_ioPsNDcygg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59851 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752086Ab3EEUSK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 5 May 2013 16:18:10 -0400
In-Reply-To: <CAKb7UvjG6QWvBHWKPOfcvt2zr04vqRvTUBNWZ-Z_ioPsNDcygg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: linux-pm@vger.kernel.org

On Sunday, May 05, 2013 08:58:11 AM Ilia Mirkin wrote:
> On Sun, May 5, 2013 at 7:35 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > On Saturday, May 04, 2013 03:15:53 PM Ilia Mirkin wrote:
> >> Hello,
> >
> > Hi,
> >
> >> I haven't really dived into the code too deeply, but why is there a
> >> requirement to suspend to a swap device in swsusp_swap_check? I don't
> >> have any swap devices, and I had prepared a device precisely for the
> >> purpose of suspending to disk. But even if I did have a swap device,
> >> it seems like the process should allow for me to pick some random
> >> other device. (The reason I'm avoiding swap devices is because I'm
> >> concerned with wearing out the SSD unnecessarily.)
> >
> > You can hibernate to either a swap device or a swap file, see
> > Documentation/power/swsusp-and-swap-files.txt.
> 
> Right, but I'm avoiding swap entirely due to concern of wearing out my
> SSD with unnecessary writes. I don't think a swap file would be any
> better in that respect than a device (probably worse due to various FS
> overhead).

There's (almost) no FS overhead associated with swap files.  Also, you
can only turn it on before hibernation and the SSD logic should take care
of the waer leveling for you anyway.

> >> Is it just a simple limitation in one or two places for safety, or is
> >> the assumption that it's a swap device throughout the suspend-to-disk
> >> logic? Would a patch to remove the limitation be considered?
> >
> > The requirement to use swap is actually essential and wouldn't be easy to
> > change.  Also there isn't much reason for that, as you can use swap files
> > anyway.
> 
> I see. Thanks for the info. There must be something I'm missing that
> ties swsusp to swap so tightly... time to read more code :) (Oh, is it
> because on image restore you just let the data fault in from swap
> rather than eagerly copying it back?)

No, that's not it. :-)

It uses get_swap_page_of_type() to allocate storage blocks.

> For now I'm just going to do swapon <thedev>; echo -n disk >
> /sys/power/state; swapoff <thedev>.

Yes, you can do that.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
