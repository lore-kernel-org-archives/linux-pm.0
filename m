Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184255;
	b=k88tLTsum+QNxwQaSvmVxr1Aihij+PNot+jZZiGT3lwDXDQife1FAaABcpHyKXEhBg7U
	 1dz34hIte3AhucS2mm6BTU98RO6nizdtghHs1niSb+LBhoPpjq7KGiZE9NEArVnay9eAT
	 Ai+VvZmwXGO8mZv2x+T5iaBuAbrls5Dd04XxhJAQI5lmDuGLY9yZugE7FqW8R6KV1QA4a
	 V3umJhYY21dThkWwIVfaHd6REP4QLtG8aDdW5/pLsbjsU/b3PzOFEhXZfftRdOIpMlQQl
	 yTWfYg9W9siZBSVYfhDK9Pjz5agUs12meXYbpEjBa3cDUMxgPFR7q13rh4mHm0O0hcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=95GtjI7R3sVW6ueWEcQfS1LOsY7+in3Ai5GfoAlrQUg=;
	b=LXnVxbeoqeWieA+tYdios+6jY0afNZowkJgJ4ru5W80udF2yGN4J6d2/I/dN7f2AEO1R
	 bFC3NGGk7eT5K+mU+roG6hhoSKCxZARtG/KaGfC6HgEj8jMqiD6TdJtVKZ43Dnzn17LyG
	 mIKlTs4eRHglLzGFW4gp+NiWWwkIW9a4BThKRVpUT7OGdajXFIUJK1t2tqyYgNUITwT9/
	 T1mHd8GbDHgO/NaieyOmjU5CVfLRLWRTlz506z3Y5qWNlc1MfRI2JLUYZh2C+NJJDp4lw
	 1XRK5KnjEpQZ3SpJgxVBL/huDlrpKs2WswPoqd3E0e9z/OzeRF/QfeBbdW7VvHuQ7qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDFArjrC;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B83606A31C
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 00:30:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9B83606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XDFArjrC
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a208d93758so3182575e9.3
        for <linux-pm@vger.kernel.org>; Sun, 08 Nov 2026 16:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184253; x=1794789053; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=95GtjI7R3sVW6ueWEcQfS1LOsY7+in3Ai5GfoAlrQUg=;
        b=XDFArjrCictE9st1QhnFkwrGteMvWg+6PeFOBGbMMOv3ye5jFLeAFhx4DwGKLe811Q
         xZEGP4PdCQbmePlqERTD7/SJWyI/R3bIRPrkuOWLLviJYa/HKFa2m8FXK2vjtXFY+O3Z
         ZYjo7OXYR1zbofS+i2pwbhxsubhKYElsira6IErpRjrohBSo1mQiQVpKW3R1ZTHmhLjF
         CGaLuY8squKcyExI3qv9A7o1AnMWMh3U/kNldT/0/MVkiTBK0GrMdJGCyuagdrGFiXCi
         EySkKQrWZavNm2kf3LeK301oeIjgGVxCaF3rN6nSbXqN06NApigV6dFNZ1w/BakxdKRN
         rjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184253; x=1794789053;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=95GtjI7R3sVW6ueWEcQfS1LOsY7+in3Ai5GfoAlrQUg=;
        b=mKY/crUi6THqxPELpyzAEI5NK9MiFQ97s3bFpSaP4Upkx4oZekVTmF/t0b+MTijScT
         8+J7/ehQx6tEuUBjSZFVW33ggdQARtOlAm9ikSJfgrp5QBIhXS+fODr+4Jlu3lGbC8+2
         qpIEoud+urofAovj2qF9HxhQdaAxnCPkBaLkv8AZP+EECxV/59DPGOaVUcxAYNJFnDf7
         BpTtCKo0Dw2lxDO9IjwgIAXcSx0B2/kREW3XRXSBwWL4CKi2juqTKzAqC2Any6M8ODkr
         W1JTnxPVE+lwlfNM2r+VznjBs6pTn64YE6U8XY3IoHnh4YatIeeAl7qbVjfXii9sBtmv
         TW1Q==
