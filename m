Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9E17EF;
	Fri,  8 Mar 2024 12:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709901113; cv=none; b=TWAn0UsByrCF4M6JHfMZFWm+XFbVUhhJ/yF8EKAB50xhs6Bo0/+0wnPsjioEJMsV4fh34WnrlNwMpg6wakFlz1ghooaSe2Ze1HIcQfkUBVsfnkm5hAgiDKSFLG7UFCCHQegIHh1o7pN+CLRqDuBXi+axlwLRp6ML/DuVCVoK98I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709901113; c=relaxed/simple;
	bh=7wC84AYFOmapT7dzQoGkHlDqzNSWk22jBdSheuL8DfY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ou8hHxrMrrQ16p1pni+XT6PvTEvVj815jPzDaIHvXogGxh5XqOvhkzuyYZ/58VN3wmn/EnCD268ENkzrupMX9AMIODg5/paN+SAUU8GA0YIgwnZkyvSWigQ7J53nW+2GQ+xrkXyGAVGOf4QJVJRLMQDyzG8ezzvsOXHw9Vsanog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4148BC15;
	Fri,  8 Mar 2024 04:32:27 -0800 (PST)
Received: from e129166.arm.com (unknown [10.57.10.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 5B30F3F73F;
	Fri,  8 Mar 2024 04:31:49 -0800 (PST)
From: Lukasz Luba <lukasz.luba@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	rafael@kernel.org
Cc: lukasz.luba@arm.com,
	poshao.chen@mediatek.com
Subject: [PATCH] PM: EM: Force device drivers to provide power in uW
Date: Fri,  8 Mar 2024 12:32:03 +0000
Message-Id: <20240308123203.196644-1-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EM only supports power in uW. Make sure that it is not possible to
register some downstream driver which doesn't provide power in uW.
The only exception is artificial EM, but that EM is ignored by the rest of
kernel frameworks (thermal, powercap, etc).

Reported-by: PoShao Chen <poshao.chen@mediatek.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---

Hi all,

The was an issue reported recently that the EM could be used with
not aligned drivers which provide milli-Watts. This patch prevents such
drivers to register EM (although there are no such in upstream).

Regards,
Lukasz

 kernel/power/energy_model.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/power/energy_model.c b/kernel/power/energy_model.c
index b686ac0345bd9..9e1c9aa399ea9 100644
--- a/kernel/power/energy_model.c
+++ b/kernel/power/energy_model.c
@@ -612,6 +612,17 @@ int em_dev_register_perf_domain(struct device *dev, unsigned int nr_states,
 	else if (cb->get_cost)
 		flags |= EM_PERF_DOMAIN_ARTIFICIAL;
 
+	/*
+	 * EM only supports uW (exception is artificial EM).
+	 * Therefore, check and force the drivers to provide
+	 * power in uW.
+	 */
+	if (!microwatts && !(flags & EM_PERF_DOMAIN_ARTIFICIAL)) {
+		dev_err(dev, "EM: only supports uW power values\n");
+		ret = -EINVAL;
+		goto unlock;
+	}
+
 	ret = em_create_pd(dev, nr_states, cb, cpus, flags);
 	if (ret)
 		goto unlock;
-- 
2.25.1

