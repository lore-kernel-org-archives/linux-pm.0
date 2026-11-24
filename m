Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795490856;
	b=IRjSMSzAIZDqf1i2CP8LR5YG6wvXnIk3RP7ipfTzinsIefqJkQ6EXEh/6pfYR4xsFeZ0
	 Yo/oV+ylt2kzeP6pQWsGzniNu6DGDX9nx0Noas6AU9uR0/ZSIi3EsTNu/KVdf6eAwlAQI
	 rI5SVAW85nvLl3GfY1WBxzAzaUL1sYFhPE7QVZChEjO7nRBjqyLtGJS/Citel+48vzU7X
	 DrbFslJKQyRIWa7tdaWmLNmQBCzuHklmUd1x75frVmbjHNHxlmtHcScYyAUTuPREHf465
	 XUp3cZwSrh65aXSnoJNmSdhDpAtauERhRkEYBd9FQ4oqOA0Drg39GhkxH1te08fy0BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795490856;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jq5SVOc1a99vGpWX8bCaU5N/TMdz/OLFvUMYaYghDlI=;
	b=svF4ZigJP0EKj+vAWWFouKJ9mdNpLkeLV+7vbMy8nqIScLtj4z9FdPMR9IPrykJz9lpR
	 FSJ23Aplz5EZxaXj7QFwAeulmetOpi456YFhyXWNugbq7ezf97F1rc6kIcXhLBuTo22wf
	 wUwU2qyR2iNcmhXvEr2slLrv+lXK/bgLtytM2xa0q9ueiUjZJPpeH6sppLR0Aa1nh1rAF
	 ZrVgoSBqG/pnuKDe36IQCPYoIJZBD8ipBCudMq0cyKWiq15E3feAey4qZ3H9VRUaqEYGC
	 YIDMUWqb5puunR6TyafqF90PepfHHB2Mf+yxdDbyXFsM/edcNsQWiwegqkYA1KVEatw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QnxElSNq;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD204606A335;
	Tue, 24 Nov 2026 03:27:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD204606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QnxElSNq
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795490846; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=jq5SVOc1a99vGpWX8bCaU5N/TMdz/OLFvUMYaYghDlI=;
	b=QnxElSNqRnbXMXveyf1vBOeak6IMkazerl75mlFhW4TY6+cxCtIU8ccItzKXijoBSiqg0cG5dFYWxLRGHgXkQlHTvFy/5Hlyjjz65PIJcYIYwJZE6Grbius9voi8Pj+L7IKzGkD6mm807WnieWR520xq0uRxDshcQe5Lpv5pXgU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=qinyuntan@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFN2icx_1795490845;
Received: from banye.tbsite.net(mailfrom:qinyuntan@linux.alibaba.com fp:SMTPD_---0XFN2icx_1795490845 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 24 Nov 2026 11:27:26 +0800
From: Qinyun Tan <qinyuntan@linux.alibaba.com>
To: lenb@kernel.org
Cc: michael.hebenstreit@intel.com,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xlpang@linux.alibaba.com,
	Qinyun Tan <qinyuntan@linux.alibaba.com>
Subject: [PATCH 0/3] tools/power turbostat: Fix counter formats and CPU selection docs
Date: Tue, 24 Nov 2026 11:27:20 +0800
Message-ID: <20261124032723.157254-1-qinyuntan@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
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

Hi all,

This series fixes three turbostat issues:

  1. Preserve current CPU/core perf counter values for the average format.
  2. Restore low-32-bit truncation for u32 raw counters.
  3. Correct the --cpu documentation: numeric selections restrict
     collection and the summary; core and package only filter displayed rows.

Thanks,
Qinyun Tan

Qinyun Tan (3):
  tools/power turbostat: Fix average format for CPU/core perf counters
  tools/power turbostat: Restore u32 truncation for raw counters
  tools/power turbostat: Fix --cpu summary description

 tools/power/x86/turbostat/turbostat.8 | 4 ++--
 tools/power/x86/turbostat/turbostat.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.55.0

