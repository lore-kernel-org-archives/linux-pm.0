From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 5/6] mailbox/altera.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:09 +0100
Message-ID: <1426541230-928-5-git-send-email-richard@nod.at>
References: <1426541230-928-1-git-send-email-richard@nod.at>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
List-Id: linux-pm@vger.kernel.org

Fixes:
drivers/built-in.o: In function `altera_mbox_probe':
mailbox-altera.c:(.text+0x400196): undefined reference to `devm_ioremap_resource'

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mailbox/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 84325f2..81b8fb1 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -47,6 +47,7 @@ config PCC
 
 config ALTERA_MBOX
 	tristate "Altera Mailbox"
+	depends on HAS_IOMEM
 	help
 	  An implementation of the Altera Mailbox soft core. It is used
 	  to send message between processors. Say Y here if you want to use the
-- 
1.8.4.5
