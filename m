Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.254.49.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699687;
	b=wxxcVyRHKslxtMW8bDqpd7YviR6PrdsYrKjSQXN2QlHIqBiNBza8/c6LEsckxaqXK8gG
	 0t+TN+UnAYtt/8lVPpupd5FHMPqDu+YtIMnJLMXyaK1YnXG4pwPOTZYHxObC9I/T6h1nS
	 PK4zzDLDtiDUhOH3B4xbdYUVGLuHoDDRBPkEa4T+3pnjvwzrpwvKUljZt1ZsZQgoCbI88
	 1n/yY9+ADYc+U6A4IQg5FnqTONkruIAKWZNR0n+VLEE2F5mwo3/f3fWWBykUgqqQBJPPx
	 Dm/0qh4ogFz58sRoHAi0Kw5UnQQR2lSbT9qxfbh/9clTfK+qGKeReXYZh3adGnJsdpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699687;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-HM-Tid:X-HM-MType:
	 X-HM-Spam-Status:DKIM-Signature;
	bh=02QniuZ8DQvIbgIq67SzSQoE/V2P85+ElmdDdal6/wA=;
	b=dj9KHywpEOwbOPxraKqBE5XK7ZotYE15M1vVjmt22tRgkuPwKeUfYANvF+rlRPvRyWdv
	 4okHO0UsQY/ZXh4qsyv0erIYRGGPoxI5oZWq/2TZp8ThMYfLEyjgPpGOQ0y9HcFPi5xom
	 A9sDxsE9Am2wH05Gff8cV/nsF/EEzQiksXhDIDsti9kP9y++SNbW7hlJBigCfiqXvktiy
	 ZYjExnNp9HwASHbZmA0bXhyhV85qUJbbpKCL2iV+Va8D+8FxyVPh8CuTv/jWtdD28/5ch
	 0KpHelvjwbF8ybQ1EQ0CeOTgAZVsAQa5DNOTqOw+iMPGrzzcqWPir5ADU4tyeqrzOuA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mail.sdu.edu.cn;
	spf=pass smtp.mailfrom=mail.sdu.edu.cn;
	dkim=pass header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=gtV637yi;
	arc=none smtp.remote-ip=45.254.49.197
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13041606A32A;
	Thu, 26 Nov 2026 13:28:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13041606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.sdu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.sdu.edu.cn header.i=@mail.sdu.edu.cn header.a=rsa-sha256 header.s=default header.b=gtV637yi
Received: from user.localdomain (unknown [223.80.110.101])
	by smtp.qiye.163.com (Hmail) with ESMTP id 561f6fcab;
	Thu, 26 Nov 2026 21:27:55 +0800 (GMT+08:00)
From: Tian Xuechen <202300460064@mail.sdu.edu.cn>
To: rafal@milecki.pl,
	florian.fainelli@broadcom.com,
	ulfh@kernel.org,
	noltari@gmail.com,
	alex.aring@gmail.com,
	eric@anholt.net,
	khilman@linaro.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-pm@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	liguangshuo@mail.sdu.edu.cn
Subject: [PATCH 0/3] pmdomain: bcm: Unregister power domains on removal
Date: Thu, 26 Nov 2026 21:27:52 +0800
Message-Id: <20261126132755.4091008-1-202300460064@mail.sdu.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-HM-Tid: 0aa2180a92d003a2kunm345e734035d93b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSUlNVhhITU9MGEwaGEhJH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVQ0tVSkpLVUpLSllXWRYaDxIVHRRZQVlLVUtVS1VLWQ
	Y+
DKIM-Signature: a=rsa-sha256;
	b=gtV637yi4/QRgcyBR74HfCYFQOwGhm6SKqyumxHEm0yN2rvlFviwESyNj5RvhTPK0IWRp4l1uI/nyi1mtrP57OaB/GHSb3CTa4DPI/03Jdt7V5N7L60FhzzLZbUqxtxkmwKC8nRY6GOnunFB/jE9bRS0NMPW2NrhJR847NID1Iw=; s=default; c=relaxed/relaxed; d=mail.sdu.edu.cn; v=1;
	bh=02QniuZ8DQvIbgIq67SzSQoE/V2P85+ElmdDdal6/wA=;
	h=date:mime-version:subject:message-id:from;

From: Tian Xuechen <202300460064@mail.sdu.edu.cn>

Tear down the registered power domains in the PMB, BCM63xx and Raspberry
Pi drivers.

Tian Xuechen (3):
  pmdomain: bcm: Unregister PMB power domains on unbind
  pmdomain: bcm: Unregister BCM63xx power domains on unbind
  pmdomain: bcm: Unregister Raspberry Pi power domains on unbind

base-commit: 4dce97c6c265544342e716e62fd24bbb232590c5
