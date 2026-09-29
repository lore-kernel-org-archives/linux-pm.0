Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5544E56E06A;
	Tue, 29 Sep 2026 20:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790713196; cv=none; b=CL1TnCcFFJmqPREd+uzcEuLJFP/THwvvSdFyIPtXPR8Ws+r2GMPU/lrAppufr/R8Ucz4VckrllDuI/XwM9zx4nm5rE83ZrCTzIcmnFxL3SspJAiwpUFiOE6MGfbBTA59yK8QBrk2yq3xf3zZ/+j8fd6ixktV8Zy+LpW3uuvgS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790713196; c=relaxed/simple;
	bh=IJDq48lnCi10fA0xA81CeRchJhwbKRMpYDRa06yCC9w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hpHFr3B32K3uL8II4qXg6kdT6sHJ+sQADciGo5Njq6W4613pgzzK3BIu535qHBvDSUZeX26oAHNi2CkvGHar0qRp4XfRbBbHBJB7c2lcI4teIz5J1dYbH8ratrdPdexDjpOp8l0Dn9Dy6M7qZsBQuf0lxKpr0mX3yKl7iH07pjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bt9M/Y7X; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bt9M/Y7X"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 6D895C0000EC;
	Tue, 29 Sep 2026 13:19:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 6D895C0000EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1790713194;
	bh=IJDq48lnCi10fA0xA81CeRchJhwbKRMpYDRa06yCC9w=;
	h=From:To:Cc:Subject:Date:From;
	b=bt9M/Y7XW2e/Qw74ZjpwR1IVK17XgObEfK+rdSwKG4OGzfF5wB2n/VUm+rCFoqMq3
	 8AgEP8UOxopFCwURlHrSspUrp/gazdP/v2qmUhm0on0UaeX5/0lvD7lmCTi2OIwHLZ
	 TkwrFhc1MiL+2jbxHcSbpK8bG2IUlJ5qv2AVHVEc=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 50758A83;
	Tue, 29 Sep 2026 13:19:54 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jacob Pan <jacob.jun.pan@linux.intel.com>,
	linux-pm@vger.kernel.org (open list:THERMAL)
Subject: [PATCH] tools/thermal/tmon: Fix string truncation warning in optarg copy
Date: Tue, 29 Sep 2026 13:19:51 -0700
Message-Id: <20260929201951.408456-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC warns about possible string truncation with -Wstringop-truncation:

  tmon.c: In function ‘main’:
  tmon.c:233:25: warning: ‘__builtin_strncpy’ specified bound 20 equals
destination size [-Wstringop-truncation]
    233 |                         strncpy(ctrl_cdev, optarg,
	CDEV_NAME_SIZE);
        |
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Replace strncpy() with snprintf() to guarantee NUL-termination and
silence the compiler warning.

Fixes: 94f69966faf8 ("tools/thermal: Introduce tmon, a tool for thermal subsystem")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 tools/thermal/tmon/tmon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/thermal/tmon/tmon.c b/tools/thermal/tmon/tmon.c
index 7eb3216a27f4..0c8deee4652e 100644
--- a/tools/thermal/tmon/tmon.c
+++ b/tools/thermal/tmon/tmon.c
@@ -230,7 +230,7 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'c':
 			no_control = 0;
-			strncpy(ctrl_cdev, optarg, CDEV_NAME_SIZE);
+			snprintf(ctrl_cdev, sizeof(ctrl_cdev), "%s", optarg);
 			break;
 		case 'd':
 			start_daemon_mode();
-- 
2.34.1

