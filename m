Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FCF345734
	for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776350788; cv=none; b=T47zqqUB/7GiGVqTrD1OgtE4kaCL2h80fJjO+WsofAxmYKMLQrMFINzXKHlC9H+q74KUqlwsEYPKD/YdB3UGXN3jNpEw7A1pWXS+MOMTZgFMN0ebPJ1culxpOQNpF8dF3H9WwhbN+qilNO+79LC/1L8yS+EpLi3CXUyLWpaiaaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776350788; c=relaxed/simple;
	bh=odAljwOFVk8WwMSqTWbW1BU+XMH3kGsNizCc9yeR6rI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9cnWAkKiMU7tYWrwhSpds++sPqs6E35YWyG8IBiV+mzVQn83bM/0qFhuZ9+JAJ6qtzH/4an1Rt2Jw3In+SM4wREucEAors3ODKAXB4QpE5qVmFD11aztv6ZSv37TkNJ2B56nceC10tPjwddueNbV+0kPNjKh+7U49VmT3GjtrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su9dzPGy; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su9dzPGy"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d736211595so572988885a.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Apr 2026 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776350786; x=1776955586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+qU/0pAEyux/mCzOSwEEqedW1q2zac3sSK7mMgaX0kg=;
        b=Su9dzPGyIu5/GHX7mNNJHTp1VrEA2PBC8SyjX7EiakoSePnNN1dnKXDmRo0ztDD//G
         jHuAU8i94tgpWGsWsfK09RqwsuyFEMxs9/2QGvV7Z77BmFUoPgcy+uTZQGAdM2rDyGfD
         LstB7unWTQE1uLt7z/7Ym0a81jbNeWFw3CtKoU8BjZlKcIVpaVeG6y0Ll00oTwBEmECm
         o92aSJKnE+mBkduS131vZlNPS4vWzSb5SUBFQaV1p3BPFLp7sYzVRKVQZ0Wd5X6UwvHQ
         yLnjhk964HPTpQ+sVKKBfrzNc/PCGfDh5IVCSZw7CvhbL9IHT4m+xglrtUlq++Me9aIr
         iwRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776350786; x=1776955586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+qU/0pAEyux/mCzOSwEEqedW1q2zac3sSK7mMgaX0kg=;
        b=a1yX/R1N8vpdR8klND+QYU8CLoYiCy2Rx/lI7iCMY32lntNFQ5lz94fAfBw2dIMhhu
         QxEL7KBtKuA73hyE1GUj7OeWnSQj+Uq0Ys7vGablZlqX0auhbz90lQz7QZodXZrrOxEF
         f60Vlmt4Q/LsWv/YdBqQP78MK15eHNh3OWaBhTNqjkGHFsr4bfvnlUMEdFsp7yfeITfK
         u4gluokU0GsUSZS1ng8a99wuBZf32hRnksmMZRMr/nitD5Og7bL81bXuNMutUa798pwz
         OZ1MUJmsvvPc7zqngE/FX+0cOCyqQ5Uo7PvKwIupqw5wAWJnFkWeOKkERJ9TeZvzQb+7
         mSqg==
X-Gm-Message-State: AOJu0YwSEV5B2NNAyGVXYwcU2wjHqlf3wxrXca9GTyjgir3B6tIhkuJ1
	Ls5msRmCdvQsOV2Bt9gqXXojnmoCRrMjZWN0ZKOrcDxd8MlixZX7odYD
X-Gm-Gg: AeBDiesImsOsI1Pdserq7CIKvIiDGNfy4iQy3NGbcn9b+9wFqilQCdUon7yjdgU2bos
	8dZiDhEYvV8Atyn7g9i3c/JT5oPN1P31iUtGiMg9CNKXBqlB58J0qr+aXgCANinVkYTnU0h82Ec
	22YZ3u8yE1NepS8RtH0uGlh87cbmLyScUChHZ67HM8pqMawP8HRJwQ+05uzRJDZizaNSbsiaIcF
	54H1UsI0ak5zOPG+6oL8IBoq1czSpl8zRN5rQdQtqpJ6TUqL2bi9R9EGREX6PIjufRRickOkblz
	8w3zBE2gzBmVQaf7NRzDPxp4erY6ry9NM3sPI/kC9tL5gsf1w9L37t/6VK/X/5ikSJCPyCWHZU0
	il/gnLKx2hlQ2T9mpSgHTvofbUfs2fD95OgsVB9VR8W6+cgP+BGuqw8s3kS4pyzKd9lI27R9zNA
	FAeUsCSnG8Tbd6r0X3HypdaR5IOP7QxA0qFVw0NhwEg6Mb3y4fSl1asSUkIKrv
X-Received: by 2002:a05:622a:4d3:b0:50d:b084:588a with SMTP id d75a77b69052e-50dd5bca2cemr387766491cf.42.1776350786100;
        Thu, 16 Apr 2026 07:46:26 -0700 (PDT)
Received: from localhost.localdomain ([104.39.116.151])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50e1af9da11sm38854911cf.17.2026.04.16.07.46.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 16 Apr 2026 07:46:25 -0700 (PDT)
From: Yuho Choi <dbgh9129@gmail.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <dbgh9129@gmail.com>
Subject: [PATCH v2] cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
Date: Thu, 16 Apr 2026 10:46:21 -0400
Message-ID: <20260416144621.93964-1-dbgh9129@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcc_cpufreq_do_osc() calls acpi_evaluate_object() twice for the
two-phase _OSC negotiation. Between the two calls it freed
output.pointer but left output.length unchanged. Since
acpi_evaluate_object() treats a non-zero length with a non-NULL
pointer as an existing buffer to write into, the second call wrote
into freed memory (use-after-free). The subsequent kfree(output.pointer)
at out_free then freed the same pointer a second time (double free).

Reset output.pointer to NULL and output.length to ACPI_ALLOCATE_BUFFER
after freeing the first result, so ACPICA allocates a fresh buffer for
each phase independently.

Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
Signed-off-by: Yuho Choi <dbgh9129@gmail.com>
---

Changes in v1:
  - Drop spurious #include "acpi/actypes.h" (Zhongqiu Han)
  - Keep kfree() between the two calls and reset output.pointer = NULL
    and output.length = ACPI_ALLOCATE_BUFFER

 drivers/cpufreq/pcc-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c4..a355ec4f3dd4c 100644
--- a/drivers/cpufreq/pcc-cpufreq.c
+++ b/drivers/cpufreq/pcc-cpufreq.c
@@ -352,6 +352,8 @@ static int __init pcc_cpufreq_do_osc(acpi_handle *handle)
 	}
 
 	kfree(output.pointer);
+	output.pointer = NULL;
+	output.length = ACPI_ALLOCATE_BUFFER;
 	capabilities[0] = 0x0;
 	capabilities[1] = 0x1;
 
-- 
2.50.1 (Apple Git-155)

