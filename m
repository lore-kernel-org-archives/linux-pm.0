From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH 1/2] ARM: at91: define LPDDR types
Date: Fri,  7 Oct 2016 18:34:26 +0200
Message-ID: <20161007163427.11454-2-alexandre.belloni@free-electrons.com>
References: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:37455 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757210AbcJGQel (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 12:34:41 -0400
In-Reply-To: <20161007163427.11454-1-alexandre.belloni@free-electrons.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

The Atmel MPDDR controller support LPDDR2 and LPDDR3 memories, add their
types.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 include/soc/at91/at91sam9_ddrsdr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/soc/at91/at91sam9_ddrsdr.h b/include/soc/at91/at91sam9_ddrsdr.h
index dc10c52e0e91..393362bdb860 100644
--- a/include/soc/at91/at91sam9_ddrsdr.h
+++ b/include/soc/at91/at91sam9_ddrsdr.h
@@ -81,6 +81,7 @@
 #define			AT91_DDRSDRC_LPCB_POWER_DOWN		2
 #define			AT91_DDRSDRC_LPCB_DEEP_POWER_DOWN	3
 #define		AT91_DDRSDRC_CLKFR	(1 << 2)	/* Clock Frozen */
+#define		AT91_DDRSDRC_LPDDR2_PWOFF	(1 << 3)	/* LPDDR Power Off */
 #define		AT91_DDRSDRC_PASR	(7 << 4)	/* Partial Array Self Refresh */
 #define		AT91_DDRSDRC_TCSR	(3 << 8)	/* Temperature Compensated Self Refresh */
 #define		AT91_DDRSDRC_DS		(3 << 10)	/* Drive Strength */
@@ -96,7 +97,9 @@
 #define			AT91_DDRSDRC_MD_SDR		0
 #define			AT91_DDRSDRC_MD_LOW_POWER_SDR	1
 #define			AT91_DDRSDRC_MD_LOW_POWER_DDR	3
+#define			AT91_DDRSDRC_MD_LPDDR3		5
 #define			AT91_DDRSDRC_MD_DDR2		6	/* [SAM9 Only] */
+#define			AT91_DDRSDRC_MD_LPDDR2		7
 #define		AT91_DDRSDRC_DBW	(1 << 4)		/* Data Bus Width */
 #define			AT91_DDRSDRC_DBW_32BITS		(0 <<  4)
 #define			AT91_DDRSDRC_DBW_16BITS		(1 <<  4)
-- 
2.9.3

