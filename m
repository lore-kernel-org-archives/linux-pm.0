From: David Cohen <david.a.cohen@linux.intel.com>
Subject: [RFC/PATCH 2/3] usb/xhci: implement proper static inline stubs when !CONFIG_PM
Date: Thu, 12 Dec 2013 21:18:24 -0800
Message-ID: <1386911905-2366-3-git-send-email-david.a.cohen@linux.intel.com>
References: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1386911905-2366-1-git-send-email-david.a.cohen@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: pavel@ucw.cz, rjw@rjwysocki.net, len.brown@intel.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, santosh.shilimkar@ti.com, David Cohen <david.a.cohen@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Current xhci_suspend() and xhci_resume() implementation in case of
CONFIG_PM not defined is buggy. If we try to use them we get the
following error:

drivers/usb/host/xhci-plat.c: In function =E2=80=98xhci_plat_suspend=E2=
=80=99:
drivers/usb/host/xhci-plat.c:205:21: error: called object =E2=80=980u=E2=
=80=99 is not a function
drivers/usb/host/xhci-plat.c: In function =E2=80=98xhci_plat_resume=E2=80=
=99:
drivers/usb/host/xhci-plat.c:213:20: error: called object =E2=80=980u=E2=
=80=99 is not a function

It happens because the function names are replaced by NULL but the
brackets stay: NULL()

This patch implements proper static inline stubs.

Signed-off-by: David Cohen <david.a.cohen@linux.intel.com>
---
 drivers/usb/host/xhci.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/xhci.h b/drivers/usb/host/xhci.h
index 941d5f59e4dc..6a5e7a98de7e 100644
--- a/drivers/usb/host/xhci.h
+++ b/drivers/usb/host/xhci.h
@@ -1771,8 +1771,10 @@ int xhci_gen_setup(struct usb_hcd *hcd, xhci_get=
_quirks_t get_quirks);
 int xhci_suspend(struct xhci_hcd *xhci);
 int xhci_resume(struct xhci_hcd *xhci, bool hibernated);
 #else
-#define	xhci_suspend	NULL
-#define	xhci_resume	NULL
+static inline int
+xhci_suspend(struct xhci_hcd *xhci) { return 0; }
+static inline int
+xhci_resume(struct xhci_hcd *xhci, bool hibernated) { return 0; }
 #endif
=20
 int xhci_get_frame(struct usb_hcd *hcd);
--=20
1.8.4.2
