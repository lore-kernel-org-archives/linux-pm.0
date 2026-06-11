Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CF400E18;
	Thu, 11 Jun 2026 13:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182964; cv=none; b=E+nk9pB7zyVgs+w5QGNkaJ3obLqE5/bdf5CNm+Pc7KreTAcDjjxU4B91IxSmkx16ZGHsuOa7WPiQa6G8EDFI8JuWRVBFRaeXAA6TCBKjpNc4Q0HJqbA9YUpe0RHcb36fZ6JK3X8HT7ztfz62DenN9dZ4UKRLz2fIDJonRc5a2pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182964; c=relaxed/simple;
	bh=bTMn1lXLF7MPlr9ABR3fwfDJcpm1iEASOCMJWI2Zay8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeHe5obdjZde6jmgoRPNCKhyH/Lor2fTx30/kI0LpEKujszMO3K2QXIhzNEhBsD1pOo9evUoWF7+Ln5j1TWTsWUOh6Px7N/el0K5IYYGVC7fmnvHBFbRVaaKApeJFlcmiyfDjTVSXFiYZFenHvHJ5m9pCjKKlEwCv0z3bDIfJmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461651F00899;
	Thu, 11 Jun 2026 13:02:37 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Sudeep Holla <sudeep.holla@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Brian Masney <bmasney@redhat.com>,
	Ulf Hansson <ulfh@kernel.org>
Cc: arm-scmi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH/RFC 4/9] firmware: arm_scmi: Add a flag for power-management clocks
Date: Thu, 11 Jun 2026 15:02:08 +0200
Message-ID: <9f632656c2f8311192efd23761307a1fb671e6c2.1781171705.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781171705.git.geert+renesas@glider.be>
References: <cover.1781171705.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Power management of on-SoC modules is typically handled through two
methods: module power control and module clock gating.  The former is
exposed as an SCMI power domain, the latter as an SCMI clock.

Add a flag to indicate if a clock is intended for power-management of a
hardware module.

As the SCMI clock protocol does not support advertizing power-management
clocks yet, this flag can only be set by a quirk.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 include/linux/scmi_protocol.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/scmi_protocol.h b/include/linux/scmi_protocol.h
index 1d55374bc8cdcc72..c98e0add25f0c6c6 100644
--- a/include/linux/scmi_protocol.h
+++ b/include/linux/scmi_protocol.h
@@ -55,6 +55,7 @@ struct scmi_clock_info {
 	bool rate_ctrl_forbidden;
 	bool parent_ctrl_forbidden;
 	bool extended_config;
+	bool pm_clk;
 	u64 min_rate;
 	u64 max_rate;
 	int num_parents;
-- 
2.43.0

