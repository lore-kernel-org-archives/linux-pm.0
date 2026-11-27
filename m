Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759212;
	b=zYpAuYhMmqBHLTobdO3HvvX7NMSRPA5JaTPF0lwhHSX+pkgSlPSs665oZp1ox/TKlO5V
	 qQeoO7LgdvfKYnm63uQDpx5rO4LRYL40OQQJH8AD/v8u9f4HOnzjgFPplzQpyEDixXur+
	 Dn0SVeLHhUCgyMkPsOBNYugZjjIzTSFYPEVkamKV+7TgAiU67KLAntt//+Cwn0JQL/jfK
	 0JSm9PX8EUlY+VPgDoPU5VfKSGMW27Kw3ny8KH3KO4WYdfm/pX4UNAa6i0ikYdcni9HSS
	 2V4U1ORvM842bAKzSFOXZn3AQbPPXJZVFpbwhbJw7WshBg/cHo63pVNIkuXmQsIrdAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759212;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hyu9ntnDVwoBpRRTLixYNnfHm+pnHrsIO12KItSDwpo=;
	b=Ib2XIBcp+/NQ6CqAjRNUf9RmnPTzOhqwxH/61xLmO56sF4VRMWTvJQ2zihYv6tqNe69d
	 c4GIQIG6YhGhJjOX+jtk7EPbZyLnF+fQTbDxbrnzVYTbyvVy9ReCncV9z/XmhYI7VnxHL
	 39tSXUEDAkhCDHG5WYlonfQKZsXqGJhtvmboGpINkyDKzXbkO0XPtukuHFb22t9H5LdiG
	 MUmuPFPg+7QDzcu3NbYZCyLYrTqCZ2/EIJ8R2rmB1NsF2j3gawCIvQcGfXYRfx6SwgdOp
	 VGFowQCj2NPMb9gcuu7JrGagegzmp0Crb7o66tGO68PIupnDlNc/IZ+Ml09LbGnL79w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aot8c2cr;
	arc=none smtp.remote-ip=115.124.30.131
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11754606A31C;
	Fri, 27 Nov 2026 06:00:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11754606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=aot8c2cr
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795759202; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=hyu9ntnDVwoBpRRTLixYNnfHm+pnHrsIO12KItSDwpo=;
	b=aot8c2cr6Lmzf3cwRQDLZtAtsYqZrVhFHujVArJUTM5pf7QhkCAZwpb5tinJL3ev4LyDG+FqV5Jc/Xv25fHSOc3IvbF5eujWC665Q5HmN+XqSPY+nRsUShYLvu+xi0VsSXXijWPEQVbIpUCLmz38o+KEKQ9W+5m8yU7lboJu0N0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFWp6Jl_1795759192;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFWp6Jl_1795759192 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 14:00:01 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: zhongqiu.han@oss.qualcomm.com
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ananthu.cv@oss.qualcomm.com,
	pierre.gondois@arm.com,
	jiangtianfeng@linux.alibaba.com,
	christian.loehle@arm.com
Subject: Re: [RFC PATCH v2] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 13:59:49 +0800
Message-ID: <20261127055952.729120-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <234fef36-b7af-43e6-8b72-e58d924c528a@oss.qualcomm.com>
References: <234fef36-b7af-43e6-8b72-e58d924c528a@oss.qualcomm.com>
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

On Fri, 27 Nov 2026 11:41:36 +0800, Zhongqiu Han wrote:
> The "same-state resynchronization failures" part of the changelog is
> left over from v1. With v2's condition, if global boost is already 1,
> writing 1 again fails, and some policy was boosted before the failure,
> the restore is skipped. This is harmless because the restore would write
> 1 anyway, but the changelog no longer matches the code. Please update
> that sentence along with the comment.

Agreed. In v3 the changelog instead says that the previous global state
is restored on disable or when no policy was enabled successfully. After
a partial enable, global boost remains enabled so individual policies
remain repairable through sysfs.

> When posting a new version of a patch, such as this v2, please
> describe what changed since the previous version below the "---"
> line, with a link to the previous posting. See
> Documentation/process/submitting-patches.rst for details.

Accepted. v3 includes separate v2 and v3 change descriptions and links to
both previous postings below the "---" line.

> Please also reply to the review comments on the previous version
> before posting a new one, so reviewers know whether each comment was
> accepted, and if not, why.

Understood. I have replied to the v1 comments separately and will follow
this order for subsequent versions.

> This comment is left over from v1's goto branch. In v2 it sits above
> the restore path but only describes the skipped case, so please reword
> it to say when the previous state is restored and why a partial enable
> keeps global boost set.

Accepted. v3 changes the comment to describe restoring the old state on
failure unless a partial enable needs to remain locally repairable.

Best regards,
Jiangtian
