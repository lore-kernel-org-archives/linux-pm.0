Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759199;
	b=xWcGKoRNdi4aN4PjLcF2sdo3pWxS+X3xKerLIKTbharWPZvafq+wBEp8VswLIqndx1kt
	 OnfENHq1vQRQG1aS35eGp0pJanRs1KDJjmBhyX7RgoFiSehEqk4o8sskEvrvoTgO0bUp7
	 dxmJj8orQMYFTKQk+jK+V/kQKX8/sOaX6kLdJrFFrKJ33V8qhUlLibAisEXIoucR+5zmo
	 6iYlwRdzULLL4N18yonLnX1lixOoqjPhPh9uMjIKu5+MCh/aqTXl54gkmOyuDwHsX7ee7
	 a6VAumGGT0MEF0LC1L0IvGdLZtkjOhON87JBl9rvMhDrIRNaChGvjBn6n1c6Nl7Yyug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759199;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=DKFhGwsOZSujyXQMW0kxwhFlbjcLJc2M1xM446yTpP0=;
	b=A68EbS/X505Ux1AsoXP/o9VTyImbbvT/zDfTgNQqqll0Ev5ucyHfWGxZcu5fzuNOpsGz
	 IFenMFXOhlgyZANWsLM9IgR9XQSO5tnXN8X1tTiIHmVuAp1DUR76jvnVA3CPGYfGUhjVO
	 XxFof0W6mi9HaWIrEn6870eUrXtLmYeDGbX9fpf8DtZ7b9+ixtASVJ8OhD/XnyDFyBEaY
	 2+0z6VKuxFNcXJlq7OS3pGD5v3up1LxF3dXwXYAeJLYftsq/OJNeUgJSkNfy7OvLa6Gy8
	 ZSJG51ced1nPCf9CK3NRW7YqALfa/Wnz20EMLyUm+QU3QyutXkkm1mdgkq0ceG/bRyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QXO3bfm5;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398DC606A31C;
	Fri, 27 Nov 2026 05:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 398DC606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=QXO3bfm5
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795759189; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=DKFhGwsOZSujyXQMW0kxwhFlbjcLJc2M1xM446yTpP0=;
	b=QXO3bfm5LgRVEHfCVznMxAD+9V3z6XbbUlPEUYD5bI/+qvYJszXf6sNp1w1Rruko+5H3xPnFBTg/WPuuIriUOiKWtWTwTmophxwXfrrqCPQcWOLUqrYNK3+ityvruaYcJQXbfhlwpZ5Z0KOg6AzAijqlm5tMDRxWUGI+KnvQzCg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFWwbZ8_1795759177;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFWwbZ8_1795759177 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 13:59:48 +0800
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
Subject: Re: [RFC PATCH] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 13:59:33 +0800
Message-ID: <20261127055937.728846-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2dcff329-4a81-42b3-b8e6-67ffc8c73f9e@oss.qualcomm.com>
References: <2dcff329-4a81-42b3-b8e6-67ffc8c73f9e@oss.qualcomm.com>
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

On Thu, 26 Nov 2026 23:09:42 +0800, Zhongqiu Han wrote:
> Yeah, it is a real issue, global boost "only means a permission to use
> the frequency boost mechanism" (cpufreq.rst), and "per-policy boost can
> then be enabled or disabled individually" while "disabling global boost
> makes the per-policy boost interface illegal" (commit 218a06a79d9a).

Thank you for confirming the state semantics. That is the inconsistency
this RFC is intended to address.

> This function uses guard(), and cleanup.h says "usage of "goto" and
> cleanup helpers is never mixed in the same function".

Accepted. v2 removes both the goto and out_err label from this function.

> Besides, the !boost_enabled check is redundant, right? so maybe:
>
>        if (!state || !policy_success) {
>                write_lock_irqsave(&cpufreq_driver_lock, flags);
>                cpufreq_driver->boost_enabled = boost_enabled;
>                write_unlock_irqrestore(&cpufreq_driver_lock, flags);
>        }

Accepted. v2 uses this condition. When the old global value is already
1, skipping the restore is equivalent because the restore would only
write 1 again.

> Separately, the disable side can end up in a similar state: if global
> boost is already 0 and a resync write of 0 fails on some policy, that
> policy stays boosted under global boost = 0.  That's outside the scope
> of this patch, though.

Agreed. I have left that case for separate discussion rather than
expanding this patch.

I should also acknowledge that the v2 changelog and comment retained the
v1 wording. I will correct both in v3 and include per-version changes and
links to the previous postings. I should have replied to these comments
before posting v2, and will do so for subsequent revisions.

Best regards,
Jiangtian
