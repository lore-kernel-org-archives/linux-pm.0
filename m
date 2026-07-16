Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6D642F6E1
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 17:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224185; cv=none; b=A4yiI7ngseM2u1jVqudExNZDDu97ml4tmz5CtVpSH/Iu61s0hLuc1Q3UjVkovonevPwsgy1z9fAipMq9uKt3RWBNBp/STwiDuZt4TsEd8MoH3y280ntjFpUniXILUbur2pEd7xtEgNUgBbfB94XA6I2SsmDbLtzHrd0drIGhVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224185; c=relaxed/simple;
	bh=h8dMwf2MXhdAxkhcE0UScQxJ/befx1264d3qYo6rnCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnogM58x4NX7UH8wvJ6m8l13K5OjwHJ5FT+qetgO51dK0+QywyspR6vlXZSxElOK9jrBwnJMri3EHrNjCiDk5m7TL+6aA8ZboJxPiH9iNNizKJIlpvrm+Gq4MHEO12AjbbrQf9t2KgPdgPmLcdUCDB7gea14+s5hEDod9ROLGWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tf0EdxTB; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tf0EdxTB"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ed2a00f12so38492597b3.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 10:49:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784224183; x=1784828983; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h8dMwf2MXhdAxkhcE0UScQxJ/befx1264d3qYo6rnCY=;
        b=Tf0EdxTBG9LXBtKNyW1iUKNQsX6YyW5St8VfvfhqO4vo0aI3iCtUNY6uliizJKCjCB
         pu5xBHMxlsM/eJyFPPv+Tli/smphfLsqEBfNj/l1tbDxPxCCJ/2NMCO5nepIkmSir07m
         kKpyv/8Zb34l52CdU9z2s7I+45looCr4wRxkrjudM9Kr/yI9zjyH3Rgik+fDcZTCipNb
         jWyrmd10/TWbxHQUZz1/nEDqefdBYvhTLZBaJro8uis6PLC+2YHrUA5+uENbyLAPF5JM
         LfH22EG1jMazYxJPl6bpuI6W+N+LikZgRmARgDjhqtwYh3m2TpK3gqBiL9rKccLcvsG4
         9S4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784224183; x=1784828983;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h8dMwf2MXhdAxkhcE0UScQxJ/befx1264d3qYo6rnCY=;
        b=oHQih4A+3LIiQAACyb01nteUZeZv1U0P6u85AA7jtdy4RKAo+Tpda5L+CDog2KfIeu
         QZEtI1xvmb5ktPCabSji3tzxYNO3AlLG9pfCufKtdgwXtiv6nIlpbTioKsN/FHT0gjH4
         8tuw5md9YMUgUwpVtmT5dfjsWklX0Z2NXcym7LQbBjwyjhCl1WSWsy4qepb+2PooCNnH
         +ieosbi0F9VujF1NN+qGeG5UFuajCla8tkk5CHaqL0uEZPKOiqOnHy9u6eJHKaStC3or
         tGlnPfjYE8KJ0I4OTgQ0Dyb0ugkVfnZFyewElcyvC7RW0wv2bEgv28XWsaEYanXUtaDg
         hJ+g==
X-Forwarded-Encrypted: i=1; AHgh+RprG11ziwbJyVxXZkQAGSBoS66UTwyER9/KImkyVhOeAwwn596eARpZGze7BY12LBJ4Vqw4ORqsIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAh8mmKWNze/BHmTX0n+41+0rHkE2M+1bx+qdmz/8giXvaiOWl
	Ls45fGIkoTnCV1UYL9OQYPgYxWFML9xDAhTOfqH50DjVxNSHpceR7Ahi
X-Gm-Gg: AfdE7cmTOTebZBFrJ+q0lOLmk9UW4Bku+Ltj9Wth3kNP4uDeY8vcP7c8fgOSdA6gH8m
	Cp7KBrTwon4kzMwQRLM/k2nYjl79f+XutnAl47fHD4fTMcjDidLe0dlTqbdyYOcRE3p4cHt2oM6
	UkKi2D6UpTy/Epm7HRm0xZnGPRdYnR5PjBaJHsVoXcLDHzKNqWD57olLaZULkGHF0zeWPgl+W87
	M2z3Qp7YxByDMgcg1NMAEQ6SjFAqXMNwTkpQwIs9q7vkGOP1l/bShFu0UrZx26id4xzsAyiXtjE
	DjgPsXPOrzoAMpI+sc6yHn3MOffDaB8+sMz80JkdD5LptawcdGJ11LqDtzN8xkS55a12iNfz38d
	dpms3PIYzxkWvWJvffE37jvCJxJZYTNJKO6yZ7T43SWOaq7j+KcXC4euVeb3V/VupFL+xCMfYAD
	ILceqB5ZvYWmSx6I+SSwfFf4JLpvzATX8kuYxOSKkkIQrIufL0TmKsz7uudPHD4YW39/InHknKy
	AqNYgqNJ9jqY3g=
X-Received: by 2002:a05:690c:6c12:b0:80b:dc35:6a2 with SMTP id 00721157ae682-81ebfe0453cmr90014527b3.18.1784224182692;
        Thu, 16 Jul 2026 10:49:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:566e:ba00:93df:11a7:3aae:a53c? ([2600:1700:566e:ba00:93df:11a7:3aae:a53c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6c1ee792sm201943927b3.38.2026.07.16.10.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2026 10:49:42 -0700 (PDT)
Sender: Julian Braha <julian.braha@gmail.com>
Message-ID: <9688c5bd-db01-4234-b9da-809747e8cdd8@gmail.com>
Date: Thu, 16 Jul 2026 18:49:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] soc: qcom: Hide all drivers behind selectable menu
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
References: <20260711-qcom-soc-kconfig-v2-0-4a907e064281@oss.qualcomm.com>
 <20260711-qcom-soc-kconfig-v2-1-4a907e064281@oss.qualcomm.com>
 <9bb44840-c3fe-4bcd-af2d-149dbc2c7c8c@gmail.com>
 <5a69bb8e-8a06-4678-bf20-f0dbf76f47c4@oss.qualcomm.com>
Content-Language: en-US
From: Julian Braha <julianbraha@gmail.com>
In-Reply-To: <5a69bb8e-8a06-4678-bf20-f0dbf76f47c4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 7/16/26 06:48, Krzysztof Kozlowski wrote:
> Can you share the options leading to that? or config? Without
> reproduction steps that's really incomplete report.

Sorry, I spend a lot of time looking at unmet dependencies. I forget
sometimes that these are actually pretty rare and not obvious to
resolve.

To replicate, enable QCOM_PDR_HELPERS without QCOM_SOC.

The problem is that QCOM_PDR_MSG depends on QCOM_SOC because of an
'if QCOM_SOC', but QCOM_PDR_HELPERS selects QCOM_PDR_MSG without also
selecting or depending on QCOM_SOC.

I'll send a patch to resolve this.

- Julian Braha
