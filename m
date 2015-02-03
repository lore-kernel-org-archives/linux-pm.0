From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: selective wakeups
Date: Tue, 03 Feb 2015 10:54:15 +0100
Message-ID: <54D09AC7.5080503@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([93.93.135.160]:53771 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752637AbbBCJyV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 04:54:21 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>
Cc: Derek Basehore <dbasehore@google.com>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Hello,

I'm looking at how to support wakeup sources that resume a subset of the
suspended devices. The goal is for the machine to be able to wakeup the
CPU but not the display or sound card when the wakeup source isn't
user-initiated, such as RTC or a network card (we can call it automatic
resume).

http://www.chromium.org/chromium-os/packages/power_manager/suspend-and-resume#TOC-Dark-Resume

My first idea is for userspace to be able to configure via sysfs which
devices aren't going to be resumed when a given wakeup source fires.
We'll also need a way to resume the display and sound card if there's
user interaction when the system has resumed automatically.

Any comments?

Thanks,

Tomeu

