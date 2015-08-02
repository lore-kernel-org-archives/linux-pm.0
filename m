From: Ran Shalit <ranshalit@gmail.com>
Subject: cpuidle - control minimum idle time before getting into sleep ?
Date: Sun, 2 Aug 2015 22:38:05 +0300
Message-ID: <CAJ2oMhLriFNr=kmgCS=0nf13QMgrRbJZVTq7a3xpxa+dguO8gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35262 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbHBTiH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 2 Aug 2015 15:38:07 -0400
Received: by iodd187 with SMTP id d187so126957512iod.2
        for <linux-pm@vger.kernel.org>; Sun, 02 Aug 2015 12:38:05 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hello,

I am using tickless kernel, and cpuidle using menu governer.
Is there a way to control minimum idle time before getting into sleep ?
I noticed that sometimes there is degredation in performance becuase
cpuidle gets into sleep.
I've noticed this behaviour with iperf bandwidth test with small packet only.

Is there a way to control the minimum time of idle before deciding of sleep.
I assume that if I have such control, I can enlarge this time, and so
the iperf bandwidth test with small packets shall never get into sleep
state.


Thank you!
Ran
