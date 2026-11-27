Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795759178;
	b=WtqE4eZ7V6bdCfJ7ykMvgK6dN91va7PDbNkdkK4YTD/zPhIumoJTCUd4MYlui8mXpVaH
	 MTkTBgcioGu/lyDyBCSlcXcKR5th3M8ZnZ4uC/c5Pi7I1oFtS6XBOWmiiyBPjx70EcbzU
	 bRLk8I3nJMJ+zlpVQT4M8nvFj0AZe0hUee7Yobe9lhtj5U613jXbQhcYgr3iVsmjT+iJ7
	 UhLlbHJsmCtwpmkx+QlHF4t02erZbtPl84cOyNVU+NDdVnHMb7Camnm3FhJjHOR2LPHPc
	 568xfwyyKj5lcja+C5RNjlpYxHarFfrBfpsWI8syR3AuSTrTduT5Coio4NW3r5QrR+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795759178;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7/uKTLta+jMJdfu5Rd65JOy6OcoxC0J0LHsok0ic9uI=;
	b=g39Q0wIM4sYgpu30faIdFYXR0fzA8v5mae2vIBTYlMilWLJYrCs27HXw6yzYz7SneKES
	 lW6pqXBdZ+c0PDrVXj/+tQAY4GnGlBeyBQCfGf90QtR9BuzeLEsShEeCINFHvXj0PaYLT
	 C1DlDaa2gPEnIA4cTBQt/bf8Yr5QTNjXD6zWWvs2+8c00cYxFb37PK+Z8AcT5jaaMw3NG
	 tSJKYMPChcdM8MuzMw0AkyM+CkhMEX5Wn2cPhjzl2ff7Iv/OZhpyjvBsRVVXH0dzF3PEe
	 0dIXOtQ3o3OvBpQjtvDmQJuOM8aLkrDFJM8tCsdV68FIcq7oJe+7j+cf5rXcb/p6XGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k4R2mNNw;
	arc=none smtp.remote-ip=115.124.30.97
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C55606A31C;
	Fri, 27 Nov 2026 05:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C55606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=k4R2mNNw
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795759173; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7/uKTLta+jMJdfu5Rd65JOy6OcoxC0J0LHsok0ic9uI=;
	b=k4R2mNNwD9Izi34C+Bp3pR85VFYidXMc/VUFSyxONPDva3Rh3j8WkXxQ7oIEXfLkdEJf3ue44kYAORN5ui5AGDsTyZpA73aPoEFsT1F6CsgV/7UePHGlGOrK+gb93azKRr4Bp3VGwfPpflHtPv80acJPHrXt0BGyiXtChi//x3M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=jiangtianfeng@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XFWqbjV_1795759161;
Received: from h68d07384.sqa.eu95.tbsite.net(mailfrom:jiangtianfeng@linux.alibaba.com fp:SMTPD_---0XFWqbjV_1795759161 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 27 Nov 2026 13:59:32 +0800
From: Jiangtian Feng <jiangtianfeng@linux.alibaba.com>
To: christian.loehle@arm.com
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ananthu.cv@oss.qualcomm.com,
	pierre.gondois@arm.com,
	jiangtianfeng@linux.alibaba.com,
	zhongqiu.han@oss.qualcomm.com
Subject: Re: [RFC PATCH] cpufreq: Keep global boost enabled after partial enable
Date: Fri, 27 Nov 2026 13:59:01 +0800
Message-ID: <20261127055921.728593-1-jiangtianfeng@linux.alibaba.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <18ac46e9-066d-45ee-a6ba-b1b9725a6c8a@arm.com>
References: <18ac46e9-066d-45ee-a6ba-b1b9725a6c8a@arm.com>
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

On Thu, 26 Nov 2026 15:07:41 +0000, Christian Loehle wrote:
> What's the RFC part for specifically?

The RFC is specifically about the user-visible partial-success semantics:
whether a partially successful global enable may remain globally enabled
as a valid and locally repairable state, instead of restoring global=0
while leaving earlier policies locally enabled.

No normal in-tree trigger for this sequence has been identified, and no
runtime fault injection or hardware validation has been performed. This
is not proposed as a Vera or stable prerequisite.

> FWIW I broadly agree with the direction of that patch.

Thank you. The implementation change in v2 only removes goto and
simplifies the restoration condition; it does not change that proposed
partial-enable semantic.

Best regards,
Jiangtian
