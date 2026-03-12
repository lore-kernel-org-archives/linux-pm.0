Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C973FE641
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338046; cv=none; b=dF2zCZTmKD3789PG15dw/qNLN3N3ToUXFJd1wQSALo+QNS8M3k73ZOh6NcwlGZ1t9o8+mMTEU4c15+n+M4wmky2lf/l+jH/GwPiTgrJhM0vHFUdlOBidwV3BKnwkDsBS0s2PZ79I81cV4hbkzDzpNjBFRKmuL8SkrONIJk8om4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338046; c=relaxed/simple;
	bh=0mqHB9yCWgRA+Ai3Bj2tlZRNssxUZO57dPTv+g71rYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNXWMRMdoScG/6nmvxdR1NmDMnYjoCQBEpJGDFl6kerVCWRh6JbE4LxZZdp8Uk6HALptHtagf2rjwV2Oo28COES5IHrmlzcXla0iv/f7TT21fD4i/7MH9YGoUN2dgGsote2M5np0OKJf3+O9Ztgq3ShDby8pxAmcOPdFXNqhBj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QtAdK+Ae; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QtAdK+Ae"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2ae4988e039so16490065ad.1
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 10:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338044; x=1773942844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AHYXlCzw3aqCugUumSoYXfA+lp584l7NZmh/mNebwA=;
        b=QtAdK+AerAI634FbrngbY5Q9mmbUrgeoBov06sQTMuQvnN7iqd5y/swZKG6le+eVvU
         /72rcraGffnlsPgKASkTH0czuQQhIj6jlIP8U5WlOrh4wGf07xxGxurrdtCkwU1YMO7h
         2rvq9BbAUhEhSybd1rVi9XeSLXXBXNHgbs+eEhqU8ihWpG2qhmpQhFIpDIucvl9Ld6de
         /50fzw8ezaoxeWk2BkOcd6GVRMHM5L/0XHuC6oBb0v2J4CQyjvbsm+a5EuwKjOoHLR6m
         5bsFPhAjL+GEQO9Taxc/HhQYvilnQ4274GUnD8aYYbYHinwZ0dtM6GkJpEHPeP5OnMbN
         /7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338044; x=1773942844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1AHYXlCzw3aqCugUumSoYXfA+lp584l7NZmh/mNebwA=;
        b=V+68TWGgkDwJsk6ROi2A8rg5KhiRgVD4VvCeluyqMUScR1MSfVtFuZMVkzbO/Kiq8E
         hZZSw1UGUSTyq4RrYFTWleFgNZX3lGBqlW2WbOK8eUCzbjuOOm+C6aGSWmAMMnabMGoj
         uaxAk4sQDb13wETz7wDXXN26EbsyULvxx3BKHTGkCIRWbFvT3wYxpY7tSihwN5MAEK7V
         vk4WL5h//uMzGcAkyeEAPmWjAagqaG2IbpQKRntFxaFGP82V+86pRUeQ+U2hqLGh1hlu
         QMIU9Rap+BK+EiE8HjdUtFTqIm18VBoDxoCnPr/UQuurr2jwSNYnCZ7u08VbnH9fNjPH
         lvOg==
X-Forwarded-Encrypted: i=1; AJvYcCVwesWayy/cLShcR5OIOv2e9y2GaGpTZ2aG9TLsZFz5s3IaDpaC4MVT6PwwPszC5Asy2xd1RsxBZQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx9PgyyHKFBkx6KTpX1P4kIFTNrRvASdVkv6wjCnvFduPYrFGB
	cslGNwBP9V0Kl6+Sc06XgR0NG8PkoBo3JkVjGZgeBrn4JhVWoHQdqEQ7
X-Gm-Gg: ATEYQzync/432R33mIdFBIqBZ3v3XQH3nC5qoD5U5xuH26X07antd1pLr9SGb27XtJr
	9IxcGmfyFO8jM0/QAJJNJCSVf0rmL/5EycAGva1CPwojn8kLVhAa0lgfEN2QBzq+BzVYK/0a0hk
	SCHMI7s6AWefsLJdcyNuKziDKBR5ictJErJmm31XZR+JhwdK4CeeH+DloK4V9DalFhfYUw59MYs
	nrxoXppsWkKzyMqoBK78vG9EioC6u0qkQuJxz24odywhlJTtZ+te185I1DNnAETs6n92oDZa4Iz
	Tej8hSgHJy4Y79qndpO03B/Ko2hZoIYsUPkoJ78xYfxU//O9uPHCB0Pum7Z5e+ZIgIdFZjlsvUV
	4ws/Bmo+zb27dS84HvCmS2MvYwpdeqLSVb47NYsc5X2sYUwKGKGTyTnMOeeuoDDI/m2nXU/Fpa0
	xZDITKxJCgBXzGol20xDG83DyIYmAuYECFn2awsfJt+5+nqg0A7jhqbcypUlnsTMQlDEmeuxqnx
	+qUPrpP9UX4xeNCTPmZK8aq87KcK0JWrPUO
X-Received: by 2002:a17:903:2f8c:b0:2ae:42c1:6f49 with SMTP id d9443c01a7336-2aeba4eac08mr40989635ad.15.1773338044416;
        Thu, 12 Mar 2026 10:54:04 -0700 (PDT)
Received: from visitorckw-work01.c.googlers.com.com (7.162.199.104.bc.googleusercontent.com. [104.199.162.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aeae378ca7sm60453345ad.91.2026.03.12.10.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 10:54:03 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: djakov@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org
Cc: marscheng@google.com,
	wllee@google.com,
	aarontian@google.com,
	jserv@ccns.ncku.edu.tw,
	linux-doc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 1/2] docs: interconnect: Add provider APIs to documentation
Date: Thu, 12 Mar 2026 17:53:40 +0000
Message-ID: <20260312175341.2944154-2-visitorckw@gmail.com>
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
In-Reply-To: <20260312175341.2944154-1-visitorckw@gmail.com>
References: <20260312175341.2944154-1-visitorckw@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "Interconnect providers" section currently only includes data
structures from include/linux/interconnect-provider.h.

Include drivers/interconnect/core.c to extract provider-specific
API documentation. The :functions: directive is used to prevent
mixing with consumer APIs.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 Documentation/driver-api/interconnect.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/driver-api/interconnect.rst b/Documentation/driver-api/interconnect.rst
index a92d0f277a1f..cf7a83f8c953 100644
--- a/Documentation/driver-api/interconnect.rst
+++ b/Documentation/driver-api/interconnect.rst
@@ -84,6 +84,12 @@ be registered with the interconnect provider core.
 
 .. kernel-doc:: include/linux/interconnect-provider.h
 
+.. kernel-doc:: drivers/interconnect/core.c
+   :functions: icc_provider_init icc_provider_register icc_provider_deregister
+               icc_node_create icc_node_create_dyn icc_node_destroy
+               icc_node_add icc_node_del icc_nodes_remove icc_node_set_name
+               icc_link_create icc_link_nodes
+
 Interconnect consumers
 ----------------------
 
-- 
2.53.0.851.ga537e3e6e9-goog

