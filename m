Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3603C1F;
	Tue, 28 Apr 2026 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366795; cv=none; b=rsr/u4b3bRwxF5JQsBjipSUCSDbb1aNaTedffcmjB4I9KSSfpLfCGcNHRIqbPUuTpNxuXmPx0j9vtmVveoejt6/56dEkWcmalQ0civov9yu8LuXCbrHa5F/CAB+ZCk8gTie4lN47lHlUNKsioNHaZJGRvGEw1YhJjpKs/CUUryw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366795; c=relaxed/simple;
	bh=A8mYPFb8sbnOQ4syqsN5w2yehB+6fF93UgowW68OsyE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Sub6jszYbda/wxO4LhQ1xXCw99h/edza8OpDJLNAbWgE36dOlv/uvCs+KdPadfm0SAY8A+skdoCI5FdFQ2ZydxMhxYrHiqmqDiihHgswMvH29jxvFpdin7m6IP7Kv0sb7BdnS3wvbPJvA/8N4gTsIA8u3BeI9oyaboFhXrN9Qog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=TB6cqteP; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="TB6cqteP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1777366762;
	bh=A8mYPFb8sbnOQ4syqsN5w2yehB+6fF93UgowW68OsyE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TB6cqteP2u4d7bx22tgyGVdbUhAG9QgzlU4+HAhz7ovGbXHjdT7ZNtGLANMOVAQ51
	 BSrqHYO9SjuxykxVE4G8q3YTcoC/AtY4vuGnNQTiXRDAHHdjrkiwv3Jt981RCSYO16
	 efKP5wEFomZNL35PzZ+dphfnxGrcYlN7CjSmu160=
X-QQ-mid: zesmtpip3t1777366744t926689e0
X-QQ-Originating-IP: Ieehv/HRYEeC4IUIhcXSKRJEUN/kBgZA1Ulmm8I5h/Y=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Apr 2026 16:59:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 346598132270762092
EX-QQ-RecipientCnt: 11
From: Haowen Tu <tuhaowen@uniontech.com>
To: oneukum@suse.com
Cc: hansg@kernel.org,
	laurent.pinchart@ideasonboard.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mchehab@kernel.org,
	pavel@kernel.org,
	rafael@kernel.org,
	tuhaowen@uniontech.com
Subject: Re: [PATCH 2/2] media: uvcvideo: skip resume when writing hibernation image
Date: Tue, 28 Apr 2026 16:58:59 +0800
Message-Id: <20260428085859.1840613-1-tuhaowen@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <937aca8d-805b-418e-a2ed-58c1e38f45e7@suse.com>
References: <937aca8d-805b-418e-a2ed-58c1e38f45e7@suse.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NI6TJc3opC6FET3uPTLYQyZ1qdIKMgP/5Kf6sbL4WTgPhmRIhowxKroL
	6IESgh6kbsjMjhMuOewRE4uCvd9aRgbhZ/+2x+5Gz4E4zMVN/7aCMz2fx9Rwl4xT+09o58w
	b29tpVNG8f7btMF5Fbo4CE91g4U1YCVr0zS+8JY4Yh+ZrmX6fG8kVPbZBaCnl1+aaUoDuss
	VkpD/LzDekE+qld6YyONQIM3zeDYUs+iHUuh1YY0cySwQvj8tsM8MKouqCERVWtBcmMA4fR
	GrBF4usUCqinoCTKNZBxnegE3BZU8QBGWzqras57bYzBY235WU8oxyRtvJ8dH0KDmt6Uj7O
	B6LRBeJoIfolYKXgFvqKqNMcZ4E9xCJYesG6BZzxSRkfe1oa39pjix5Tov8zfiAVYj17C6e
	nucpU4cmCTz4zjDm8H4zFrGq7JS4MsYCbhkaZvtZiKeMTj/KaodEiJBH9FmayLhvgOcalii
	CvIEp190Bj6VKHyjygnlqZAQT55B6CzRXKUD8dCNsFDeHDfqR/6Ve0kBMp+QyqCEBOOCsvl
	G2auUxVJczP3pxlwuZjsxmGz0iiHr/dh2YyLjLufjwpgH6KYZznz1cekaGKbUzqBVfBCCgW
	QE6NyEtHN4lX/cAR5S93Q6jfLrH3A0DltlVTeXt5I8SxPot+HrivvKXbx62nvG+Cid34l8U
	e0z1uYV8+De5cx9cBod3BNeMwDdekIjD0cVWFE1U7ksqQDALJJUommBJjV2t2QDRfjtdLWb
	z6xFjx+QjYM4ZmVfu32Lb54NEUxaaR8Lep4wySb6TaQ/ikhS0zIobe8/+SmkbMAkDtnMmoc
	V38yRr2bpou11tvbLV/Bi+PBd5R5/B+hBYwx5f+zPOaH/QjorbJhhmGgi2MXQgquQKet5W4
	t1s+iaoHtKWx1nM1MzENQ/mhUnAXXM86RYGrPJMndnx1x+NZvRJtEqZFC89UqijJGlNRKfI
	e/iN9CAaC1xCzeDBLsxlKYozPZLkpbJ8YUjFTxZd01ex1bmQNdUqlCnYsIv5zdVt6n4SiFr
	h/w6GANG+OtYtrEhX8KMfnf/4UKKGQCbSkKNBS+ApLsRurSYLyOEfoKS5VdXIzgCHVr3WKz
	7f47ua3R6v+
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Hi Oliver,

On Tue, 28 Apr 2026, Oliver Neukum wrote:
> What happens if writing out the image fails?

Thanks for pointing this out.

If swsusp_write() fails, the system resumes in the original kernel
instead of powering off, so the failure path needs to be considered as
well. I was reasoning about the successful hibernation path here, but
you are right that skipping resume work during THAW may not be safe if
the image write does not complete.

I will trace the failure path more carefully and update the series
accordingly.

Thanks,
Haowen Tu
