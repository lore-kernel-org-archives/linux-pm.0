Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773918;
	b=49Dzbbixr0atxYAxLY4QBFufcV6nMPXzzZ1EHIsWK3LoF/bYrqEavxH2v8G5wAcDwAvX
	 pCSzbzZ4J/6EZnFkLQfFYtMw8poQdjQnXtlXTnjhSzapfEccmENDD4Rru+yQYRUt8V7Ri
	 pH2+zQ5XURGqLK60pt1Br/j6LD0S29gj0AmqyUzNZmWwc2CvxURyFjXVZxU6WojmPLQ+J
	 sGvxD7pNdCjIAIA1ddxGAnqMo64rJvEHaRgqeqb7Y/XzY62SfLP0LYYsD1P5cmGkPzaCW
	 psk/HJ26cpx8CHXeb51W2q8EWoiUaDIkuMFnqu9cN5arQq5IUlmrW0zYjyxOS4Bhsmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773918;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-Id:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
	 MIME-Version:X-CM-TRANSID:X-Coremail-Antispam:Sender:X-CM-SenderInfo;
	bh=Zfs1S8kl80WkxxB3XrF1vdS+43cOLDw0M4ufZrJjGZc=;
	b=12Q4yFw3iz9ZZJ4ZdR52O/ti8/cZrSUJ4KBToCUmirulvOcu/93+WZZSNLTrl84xV70n
	 GMODNrX2Gh+dd3Uthi2ECt1fkUtCgsF5zcXbsiRRkrEalfxtZwJF/+LF5ltHLaS1CUb9T
	 Uh06aeUYarLrj27BHX8dNgunuqHE94JTf1vl2tcH21+y2Q37ajQkTbU+pCvhrhjJJFZ7K
	 WL7g2YwAXGbhI8QSsU5gY38JgAXPAp52rYoLnSBU3spVVlYJVdVitpC0RqO8psyepPHYd
	 LjhUnkINB3aV2H6+CGnwSTcmFerP4fddPr3MxKjX81rDTPGN7Rg0F4R5abY1I4AM59g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kylinos.cn;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LsLUBMqN;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC5C606A326;
	Wed,  4 Nov 2026 06:31:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC5C606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=LsLUBMqN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:Content-Type:
	MIME-Version; bh=Zfs1S8kl80WkxxB3XrF1vdS+43cOLDw0M4ufZrJjGZc=;
	b=LsLUBMqNU9sCWJF0CQm2MjxAyaPkO19jUvhhDNTy0EtyFB/X4a9wyhzp/+QEvK
	SOrMi//3o/nObw97qZV50d9EQbeDxvoKbAOo1GeTwcikg7ufSTJ/NKgi2SZnLaqi
	Gb2IQNsrvuohP4pxD1CJbLVJJQoRDeCIiIZarlc0Zu5Q0=
From: Yongxin Yang <yangyongxin@kylinos.cn>
To: rafael@kernel.org
Cc: lenb@kernel.org, pavel@kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PM: hibernate: Log the hibernation mode on entry
Date: Wed, 04 Nov 2026 14:31:19 +0800
Message-Id: <20261104143119.7308635-ping-yangyongxin@kylinos.cn>
In-Reply-To: <20261015081644.1353321-1-yangyongxin@kylinos.cn>
References: <20261013023411.1364546-1-yangyongxin@kylinos.cn>
 <20261015081644.1353321-1-yangyongxin@kylinos.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:PigvCgCHKjdP0epqqg7FDw--.32566S2
X-Coremail-Antispam: 1Uf129KBjvdXoW5tw4kGFykZF1rtF18Kw48Zwb_yoWxXFb_uF
	y8WF97K3W2qrWxArWruw4xu39xWayrGr1UXrykXw1SkryrKrnrWr4DWrZ3XF97G3sxAr1D
	KFZ0yryUCryUZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUj-eOtUUUUU==
Sender: yang_yongxin123@163.com
X-CM-SenderInfo: 51dqwsp1rqw5tlqrjji6rwjhhfrp/xtbDABDde2rq0VCT2AAA38

Hi Rafael,

A gentle ping on this one -- is it still on your radar?  Nothing has changed
since v4, and it still applies cleanly to the current mainline.

One point I would like to close, since v4 was the answer to your last
question.  v4 does drop the wrapper and looks the mode up in
hibernation_modes[] directly, as you suggested.  To do that it also moves that
table from above the /sys/power/disk comment up to the top of the file,
because hibernate() prints at line 797 while the table sits at line 1134 and C
needs the declaration first.  If you would rather keep the table where it is,
say the word and I will rework that part.

Thanks!
Yongxin

