From: Ryan <ryanphilips19@googlemail.com>
Subject: cpufreq policy
Date: Mon, 2 May 2016 19:15:16 +0530
Message-ID: <CANMsd00DqTiTQEM3HxEvY3Qyo9cBpAHV83BjVpXKcq4gE0B96Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:38767 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcEBNpR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 May 2016 09:45:17 -0400
Received: by mail-ig0-f169.google.com with SMTP id m9so73982882ige.1
        for <linux-pm@vger.kernel.org>; Mon, 02 May 2016 06:45:17 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>

Hi,

How can i change the governor at runtime or run at a specific
frequency while doing an operation.
For example i might want the cpu not to scale down during specific
operations in the driver.

Thanks,
ryan
