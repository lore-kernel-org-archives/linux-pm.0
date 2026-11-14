Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794675437;
	b=azuN92yb9m/42mKNecMkpgCENZtsMq5kGMnhXH28PSZFHpNygYDLQweF4NOFy8d0LsSs
	 moa9MuMtvPenbqvR/yrRfer1o3vKVhm6iKDLRaUvgYSrT7YCyIwZ3QGKYCwxyE0ddwTEd
	 amIkrIPHRrVROyGqtwp9T4pAvOnR0YOKLBOF9svMNec13iddhTCNn2Udn+eH85EWdAYCH
	 t2Q1yf1svunWPDercOgnsO0jsYTGEQAWXdIPJVkMTePYm6eK/G3YdCKzQw0O8Gijjk2dF
	 a54qgMpS/tLUV+9BFMqXmFVhDyzh2Wi6QeNVv0i19tS50pPA8fF6NIKgmsqfZ7nT44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794675437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=wr4kdk8C2zCB8/tTYG73CAJVXLDQ9d7LAKTuJISMvv0=;
	b=lbgIra+ozqb1YoO/slvavLIndhuOYkASEOAHYHfG7bJjboA5mKnI57wVM+eWwIfuaXBV
	 +EE0aXm69UhyMx+dFlmwwgv+8LLQShZjQsyY10u+AgWTTx5jCRkRRvEsRe+GDzlPkG0Gg
	 iTnb3itQy89baW/d+xT7D1z0qxn1Y/EuN9l+2x/5blWULl2/rfU0cA+9XYYxNNfgnKLu0
	 E6KKMBypQDQEvvIriLI8oUhVXQqk2P1m1WYkb0pyTLcKU9JiXOjJxSvVrUfmdYD7jQkId
	 3sQ3qNzz6Ud7bDcHef0tD66YQw29NONvrWsSZyNIi1aA1eAwBlfdiz646i1y0YFtvkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4Ei6ecn;
	arc=none smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F8F606A89E
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 16:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6F8F606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k4Ei6ecn
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c17a1775fcso1054770e87.3
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 08:57:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794675435; x=1795280235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wr4kdk8C2zCB8/tTYG73CAJVXLDQ9d7LAKTuJISMvv0=;
        b=k4Ei6ecnHRY1e/0/w/PKq2+Ze9Gqhi+rtn0BBcjUFOYg/bPyzuVdefRH0j6dwoFUG5
         TaH5kVxvrdC+S9ih5z2ZHBacCqygR0l5xxeqFcB0Fqrh2da9oFtMa7oM+zuN7PHdPWWq
         V5aYzDU9vBVd2Ai7fjK2bivx91LbCRa9qJhHBFicUGUcwnEiLG3OeZWZT/qmGbJrzn9d
         6PTVrjages/NJZ4ZM0ra3z98iy4yeO4kqsJX1r6LPkA/htBqh2bgGnH6VHU6VeoBudm6
         d0hkTtyzQzv+VcEODbRSpoD5RhE9KLeENMzR450c9OebWnARW/JA61n4EjA8PfOea9S1
         XrCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794675435; x=1795280235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wr4kdk8C2zCB8/tTYG73CAJVXLDQ9d7LAKTuJISMvv0=;
        b=CHUdn6Gsy9wFRLCG/eLfG+UGEP6nhvl94cJqxi5Xvpk6QJ3XSr+Dl9lbLeKRjdBjww
         7RngrtqLOJeXbJwVNp6o+QvAQaW9ZyV0utZjdx5JQOXMt9VpaNDv4NpRF8IJ1nhar+7U
         7pDHTQWvZlYT9o5O8wyBT3CQppBdfhXxBAnFbsn1hsn1XnsMUKsHOyIeBXelCJVOaLNM
         job+1d95Ger38sbqREN0/Q0ntX79jthW6py3B44z/osB8PrICcEdAwWe+7kmr0NkkjRu
         DBLMydI+xD4lT+WtSdstY5/U3SCOTqfETW62mIQ23Cncs3Qt4nUJTjjzjArNGHO3C/eF
         yTgg==
