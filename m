Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B3642252E
	for <linux-pm@vger.kernel.org>; Fri,  4 Sep 2026 11:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788520043; cv=none; b=ACNQpUdDX9yNA5km4syaZ6bX2V67jAcuPzuu1hk7pp9fF7mza3HlNToVEmWnfh9MPK+5G4Hgzj5zRTnqJHYnjbCsFezFTNjVTGhcyvV3Gx4mtW/npLW+PgzpWqegk6x7eDrJy8ANtHfnsC6Vqmw5DkRlkyThzey3DlZsRtm1yaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788520043; c=relaxed/simple;
	bh=WsyJHW1clZ8iKOOVdJ3ec2qpn5XWVAQgC6D1tlBvu/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B9jV/uGCJen/Bkg+4WAsILeN1/YXT3cSv4YVQQgtKRSymIH/FUzpw8WxLI+K3kmSCG0omFmoC6fYGUiD0YDJwopH+wymNrfuIARCQeCAXLQY1Wx79Tz3kV0kPxslKanIHW4J3NEuR4HvVL8fjpj7tRmFQ2lFpIzQBx9wvGOwAa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHTz6Qdn; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHTz6Qdn"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-4a45b3f0becso669036b6e.1
        for <linux-pm@vger.kernel.org>; Fri, 04 Sep 2026 04:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788520041; x=1789124841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=67sJRcIvyS9+alfNbLSeAD3FZ5gx7L7BGnwp5aAPOi0=;
        b=tHTz6QdnNJqwcuht8UREcQiNzVKNGhYOzO058ExUR2MMqUBB2ZrGtoAZJGaoEpcjyx
         xDTlbG5OFSfn2hHGSoX58JKVRgMStYD4yz8AfwOY7bW6tR2JjC2pysYsILMRjIqKAr7j
         zBMz4yjDTIQnYjs1lKo1yUtvK9OcffcKKE7Il2sxalvU26/TE1x6y7PUxVbQu/qZ1WtM
         hC6ayf1hHpFblcXu2oJkxYhseNxUVhKtmO1HVNis0JClSTnFYr3fLI0eRsZyPsVjNkPx
         0hlta1xcfTJrGRJMxdecNcq2VE0O2c4od3aG/oJh5r0wNfjVdjk0TFrk/eV296g55UoA
         WuAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788520041; x=1789124841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=67sJRcIvyS9+alfNbLSeAD3FZ5gx7L7BGnwp5aAPOi0=;
        b=GDp33m1z+fKuRMkC/bd/GXKaTOHk1UHe7AxjzIWNfn8+9iednnznr1ZoXHBmjOj0I1
         mQjXSyr+ifSaqWNJeY5MtAasFYx8qPXJ+xn+Sfh38+Kd9A3EVjcq/N537s0bF0Yb1UQi
         w8+fBYI5Q9Gdhh8k6jjH3YmDDk2XuWzpI8+1PWDbJIbrTMt5/h0pd09A/7UTcPl1mT6r
         xXdyw2xAYvUyWqZ7bpgQx7Jk79NL4za1G3Hw+Ox/oILt8AjOO1hhn6hsnncHOjP1yl1Q
         KcWZPo/KkeoiVd4UTuE0/Mwwg+x5un6nC1aaT0l0w/gwFnYiXNGa9Na+mVRez92IqJOO
         5vGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxYrxttBY7UHEgGSaOVsBy2JOSUwyCU/qrMM38eLzT0VceM/bWglGNouNN0UJ0jNWx+ylCEChvY3A==@vger.kernel.org
X-Gm-Message-State: AFuF++lDK+mlkIXhyGf9TkwxYzMVVjOLOPaizZo3OVdAQD7UhRtDIFq4
	5jE+c6Wj+Qpw46AjTxiM74KndI7KkUUjsWX7OFRBrVZ99eS1zyveFQOHeAjrkz4JQRM=
X-Gm-Gg: AYBFou2h/9zCKjFHr7hfh2brLraqEeV/rX4S9V4CcOkkDh75q/sneYSNH/Dl8CeQ8pW
	KJfYbhku33ohviZUSI+EdEwOBRrWKLaFPBul5kKIa7V62kYpS8yuTo15DhVvNgJYXcyRDMrniJu
	aMffZI7SV7DivcqJqySZ4hEKXnK7KtBlHFvq16Wf2adfvJlMFfR2Jy7wUPwSGdf3pBkzfdcV0TA
	0KAO2xO3vznU5U8jD3Oar7GObm+z/UKU9FYHR6cZyTA//UvhZO/v5M5hmmEOoTwbK74fDkTxTjh
	k8RD30HwX3YPVCmIC1BjQTUpxOILEpPTH8nbZ5MvXajZC4H3MQ/FFkOv7CnNyw2jr6wdJF58ftH
	NPwt5nWPUg10DSVpFGBJv+yUpsLxNXsFgi61IcUe1Mzh/JgRtVrDSKfHtG+ocu9YmDxmRwnaOi9
	8IPkzNvuMrP3ioZasNQIt2PpYAd9fQ05BqsehWcuvN74P6b1JAt2H58+HdM31Zj48VkwrBdERlt
	Nsvb55m9M9+U2VPbNIGX5C9p0g=
X-Received: by 2002:a05:6820:813:b0:6b7:46fa:1693 with SMTP id 006d021491bc7-6b746fa1a49mr1990618eaf.40.1788520040539;
        Fri, 04 Sep 2026 04:07:20 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b123731sm5588331eec.18.2026.09.04.04.07.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 04:07:19 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: [PATCH] devfreq: fix typos in comments
Date: Fri,  4 Sep 2026 16:37:13 +0530
Message-ID: <20260904110714.18123-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/devfreq/devfreq-event.c | 2 +-
 drivers/devfreq/rk3399_dmc.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/devfreq-event.c b/drivers/devfreq/devfreq-event.c
index 9e183cd8818c..ba0a5577c775 100644
--- a/drivers/devfreq/devfreq-event.c
+++ b/drivers/devfreq/devfreq-event.c
@@ -161,7 +161,7 @@ EXPORT_SYMBOL_GPL(devfreq_event_set_event);
  * @edata	: the calculated data of devfreq-event device
  *
  * Note that this function get the calculated event data from devfreq-event dev
- * after stoping the progress of whole sequence of devfreq-event dev.
+ * after stopping the progress of whole sequence of devfreq-event dev.
  */
 int devfreq_event_get_event(struct devfreq_event_dev *edev,
 			    struct devfreq_event_data *edata)
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index dbdce7636ca5..2cc753fe30ac 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -189,7 +189,7 @@ static int rk3399_dmcfreq_target(struct device *dev, unsigned long *freq,
 	 * Check the dpll rate,
 	 * There only two result we will get,
 	 * 1. Ddr frequency scaling fail, we still get the old rate.
-	 * 2. Ddr frequency scaling sucessful, we get the rate we set.
+	 * 2. Ddr frequency scaling successful, we get the rate we set.
 	 */
 	dmcfreq->rate = clk_get_rate(dmcfreq->dmc_clk);
 
-- 
2.48.1

