Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978422;
	b=WfyTWVlrPTTOTFqwVVVuZKq0GXgww2wHyOKnAVNjUrypswTKEjaEkfv3zF/zhRuxZ1MI
	 wI4pjdxHM+k48KDs2F7Y3JCObVaih0nmFXhNJpugjN6dlTlwWxBKHbzwvWBPiRZt8KzPs
	 T5C/5uSVb6kH9brrPkMToqWsZ7/W16iud4L6oQGgsdirkZ+aqqyDMnnjNwCitqD2fk90E
	 zsWqaMBecaVrkgvwaJvmxB+sLjADJUEyTD3UdL/f/c4M8nePfSwPuADeB3m5EJZQXVlDG
	 x2w98UQp37bPRhULrxc5pBvQR2vSxbR3c4OPtcsB5nC6P+RZ6Bxs/zC5sWoORBsxb0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978422;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
	b=RPylys3SLM4KX2WF8SkCizWsVftBituwp78OvTFeGWTg5S5n37aAbhRnssywPNK4eKLJ
	 fNN16mKJaRFpdmt+0xTmthR2b+ub5eOhqha9daK1Rn8C6wRAvVdZHzYUWMd2RBL8rYDfK
	 uuHwOpHGUe0/itE7W4M/5A0yyObu/9hNx74P1/a9xxpka+DZ2VRCvHWA+YUc0/nRe36gb
	 I+foZSNnmfU0eLV6Jl5n89d6iwzIak58xNPDNJlQUlQqe+X3wli+EC1Vp2I1lRgMiWTkO
	 Qcnp35hU1fYZWjTBR+enrR8OpX2QAleGcRAvvCdr+sIL4NvSkTbIhKCk2BrXJg46eHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oUaDCEwV;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61DA6083602
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 15:20:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B61DA6083602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=oUaDCEwV
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso699620f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 07:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1793978418; x=1794583218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
        b=oUaDCEwVrwd7wVYPPsm0oJBpoZHHoBSabQQXobDkNX1E/yVA4GVnM6EJ2wRhRu9Nem
         fXy0GSv7+LLM6mrTX7ub/JDoVi3llKrfkaWQtp5rSgdmfG9heTBixWcv1YfsMC9R9m/8
         wQpPF5NKaAUGu82YN/HxZ5r1W9Ih5LCkruyQF59UHv3IEcRuroRLtw643mvMX0xeNxYG
         KFsJwLKYLXvHgizNpv56l4kTCPx4E+9qkvyq0oFlA0LW1FQ0VbjzGVevyQtsszYH9Y1C
         4Bkbn7leuF/WAf72QEY7eTiwlgRsKFMzz2xMAKNJ+auHdipQcYh0ZRalBeYFTLs0Rrsl
         O72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793978418; x=1794583218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tX9HEYRWehVYzSumdU6wnzHc9q5GXalqxT96ZBMgpCY=;
        b=dgjzxflyG+1GW4x8H3szg88zu+dF9xdFdgnMlT0GP59eZO83TxVDGaBYiHAXsEsroo
         A8vL/d5iGJMvpA32vjJNOvBP51Dg0OccLLQj9XXJ50kRcMuZtWZFClAG8ISN2s10yu5H
         GYA10G3XQNh4WBF5uuTcYZq2fPOdjrtY5E+TNRLt0+5yLSMlDkC/5c7JCwQohdvTrOd3
         yazGoj2mBetnhydfbUmI+g414to2f3fu3wxpvSJwFY4P2yZ3AQ0fp4aOtdCVVQqlRACa
         acuwDGxRSIExcEoFoWQ6ImjgpXwH8xVYHnf+oY/CIIeCBUlK03iJofC2gtZBM0noxfdO
         yKIA==
X-Forwarded-Encrypted: i=1; AL+hErFsVWT138/3+4WrhmlH45g/DTiZlKnFASQ/IwFOuP1ez47iF5QYEKqTvkGQ27lJmaFrspq+CW04xg==@vger.kernel.org
X-Gm-Message-State: APuU4Z9K114gAd6tpYRThRA42Gs+gP6GvR0xv1NWkFJq+Mys3fGIAblC
	5fJhPlZywkK8ymbi0W6D/KoadbP/zAsX6b1i19hwO+q2W3RTLZ29eNyIEWGStBZTkgA=
X-Gm-Gg: AYBFou0ziN9u+8ErhE8srgnTWV+XJkHkvwSl1lQafXwyn/bqvKdophbdQ+OqcnY8+nR
	0LE2chhiKfKaUeRWLfwrY5vYp+BDIOvoj5gW71vqQk/AhoieYOxMtk8p+JkH897aEu/5eun98c+
	sQ/5U4Up0ZY0HUQJxPftS9hMSrfGCfxrmNphi9BFtgLfg5pym+W8PQLXSg2KoBrPf2z34PkvDVu
	KkN5O9oIceadQpuCZWWpW931AmD3eppu6Z+iW8qzvWaBiutzbO8ffDqsWNb82nWQALHcpM9PP/6
	ZRBw525+KCFAgjkxQq2CTIb8M/TDCGhzt8qEuceBet3GJ21dxOUo1lsCiZOzHQ/I4B64+4LY+SG
	VVwY26AewecWkAhGrdA6TeLNZ40glf9bVYsiw1kI+ZBuXjmRHBJul7UZajn+K/50p/9VEUYSgr1
	D4cZflBKYJkUukMGb9PWS5jtw63ncdQ5gurkbet71oJp0nPuxyS2Qdzqcl4k2crq0Y8xC/B6ko/
	fpiStooyy9P2+KtkJyBeBlYOPA9CAJ5vjKzDSHJaCAhybFVD3bif+RJhspv2udP3V2/Qor0Cx90
	xQLiD0FR6+jtm08gUgZcyGbTWcHL1fBPP20jYTojE+2op1rq
X-Received: by 2002:a05:6000:2893:b0:48f:f26d:c5c with SMTP id ffacd0b85a97d-492761d00cdmr6320952f8f.9.1793978418032;
        Fri, 06 Nov 2026 07:20:18 -0800 (PST)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:ed97:32bc:977a:3b65])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-492d7cc5e23sm4477405f8f.45.2026.11.06.07.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 07:20:17 -0800 (PST)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	lukasz.luba@arm.com,
	rafael@kernel.org,
	linux-pm@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev
Cc: qyousef@layalina.io,
	christian.loehle@arm.com,
	pierre.gondois@arm.com,
	sshegde@linux.ibm.com,
	kayracizmeci@gmail.com,
	tim.c.chen@linux.intel.com,
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 15/20 v3] sched/fair: Enable push task for preempt short
Date: Fri,  6 Nov 2026 16:19:42 +0100
Message-ID: <20261106151947.3991524-16-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106151947.3991524-1-vincent.guittot@linaro.org>
References: <20261106151947.3991524-1-vincent.guittot@linaro.org>
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

Enable push mecanism for the preempt short feature which is the
1st feature using it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 919d0fb00bd9..5481f2472e17 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3497,6 +3497,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
 	sched_energy_set(has_eas);
 #endif
 
+	if (sched_feat(PREEMPT_SHORT) && !static_branch_likely(&sched_push_task))
+		static_branch_enable_cpuslocked(&sched_push_task);
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.53.0

