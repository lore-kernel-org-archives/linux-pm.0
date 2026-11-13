Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794583207;
	b=ei4JBSFSl7mQurQi7FfU8KtiEz0sQcpX0DFMLmAS6ZlNiHkww3qSGnvqPCyxoc9fUb2H
	 I2jn3dEh5To5LmZMOVNro/sLULbBzTyf/JSBsKY285KLJDw8hVEpoiP9/y8XEdjG+xvC7
	 N1UxxgTF8Pyz7Q+hFUjAtlBMZ4GKjSt4civFLlhJL7+4x+dJBaQD936IB9+wicaPRj/a5
	 v1qYcLSc3bU/2ZwNm7B6AOlarS7SaZ+5EK5ngtNaiJQrUYOPjyjPW3ZxHm2T8i+DTUT+0
	 29IbmuU3eTbFoMAxnHodF7+q6LcJ1OGlHCftxXb24zQPGNrt9XSH5qfX10CfO8D4V9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794583207;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
	b=L5q+KGpJFhK8XIwaxcTgmueLGBNy/IT9dCEob26hknQq7cGN6wg1p0rOmiCjoi9f23NX
	 I20AMOR1Xj0uKvY7ALGpKoknL54lSsYadTB9e05QL1ix442G1aSQqgt3O+c1NiKWQEJuJ
	 DpPDWWgnBZX4SWJEMrjwxT6SqHvmaaK3KZgiSnOLMDGw0acCubEjFMnprxavI9o0H9rTV
	 bdjBtx40e+ty4lmVFVCCgUoZ5STQErKy0QfQlqRWzd9/2bEKCemNyvQmaHqUOwuZw2XwY
	 DXL/dE9VpZtjJSFo9x3QQm8KLqGE3vvqPyXcpI5nitTgdG9J8aYsxiQVkapTeFF1P4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDCC606A336
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 15:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FDCC606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFcMT75e
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso15253615e9.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794583205; x=1795188005; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=sFcMT75ewHSGlHNFmaIaCzRv51RyA+AmoclO+Wvr0qj7IRgdft+YPwpD9jRP6WK6c/
         JYnz5nY7tp8rDhhxRl839jDRSaCdOFEO37y9omk6Y6bTMpvUdRVO3sHs40wFUzQoK49R
         KDfhcSnlxOwqISdXag2i2HeczyJwl3JciKS1IO4IueILgI43L1Jav1Ck2sEsLOvdW8YJ
         xsnD0k9f1YMungKWzdWfs/wgCnEVQku2SHGreep9hdKIBeljPxLy6tKl9GtdE53m1rK+
         tr1h/mPnq09YX6erwWu4ZIbwvv7uEDWKwAiALSZofPGlkAv/kiWcyL4UzspYLPPPopZN
         ldpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794583205; x=1795188005;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dIw/cEasDaTMuxY4JqRIaZBNhw3B2/VuC8Ktx1d1fI=;
        b=UZqUDCgum2f5oTtLG9m5H66i6T/6CNPhGj4GmcNWlIs8WTHaiB1VwruD4N9IMkUG7Y
         q1IgB9wh1ZCdbzqO+x5KrBSNQrAaHAkMJaLF/W33FiQgvcm3gx4q0dG/Zd3y+tVrBJbX
         1bfDHxnQln/ml1YdGmUOULPmNwhk+8HvowG3RNO8M8+JdAZf3JU+3EjPwpnXLtJFWTyz
         O66uMtrfbc/xhf9zWKGlNtnOpxc+WQlsWFsHKIzycILi6IFY83AAjexykXFxSg/n2drU
         TELVn2IIwgR04x6c5QB0uUbxxrN0eWcfj4zztaDj15vOx2gmr81CAA4BCv+lUXpuirVQ
         3lVw==
X-Forwarded-Encrypted: i=1; AL+hErHdqKf7zlE6nGuqeGT3sXji0x+bXN7w/LvLtinON0mxQXyw/+nWs07i5AJjiQc1OPckAIfs7pAqVw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8YqLP4IJb/g7EjCHfr5z+WDoExxZOjjhw+oS0JIBatDijYFMb7
	Ldk09Z9kBP58yrFHUTnRADjIJ/FDmKdQRrGG8xXFeflTNVfYCUzlpdm9
