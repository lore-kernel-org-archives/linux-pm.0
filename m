From: Alon Bar-Lev <alon.barlev@gmail.com>
Subject: intel_idle/parameters/max_cstate read only
Date: Sun, 21 Oct 2012 15:55:55 +0200
Message-ID: <CAOazyz1dFziKegE8wM-heVmTqKuROzngheGJFEkw4XUN9BT8cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wg0-f44.google.com ([74.125.82.44]:53773 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2JUNz5 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 21 Oct 2012 09:55:57 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1538420wgb.1
        for <linux-pm@vger.kernel.org>; Sun, 21 Oct 2012 06:55:55 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>

Hi,

In the old acpi module, the max_cstate could have been changed at
runtime via the sysfs.

The intel_idle does not provide this functionality.

# ls -la /sys/module/intel_idle/parameters/max_cstate
-r--r--r--. 1 root root 4096 Oct 21 15:55
/sys/module/intel_idle/parameters/max_cstate

Is that on purpose? Is there any way to achieve the same at runtime?

Regards,
Alon Bar-Lev.