X-Forwarded-Encrypted: i=1; AL+hErFJzE4ZCwn4So/zb6xuDXHpYlZV44N/4ZUraIi7AI2bEM+bhN6bm5wifr57vSB4pvLno8UfEsvrYg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/bKFXo51Y71NDt0rj593qcg3Cw2OAlgzF+y8N6R6OEjxsMLrIl
	L+s+kLz+cAgypwxOO24IsPOT5PF+aC/HQdxAuAV5Snpp0pSksrM5Gvrp
X-Gm-Gg: AYBFou1DRiBvm2IYgdOVQ1pLuexJ+ZWeBOAGXIkbOS+fXI8u8DHGFwyMCuRY6p3ENZ/
	bzINff+ljSaYZ04BbaHZDEEeS9GYeU9zRj7t5GMpF5tWpMlykukZN/i02/d1F3D6sCDnlwnFrrJ
	mJ2/udDj7gnrrmWY4zFUoQfiiw/X33cEHt4NlnD2iDTaH3xXAtsqD42eYNQcltKNLLepPh2jgrN
	Whx/dW4YOyo5pq6pWRbTrtbtgcgl801iGjpz5exUb4/aeF3PX1FJGqXz/6PlDoAKdWZXzHIu5lg
	v8suYWq2XeYZ6HS3ajLVxO2tf82RZIIWdloXCAynoIL6sjiTl+ZqblmsWQH2yYRp/ndfP1vb9hv
	QG6nbV5jTqqnLhtekVpVdOE+h7cRMiELWrPaFjSrMxif69lh5ilsqUQvdS79fTPROVK8U13ecW6
	WGttMjxfOeAZxXKDSs5T00PT+y7YOQhRB7+AZ8PKLUycaMnt9Vs56NaRnfZb6H9r9VdcSv33ISs
	JdFgc5cfmyE/4sgDfj1ce86iT8VA55RoZNUlQQWG5Sg2WrER2fF/SuEojpn0qrSQR5klangIkzk
	lNLt/quSjsq230vLdkCrJ/p/9gm+GeqE0Aofwo22ES2PvRuGkyGs4zUqamRca4DkkczF6SZfqFs
	d8vdEtJzK2Z3CDctnoDT7yCk09J39SOG8
X-Received: by 2002:a05:6512:618a:b0:5c1:5278:f9b7 with SMTP id 2adb3069b0e04-5c170b1c7d2mr2300190e87.20.1794675434789;
        Sat, 14 Nov 2026 08:57:14 -0800 (PST)
Received: from SafoStation ([31.40.65.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1712dad26sm1792051e87.8.2026.11.14.08.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 08:57:14 -0800 (PST)
From: Safocl Stollmannovic <safocl88@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH v3 14/14] suspend: fix duplicate extern declarations
Date: Sat, 14 Nov 2026 20:55:54 +0400
Message-ID: <20261114165612.368785-15-safocl88@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114165612.368785-1-safocl88@gmail.com>
References: <20261114165612.368785-1-safocl88@gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compiling a kernel module with a C++ compiler results in a "duplicate
extern specifier" error.
This occurs because the code contains `extern asmlinkage`, and `asmlinkage`
expands to `extern C` when processed by a C++ compiler.
Since the code already contains sections that respond to a C++ compiler,
I believe it is a perfectly valid approach to gradually move toward a state
where kernel modules can be compiled by a C++ compiler without any issues.
The `extern` specifier must be removed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=222257
Signed-off-by: Safocl Stollmannovic <safocl88@gmail.com>
---
 include/linux/suspend.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index a38150277..b97af3420 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -385,8 +385,8 @@ extern int swsusp_page_is_forbidden(struct page *);
 extern void swsusp_set_page_free(struct page *);
 extern void swsusp_unset_page_free(struct page *);
 extern unsigned long get_safe_page(gfp_t gfp_mask);
-extern asmlinkage int swsusp_arch_suspend(void);
-extern asmlinkage int swsusp_arch_resume(void);
+asmlinkage int swsusp_arch_suspend(void);
+asmlinkage int swsusp_arch_resume(void);
 
 extern u32 swsusp_hardware_signature;
 extern void hibernation_set_ops(const struct platform_hibernation_ops *ops);
-- 
2.56.1

