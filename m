From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 1/6] clocksource/sh_cmt.c: Fix !HAS_IOMEM build
Date: Mon, 16 Mar 2015 22:27:05 +0100
Message-ID: <1426541230-928-1-git-send-email-richard@nod.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-iio@vger.kernel.org, linux-pm@vger.kernel.org, dwmw2@infradead.org, dbaryshkov@gmail.com, sre@kernel.org, jassisinghbrar@gmail.com, pmeerw@pmeerw.net, lars@metafoo.de, knaack.h@gmx.de, jic23@kernel.org, tglx@linutronix.de, daniel.lezcano@linaro.org, Richard Weinberger <richard@nod.at>
List-Id: linux-pm@vger.kernel.org

=46ixes:
drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_map_memory=E2=
=80=99:
drivers/clocksource/sh_cmt.c:920:2: error: implicit declaration of func=
tion =E2=80=98ioremap_nocache=E2=80=99 [-Werror=3Dimplicit-function-dec=
laration]
  cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
  ^
drivers/clocksource/sh_cmt.c:920:15: warning: assignment makes pointer =
from integer without a cast [enabled by default]
  cmt->mapbase =3D ioremap_nocache(mem->start, resource_size(mem));
               ^
drivers/clocksource/sh_cmt.c: In function =E2=80=98sh_cmt_setup=E2=80=99=
:
drivers/clocksource/sh_cmt.c:1034:2: error: implicit declaration of fun=
ction =E2=80=98iounmap=E2=80=99 [-Werror=3Dimplicit-function-declaratio=
n]
  iounmap(cmt->mapbase);

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/clocksource/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68161f7..c948f4e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -192,6 +192,7 @@ config SYS_SUPPORTS_EM_STI
 config SH_TIMER_CMT
 	bool "Renesas CMT timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	default SYS_SUPPORTS_SH_CMT
 	help
 	  This enables build of a clocksource and clockevent driver for
--=20
1.8.4.5
