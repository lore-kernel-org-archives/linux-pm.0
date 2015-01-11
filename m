From: vichy <vichy.kuo@gmail.com>
Subject: Auto suspend not working on usb hid devices
Date: Sun, 11 Jan 2015 21:23:54 +0800
Message-ID: <CAOVJa8Hu5j04UKAPiQwhBYOuxvUdjbz_BASzcuPxJX63kE+Q2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f42.google.com ([209.85.192.42]:53190 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750863AbbAKNXz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 11 Jan 2015 08:23:55 -0500
Received: by mail-qg0-f42.google.com with SMTP id q108so14663970qgd.1
        for <linux-pm@vger.kernel.org>; Sun, 11 Jan 2015 05:23:55 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

hi all:
I list below environment I have that autosuspend seems doesn't work on
my platform.
1. kernel version 3.10.30
2. compile kernel with CONFIG_PM_RUNTIME=y
3. "echo 'rpm:rpm_suspend' > set_event"
4. insert hid devices and "echo auto > /sys/bus/usb/devices/6-1/power/control"
5. there is no any usb related runtime suspend output in trace.

Did I miss any kernel configuration to let it work?
Or where is the proper debug entry I can check why rpm_suspend isn't
been called on my system?

appreciate your help in advance,
