From: Ilia Mirkin <imirkin@alum.mit.edu>
Subject: Why is there a requirement to suspend to a swap device (and not any device)?
Date: Sat, 4 May 2013 15:15:53 -0400
Message-ID: <CAKb7UvhTEiee-p8-3OVaAXMBPWL0F7SBAHzyLEpUYCq_o_u2RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:46161 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751335Ab3EDTPy (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 4 May 2013 15:15:54 -0400
Received: by mail-bk0-f46.google.com with SMTP id w5so1125809bku.33
        for <linux-pm@vger.kernel.org>; Sat, 04 May 2013 12:15:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I haven't really dived into the code too deeply, but why is there a
requirement to suspend to a swap device in swsusp_swap_check? I don't
have any swap devices, and I had prepared a device precisely for the
purpose of suspending to disk. But even if I did have a swap device,
it seems like the process should allow for me to pick some random
other device. (The reason I'm avoiding swap devices is because I'm
concerned with wearing out the SSD unnecessarily.)

Is it just a simple limitation in one or two places for safety, or is
the assumption that it's a swap device throughout the suspend-to-disk
logic? Would a patch to remove the limitation be considered?

Thanks,

  -ilia
