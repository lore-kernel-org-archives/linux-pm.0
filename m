From: Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v3 06/16] Platform: OLPC: Avoid a warning if the EC didn't register yet
Date: Mon,  7 Jan 2019 19:34:29 +0100
Message-ID: <20190107183439.50626-7-lkundrak@v3.sk>
References: <20190107183439.50626-1-lkundrak@v3.sk>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190107183439.50626-1-lkundrak@v3.sk>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, platform-driver-x86@vger.kernel.org
Cc: James Cameron <quozl@laptop.org>, Mark Rutland <mark.rutland@arm.com>, Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>, x86@kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
List-Id: linux-pm@vger.kernel.org

Just return EPROBE_DEFER, so that whoever attempted to use the EC call ca=
n
defer their work.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Acked-by: Pavel Machek <pavel@ucw.cz>

---
Changes since v2:
- Adjust the commit message for the s/ENODEV/EPROBE_DEFER/ change

Changes since v1:
- EPROBE_DEFER instead of ENODEV

 drivers/platform/olpc/olpc-ec.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc=
-ec.c
index 35a21c66cd0d..9ee993d5d54b 100644
--- a/drivers/platform/olpc/olpc-ec.c
+++ b/drivers/platform/olpc/olpc-ec.c
@@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 =
*outbuf, size_t outlen)
 	struct olpc_ec_priv *ec =3D ec_priv;
 	struct ec_cmd_desc desc;
=20
-	/* Ensure a driver and ec hook have been registered */
-	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
+	/* Driver not yet registered. */
+	if (!ec_driver)
+		return -EPROBE_DEFER;
+
+	if (WARN_ON(!ec_driver->ec_cmd))
 		return -ENODEV;
=20
 	if (!ec)
--=20
2.20.1
