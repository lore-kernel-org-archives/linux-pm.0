From: =?UTF-8?q?Manuel=20P=C3=A9gouri=C3=A9-Gonnard?= <mpg@elzevir.fr>
Subject: [PATCH] drivers: power: fix typo in documentation
Date: Tue, 29 Dec 2015 11:03:21 +0100
Message-ID: <1451383401-6981-1-git-send-email-mpg@elzevir.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, gregkh@linuxfoundation.org, =?UTF-8?q?Manuel=20P=C3=A9gouri=C3=A9-Gonnard?= <mpg@elzevir.fr>, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org

The documentation for detach() said attach.

Signed-off-by: Manuel P=C3=A9gouri=C3=A9-Gonnard <mpg@elzevir.fr>
Cc: trivial@kernel.org
---
 drivers/base/power/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/common.c b/drivers/base/power/common.c
index f32b802b98f4..f48e33385b3e 100644
--- a/drivers/base/power/common.c
+++ b/drivers/base/power/common.c
@@ -112,7 +112,7 @@ EXPORT_SYMBOL_GPL(dev_pm_domain_attach);
=20
 /**
  * dev_pm_domain_detach - Detach a device from its PM domain.
- * @dev: Device to attach.
+ * @dev: Device to detach.
  * @power_off: Used to indicate whether we should power off the device=
=2E
  *
  * This functions will reverse the actions from dev_pm_domain_attach()=
 and thus
--=20
2.6.4
