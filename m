From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 04/15] power-supply: Forward declare structs together
Date: Thu,  4 Sep 2014 17:31:25 +0530
Message-ID: <d6239b171cf2073271fc7676668c892b892b7628.1409831636.git.viresh.kumar@linaro.org>
References: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:62763 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753774AbaIDMCW (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 4 Sep 2014 08:02:22 -0400
Received: by mail-pd0-f180.google.com with SMTP id p10so13360568pdj.25
        for <linux-pm@vger.kernel.org>; Thu, 04 Sep 2014 05:02:19 -0700 (PDT)
In-Reply-To: <2eacd908a8094887cc1796f75ae0513be8a3e36d.1409831636.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1409831636.git.viresh.kumar@linaro.org>
References: <cover.1409831636.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, anton@enomsg.org
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

power_supply.h requires to forward declare few structures. One of them =
is done
at the top of the file and other one just before it is used. Declare th=
em
together for better readability.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/power_supply.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/power_supply.h b/include/linux/power_supply.=
h
index f3dea41..8c18412 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -18,8 +18,6 @@
 #include <linux/spinlock.h>
 #include <linux/notifier.h>
=20
-struct device;
-
 /*
  * All voltages, currents, charges, energies, time and temperatures in=
 uV,
  * =C2=B5A, =C2=B5Ah, =C2=B5Wh, seconds and tenths of degree Celsius u=
nless otherwise
@@ -172,6 +170,7 @@ union power_supply_propval {
 	const char *strval;
 };
=20
+struct device;
 struct device_node;
=20
 struct power_supply {
--=20
2.0.3.693.g996b0fd

