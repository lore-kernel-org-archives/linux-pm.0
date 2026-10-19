Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792448800;
	b=ANQu07+NcGsZywO9pW3N/z3Xy8aUVviuLkx9kXt2nFhHSopywTrUKs2J1YR09fOgwqQx
	 e5n+yCVK01t+DBVsNTiaSp6YvMvDw+MulSSJ0ocvwYlvf8548l1z9/ywPN4H7pKUChX/d
	 gcwih0u12UNmtBRAE/QRfS/cYTdDdGoJll7txU9kVPx0Ub6PitTUVXaI4cJqqBLLOQd2D
	 Z/0483Ni6M+stf6ClqDIqF4ToROZKAHcelcwcePZZK3zdE0S9VAyiD0SjBldskiAHkV9H
	 YjvE+LbvLGX4EiAJLnjjX2YqvRBaiAzEaphQLAZCss2+uQ0WCpeNbRYbD0X8LKmncvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792448800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
	b=gDYOAxtR3+N8tLEFRGEnuYEVOTeBlje8lcu8jSFClDJfSLft8tgU7VSDRwNx1LdwHGJl
	 rrJdX3WhlXArpmat9yLbU3Jz6mKxcTa6CfSXK2wl5iOs2leR4sWPpVRl3mDswoYpx/s5Q
	 VcUr8GLqCa8n5KQ8+VCF4MDPGGXqEoy+g6dizE5zMIyiwC31nvqRvNOme01oIfkoyYiRY
	 VP1/ZbDji+1T9HUBwIGT5tEo/USfP9M0tMk4SQRgALsNYpseLthajeIeKZFkOfUa/dtJ3
	 hZXeQ2oVjoGbgedDsZepgYI4Fjy477g6l9G7s+B3r1LF/QLIyZ4/ca6zCJUSBWiLDHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyoJd5Fa;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F38606A323
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 22:26:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2F38606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PyoJd5Fa
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c45111bebso1591506f8f.0
        for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2026 15:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792448798; x=1793053598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
        b=PyoJd5Fa6w0NKm6PZgA9niUo5UCGgIWXLWZf4MB4Td1LUV9u98xBgGXAAcFaV+BOWs
         hgowkV2nfK3+613G7WR4V2oLAxCnDj4iyl+52s+AK+AHM6H8fvVXlM2js+J4fCV6P1+V
         gTqnza+7ZPFrMAxxVfLHTNBd9Agu15LHoypNEAbHtjXZxZ9spm4TSzMtis29ctHvC1FI
         40d9TMfLQgS3FFkULWArffUXk5fSsDToNGhoDRJjpxABO6ZbHm4RktKS+K2pEf9fpxqG
         e1FRup0ipAOb9nKvvTPxOOD0bEvJwT71DVhJxb7+JuPDNTRtzhNmrOubY2NsO6Dno55A
         sPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792448798; x=1793053598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ryRG0e4/3H27Att8+jO3Gq6g8+ldVnq0TGRgHWVLyao=;
        b=Qo7QYPP6TDvtAS6pfMoUM62eR+zcaDROQBGuRP7DyN14DryNCINtAOiTKQEPusQ0VF
         bVteq5z417RKXiVuVPzdevbjHHLNspdFfOFoseosTO4ILrw0WpA/vG1jChx/esSZO2gT
         sP4NX0HXyHyj2CFwEmEqzjzC+tMtQNVPbvsmv8wxmfg12ON9Fcg70bxzhOzvCtRUVn2B
         UKZVHq1ckH8FtDJAeBFZMvbLuNV9X+tGxa2JVkaJcxDhWGZp2PjRnnCgG1G0GuSJ4Sfm
         y5QdRY5kkFnIorS5uOwqmITOqEWrgFiVM8S9KCsdsSe9ucz3VBfXViq18EwS1Z7sfLKz
         NISQ==
X-Forwarded-Encrypted: i=1; AKwUvBw6AAihq++gK8SRPpiyl4yEbFUkJM8xg8U4DRGzqRlnrXUGACuyIxUfT/zFYQjVt3t4X8C3wPkqiw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJWCCnRPynT1uENb3zoLuKUBCcroS/I7YZVe6OcyibrAbHlOFeC
	nfYrXEhxFkHim7cDnNY+G5LJxDtfX6XynKVPZSfw6dfoLtQs2NKc4Kw=
X-Gm-Gg: AYBFou23VHJTqjOzkLrd7+cTgLbIhhsv14+1WAWm7QIgydxQzaL7pPkrsdPjyISYpUU
	QxW/c32FXpx2FPwkeGHmETCUDeH1cOXcQAwlEBD4/UEWiFllIzhz5g5+ctrSnf77IwcN/tyO8uh
	rC29/+rKaOOSkzHaESG7M9bzmFEuT48fUMkZfwxDBh+BUj2csxm2tpALtUN7n/d1g56OOPsMWVg
	5DZy7IzmUEzyjixGxdjM4ytfAfidmM3y/7IZjW5x5e407XOvaPSschrJoBe7IozGozOJmU4VHKv
	wSeliuxTXaMM3fiAw/4ejhjWjhQDS8/XpQR3pXQsWd8+ZaJ7trkd6hpJEgJSKGnwQ8R2UCvYUSl
	Qg4r/zj61n+R8qR/T5WZIm7Ney767pYlnoSrlgSUnUxlSox7mu+DgUnuERPgFC6REPmTZ6Ug7ID
	HZFnwF0E7opJQNxKlLMUrLN05BB/16EskpVZ1M5nE=
X-Received: by 2002:a05:6000:38d:b0:48e:884:c70e with SMTP id ffacd0b85a97d-48e0884c755mr20966448f8f.33.1792448797908;
        Mon, 19 Oct 2026 15:26:37 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e1d818c59sm1784977f8f.30.2026.10.19.15.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 15:26:35 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Len Brown <lenb@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] cpufreq: intel_pstate: cancel HWP notify work in driver cleanup
Date: Mon, 19 Oct 2026 22:26:35 +0000
Message-ID: <20261019222635.1741146-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

intel_pstate_driver_cleanup() frees per-CPU data without cancelling the
pending HWP notify delayed work. If hwp_notify_work is still scheduled
or running when the struct is freed, the work function accesses freed
memory via container_of().

Call intel_pstate_disable_hwp_interrupt() before kfree() to disable
the interrupt source and cancel the pending work, matching the pattern
used in intel_pstate_suspend() and intel_pstate_hwp_offline().

Fixes: d0e936adfe84 ("cpufreq: intel_pstate: Add HWP_HIGHEST_PERF_CHANGE handling")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/cpufreq/intel_pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 17158cb25dd89..0e6ae4cdda5de 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -3436,6 +3436,8 @@ static void intel_pstate_driver_cleanup(void)
 			if (intel_pstate_driver == &intel_pstate)
 				intel_pstate_clear_update_util_hook(cpu);
 
+			intel_pstate_disable_hwp_interrupt(all_cpu_data[cpu]);
+
 			kfree(all_cpu_data[cpu]);
 			WRITE_ONCE(all_cpu_data[cpu], NULL);
 		}
-- 
2.47.3

