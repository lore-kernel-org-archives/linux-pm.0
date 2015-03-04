From: Ran Shalit <ranshalit@gmail.com>
Subject: reboot command - fail with power save support
Date: Wed, 4 Mar 2015 21:25:01 +0200
Message-ID: <CAJ2oMhKAQOO9A7w=+0rBP8TmTHpko64B9-xOQAF9dnp1ca0KOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

I added power support to kernel menuconfig, such as cpuidle, and it
seems to work fine. I also validated in counter that cpu gets into
retention.
The strange thing is that reboot now doesn't work and more: it starts
printing garbage, but does not continue with reboot.
Is there any idea ?

Thank you,
Ran
