From: Yingchun Li <sword.l.dragon@gmail.com>
Subject: Linux cpuidle driver: Is there ready API for checking DDR's masters?
Date: Wed, 16 Jul 2014 16:52:42 +0800
Message-ID: <CADkvYHEfeRzzK1PT_hxBB0pCMeKoVihyivOxrNPYxbuM4LgmQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vc0-f175.google.com ([209.85.220.175]:63875 "EHLO
	mail-vc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758397AbaGPIwn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Jul 2014 04:52:43 -0400
Received: by mail-vc0-f175.google.com with SMTP id hu12so1019361vcb.6
        for <linux-pm@vger.kernel.org>; Wed, 16 Jul 2014 01:52:42 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

I wrote a cpuidle driver for my board, and one state is shutdown the DDR.
Before shutdown the DDR, I want to make sure there are no masters
(some controller has builtin DMA, such as USB controller, SD controller.)
to access DDR.
One option is the pm_qos API, and every master request a qos before accessing
transfer. But the API cannot be used in interrupt context, it is very
inconvenient
for my case.
One option is implementing a customer API, and any master who
access DDR should get a reference and release the reference after
free the DDR.
Please give me some advice on this issue?

Thanks a lot!
