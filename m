Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399178;
	b=z9/JkYGsPgBG5u7E847X8XurI3S0RLlwwgpJ1FRFDmmVMExyi6xWLSzHu+TidfkZ3q8T
	 O7MK0A/k66vuX375I2Lnx6ozsRJETufg2TshMWRfUKhvQvxxaYrTqrJjq7oxLGqkPU1w5
	 6X2gFqiPl0LohE6ALVPuLQjH17fO8KUQU3wqYQdFmqPEYvDasZqZSebM/7aODLhi8HqGd
	 RVQQntJmPdMdfElZOPYvZbSDOQ6JXnVtMs7fSA3bh9pvD6caPq0dM/Nag0oNXo75x2r8p
	 G1WBKldIOTNXY5V6B5srW0BQxfsbnOieg2YwxA4tTOIDfQhspQ65930BUxtl5iF3i0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399178;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=dXm0JcWF+C/KVShh61c7qMJiTSbyRZrBYUEu2eQdrac=;
	b=OsL15AxCoM7xRDNbMv1TB2081ZaNMSBsNpK93UMUu/h5BaOrtb9jRbTl+ni68pbZtUS/
	 51aUIsCEpnb4IFOKC6cjU0kNA4ginn4z6/DivBYW7YLULI4g9GCfQLZw0UhOfK9pba6iw
	 cfuf/ZItyCLOgoN90tSH+NCK0OoLuDhgUiDUDqbx2Olw6/UEvv71OH8DGIyHPTi3tucGU
	 s6PpJZBPzfMSBRT2FMISSrgQ/rpT+J3IgYR8YgGoieJaF7Z2k6sPMiU4pM7UPYtz1tYOP
	 jF+CPFduB4/4Nr9L480WFtVmP0YsQ1iwjyngigdMjAKGmMjwz3KS1tOimTr9UfpDOUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2+9BuZr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B66606A31C;
	Wed, 11 Nov 2026 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f2+9BuZr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA581F00A07;
	Wed, 11 Nov 2026 12:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794399178;
	bh=dXm0JcWF+C/KVShh61c7qMJiTSbyRZrBYUEu2eQdrac=;
	h=From:To:Cc:Subject:Date;
	b=f2+9BuZriRPmGzL9Z85Q1y8So6twrVUC8Bx2N8kLRNKYB+uaJMLNDmTNMhassC8Us
	 3uqM3GFqpvr7SHKCiDhXLY7IoNGRpgY9+wMWGpmmH7qY96gz/q/qJzO0qOJN5Szr+c
	 H5gvEn8RfKRA82UnTXDGwZcK6Epn6IyrFFsdd7kPEIux4+z9a6Q5gbSuZqkZo3BDgO
	 fLoyEk4F9xU2jQDb4CupCvIGujtK5/leJNg9jeAuSeLo7jFlp7ojkZXOVypSG/j32N
	 fD2myG8/7WzGgsXDS/mjdu1AF7s4QjmjD2KDRDVdSfeR4t8O9H/XmJo5ie/2udJPz5
	 8QyMHbmhy1DdQ==
From: Thorsten Blum <blum@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Thorsten Blum <blum@kernel.org>,
	Yury Norov <ynorov@nvidia.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: intel: powerclamp: Return -ENOMEM on allocation failure
Date: Wed, 11 Nov 2026 13:12:23 +0100
Message-ID: <20261111121225.70218-3-blum@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=blum@kernel.org; h=from:subject; bh=MzwwFr7Z8BbQjK9ON9Cn0xawF1ECLb3vQYrRyXHTcDw=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlfolfmXT24/GXh4417+WYaTDiTaLOKWcK2V9vrzIFdZ wqi3edldJSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEbqYy/I8VWbpprwm347Or VpJn2frnl/iJH0idsuwU6/uFceyCSywY/spUCd6T+rE89vO9NXNPTXyV7Ttd5c+TSUnTd6htUG1 LO8EKAA==
X-Developer-Key: i=blum@kernel.org; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit

cpumask_set() returns success (0) if alloc_cpumask_var() fails. Return
-ENOMEM instead.

Fixes: ebf519710218 ("thermal: intel: powerclamp: Add two module parameters")
Cc: stable@vger.kernel.org
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 1ffcb0a699e5..df898fc3f3e6 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -157,9 +157,10 @@ static int cpumask_set(const char *arg, const struct kernel_param *kp)
 		goto skip_cpumask_set;
 	}
 
-	ret = alloc_cpumask_var(&new_mask, GFP_KERNEL);
-	if (!ret)
+	if (!alloc_cpumask_var(&new_mask, GFP_KERNEL)) {
+		ret = -ENOMEM;
 		goto skip_cpumask_set;
+	}
 
 	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
 			   nr_cpumask_bits);
