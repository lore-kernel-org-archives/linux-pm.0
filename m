From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: [PATCH 1/2] MAINTAINERS: regulator: Add Documentation/power/regulator/
Date: Sun, 19 Nov 2017 06:09:06 +0100
Message-ID: <20171119050907.5043-1-j.neuschaefer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:60443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750703AbdKSFJq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 19 Nov 2017 00:09:46 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2811a211632c..a644d41e088c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14447,6 +14447,7 @@ W:	http://www.slimlogic.co.uk/?p=48
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git
 S:	Supported
 F:	Documentation/devicetree/bindings/regulator/
+F:	Documentation/power/regulator/
 F:	drivers/regulator/
 F:	include/dt-bindings/regulator/
 F:	include/linux/regulator/
-- 
2.11.0
