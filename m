Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795090872;
	b=eCgU59i8ZwjnHHVPknt5GizDDCGKcIp75E9oO8iozvhqudlp5ep2s123JDqr6Jcg0zm6
	 PBaRPgxF31j/viPculvdMAzJsTM/VIqEuXvJyYR2X0Rek5rT5JEnVnAXxA8gVhGINSkYS
	 rbLQoMSTT6DHdKPyJ3nSlNAijJLLOfNLGQFeGpwCm77JC5Ux/bKsz5GNvDquqcixTbEMv
	 cb4v8aA7Wr5t4p+xutG63u+N+f34y5w9GgkXfBkns/Ga7oAZ1YFLi2qka2FCA3U4zlMT/
	 Bp4Z6rnOC1oy/695axSAasQmGenMOfHMh+S2uMKGcBZnS0UzkYZaPFd61lh1XGYQp4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795090872;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=2f21doTHFGdxnjZqkn9v66hcP4nTVSER8CO0mMlnHRo=;
	b=TXABgZsPGqK+pS7NvhywGM/bYbLxTWrfRcPz1qW6w2vjKnMpIl2pKjREefvnnBB2Ckts
	 Wy5WAHIgh0NsiSIU0eBHPCmQ5gynnCCg9+gc+bjyuV6PEGu3fEiEsmslLDMqtoLmi96c5
	 o+peg0hzj/iBRVvJUFnHeuZnB7KASEU0In3KUspWx/yxPGZbOkMbQARnfJ2h35vHjvLDY
	 J1jPvcGzre6uTnVZ2cqcFsCxcoQ7e6GN28lbpsbWXOiIQuIw+I4G8LBvpHDU2Nb2bHJni
	 AR3x16QgpV7EdJTtaVuNuBVtZTlB4tY5orsDqk/Cz9i24xFyScVzNuePx2HccpoaUGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GIV4PbqH;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020DC606A324
	for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 12:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 020DC606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=GIV4PbqH
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so18213695e9.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 04:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795090870; x=1795695670; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2f21doTHFGdxnjZqkn9v66hcP4nTVSER8CO0mMlnHRo=;
        b=GIV4PbqHeGq4Gk/jo/EQNtTLPSTM4Fp7k84fqaHnbhCmEIzbs7mOqsfNB37GnNmQ62
         wn0+WlNIGQX5dUs/FapjFwGJ4grnw+WpaT9y8IBQQRuKT4LV+g1Y9xGisErJlNKtkftc
         tOJT9skopUObYECZQwswNuvQMSwgh3OQ1+SYEr98CS8/j+ST2RtOOKSm7WIgFZG1Bb/a
         W7LnplNGH3Cm+sW+u5uw5RSzvER+pbE9UDAEquN/wCe9s6AOz5YKGOEsDfHM1owkTiZE
         mB2n/VmUYqGbkuaKKkHAIpyvz1m5WRNti0LYA60sTZxRMg2cRjFuAgxgP+K6rBnLy8EI
         ObzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795090870; x=1795695670;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2f21doTHFGdxnjZqkn9v66hcP4nTVSER8CO0mMlnHRo=;
        b=mHiavZgoJezToKt0xtNv8Z7s7PGxYmZsTQM6Vg26DD3heuydQueSh2MMJFOn7/cPFD
         i2TXHhS+tLXqT9mPR8iM47u3/BRb7wgxScBa0I8kEMNMSh1LaHLbWmc47br47o4p7aUD
         zqGaDvCfnFAfouVBxRRYpx4PyeVCqHFb38h22AxHgPs+rOGCHAlUQDIV9gM1xABJQYp+
         yjD2aEleE9gPx4D2OYDo3l40kqF+mzV1U5UG+W8l483jRrMi2R0uvJQxdbJ+5xioc6XV
         1nB+aIUzpLHLuF+SAyYTDOlUcWHa+DkcefJGXyBEHi5AR963fFdKhCz1nWzTCEbw9Ecc
         OX5w==
X-Forwarded-Encrypted: i=1; AL+hErEnCFw9ZRwhx453Sidi+EiWilzQNXiPk322ZuMQT0pG480UJ4Qxdu1DgFXKwHHjRnpygLy4GwoGVA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+VISK+wxlnU08pmclmbi6MrSQsv8eRydQBZJzFbKsEG5Ej6ys4
	Q+og+RdLhGb3cTb8ZZCf8eeYaX+zg4ltSZ00TKUVOe2jYSFN0CIQ9bMsXZn/lG2ZFmo=
X-Gm-Gg: AYBFou02Cp2cYBCgTQ+ex6Ifal9KWet63uOwptRIOuskV1eK6l+Bg0abDo49e1s+GRO
	pdEIH/vzPesxbP37qZ5Nz19PUTg/+BAj0MIY8yLuCUHnq5KNDXmV7UajzjA2vcYaboLFbJBOdQZ
	B67Yq7B9Wf/C1bp+poqKdsMz0cVbXOww8cQuhBzRGsBlKx3eHQQtlLgqXnkvfoEMPVA8CRT0daB
	H18SBa3jLc8kJE6CXvIy5U1ZYtaMgCgCvc2hT3P2/L8EwKouZpnwKMe1PtiZD2CTuPuJpjkuUa6
	sm+/OMBxpZksP7LKbYISVXQvEc9RWI5lxhXKoT/fsCm+pwgsAVUMk4McIu0uABZ6LQ5G6/F0fIi
	t7f0UiLouXCXvqnVlN8C2xxZeov+nV6jPFe4VMszvrRyMR+9Z+x6+uJbDM/q6TaPbaAl/HZbu9r
	d4LfVVAvbCLXkEfTH8zAqALCKwLB5wDZ5odatTbHjO9FgryuslVocAjSyr0BNTelsIazQa2qbMH
	2nHZPTMrigTxhTxZQPDHaNu9giFj3p/aaAYYwqWfb/bepI7dYuvQ2v94LPfNsCzwAeWcXDnyLnt
	2ENAttdgwY1d1T0k/2QpKIzAivjGR+8ddwfCWkYl
X-Received: by 2002:a05:600c:4e45:b0:4bb:6814:738c with SMTP id 5b1f17b1804b1-4bb7da267bamr102371215e9.22.1795090870232;
        Thu, 19 Nov 2026 04:21:10 -0800 (PST)
Received: from [192.168.0.252] ([79.115.63.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb84e4df2bsm31124375e9.3.2026.11.19.04.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 04:21:09 -0800 (PST)
Message-ID: <274849ed-4090-407b-bc3c-57caa029ef0b@linaro.org>
Date: Thu, 19 Nov 2026 14:21:08 +0200
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
Subject: Re: [PATCH v2 3/3] thermal: samsung: acpm-tmu: add Exynos850 support
To: Alexey Klimov <alexey.klimov@linaro.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Mateusz Majewski <m.majewski2@samsung.com>,
 Thomas Turner <tturner@lineageos.org>,
 Peter Griffin <peter.griffin@linaro.org>, linux-pm@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261118-acpm-tmu-e850-support-v2-0-19848c0d97e5@linaro.org>
 <20261118-acpm-tmu-e850-support-v2-3-19848c0d97e5@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20261118-acpm-tmu-e850-support-v2-3-19848c0d97e5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/26 3:51 PM, Alexey Klimov wrote:

I'll review this after you address sashiko's feedback,
don't wait for me.

Cheers,
ta
