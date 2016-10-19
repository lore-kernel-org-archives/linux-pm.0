From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH v2 1/2] ARM: at91: define LPDDR types
Date: Wed, 19 Oct 2016 13:44:19 +0200
Message-ID: <20161019114420.15213-2-alexandre.belloni@free-electrons.com>
References: <20161019114420.15213-1-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161019114420.15213-1-alexandre.belloni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Jean-Jacques Hiblot <jjhiblot@traphandler.com>, linux-pm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

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
