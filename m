Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0284529401
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790068331; cv=none; b=OIh5nfuwEANZuuk5/51DZLeCv02RDgUSqbErHF0WrUSyGiaZh6RX7Gh+A9lLP/9AfSy3sYNOlPv6HIed7lusxgjzEWi99JpXM3xPDfKdWUMW7RKMi80IMlbValsaQLUqeWNejZA6dWIb9iIQZgRkGYcw8aKv6cWg3DuFbzZpUwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790068331; c=relaxed/simple;
	bh=fQgPBD9Kek9DVD06+pbQVN0+3t7b55JwSdnBbCBPOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3vd78+P20PHJqA+I3xt4G13LsZE+0IVZl9tEf39s8+br166UFp3piMi1ebMcHSKaeMH8CqPdM/cYcvW5rPyVNOpePDfOcOpCbJiFUQjOVTpfzGokfeUD8r3cV4lLpGY3/B6SxVawZR7sfI+Fbp/PGVoK1VznTbG408B2BfrbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E4j9lA3g; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4j9lA3g"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8c7a1aeecso2740018e87.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 02:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790068327; x=1790673127; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cDbclgIWO4R8bDcAGU87sYhseS50l+4Py8e7acKbvhM=;
        b=E4j9lA3g9VPS++0abWvJpBp0IoJMXr0rOF0+gYV3lm2L5K+o6m5tw6nHr+RfgRVbWv
         BpWsyxOfl9eDvlbWWmbh/bsO5L6kf9yQUyV2IOx8KPVKZQgKStJmMptaNRitzsaUQhnk
         NHXMUJPdQoNWy6PXT1aJfXTATeIiYKFmWUT6iDjQWincbnWhQKVHh+XPiiwE9k82Jnef
         pwV0DgWEqUHU4qKs6lDmCoI4nUj6nn7dbphI9k0JO7vxlBzyzNCipQa5+sm8RPN23e1Y
         ZLUzxLhyAXUm4OLAXOj5uTvTfnrItiJd+U8Kn5KCflv/n5LWw1OnaQeAvrM+6rSTEuSA
         EGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790068327; x=1790673127;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cDbclgIWO4R8bDcAGU87sYhseS50l+4Py8e7acKbvhM=;
        b=jikvR8A/+QlPQeBEM7ifDXIJz925EcBdtOtyKS34Dhb1fWmJiB5h4gu4uGpSKs8eRm
         hAj4hhpBfQopGCXOOJHJuMsx8Zqcs4XX+b3Zv83aI8A3E3I/RRW815NsByHPAuY/EZYV
         eTRDeZ8dmKFBdp7BUpSvNd8xja3LvaLtTI2nOFm56ONiPk3nOhn0LDIahcdr+0UcsrM0
         CsiLyDCz+gx2DJuyAWdQB/Q2793GNknU5B159LMl7pj3mu7zIcR89jv5ehkm8jzYd/2N
         b10FsMBcGu/bTbi3G87aRFG90Z9LV2LDdsx5w/tNfSm8mR3Z8ZaW1RrwpERuqAiJgMJT
         atyg==
X-Forwarded-Encrypted: i=1; AKwUvBy1cV8o+oOdfZTnABnu7LXzGxNqYOpV8atgyb70Zumjs7QsF1YgK/jbUCyMwFiMBXpqPy/S0lo/dg==@vger.kernel.org
X-Gm-Message-State: AFuF++ksTXBWrQUkpTU/jXF6i+i7mXYpZp8fuKlOpOFEr/96bDwlc8pj
	kJqsb8Z+HRWO4OjhPaT4dv/f+VTlTSwhGeEC1ETWlWIiRFGYQxS82Zme
X-Gm-Gg: AYBFou1sH7M/zYnmrH/a1Dy+t9duLCoYP6/Blrh+Stk/jqctNmK///kgb3dr1B2TijO
	xsYvHdEDv60D3D2NfmURVEtKpX9mH8ds2X7bVLKXiD6JsbosEFZHLzQBWNPcS/SZ139vGpgZybo
	HtyDWZkzbhoE7AoRBdZ8xDkO/0lkxUnZpb8FU3uTl9ycDXK1e1Rc8gUxpGuDtpIVNsVqeFqRHbs
	YbBEY6stHmA38DEVEMxnSqpQuMuy0UxsJbRHOv9xOJS/JUD4bEcT+V2UWLEZA26/AkqPxcnmnwB
	g+e+TBe5iz361py0VH2iFbZojBdd/lMvZLj2U6YftutmWoEDuvgyhy5F88168IXOyO/4Map9bIL
	wnH8z5pabff74Cq2LBWO/cGPJN7NkcwWQDbLxqlxyW6duzXz1xhrZQlD1pzWZbTiAHDGtkHNXGc
	SvuMHMJDam1wJUUqxtMzqsMnkfSP4lJd5TcxmJeOy1ZvT3yuylQFpFWDWusRYQmC9XvFecy1vmK
	vYBK7pN4yw+JAr1Kl6mPeTEHFy2tBPS+rTdubKYCQhNQ9tuGtoHsNs=
X-Received: by 2002:a05:6512:3ca0:b0:5b6:423:9fa7 with SMTP id 2adb3069b0e04-5b8c1845600mr4360136e87.31.1790068326297;
        Tue, 22 Sep 2026 02:12:06 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8d46d1e0esm317726e87.20.2026.09.22.02.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 02:12:05 -0700 (PDT)
Message-ID: <822bdb90-185d-4b2c-962e-5f487c112b27@gmail.com>
Date: Tue, 22 Sep 2026 12:12:04 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 6/6] Documentation: Add sysfs documentation for PSCRR
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
 Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
 Tzung-Bi Shih <tzungbi@kernel.org>, Guenter Roeck <groeck@chromium.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
 avaneesh.dwivedi@oss.qualcomm.com,
 Umang Chheda <umang.chheda@oss.qualcomm.com>
References: <20260921-pscrr-framework-v14-0-a16290003b7c@oss.qualcomm.com>
 <20260921-pscrr-framework-v14-6-a16290003b7c@oss.qualcomm.com>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260921-pscrr-framework-v14-6-a16290003b7c@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/09/2026 20:44, Faruque Ansari wrote:
> Document the Power State Change Reasons Recording (PSCRR) sysfs interface
> under /sys/kernel/pscrr/: the per-provider directories and their name,
> device, reason, caps, supported_reasons and record_policy attributes,
> including the stable reason token values.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>

Good stuff.

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
