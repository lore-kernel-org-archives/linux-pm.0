From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 0/3] ACPI / hotplug / mm: Rework mutual exclusion between hibernation and memory hotplug
Date: Thu, 29 Aug 2013 23:12:53 +0200
Message-ID: <9589253.Co8jZpnWdd@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:43009 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752205Ab3H2VIK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 29 Aug 2013 17:08:10 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>, linux-mm@kvack.org

Hi All,

One thing that bothers me quite a bit about memory hotplug is that
lock_hotplug_memory() acquires pm_mutex which is kind of a blunt thing
and has a huge potential for deadlocks.

This can be avoided if device_hotplug_lock is held around hibernation,
which is not too difficult to make happen and hence the following patch
series.

[1/3] ACPI: Acquire device_hotplug_lock before acpi_scan_lock (this is
      necessary, because hibernation acquires acpi_scan_lock in linux-next).

[2/3] PM / hibernate: Allocate memory bitmaps after freezing user space
      processes (the reason why is explained in the changelog).

[3/3] Rework mutual exclusion between hibernation and memory hotplug.

On top of linux-pm.git/linux-next.

Thanks,
Rafael

