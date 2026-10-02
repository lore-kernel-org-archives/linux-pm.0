Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3479F4D0CD4
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955931; cv=none; b=H7985HL4933t8seKgfIPHIawY6GcLd+w5vW4fKPFsL6vxEOjoPyCvSC57R7PbCbDRxflagwvSDbYMdzOa2u23sNP2Xjkr8lZBgUA+tbF5MKVaC2GQpTpu80kQaK7b5H6O74g+q5JYfitvwRCJkR3wPPGMNaDbvm2SmxZWOWaOj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955931; c=relaxed/simple;
	bh=qgQ6mPEUSsweS0ySFC93r8P4Eludf9RVMAvxsJJRRs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o0qkI4HQOkOlJythLHUXJQmCPgiM6rnuKxDCewThzGJf8SPhIqoZVQ2IgBcDLspF+959YtmCihEqQezbVYt63XmIMApeMjUbotWA1To47CDOaYwY2G3bXkAdOwtjRDkxzVSd3mZEEoC4wQd6F/ai0/S/iRE9468P1Ipe0wMsecY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eM78FrUn; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eM78FrUn"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d3920so262495e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955923; x=1791560723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pxDjVmpry+V5sESUwysJzs9Q3KJpqmz8KRnIcWV2Dos=;
        b=eM78FrUnxkEFSWR1T5s3qUniky8aZ2xEoRNeycWDgxz8i3mV6XNhfM+BOj59rsxZW8
         iRKfNHTYXjYS1kzs2DLf0NOtj3xW+aOAbgXAH9ASqseOUYWG3obWSl+LcKSgiP91A7xX
         1Y/JqVzd75r2tqALzoRp71fSNf27jXdnJkTYJ1LtFe8Tyz7nnc1KaxxVINKDNxabQKUk
         ZokPjH4TfogGUmMOdccO124MK7IdjMn12O5dr/Gdig3OIR9jJmYv5JBsLQNCJOCIovoP
         OQgCWzh7RaSXds5ZMJQVIJoeS7SxX/4cO+pxJtNYHnr20HG7fmzRMo9njAJlVmw/brLq
         03rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955923; x=1791560723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pxDjVmpry+V5sESUwysJzs9Q3KJpqmz8KRnIcWV2Dos=;
        b=0hLwj99saBRcITJm1z6uvkGVsJNj+C2ehJLIra7qF8Y+q7c0O5EMIqxkQKZF69/cQ5
         mxSDBJ9BQW+uIisw3qMcXMAgDIp9JqbcprlwKpokJgKMEVvXNfGXKMghEkxMKvk0QX2Z
         pdiwVE7ZEKNvG3A31xWYwzEJH/VEYV4VdwrV+hA8V75sS+iRDfHdPMd9y2wxNhC7pzAa
         MTybu+1HatTKF2DdwabbKxDvMGGprMm8MdCYjJXBonOmeGqgrAmCjy//DIm5/xniEKGW
         U8YRg/8ho80CRrzRyiPro9GgCFr1R8JxZ7K5y5Ax5wcOGue54zi3+FgIP/g/e8cpkoVj
         ADGA==
X-Forwarded-Encrypted: i=1; AKwUvBxYiXTHjoU9mJADyki4Q4rOX4GkEZ5kvG0VV3ulbDSZ+i3gxfSQBOcfnM2eBF9fTR3mpd2wLriWrw==@vger.kernel.org
X-Gm-Message-State: AFuF++kGkzdZUT8OOoKMtiC27Cy4gGcOMsPqu7+JTkVoSPgrbrrDd6wZ
	40S3fx1RYEAfyzWft8/dTUCvvHidwotahhWTq1DLP+IriBo79/VPDJow25s9vV/xDrU=
X-Gm-Gg: AYBFou1usqB9Oo7Ua1u7BhmLJPz1kesFGig1VKD9+nwpJ0iWr4d0ndLi3bylSImxYdM
	tGVIjD/yA/2xU31fE5YM8MogWifGak6kCcvk2mdfjdaBnIY9B+BU04IxASLO/xDUP+DWkTZrSjL
	sw8NGf2Jakiti6hyFRwCNG+ERbxx754aYCDkjlZjb+NcDUOtgKT2xqHg8JBlLg2LRygBtjUrgyq
	wWVN8I+XitZmuZimkE0ef70t1LSAoD/N8Y1XNJ0QcBIFYKxoGpQsufISQYrgPGfzkMfisKmHcRE
	H6hXSDZiw3SNpVOU5GRXFVItot9a2Tw47pJulN0qGBLk5i/kohblk/JRu6nG68OlRNibmZJ/Bka
	Ln9RRSMh9WzxbzQRX/wHxTc9KGOI0Bd21oVOnyokKJxHlmrR3RaoRrMNkDgL0cR7/IRm2cFgcwF
	xKkeAGnuOll8kLCISG1dtolCLKnjZXwUxdjgOtvdlb1kNWuJPrUfCfSboKEgTNx3FVtuqn/Gvn6
	cGRrnBaHF1Ezxk6
X-Received: by 2002:a05:600c:5308:b0:4a0:168f:d962 with SMTP id 5b1f17b1804b1-4a02751affdmr54746315e9.3.1790955923338;
        Fri, 02 Oct 2026 08:45:23 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:22 -0700 (PDT)
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
	Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 14/18 v2] sched/fair: Enable push task for preempt short
Date: Fri,  2 Oct 2026 17:44:11 +0200
Message-ID: <20261002154415.2270586-15-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable push mecanism for the preempt short feature which is the
1st feature using it.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/topology.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0248227d983a..6b1058268e6d 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -3475,6 +3475,9 @@ static void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new
 	sched_energy_set(has_eas);
 #endif
 
+	if (sched_feat(PREEMPT_SHORT))
+		static_branch_inc_cpuslocked(&sched_push_task);
+
 	/* Remember the new sched domains: */
 	if (doms_cur != &fallback_doms)
 		free_sched_domains(doms_cur, ndoms_cur);
-- 
2.53.0

