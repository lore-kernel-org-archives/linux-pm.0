Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1587F1A6815
	for <linux-pm@vger.kernel.org>; Fri, 22 May 2026 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779423561; cv=none; b=p3M+gFpS4eFRj4iTzjCz21N0kwBXgQGzrMTHo+3ii7IPuwP8lLcnuYYcIKc/ox3wuDBLfIZALY6/HezTRcrLTdMUpRhe7+yfjXyqTxEZ4O+brhjciKeVZbNpZfMsVEpujXRPmI354pN8KOE00wX0CPGQT9AxRmoO+YG0RTLx4Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779423561; c=relaxed/simple;
	bh=aoAXD4FEj3mVD7KeLqDFcZWIdY1F4Zs2EUzdGYD6G1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SvVUixVF3dUNhC47uHr9FzYnA5Q9mmaPMH3WCXZ6NI9XvVI9thk0IpBEZgZAdUeuwxtAHvrsifjc3wm+7kjS+wXojudtuTNOdfhaXsbJniz0BIrul3o9C/p5pOGD/PdnBb9Xurqo2vpTRwA23YODUMOMazmGovsWvrmz150/dpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PvpKzl4B; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PvpKzl4B"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c80227c9572so3225169a12.2
        for <linux-pm@vger.kernel.org>; Thu, 21 May 2026 21:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1779423559; x=1780028359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HcHqVighP3V8aWHjL50Kv6EuFW3bfV6LWIgOlINaXQA=;
        b=PvpKzl4BrCMiRroSxq3qw5v70hVncO5iAs8x9sxkMG9BcZdJdbdncvNAQqrAJQWacB
         vtR08RUpVk1j/jT0XFIZrsxgPgiO9GKmeupM6bALpUKsP/6BSDPjmBv5Ky7aLy1jjXdc
         9Zht+B7znuPT2UzgNZua0c5qdbu07x0BoK7X5D2t2rwPKINXo0CuzfR7eyDZB+e1vWVl
         k/coUBUHuA9Ed84Xo8lon//j83F4CZNGIdGrAaUOqbrfX+XxomH/Kocjad154FwHrcD0
         QpFMTvOMuBTlojKCcI7xwv2yXhB1c1KFA170/5t3QMbpf7G+UiwcJ+23HKJIcl42kYF2
         1sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779423559; x=1780028359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HcHqVighP3V8aWHjL50Kv6EuFW3bfV6LWIgOlINaXQA=;
        b=c1PcMfTVI8W2ZVd25HarelLXX3UeEfQMNhWkMlieQqrgeV34dwWHv8I2YMJna3scCp
         LTEFv4Lex5AiMyY6jXymhmPkH0gfPj00MEW/7yWPLIVZDiJZ1/AOITtsqbPXVvPKCfOh
         IcLDG94BRCRZZfbRk37zh+yzaNeMVD98THbYkxnoYFAxX9rWOGtLiAwNOfWaThWc1C1L
         c3IPmjJH3FhhP+KQ64PZT8LaH4q339NtgLMeJ/gwoqaF9Lr++bOWdc2AF7kHejTTeoBR
         GGO7OXZGJrANDeL1v5yW4HYq/9dHKlu2h2MY3nzSZTCQWWytTXS2NMuCJ/aHqV1FkTi/
         moYw==
X-Gm-Message-State: AOJu0YwwNpsuhMnNAY+846saU+oO2CASYkb9yOKLVfaCTAtQlHhdoKm9
	m222RntnM6I0sf9nPG0He/8Er1WZ8VDldW/UgzbkNXMsgVndYgCv2WeAbnzUApPNs13niv0Yi9V
	tDYfU
X-Gm-Gg: Acq92OGKxse25+DlIQycUWxYnRNRxyEHmalxrKXUODNag7exwN4YsAtXxSozY7gJbdC
	luQ2JqopMNERPL7JEkkbR2JLj/cBgZb6HAkmFlfzpk41p2iu6r+O88RqVJbBqDz5UePP4pqxsw4
	B1xOHVXPi4omjoOmlljOYLHhoqyzxGJeSmT5qBqXd3hjZ4ftJ7b5mm+rlUk09Lyhhi95GmArM20
	ZgJRVr9LyJuZabJRtIORQkOASrMGfZgCby+mZgWnqKRWdaN2y2Y9WciFFJjIrEBUAA+YAg47Nfb
	JOjxv3XtcYbpUo6MuQdIAn3iGRu8Wi0Rz10arcAU5cHccZDt6h0I/YxpmVrlaLi4tTsM6cc9ZSd
	Eky8e4Oouv3EmmkgY0NneiHWBPBhc31S4KPzAi9M8Vh7vvNjOQ/7L5/LnaXb/bI4e2lOzGSXlz3
	37B1fQCMQs59ifhpDpmoaQkao=
X-Received: by 2002:a05:6a21:7117:b0:3b3:2830:9448 with SMTP id adf61e73a8af0-3b328c93ee9mr2005600637.13.1779423559065;
        Thu, 21 May 2026 21:19:19 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852056d767sm224700a12.25.2026.05.21.21.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:19:17 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Stratos Karafotis <stratosk@semaphore.gr>,
	Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Lifeng Zheng <zhenglifeng1@huawei.com>,
	linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Subject: [PATCH V2 0/3] cpufreq: Simplify freq limit handling
Date: Fri, 22 May 2026 09:49:07 +0530
Message-Id: <cover.1779423281.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

Here is the second version of this patchset.

V2:
- Add tags from reviewers.
- Drop intel-pstate change.

Lifeng Zheng (1):
  cpufreq: conservative: Simplify frequency limit handling

Viresh Kumar (2):
  cpufreq: Fix typo in comment
  cpufreq: Avoid redundant target() calls for unchanged limits

 drivers/cpufreq/cpufreq.c              | 31 ++++++++++++++++++--------
 drivers/cpufreq/cpufreq_conservative.c | 12 +---------
 include/linux/cpufreq.h                |  5 ++++-
 3 files changed, 27 insertions(+), 21 deletions(-)

-- 
2.31.1.272.g89b43f80a514

