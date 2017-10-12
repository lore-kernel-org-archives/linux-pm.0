From: Daniel Drake <drake@endlessm.com>
Subject: Re: [PATCH] USB: Force disconnect Huawei 4G modem during suspend
Date: Thu, 12 Oct 2017 16:13:03 +0800
Message-ID: <CAD8Lp47KttKsevohjpAVeS_u77WqZd+rUZk4uwt=VV_SzRW-rg@mail.gmail.com>
References: <20171011064753.11471-1-drake@endlessm.com> <Pine.LNX.4.44L0.1710111058380.1339-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f49.google.com ([209.85.218.49]:45529 "EHLO
        mail-oi0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752932AbdJLINE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Oct 2017 04:13:04 -0400
Received: by mail-oi0-f49.google.com with SMTP id f66so7230840oib.2
        for <linux-pm@vger.kernel.org>; Thu, 12 Oct 2017 01:13:04 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1710111058380.1339-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux USB Mailing List <linux-usb@vger.kernel.org>, Oliver Neukum <oneukum@suse.com>, Linux PM <linux-pm@vger.kernel.org>, Linux Upstreaming Team <linux@endlessm.com>, Chris Chiu <chiu@endlessm.com>

On Wed, Oct 11, 2017 at 11:04 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> Also, you should check whether this is for a runtime suspend or a
> system suspend.  You don't want to go around disconnecting a device
> whenever it gets runtime suspended!

Good point, I had not considered runtime suspend. It's not quite so
simple though.

I make your suggested change (testing PMSG_IS_AUTO in this codepath),
then enable autosuspend with:
 echo auto > /sys/bus/usb/devices/1-9/power/control

then the device gets suspended (no interface drivers are loaded)
without the port disconnect happening.

Now if I go into S3 suspend, the original problem returns: the system
wakes up immediately.

So that is an imperfection with this approach. Any suggestions for how
to proceed?

Daniel
