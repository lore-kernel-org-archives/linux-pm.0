From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: drivers/acpi/processor_driver.c:351:2: error: 'else' without a previous 'if'
Date: Sat, 05 Jan 2013 00:49:39 +0100
Message-ID: <8935203.oQUE83Y3lT@vostro.rjw.lan>
References: <50e75f94.QueKkJ7Ms/cbp/Qu%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:60550 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755289Ab3ADXoC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 4 Jan 2013 18:44:02 -0500
In-Reply-To: <50e75f94.QueKkJ7Ms/cbp/Qu%fengguang.wu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Bob Moore <robert.moore@intel.com>, linux-pm@vger.kernel.org, Lv Zheng <lv.zheng@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Saturday, January 05, 2013 07:02:44 AM kbuild test robot wrote:
> tree:   git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
> head:   279355c3da8cc9b3ce41865fddfa1cedc9625bf9
> commit: 2e6bce9096cf01e4b57e1d1ae7574a2bd986dd8e ACPICA: DEBUG_PRINT macros: Update to improve performance.
> date:   42 minutes ago
> config: make ARCH=x86_64 allmodconfig
> 
> All error/warnings:
> 
> drivers/acpi/processor_driver.c: In function 'acpi_processor_get_info':
> drivers/acpi/processor_driver.c:351:2: error: 'else' without a previous 'if'
> drivers/acpi/processor_driver.c: In function 'is_processor_present':
> drivers/acpi/processor_driver.c:674:2: error: 'else' without a previous 'if'

Thanks for the report.

Resetted the acpica-next branch to "ACPICA: Update version to 20121114."

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
