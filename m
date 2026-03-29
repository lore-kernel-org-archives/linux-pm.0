Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F8E1CDFCA;
	Sun, 29 Mar 2026 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774769795; cv=none; b=n1J6BxrL6BXEwOjLKbF9+zWG10cIL97tSHxxIo67j2Z8vNJ+GHfVylA7r6xbYITvW8coMxlvbLsBr6WQm94r7whDkbBAwvuW882+EKyyi0je3x+8mRICZenHOMH5ea/PZkiRuqZn8K8tc2N6wCDruxkpjbMWrilw8ox3CH4aqmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774769795; c=relaxed/simple;
	bh=LZw1up+vUGUObLZw4MGaZ4Xsyjo96wRDbjmvSJ0nBx4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i3dxh2Bz5nBq19/UjWRnUQxVQxYfT1wxrjP25DPcwwPxUsoZuoSVPg6RcDUbVaUe5PWTnYNXmmUaCTmr99z9ae703Fp8ENrxqbiJfJgkYP0rO3FUYc+kgEldbC6/RVrw9XNf30c94HEdoRUC4yAQxseJr8hQNvJZ7NPVY9r0CIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rOD2QyP0; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rOD2QyP0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q6ZwaroGeSRVTmrek/vsFvZNjYseP+LFK/q1uwnQxmc=; b=rOD2QyP0bFvyrh3FmNzmBUz/um
	w4sUlKjUuRPwuK1EyNkYigZ4nxjydsUJmx38sL2Z6swnYNbIn6cpjhgtfJ24YaTZEv2AYJaXb+rvX
	RCKRFv1ja2+a5LOOwFRfB/2XP/ZGYgAntrTun5i2UJWPNqeV71dDl3LBVO/Mw46l3HDFCLzIItFu2
	vGiQ6HS1BYRo0OpWY3D8ZVhgutIDJiLMwEsHKHGj+GumsQ2yBHP7WH7pDsuWQi5MHkEph7kJ7Aym2
	k16xoPhuH9j/74u+Mmngf5+N7SgajxICEcu976qwFjLKrBtrGw7DB8sma14z3cMOEHX9+FeRBAD+J
	4e7VdqmA==;
Received: from [175.114.83.198] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1w6kh4-008TRQ-9Y; Sun, 29 Mar 2026 09:36:23 +0200
From: Changwoo Min <changwoo@igalia.com>
To: lukasz.luba@arm.com,
	rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org,
	donald.hunter@gmail.com
Cc: kernel-dev@igalia.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Changwoo Min <changwoo@igalia.com>,
	Yi Lai <yi1.lai@linux.intel.com>
Subject: [PATCH] PM: EM: Fix null-ptr-deref in get-perf-domains when ID is not found
Date: Sun, 29 Mar 2026 16:36:15 +0900
Message-ID: <20260329073615.649976-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_energymodel_nl_get_perf_domains_doit() calls
em_perf_domain_get_by_id() but does not check the return value before
passing it to __em_nl_get_pd_size(). When a caller supplies a
non-existent perf domain ID, em_perf_domain_get_by_id() returns NULL,
and __em_nl_get_pd_size() immediately dereferences pd->cpus
(struct offset 0x30), causing a null-pointer dereference.

The sister handler dev_energymodel_nl_get_perf_table_doit() already
handles this correctly via __em_nl_get_pd_table_id(), which returns
NULL and causes the caller to return -EINVAL. Add the same NULL check
in the get-perf-domains do handler.

Fixes: 380ff27af25e ("PM: EM: Add dump to get-perf-domains in the EM YNL spec")
Reported-by: Yi Lai <yi1.lai@linux.intel.com>
Closes: https://lore.kernel.org/lkml/aXiySM79UYfk+ytd@ly-workstation/
Signed-off-by: Changwoo Min <changwoo@igalia.com>
---
 kernel/power/em_netlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/power/em_netlink.c b/kernel/power/em_netlink.c
index 5a611d3950fd..4d4fd29bd2be 100644
--- a/kernel/power/em_netlink.c
+++ b/kernel/power/em_netlink.c
@@ -109,6 +109,8 @@ int dev_energymodel_nl_get_perf_domains_doit(struct sk_buff *skb,
 
 	id = nla_get_u32(info->attrs[DEV_ENERGYMODEL_A_PERF_DOMAIN_PERF_DOMAIN_ID]);
 	pd = em_perf_domain_get_by_id(id);
+	if (!pd)
+		return -EINVAL;
 
 	__em_nl_get_pd_size(pd, &msg_sz);
 	msg = genlmsg_new(msg_sz, GFP_KERNEL);
-- 
2.53.0

