Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142866;
	b=d6LRKykx6rcY47lfvwfA2YY1fC4S1oyxtRR+eMb5WqefT/kmVF/ZnfN7+1fOvQy3KSNO
	 /nrgoC8rc/MoLZ1yHv7C/csaCxoZG0D0kojq90VqP7bpQJUW2knEk9FyfwwiQnbi1Ddvl
	 cRp8ojhtrG0LmudPn+XvkbeS5S2pm8LF0Xk8nDXbsBYDrdk8k+N+T8UVvmw0vTvGEJYcg
	 gLR8V9R9yR2jvZFYeg2TDdz+5gijX0DDCcXX/HjVBWT7YsCrBY3ntuO8GNEd1LNqcBq+i
	 nAaguXRUap9pVk7mLFwanNO28JWQl3masfxGKkC2oHtGfBaIdjThLiHQXLFqTl0KKXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142866;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eVrCKlzH4lLszUutPiQuTSZmQWPqwrLEs6IIi6j3BbY=;
	b=Q0hFlVQ/llGsKVO+Vr6Ac62YYbAedKbKbxfp7elHMVf2YDN4YmK+rdIc5xn5fWbOXK6R
	 DRg1w9vNgvAIjdKjygbdo3y4fMTtTW6w1vQb8t8magZdhlqHE7slTxTo7osdHGxqWuKvZ
	 y5s0VNm0ZG9EN/pOyMolNVW47iDRJ/tfxbK4ULOV2IqSL+l0fAMq+w6vBS0qNyiOd3157
	 JG/rkEwoeCryGTG4Shi7/qJ9m1fKb6ee0Q5ylt/Mwm8vkGyZHRLnconkrCoaRhFbimauh
	 t97V0Cc/secT5Ur4EmT++q3Nz2wPMfu/Z8swKqb20vlTTWukXqTFzD2awvd4Kk9A+Gg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rowland.harvard.edu;
	spf=fail smtp.mailfrom=g.harvard.edu;
	dkim=pass header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b="WjFjI2/R";
	arc=none smtp.remote-ip=209.85.160.181
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50EB606A320
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 02:47:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C50EB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.a=rsa-sha256 header.s=google header.b=WjFjI2/R
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-55d03bfd477so4840581cf.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 18:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1795142865; x=1795747665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eVrCKlzH4lLszUutPiQuTSZmQWPqwrLEs6IIi6j3BbY=;
        b=WjFjI2/RqNsnIlR52LEfePwwBh3Y8NCZxXlr8w2hRAHQAdP/y7zfyGtH8tK+aDobqq
         e4WD38l7oK2Aoe1mGokBjniWSUvmsaQ2Oz74U56BIfQri13l8CT1Wkhjo0nUEHmoYcmp
         +snvU16JjAZ7mA7t97EzDt/0FLa1eJ3MKhVfWB513YtEPG3DwDGlx1HTosbpAyy9adB3
         sGXj55z8lB1N6Vct2ogBdpB8gHtv9JaAJtVhZKxL/wMrH/N9xlmOtBsHl1yrzjSVWXdz
         4FQcOLI5YbtqgxIDD/jZwMezIsFEbI2Z3K/Rp5cU3MGL0ERCcVEI+MjRx8P5f2UwhQfB
         ZvNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795142865; x=1795747665;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eVrCKlzH4lLszUutPiQuTSZmQWPqwrLEs6IIi6j3BbY=;
        b=kmpwrsXMv5AP9mq0PLk+Cq9SK2SONniQep8G+L1Y/a8iN7yDYAS2NcJkhDHNGCX84L
         rVBjjfJ2SiM98TxNmFanGuZfvsqJ4k4STaJH41Aps2PIdmhxcN9BFPanqRRqo4Un/PjK
         +YIYtjDreuZ7TXjx5LqXbMf8vC7Vjx46RCIHQIwMyt/GZcsp3SwNRLJlw9PDpz7Qen3v
         eUGw1OcojA5qrBPcRv0Pr86lYZ7ONWWYbZGbs50z8sQTnBlQE0Xtli5kOg8zkNy120Vh
         /A/qJJ/Z10khYzzp38Ziy6HJbhOF1xCtUi3Hk8WBseThCxE4lExRHL13LG/U9ItJwXZi
         a16Q==
X-Gm-Message-State: APuU4Z89HKQUCzUromMGSUPK0uRV/srnLQ/E2qbWir6h4kEkjQbqpkNo
	YHgi8p2lqI3nxg+zThRmiu2jknxLTxRA8l1c7toQrbc/Y8W2pBuP09wVDzLIvWgg4i8mFsg168I
	3UNrFUQ==
X-Gm-Gg: AYBFou2GXy81D7uHvWZgeSIIzaG5DIz48ptafagis+mAqg6e3q7b+y3RBUdMYhWSwXz
	OqJ1okeqbQdIz3vlZqOQDIcatnZUOVL4fUMWOxWaFkWgPlud4frOCOZd0ZzDo61RAeTzHymTT9+
	ydFHSmdI4jSzJT3GUYtV4ogKvKs3IyH6dErdTCqK2CcnSAzDgBTvxMXw+HpzzUjPdMBrPaECyrR
	qX+SaIHabHphMw7mHxD0IQSXUTPACGdzJH+nQXDZLE8cc4vjPPSM1fN6ygDQXQvRqQY6k5z4KYB
	TzVCNqKo8NAodZNQi1k/vbDzD9XuL4Od04tdjTf2N1LVbr9v1+GSA9YFGvp56JTNY+RVCCTgS7b
	IPZGR2PmupjqET7+M+ZUoI68HY3OoKEk4VmI4wimAHHtR3r0kcsh2wxz0+s3fsYj55Q0XglbVq6
	PJ90H81rULslHA3TgVb+YSo4BgZ7efgtLRqQ7lBunkCtjtC/0GoTOU3Szcw9EvOZBcuy1LlK+SP
	ujognH6XDfzEfL1vrSEIEi1Ga5Y/fZrhj0fsB+NBATp04Ai9IsWSR4mLphxEPpN9NNsUSR1JC9G
	cHATZ43uDD84c2+ZZSt+qT1ZJABmgh6j0Iv6/iPee60BcQEIu0U=
X-Received: by 2002:ac8:5f0b:0:b0:54b:5cc6:6036 with SMTP id d75a77b69052e-55d76afed61mr34895051cf.58.1795142864676;
        Thu, 19 Nov 2026 18:47:44 -0800 (PST)
Received: from rowland.harvard.edu ([2601:19b:d00:161a::d398])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d7887bec2sm11008161cf.22.2026.11.19.18.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 18:47:43 -0800 (PST)
Date: Thu, 19 Nov 2026 21:47:41 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1 2/4] PM: runtime: Drop space characters preceding
 labels
Message-ID: <c1a2c90f-c667-4bf2-bbc0-2cb3f840ad97@rowland.harvard.edu>
References: <1978814.tdWV9SEqCh@rafael.j.wysocki>
 <3453847.44csPzL39Z@rafael.j.wysocki>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3453847.44csPzL39Z@rafael.j.wysocki>

On Thu, Nov 19, 2026 at 09:17:08PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Drop space characters preceding labels from the core runtime PM code.
> 
> No functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

There actually is a valid reason for keeping the spaces before 
statement labels, although you may not agree with it.  Namely, the space 
prevents "diff -p" from thinking that the label is the start of a new 
function definition.  That's why I put a single space before statement 
labels in the code I write.

Alan Stern
