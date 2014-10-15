From: Ran Shalit <ranshalit@gmail.com>
Subject: cpuidle and SW sleep
Date: Wed, 15 Oct 2014 07:55:46 +0300
Message-ID: <CAJ2oMh+W5vA96ftyRUA8V9fBx8xGA_26QkDt18A-j3+aw3TG4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:59742 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbaJOEzr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 15 Oct 2014 00:55:47 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org

Hello,

Is there anyone who can please explain the relation between SW sleep
(such as udelay), to change of C-state as done by cpuidle ?
How is wakeup done ? As far as I understand udelay is sw delay not HW.

Thanks for you comments,
Ran
