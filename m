Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE65E40627B;
	Wed, 13 May 2026 12:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674321; cv=none; b=QEc5Ja/wibnzjeOURp66LSLJih1UuA6wQzjg0StmkEIFkPhVoslKhd5Gt2G5AaGkpTNUEeE/nd5B7VdeV4JE6zcOwDG1hF2XxChyA8gChEIFOjB300J9qV4TR5YxqPMj6x6FPs3nEHKctG9g6mRJcjaBh+ys8uXkX/VBxefn7G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674321; c=relaxed/simple;
	bh=vNosVCYPJbIoWSprBUxUEYXiyygoyJw4B/8zom1JlYE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NrCxkRugQFGS7HnVLlIQHbbeR753HpD/ZLq4C3jZClGGD2oHrqnEQEk4AM7faru1J/nR5KJPY6oVfFS4EsdYtkjLqXNB1wK0e7Q64PKXDQ0Je1KQox2deeGoUdOai1GSAgDnpEPop0utTl1tbPdWLIQaQVvzqsguZxEJWle65NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=fn8F+MWg; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="fn8F+MWg"
Received: from LAPTOP-99KJFSET (unknown [112.10.223.127])
	by smtp.qiye.163.com (Hmail) with ESMTP id 3e4424636;
	Wed, 13 May 2026 20:06:40 +0800 (GMT+08:00)
From: Hongyan Xu <getshell@seu.edu.cn>
To: rafael@kernel.org
Cc: viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	getshell@seu.edu.cn,
	jianhao.xu@seu.edu.cn,
	Slavin Liu <220245772@seu.edu.cn>
Subject: [PATCH] cpufreq: pcc: fix use-after-free and double free in _OSC evaluation
Date: Wed, 13 May 2026 20:06:39 +0800
Message-ID: <20260513120639.894-1-getshell@seu.edu.cn>
X-Mailer: git-send-email 2.50.1.windows.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e213b60bc03a1kunm64400812664b2
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZSBkYVkNMT00fTUoYGB5JHVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSklVSktVSUlIVUpJTFlXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=fn8F+MWgoVcBD5IppJ783ur477A7GeArqY6O/7yVpLhHTgpVqAXoaBJs40zNemKINKp7GPVnnPbzbBWTAdkYAmZx4QtQAmJkzk+hk2aLa4bOuNtUlN7V8j4NBqyjwQymHwDu9Pg6Mvalx9mYvLfEjAhBhirx0qAllg59dI8mhdo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=v5il06slrm6Tekk/PCx0Ligp73KaVtwqcTsb36Hn8B4=;
	h=date:mime-version:subject:message-id:from;

pcc_cpufreq_do_osc() uses a two-phase _OSC evaluation and frees the
output buffer returned by the first acpi_evaluate_object() call before
reusing the same acpi_buffer in the second call.

However, output.pointer and output.length are not reset after the
first kfree(). That can make the second acpi_evaluate_object() treat
the stale metadata as a caller-provided buffer and write into freed
memory. The shared out_free path can then free the same pointer again.

Reset the output buffer state after the first kfree() so ACPICA
allocates a fresh buffer for the second _OSC evaluation.

Fixes: 0f1d683fb35d ("[CPUFREQ] Processor Clocking Control interface driver")
Issue found using a prototype static analysis tool
and confirmed by code review.

Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
---
 drivers/cpufreq/pcc-cpufreq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/pcc-cpufreq.c b/drivers/cpufreq/pcc-cpufreq.c
index ac2e90a65f0c..a355ec4f3dd4 100644
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
2.50.1.windows.1

