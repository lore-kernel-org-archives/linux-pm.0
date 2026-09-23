Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566424519B1
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790148916; cv=none; b=FXYIpjMYkY/7PhFD6U//ItfnypAHd/JjR2V5A9yqKA3SCtT7Xzz+GyiHHjeFyYGCVOjhRNdIToKa0JDTYlF/sHlL0xFRQSYmnRyRhB4JOXhaCiJfjdKBVFT6UVU0P9Veew6afR4bFP/D4FbDYSK1ErA2/vrBU3ux7q4ckLpx3FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790148916; c=relaxed/simple;
	bh=NpAQJEpAggqV1p2gBrvheK1e8z0DrJ7uAPNXG/lVgjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfvDuMGGxBkdgsuY36TO9kiZgqvkvPYQxllBO2/bhWjniqo/emSw0+slctphLo3uwmCt62I+Mj2vSpvObCVPh9u+DE+KXrE/YzKlKl2u98x5ep8v3a4wEWFsndMQevBkp0cBTZNNbV/iUSRTQGf+JhTEmybFwC9vesy1pXiTz0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DG5pzHh5; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DG5pzHh5"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so3249085e9.2
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 00:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790148910; x=1790753710; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NpAQJEpAggqV1p2gBrvheK1e8z0DrJ7uAPNXG/lVgjc=;
        b=DG5pzHh5r/Zq22kTIQE4z2zCLr5Vvq+/VAZ7JzV8m0DHyr1DTaeh/5R80ylSDvhLdj
         ulRRH/nA9DN1JUtczNNCDcttkIzx2nrPO+jr69++qZ+0qdKhOXt4F+MBJLUS6C4/Izjr
         FeD2l4g6V8yVTS3Zb0+aoPB2Zfyu7KiZ7XJpw8J/7AHlxeKzmOGS4dROIEHp4iV3brI2
         EMG1KiKNqgjIM367zL/GYf02rdwf7QqIo6ZVQBSBeVG5hPm5To+Bs9Remb1AovlpftvF
         7mwxYjR5rKAHkTT69gHHbm1U9mEFJ/0hkFB6ns3gHQnTHeiEaecPDimliExUzSsg7zW/
         A0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790148910; x=1790753710;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NpAQJEpAggqV1p2gBrvheK1e8z0DrJ7uAPNXG/lVgjc=;
        b=uefgxPp5H+M2etNvJAdV77Dmg7FVWEUi078MluU1KXCz5EPtnXSyRP9oaWQ/C4Q7Ua
         eOhcPmAtaPI3iBOLyIbn9vdom6zJb3Gwp/rpR0XrMsCpeu1mB5Dav/1P7wMSCt976QHW
         R5Jpyl4atalaEy5/jMRihRdOPDdRh/qtchEOUt3aca7yj2MdRocVBQHaTMBnPsNFXBmf
         xs/CgKKKkCYkg0NDbyjDzi0vqPF2cOKuRF2IrdwKhkENcO4KoQ8Aaagr9rJuFg9W3QkB
         og8ma85nJCej0znFzOtyhE2JqfPPO0H6XPHyhfgkSCKjHxFAF2mkVSMwXgSiWhIumtYG
         eGEg==
X-Forwarded-Encrypted: i=1; AKwUvBwnXHcO2usU7TtFrgg/cBWg/oQtGsGgJUY+3Vtso789BjJCd6SiUeSGTL+3CQk9z4pHTHPRUjmmkg==@vger.kernel.org
X-Gm-Message-State: AFuF++lobwIbPZ5Z9/sz+9+guNfAky8s7/pX4CBgfy/1SayZCrd0W0YU
	rURNSkLW4Cwnj8R803toytW+WR0SQBnXgzsUfUcwtkvBVk++AAhe2AHS
X-Gm-Gg: AYBFou1VCEseZB+fZkY/CV2OQH0zH7R6a0/ENeCLUjsCTfguAu2NRoCl4XDRRS5iyWi
	mOHTgTAVYlsI/8LVDHF67DNFlla9cnfO2Spcjk/d8UhW4m6MKEBB51KHWeQo1GM9cUrD71blneU
	TVP4/b1RzYLheOtmHIctlabys5irXwnF5C57BReHxiYaeLlcCkEUSGb1J5vFRcrxKbKHH7CeaYD
	O+PI4bPAz4HhkEA+ALpcMtc7Uiv9vHf0BMnKYY1nWjDv96X19jlBOrZ5QvdqvinM/3P3i24AkFk
	8Ve87i+hZHnaCyGDA+gX/TG8q0DHHqmg5cHaCwLb4GDILSOYhiHNyYDaWUd9qwkj1M0zV8fJA/n
	vJ6lul0rPLwGvIn/XjCW/EsahPFK/M/A5Dmj20Sx1BqZuKC2cZbrxoTC+fvhe68dkNgXoVktQVs
	u+rywCt38GpTIPyaUtBP7I7p69yOOfhAo2NRys7NMxcYdVHBpAjTf4sQ3g2YhFqvqdWsAhL0Ek5
	/165mjMZwPVDd+F/A==
X-Received: by 2002:a05:600c:34ca:b0:49f:ce78:3568 with SMTP id 5b1f17b1804b1-49fdeffd818mr18600225e9.25.1790148909725;
        Wed, 23 Sep 2026 00:35:09 -0700 (PDT)
Received: from localhost.localdomain ([94.252.74.168])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49fde180a39sm70649425e9.1.2026.09.23.00.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 00:35:08 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Prasanna Kumar T S M <ptsm@linux.microsoft.com>,
	Sumit Gupta <sumitg@nvidia.com>,
	Beata Michalska <beata.michalska@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v5] arm64: topology: fix arch_freq_get_on_cpu() overflow above 4.19 GHz
Date: Wed, 23 Sep 2026 09:35:00 +0200
Message-ID: <179014889997.344140.3757658991789489835@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <arKpSGPXOCFF09hM@willie-the-truck>
References: <arKpSGPXOCFF09hM@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Will,

On Tue, Sep 22, 2026, Will Deacon wrote:
> ... does this introduce unnecessary 64-bit arithmetic for 32-bit
> architectures that currently pass 'unsigned long' to the existing macro?

Good catch. The truncation happens in the unsigned int temporary in
arch_freq_get_on_cpu(), so v6 will drop that temporary and leave
kernel/sched alone.

Thanks,
Oleg