X-Gm-Gg: AYBFou3d67xV6dLF9+QesXa1pysUomZx1cbH5vHCy4ZaWhX4jxrp+9fIPcvISpaqR4s
	8AETTX7MJVoPt89nNJCkQi9/0asVVCucheNbH+Socz8KQjm3zW7nAQn8UE8NMEUVvc4/UcOE41G
	GLieo9+RtcvQFJf0rcmKWFUryEr3y52i5ctV+stThz54STjWI9CFS2OEKKO375HPU+HPAisu4W8
	QqmRjmT1JfL05eqHsNkSfK//aGLJeVYVlaq3+QjsRGDJpGBstDWcxx/j/jokTqtr8Fz90N0bHA6
	QcDbtL6knyUexKTgAgxhebCO7p2Tp3W7TFUk0fxPYFiDyGVWVo7CoqdcuRgmXYr7U2LN7ZVo9GK
	WlxQxNh9WPCx1MGNvL6PGI5fm++6XPHo2gTfCX6rCW/synaMafOJ7dFT6sUjzIbFd2lpTk3b53Y
	1Oa4SIOgPr6AlUjh/B14uOyg6z8aMQ65tBA5jYimIB1foMk6xSjeqqgPKmRoGQvuuCiNZPN8CY/
	ZnUEe3HJ0qG4dpJiPxbvXCaX+RymZMDRc+VeHTM+ZDAQQ8z+vsG3Z3Q+2A7fwvzSbwsFWlH4xVZ
	zgfce4Kc9JFRqbysB/ylOhMKBGcYavBhyLvmXP895NDjzf9fVEKAqA5kobJjXjMj6DdPHmTFhHp
	SQgyKRZA0dyNADB7Kf7x9iQ9mueydTYBDDxe2vp1P2EeZ/vuFPi556VoQ7xEAV8ObDgRpTFQiBe
	5W0VqRhdedjDY4w4Q8LaYq9xipawQbZCp054a1tCeca7LN/0UdPbZ/1me7evdeeNEeiGu5YQf+p
	RWGKi8WShoXcA==
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr67471255e9.20.1794583205214;
        Fri, 13 Nov 2026 07:20:05 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2adf53sm159789845e9.15.2026.11.13.07.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 07:20:04 -0800 (PST)
Message-ID: <a0a6a72f-0ed5-4f1a-a93e-30bb99338045@gmail.com>
Date: Fri, 13 Nov 2026 16:20:02 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] kernfs, sysfs: add SYSFS_NO_SPLICE to refuse
 splice on writable opens
To: Tejun Heo <tj@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Ian Kent <raven@themaw.net>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
 autofs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+002fb7b2d0bc53bf7e75@syzkaller.appspotmail.com
References: <cover.1794479968.git.krystianmkaniewski@gmail.com>
 <f9f3df7a60ecbbacc3186b700deb947d7dc23e9f.1794479968.git.krystianmkaniewski@gmail.com>
 <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <07d063ef8ebcfc7f4e05c7318a423728@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/12/26 16:11, Tejun Heo wrote:

Hello Tejun,

> Hello, Krystian.
> 
> On Thu, Nov 12, 2026 at 03:17:01PM +0100, Krystian Kaniewski wrote:
>> Read-only opens keep splice support because they cannot reach
>> ->write().
> 
> The patch looks fine to me, but I'm not sure whether the read-only
> exemption is necessary. Is it addressing an actual problem? busybox, for
> example, just falls back to regular reads when sendfile() fails with
> -EINVAL, and refusing splice reads on read-write opens while allowing them
> on read-only ones seems more confusing than anything else. Would it be
> simpler to refuse splice for all opens of the file?
> 
> Thanks.
> 
> --
> tejun

The read-only exemption was only intended to minimize the behavior
change. It is not addressing a known user or regression.

I agree that refusing splice for all opens would be simpler and give
SYSFS_NO_SPLICE consistent semantics. I can make that change in v4.

Thanks,
-- 
Krystian Kaniewski
