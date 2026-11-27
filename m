Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795767868;
	b=x71vifXN+dKPhWGSLjsyNin93ncw88C6bgTsi4KnDsPFnRKRxAcUBvk6d8gFY+QYNBe9
	 d0PkNJh2gm48Wp/zKefvXYJP+fHEiEcScwzJeUyBXm5LnZbrDu5DkHZd0JBHEkFMlrkzm
	 vb66LXc7vW38bE2tTN7erQDKCqz4LkZK8AqsLxvZR8MddsTUbDKFP4eA2F3jeswdYaFis
	 oC2609pO6yO3zdNxBwYOHBiXRr5ngnXw68AIUy/jTwtNu4fJK/XMprIX+hjQxnCRLZZlO
	 QwInXPGYFswAdreNnS/p657jDudXfhg/GcYkAoW0daPrP9KIcriQTajpfCff90bJ7bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795767868;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bxqLFaxeSXekv8pV35zqiFDuRDd8lYoCf4UL4nBylLU=;
	b=GhPCrtmo8OXVgAAsJdvqS/l2CTzMsDh3v2q/W8giADnYPUZsDTk5wLK+Q4fg/tE2yZoU
	 WoFEILr2Bwh5K6z7P1qGsEtjUdYl6fdE7kR4ZvL8fD3wtOX/CX5vBh339xPPk7Nqh22EH
	 EAavyRgrL3HMZ2rLtmIAwxKmyIITkpFsxLAp7pSGoAWHt5ARoF+8DlRmE2OCBKTVLYETn
	 luSUpFbNsC5CC5qN1m3X9m93sNTHqbNkJn/1Z2ytFwXQ49n6dD3wuKm1Cj4EZtsJBGpvp
	 t4D0GIcW49AMXUURoVSS6lKqXZKLLxxPy6pvI5WXp8Z52b65kHUG22keznoPkmMUr0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qm32bBe9;
	arc=none smtp.remote-ip=115.124.30.98
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B158606A31C;
	Fri, 27 Nov 2026 08:24:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B158606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=qm32bBe9
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795767857; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=bxqLFaxeSXekv8pV35zqiFDuRDd8lYoCf4UL4nBylLU=;
	b=qm32bBe9f7YYCixZjXXtsL7i/WJxBGMUnfQPwlyOB/UhKfXtxQA9PA64L7OtZeWWkChCOGgJMcqgz7ZyV5aZ8KiRGffSEKUWGCFNMFmg6actkxfgMQZ+91Jki9eaC7CuHqTC5lzWPmxzo/EWE6rcy3nM7OBpKWpi2CKrEA5gTd0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0XFXHc.Z_1795767837;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFXHc.Z_1795767837 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 16:24:17 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Christian Loehle <christian.loehle@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 16:23:53 +0800
Message-ID: <20261127082357.879160-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <bf120bab-75dd-4660-88ad-c00dfec38c92@oss.qualcomm.com>
References: <bf120bab-75dd-4660-88ad-c00dfec38c92@oss.qualcomm.com>
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

On Fri, 27 Nov 2026 14:54:18 +0800, Zhongqiu Han wrote:
> One thing to note is that a failed 0->1 write may now read back as 1,
> though the resulting state itself is valid since 218a06a79d9a.

Understood. That is the intended partial-success semantic: the failed
write still reports an error, while global boost remains enabled so the
successfully updated policies stay valid and locally repairable.

> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Thank you for the review and for helping correct the implementation and
changelog across the revisions.

> Please drop notes like this from future postings.

Understood. I will omit human-review/DCO-process instructions from
future postings, while preserving substantive AI-assistance disclosure
and applicable validation/NOT_RUN information.

Best regards,
Jiangtian
