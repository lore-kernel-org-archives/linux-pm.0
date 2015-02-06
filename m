From: Hanjun Guo <guohanjun@huawei.com>
Subject: Does ACPI thermal driver support temperature under zero?
Date: Fri, 6 Feb 2015 11:02:38 +0800
Message-ID: <54D42ECE.4040600@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:22524 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751974AbbBFDCt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 22:02:49 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org, sangyan@huawei.com

Hi,

My colleague was testing the system booting in temprature at -20 =E2=84=
=83,
then the system print "thermal_sys: Critical temperature reached (244 C=
),
shutting down", and the system shutdown as not expected.

The system is using avoton CPU and the kernel version is 3.4 stable, I
just find that in the latest of version of kernel, all the temperature =
variable
in thermal structure is unsigned, it seems that in thermal_get_temp()
in drivers/acpi/thermal.c, *temp will be a large value if temperature
under zero, did I miss something?

Any help or guidance will be appreciated a lot.

Thanks
Hanjun

