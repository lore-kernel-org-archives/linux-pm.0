From: Subodh Nijsure <subodh.nijsure@credenceid.com>
Subject: How do I mix battery gague manager and power charger?
Date: Fri, 6 Dec 2013 00:47:12 -0800
Message-ID: <CAPeC_wf2vHNn+x+v=E+oLjAUtPZ-cznjtUvYAVyW=DNJ0JbqHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f175.google.com ([209.85.128.175]:40466 "EHLO
	mail-ve0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757001Ab3LFIrO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Dec 2013 03:47:14 -0500
Received: by mail-ve0-f175.google.com with SMTP id jx11so422429veb.20
        for <linux-pm@vger.kernel.org>; Fri, 06 Dec 2013 00:47:13 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

Hopefully this is correct mailing list to ask this question, if not
please redirect me to proper mailing list, will much appreciate it.

I am working on a system that PMM8920 PMIC but we are using TI's
bq27520 battery gague on MSM8960 based hardware platform.

I have defined the relevant config options to enable the
CONFIG_PM8921_CHARGER=y for the charger and CONFIG_BATTERY_BQ27520=y
for battery gauge.

However /sys/class/power_supply/battery entry is pointing to
pm8921-core battery charger.

ls -l /sys/class/power_supply/battery
lrwxrwxrwx root     root              1970-01-09 00:13 battery ->
../../devices/platform/msm_ssbi.0/pm8921-core/pm8921-charger/power_supply/battery

How do I get /sys/class/power_supply/battery to not override entries
that bq27520 creates?

Or I am looking at impossible target of pm8921 charger and TI bq27520
coexisting without a lot of work?

bq27520 driver is certainly getting probed.
<6>[    5.889607] bq27520-battery 2-0055: DEVICE_TYPE is 0x520,
FIRMWARE_VERSION is 0x329
<6>[    5.917228] bq27520-battery 2-0055: Complete bq27520 configuration 0x0C


-Subodh
