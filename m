From: Ravi Chandra Sadineni <ravisadineni@google.com>
Subject: Understanding pm_wakeup_event() call in acpi/button.c in acpi_lid_notify_state
Date: Thu, 15 Feb 2018 10:42:35 -0800
Message-ID: <CAOGSYL0Oo-OLFZk9FxK1q92h3saMYnq+BOhR5DqyLmHahhS7NQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f174.google.com ([209.85.216.174]:36844 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162092AbeBOSmh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 15 Feb 2018 13:42:37 -0500
Received: by mail-qt0-f174.google.com with SMTP id q18so866470qtl.3
        for <linux-pm@vger.kernel.org>; Thu, 15 Feb 2018 10:42:37 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rafael@kernel.org
Cc: linux-pm@vger.kernel.org, rafael.j.wysocki@intel.com, Dmitry Torokhov <dtor@google.com>, Rajat Jain <rajatja@google.com>

Hi,

we have a user space daemon that identifies wakeup source based on the
device wakeup counts. We are facing issues with the ACPI buttons
driver(acpi/buttons.c) as the wakeup_count increments immaterial of
the wake source, if the lid is open.  The reason seems to be
pm_wakeup_event() call in  acpi_lid_notify_state if the lid state is
open.

    if (state)
           acpi_pm_wakeup_event(&device->dev);



What is the reason for calling pm_wakeup_event() in
acpi_lid_notify_state() which is in turn called  every time the lid is
open on resume ? Can this be removed ?


Thanks,
Ravi

dtor@google.com
