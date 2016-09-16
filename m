From: Andy Lutomirski <luto@kernel.org>
Subject: Should drivers like nvme let userspace control their latency via dev_pm_qos?
Date: Fri, 16 Sep 2016 08:26:03 -0700
Message-ID: <CALCETrUsgA2H=TuwZMuwW2XpXZ7KPrEYu6xckmTbhU8oZwr6Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754118AbcIPP12 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 16 Sep 2016 11:27:28 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 153F52060A
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2016 15:26:28 +0000 (UTC)
Received: from mail-vk0-f54.google.com (mail-vk0-f54.google.com [209.85.213.54])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B4E1205FF
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2016 15:26:26 +0000 (UTC)
Received: by mail-vk0-f54.google.com with SMTP id g9so31766747vkg.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Sep 2016 08:26:26 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@fb.com>, linux-nvme@lists.infradead.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, J Freyensee <james_p_freyensee@linux.intel.com>, Christoph Hellwig <hch@lst.de>

I'm adding power management to the nvme driver, and I'm exposing
exactly one knob via sysfs: the maximum permissible latency.  This
isn't a power domain issue, and it has no dependencies -- it's
literally just the maximum latency that the driver may impose on I/O
for power saving purposes.

ISTM userspace should be able to specify its own latency tolerance in
a uniform way, and dev_pm_qos seems like the natural interface for
this, except that I cannot find a single instance in the tree of *any*
driver using it via the notifier mechanism.  I can find two drivers
that do it using dev_pm_qos_expose_latency_tolerance(), and both are
LPSS drivers?

So: should I be exposing .set_latency_tolerance() or should I just use
a custom sysfs attribute?  Or both?
