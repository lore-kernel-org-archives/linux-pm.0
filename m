From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Why is there a requirement to suspend to a swap device (and not any device)?
Date: Sun, 05 May 2013 13:35:52 +0200
Message-ID: <1404546.uCVdAbM0si@vostro.rjw.lan>
References: <CAKb7UvhTEiee-p8-3OVaAXMBPWL0F7SBAHzyLEpUYCq_o_u2RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:59400 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751051Ab3EEL1b (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 5 May 2013 07:27:31 -0400
In-Reply-To: <CAKb7UvhTEiee-p8-3OVaAXMBPWL0F7SBAHzyLEpUYCq_o_u2RA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: linux-pm@vger.kernel.org

On Saturday, May 04, 2013 03:15:53 PM Ilia Mirkin wrote:
> Hello,

Hi,

> I haven't really dived into the code too deeply, but why is there a
> requirement to suspend to a swap device in swsusp_swap_check? I don't
> have any swap devices, and I had prepared a device precisely for the
> purpose of suspending to disk. But even if I did have a swap device,
> it seems like the process should allow for me to pick some random
> other device. (The reason I'm avoiding swap devices is because I'm
> concerned with wearing out the SSD unnecessarily.)

You can hibernate to either a swap device or a swap file, see
Documentation/power/swsusp-and-swap-files.txt.

> Is it just a simple limitation in one or two places for safety, or is
> the assumption that it's a swap device throughout the suspend-to-disk
> logic? Would a patch to remove the limitation be considered?

The requirement to use swap is actually essential and wouldn't be easy to
change.  Also there isn't much reason for that, as you can use swap files
anyway.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
