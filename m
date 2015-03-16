From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 4/6] power/reset/rmobile-reset.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:08 +0100
Message-ID: <1426541230-928-4-git-send-email-richard@nod.at>
References: <1426541230-928-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1426541230-928-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
List-Id: linux-pm@vger.kernel.org

=46ixes:
drivers/power/reset/rmobile-reset.c: In function =E2=80=98rmobile_reset=
_probe=E2=80=99:
drivers/power/reset/rmobile-reset.c:61:2: error: implicit declaration o=
f function =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-decla=
ration]
  iounmap(sysc_base2);

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/power/reset/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 27f6646..6f791fb 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -154,6 +154,7 @@ config POWER_RESET_SYSCON
 config POWER_RESET_RMOBILE
 	tristate "Renesas R-Mobile reset driver"
 	depends on ARCH_RMOBILE || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Reboot support for Renesas R-Mobile and SH-Mobile SoCs.
=20
--=20
1.8.4.5