X-Gm-Message-State: APuU4Z+6i09Gg1E41uhdz9srJQZsODk72OhwG4LV5EHQjQo+pPGDgdJS
	i7+HncIUCCNTWbqAYDUHcAk0W5Pif28+OBCVuHhgq8igc6I0UCmpq54C
X-Gm-Gg: AYBFou0gAqqaqGCmL3szs9PmG/Mf9RtMQ7hzrlL6D2dpyoBTuqAYee0flWrebbk3fln
	fzxdW7We+YxUl3RSHkL10GoryqNkIs65oHuSlgfFUaIjvAHcahRrgFRg7uGZ+3wSTBHBbW7mDOG
	KjVv5wxyuCGDkQUrxabqBvxUS7brvqAvx7n2ptdvwueMdvR7SboAeTzWZGD6mirKClN92c5DcuW
	1Yx48B51pGO/ZsQvJIqzyQaalI54e5STF5TyyMqREVYrJ7L38pvWeh+3eU7ZWIuK5F23vGdZg4B
	DUPdAltwrICCmJ8xZgSNXHaPCdPJCv4GnQysBgma+8e1daiHcIrC+6vP6aliUgzgvhnlFO7MZCp
	6XBQCPabJL44umxYRtCRlaw5jWMMJrlctTguC+eUyUPZJIjeXMWCLCc4suU1WoZULIApoxwjWSA
	zmSl+Wnxw8xViJkzjp3SbQAIl/1ZBeUyrCdTfmRGgfatXtm3Csmr4HjLcQw1s5YU5NUiL1hHk8B
	dFt1G6NGp2MG3LBrGfVo6EKDded6iQ1HMCq3XdqrszbyYDM9BeE/AK/HS7h+cHArjLekBaO6suN
	9LEhsFkLnrUUcBe55QjmbgV0hR8WazXbvMphZvsr
X-Received: by 2002:a05:600c:4e45:b0:4a1:e00b:a10b with SMTP id 5b1f17b1804b1-4b963c75f1bmr49563625e9.7.1794184253400;
        Sun, 08 Nov 2026 16:30:53 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b90619bc91sm91755665e9.2.2026.11.08.16.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:30:51 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:30:48 +0000
Subject: [PATCH] cpufreq: Add Halliday to cpufreq-dt-platdev blocklist
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-halliday-cpufreq-v1-1-d87a397396fd@gmail.com>
X-B4-Tracking: v=1; b=H4sIADcU8WoC/yXMwQ5DQBRG4VeRuzaJO9qGvopYjPHjNoLOIBrx7
 kYtv8U5O3k4gad3tJPDKl7GIYDjiGxnhhZK6mDSiX4xJ5nqTN9LbX7KTkvj8FWM3KbPjKGrB4V
 scmhk+y+L8rZfqg/sfH3oOE6OCCm+dAAAAA==
X-Change-ID: 20261108-halliday-cpufreq-1e9c3581e2b4
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184251; l=1285;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=uNznV5UnL/siRzpE9ErXbIR3tObacb2SkxWFuaAgpNw=;
 b=WuxcfbDO4QCA9OqCNJ/dILd+E2ZTLSCHxEIrDy3MEReCDknxr57EFNTO9rHhDRg/RRzjSJHUv
 shnfvNG7j0nCjaMmZj0tzBC/SnxOteAlBpbSRw+SfMyVLB9dYt4CVaO
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

The Qualcomm Halliday platform uses the qcom-cpufreq-hw driver, so add
it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
This is part of the bring-up of the Qualcomm Halliday SoC (SXR2250P)
in the Samsung Galaxy XR. The DT changes follow in a separate series.

This work was made together with Claude, ChatGPT and Gemini.
Reviewed and tested on my Galaxy XR, where cpufreq runs through
qcom-cpufreq-hw.
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bce4c87573a1..3d5709eaa08f 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -155,6 +155,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "nvidia,tegra234", },
 
 	{ .compatible = "qcom,apq8096", },
+	{ .compatible = "qcom,halliday", },
 	{ .compatible = "qcom,milos", },
 	{ .compatible = "qcom,msm8909", },
 	{ .compatible = "qcom,msm8996", },

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261108-halliday-cpufreq-1e9c3581e2b4

Best regards,
--  
Stanislav Aleksandrov <lightofmysoul@gmail.com>

