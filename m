From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH] mailmap: add Sebastian Reichel
Date: Mon,  1 May 2017 14:03:29 +0200
Message-ID: <20170501120329.25022-1-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163617AbdEAMDl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 1 May 2017 08:03:41 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add two entries to map to my primary kernel address.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
Hi,

Since this is very trivial I directly queued it to power-supply's
for-next branch. Both addresses are valid, but this lets git know,
that its not three different persons :)

-- Sebastian
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 67dc22ffc9a8..979c2c96636e 100644
--- a/.mailmap
+++ b/.mailmap
@@ -143,6 +143,8 @@ Santosh Shilimkar <ssantosh@kernel.org>
 Santosh Shilimkar <santosh.shilimkar@oracle.org>
 Sascha Hauer <s.hauer@pengutronix.de>
 S.Çağlar Onur <caglar@pardus.org.tr>
+Sebastian Reichel <sre@kernel.org> <sre@debian.org>
+Sebastian Reichel <sre@kernel.org> <sebastian.reichel@collabora.co.uk>
 Shiraz Hashim <shiraz.linux.kernel@gmail.com> <shiraz.hashim@st.com>
 Shuah Khan <shuah@kernel.org> <shuahkhan@gmail.com>
 Shuah Khan <shuah@kernel.org> <shuah.khan@hp.com>
-- 
2.11.0
