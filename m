From: Pedro Ribeiro <pedrib@gmail.com>
Subject: Hibernate unreliable since 4.4.X / 4.5
Date: Thu, 14 Sep 2017 11:57:11 +0100
Message-ID: <edbd6341-1f85-b09a-9540-07df18585f77@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f175.google.com ([209.85.128.175]:43770 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751784AbdINK5O (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2017 06:57:14 -0400
Received: by mail-wr0-f175.google.com with SMTP id a43so5573819wrc.0
        for <linux-pm@vger.kernel.org>; Thu, 14 Sep 2017 03:57:13 -0700 (PDT)
Received: from [10.5.223.15] ([194.42.227.53])
        by smtp.gmail.com with ESMTPSA id f188sm1526094wme.21.2017.09.14.03.57.11
        for <linux-pm@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Sep 2017 03:57:12 -0700 (PDT)
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi,

I've been trying to chase away a bug that exists at least since 4.5 (and
some point release in 4.4), which is a crash when hibernating or
resuming my Thinkpad X230.

It happens randomly, I can't find any specific trigger or operation that
causes it, but every 10-30 hibernations it just hangs when hibernating
(more commonly) and sometimes when resuming from hibernation. I think it
might be related to the graphics card, as it seems to happen more
frequently when I have my laptop in the dock, although it also happens
outside of the dock. The only out of tree modules are the virtualbox ones.
When the crash happens, the screen is black but sometimes the laptop
will still respond to commands. Other times, the screen is frozen, and
the cpu fan is pumping at full speed.

Every time a new kernel or point release is out I update the kernel, but
the bug is still there. Before 4.4, and probably in the earlier 4.4
point releases (can't remember for sure), hibernation was super reliable.

It's a tricky bug to reproduce because it takes up to 10 / 15 days of
normal usage for the hang to happe.

So now, how do I start debugging this? git bisect the whole tree since
4.3 or 4.4? Should I do it up to 4.9 to reduce the search space?

-- 
Pedro Ribeiro
