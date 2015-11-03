From: Yan Pashkovsky <yanpaso@gmail.com>
Subject: API for querying the resume cause [2]
Date: Wed, 4 Nov 2015 00:29:39 +0300
Message-ID: <56392743.6080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f170.google.com ([209.85.217.170]:35022 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964899AbbKCV3m (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Nov 2015 16:29:42 -0500
Received: by lbbes7 with SMTP id es7so2081155lbb.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2015 13:29:40 -0800 (PST)
Received: from ?IPv6:2a02:2168:d01:e000:44a4:6843:2dc:a1ed? ([2a02:2168:d01:e000:44a4:6843:2dc:a1ed])
        by smtp.googlemail.com with ESMTPSA id e63sm5179696lfi.1.2015.11.03.13.29.39
        for <linux-pm@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2015 13:29:39 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hi everyone!

I was writing you on 21 of August 
(http://marc.info/?t=144007145600001&r=1&w=2)  about API for querying 
the resume cause. I was looking at the releases of linux kernel and 
discovered this:

"Finally, the PM core gets a new mechanism that can be used by
device drivers to distinguish between suspend-to-RAM (based on
platform firmware support) and suspend-to-idle (or other variants
of system suspend the platform firmware is not involved in) and
possibly optimize their device suspend/resume handling accordingly"
         http://lkml.iu.edu/hypermail/linux/kernel/1511.0/01164.html

Is it what we were discussing? If yes - that's fine, I'll contact 
systemd team. If no - is this API exists in someone's todo list or smth 
like this? Are there any plans for this?

Kind regards,
Yan
