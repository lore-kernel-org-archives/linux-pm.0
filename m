Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC761F30DE;
	Thu, 20 Feb 2025 11:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051676; cv=none; b=YIFCCyvQl+zVrwaMmiUwNqhgSr/o8scfwcK4oro0XMK6jmItbQ90AOinhsSAT9HeQHQEC91Z/jIaKwZCkF2yID0v1tUjxKuG+UXJKQ9r/gGKsr3ZeNEJ9MRNbinz7U16b/CfZRdu+dUxc6yaCFSi8+5wnAx2IWrNYFRhaqypzVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051676; c=relaxed/simple;
	bh=9h8PRFrP+rKtBGmn8XUWSDuLjHDVpz4rwP+tyrfHvDA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYiSQJ9UTvtN2XpJl7flF3nrSZl++Q0n2VK9u9AaIg0VPpwO+JljDID7dDYmQqEZpHMZ/UCuxP9TIb2VWXcF9WdeJFFFAOlaLllY+64m7W53jmlJNoysoj7sO3qy4nnvCsgs7O6P7OE7Ied4lCtbbuZ4hUoaNDWjnGJOtbQWRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A04E416F3;
	Thu, 20 Feb 2025 03:41:31 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.77.59])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 457603F5A1;
	Thu, 20 Feb 2025 03:41:12 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	dietmar.eggemann@arm.com
Subject: [PATCH] MAINTAINERS: Add Energy Model framework as properly maintained
Date: Thu, 20 Feb 2025 11:40:33 +0000
Message-ID: <20250220114103.515278-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Energy Model framework had some recent grow and became a bit
more complex. Add the proper contact points to maintainers so
other developers can get the right support.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b9f7d2115b57d..2d0dd9100292c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8529,6 +8529,15 @@ M:	Maxim Levitsky <maximlevitsky@gmail.com>
 S:	Maintained
 F:	drivers/media/rc/ene_ir.*
 
+ENERGY MODEL
+M:	Lukasz Luba <lukasz.luba@arm.com>
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+F:	kernel/power/energy_model.c
+F:	include/linux/energy_model.h
+F:	Documentation/power/energy-model.rst
+
 EPAPR HYPERVISOR BYTE CHANNEL DEVICE DRIVER
 M:	Laurentiu Tudor <laurentiu.tudor@nxp.com>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.48.1

