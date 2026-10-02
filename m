Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840734D4895
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790955932; cv=none; b=AQtWajiETsja5n+ZKXjH7q40unOOCs0puHgpFnjCNnw5m6aDnvulsob2dDK9pciIWqSIUsxPvHDyustV1zuYNtKC5FnZQev+4h4gXFUiDtXbFAd2YPVts/xLdVqeU+JGBFjy6Y+6RaJPxV4id/BfiyUpf+umQ+V5iPliHlTLx2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790955932; c=relaxed/simple;
	bh=XJBmbAQssDpv3cWBcThWNbjc6nl3j+gt9Ko4eNiaO98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg9cL4gySxM9dXnp1L7vPR4h6zA4pusCmRfEQjOsFVTgvP/sZDzETMGnqs78X7KbezWbDyrooDi094jEG5maYdjg4Yd81HTSXCtVIBhw6+8BLO6ijDa0Ot/6iB8TYEgWGWm4h6v0kmDsl4lU01YtmXz8QNtl4tdwRXVnFFsH7lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nhzdFhK4; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nhzdFhK4"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-4a11603310fso427385e9.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 08:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790955925; x=1791560725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=nhzdFhK4XJm4ywkcMx2iZMlbdA0TopX3qmiFqXqJugOxcLyeKb3VMWUs0kTjTnGuM8
         2mNAe8T2O4hzGJQSPLdDh82R7EJs0X889b+En2tC6hrk17UoJZG1IZ8bXRoK56uxa2zx
         AO+vWqV8B/fAAV8FQKM+MAHDUiEWDtazoFIeizUtFrCdVkjLsW0+qfVNTkOTlQBCuqSE
         Vvd6wedQWqZPk6RJgoTNBb/SUo8uK55/IJa/tKgPE+Agf7NmfSihpJxqjgkTl/P5giYl
         SQV52N9l+O719/iKvYM5j3/pDDgcnqX5MVQdEzeQrUKfYqm8CTc6LH8x3h35/b5MEyqu
         egAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790955925; x=1791560725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WkE6gJnDRs+XLmAou5XPy/YO7fax7WUEGWY0OkDdt7Y=;
        b=bIv4hV+4IkOpwlFiIxSuNXgqhikgquW3+X491P8OOaEzNbtjQrFWn22Bu8H9/B2i23
         N/xlMZ/uQSii3vTRvE1YUlvFgPAhEAyw7pcxTxYOGjiBclbomMFy+0KbDc8QXVJggZiE
         ptSPmQWukNdvW8Pg6AJ9WUUYzan/frjRIUHn/gxVnjIz2pjRKwsJG5wQHNh2JmWeRi+G
         U/NHqfVmEsrDeYl+GDroqMw6HMlWJRcz/MqkXr5lc0MOXzoqjSzr4Io03VbpUcuRzqIH
         7/J1IjlUv+nLufB6JRIKNETi7RIgmFLTt1fshwtPUXWetejTTy2f8CYvMTB9EFiIVSUw
         cizA==
X-Forwarded-Encrypted: i=1; AKwUvBzD7neZT2Q0CgQ3TcHpQ+Qy6V6hbTa4f6UUuWaQhmYNPwzRgrqujOXa6wPqBi/x/r8I3HPSJbXqiw==@vger.kernel.org
X-Gm-Message-State: AFuF++mJixMsNdhNuck7jrpZmElSdrPSj1Ku+J1Fvxf9Z/zM7RrjtWsi
	y1K7LEWI2rU9hmXVr6RGKfTUWW0MOX9CsZH4JnSj5gTc7G0FE7C9cceHp9VSjRoEp90=
X-Gm-Gg: AYBFou2w9bVUjRiEjHoG06uelGM4ccTu5KyDrFISDpJK8Av58jYGOdVjY705Bvo1kXB
	Hi0X8pffm+/wfIreFV/+CsnaluJPAkJmggSAckREv0w3u6EQ2VP6Y4pbcGOMS3q3a3MOOVixRpk
	VDTplMV/8ZFw8PfSCBfb0+IZMlcFSPNzwiB0kccfyTF4YwSaPaXUqFiMBUHpTpCcmfVqFdajXlP
	WiG/EwTeDYJmuQQ8LAkJkcVMkMxNzKYaC15R62qQTqk9M/aiY8q51DnUasyYlyXkgp+94yHZu87
	K77UhN6ODb9Lw3DU8h3ccKnOds/d0fivSkESNZlgKT83Ez2CEQUHSlp92ZhUVFdTKgEQRIsJ0N8
	jXo+CwsGdPViodyhTSNHAsGa3jh8pg45+kp/yswzsHqBZ7oAsgSoGCif6/rTYb2wyeta3KG5cIR
	q3fgwHNP1ZXhEvpHxeizLVnAAVNQ3K6DwJKiWFn4WveEo/nXDV2kIAhcShh1B/TfVurScpA4qsZ
	YvHLxU4xBcwdgKt
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc25 with SMTP id 5b1f17b1804b1-4a0276a224amr56824375e9.32.1790955924579;
        Fri, 02 Oct 2026 08:45:24 -0700 (PDT)
Received: from vingu-cube.home ([2a01:e0a:11f4:3020:718b:4747:291c:e5d8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0280bcf0fsm101958045e9.6.2026.10.02.08.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:45:23 -0700 (PDT)
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
Subject: [PATCH 15/18 v2] energy model: Add a get previous state function
Date: Fri,  2 Oct 2026 17:44:12 +0200
Message-ID: <20261002154415.2270586-16-vincent.guittot@linaro.org>
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

Instead of parsing the entire EM table everytime, add a function to get the
previous state.

Will be used in the scheduler feec() function.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 include/linux/energy_model.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index c909a8ba22e8..89cf109cbca6 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -224,6 +224,26 @@ em_pd_get_efficient_state(struct em_perf_state *table,
 	return max_ps;
 }
 
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	unsigned long pd_flags = pd->flags;
+	int min_ps = pd->min_perf_state;
+	struct em_perf_state *ps;
+	int i;
+
+	for (i = idx - 1; i >= min_ps; i--) {
+		ps = &table[i];
+		if (pd_flags & EM_PERF_DOMAIN_SKIP_INEFFICIENCIES &&
+		    ps->flags & EM_PERF_STATE_INEFFICIENT)
+			continue;
+		return i;
+	}
+
+	return -1;
+}
+
 /**
  * em_cpu_energy() - Estimates the energy consumed by the CPUs of a
  *		performance domain
@@ -375,6 +395,18 @@ static inline struct em_perf_domain *em_pd_get(struct device *dev)
 {
 	return NULL;
 }
+static inline int
+em_pd_get_efficient_state(struct em_perf_state *table,
+			  struct em_perf_domain *pd, unsigned long max_util)
+{
+	return 0;
+}
+static inline int
+em_pd_get_previous_state(struct em_perf_state *table,
+			 struct em_perf_domain *pd, int idx)
+{
+	return -1;
+}
 static inline unsigned long em_cpu_energy(struct em_perf_domain *pd,
 			unsigned long max_util, unsigned long sum_util,
 			unsigned long allowed_cpu_cap)
-- 
2.53.0

