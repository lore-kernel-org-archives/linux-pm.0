Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EA83A75A2
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520599; cv=none; b=dEGDvP9NOPCKGknrIQmEP941Qenu++kgah/sS9t/S4waQLxMR7hQJXtEls2WehwEgrk0ov+Dt+UZ6fuxW7ydUdjXsBxXh0tKCQlepgAgGIvWSLN3AkgRvpEaqtlXepamrHs72xMJ2n8hFMTGx1nUAHVrL2da2snBbwxP7knz6wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520599; c=relaxed/simple;
	bh=ER8+VqkKNh1m5awCYEZ0+WC8t8fPrdYjk//ReUw6pk0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYkWhnthRUweYbt6Up5pr+scbjBRsoKv4DqX1kpm2pEd4TJAEWz4l7krE41ak0+e8T7LmK64MYAwr5Nn1vNOtsS85T0RyjEyw3xBpvQrfNRXqErzrUKcqjzZs9xu3tuLh1w4ZewJGgGH4IBVTEvlcGJ7ir8mG0YKomCmjNhqVhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHX5vr9g; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHX5vr9g"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso923944a34.3
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 04:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520597; x=1789125397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JppfUUpZfHKcmt6XqyrmFgzf+ARztTLGx1FGIhTdjnQ=;
        b=MHX5vr9gnpI5FXxDnZSt4klU+uF0DRX05+ChFKdk9U8fwjkEfIR29zK1e+eJGVxvqA
         8nP1XNpdi2nca9TJhD6RCrS9kp1DFJ1inrMya30oWsghuAZY1IMiLgU64pHwoclOZoSb
         E4qWg3MXLvPVXcyVs+fsIfuLSRWpQt5oPFaUC8gLq0eXexPGUovy6HJeJEQpbrXguwxr
         dlt8ahG7xoz+qIX+tFNq3nfzjC6QuYK15SHoKnFhJD/n+PnovMftIyudjK+rCHVOp13/
         UE48tj4/QBOhNvqIda6AlIKY+PZvqeD+gaQCUneiZF3J33AqssFRMDtFExNuMFf86gSj
         F0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520597; x=1789125397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JppfUUpZfHKcmt6XqyrmFgzf+ARztTLGx1FGIhTdjnQ=;
        b=pYRIR8s7r5j8PXmBZTA9cknuL34CbCiGrgsAwZImuicZswkWMrD4Eph3wpuZWPUBtl
         UnColvbFM04Skrm1XK5Ao5XtdDqDBm9nzJQX3nNJNKpnsl8oScCVwXwHXUuMnu9HhFeo
         7qa44YnckqwIIR+Md8QnzX8KEKPwsoaial3o18XEXfZO5oJgVYAFJt/DjCJG3Qy5Q6HH
         rn1u/c7/IHdiqXxVJXk/HsBkom8Dr5DoHIDGKyRC8bvjCRtLG9lV+mad1ppfE8J925gs
         +uPZGqCIzeKemnxk2vBz7JO/b4ZScDFAYYyqgmIiIBSalB1VwTT6KaAXVWYhTiWwue2H
         NpSA==
X-Forwarded-Encrypted: i=1; AKwUvBwCaVvXjNQieQzzFlTDCy6FNJ6FEBoWIacNcZJ0s/H+UtvmjuAVaUrwqQlDhuQBoC1hjGgNHtSc6w==@vger.kernel.org
X-Gm-Message-State: AFuF++mzGTudJ/7WNNkngDFNjzm0JrScBOlrrmZRatiRZaI5358TmS7f
	relelQ0GA+eMvwXRkygUX7SozF0bUvcNBlil4nbb2O1coZkGsJAJ/XelInmiE5yQ6S8=
X-Gm-Gg: AYBFou1MNX/RP18GDwoMYSRNFR6/9y2rJ8ySPQgmx4c0eLT0Nq7zEAjVwjBf3K04ENp
	Bf2qluvqn+EHQ4RFDUnYxkc1ds9wZBkeJgD6syDEfn8ZmJphlt7vBdwm0Kdo+ts/JkKzzv3CsDW
	FOjMIHNmSTcpU4mpEwFyu+m1sC7lP/t0PmsUD+JHULJoxXGzhxglY0HwjCHKHqVG3p7iVgr47n9
	TZN5vfzxm1VNU16lUrrBNj66H1RMY1SOvuXAZYlPbc4lUza8BDqeI2rpxnncUfqcHuAWa1XOAzJ
	f712cdMOlAZB9HVEHXUyXDY8Uim0UrKnu6wgq7Z7ynhwUwgSTOzxCsw9IY4GF1YY41nUdVpZVie
	rFMyFcKFvCA4mwAXGVn/eSCRUNKmaqsFGYuRypF4NRLShsHHxCJeOWGuXq/7f5w7s0jw0jRLB9o
	9tvniKCGJMJueIHiLBHqaeDmQ+ld45lS9zrKLIsV7weJo1hg1XuMhnzdg4FA2mwrQl/vp87nyrs
	7mMsUOUQzAkJAs=
X-Received: by 2002:a05:6820:220d:b0:6b1:4061:4193 with SMTP id 006d021491bc7-6b6f7988a8dmr3287799eaf.0.1788520596953;
        Fri, 04 Sep 2026 04:16:36 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b6036fcsm6395431eec.20.2026.09.04.04.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:16:36 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] interconnect: fix typo "commited" in comments
Date: Fri,  4 Sep 2026 16:46:31 +0530
Message-ID: <20260904111632.29262-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "commited" to "committed", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/interconnect/qcom/icc-rpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index ca4c8a944755..da06c58e078a 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -402,7 +402,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		if (ret)
 			return ret;
 
-		/* Cache the rate after we've successfully commited it to RPM */
+		/* Cache the rate after we've successfully committed it to RPM */
 		qp->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
 	}
 
@@ -412,7 +412,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		if (ret)
 			return ret;
 
-		/* Cache the rate after we've successfully commited it to RPM */
+		/* Cache the rate after we've successfully committed it to RPM */
 		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
 	}
 
-- 
2.48.1

