Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674A4F85C4
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 16:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790697851; cv=none; b=Bzfil/RW0fpy6I2DoicGtfdC+GJ1k21KZMDNMhmkfl5xU8/YIcRe2iP/+5f0kNlRWG4hoVXj0IF++nQdteLNbhGeLcH3YH99dXgGQZBVG7MUBKt09TJkkwDPLEglDPyXnHAHx/00YwUgzRIvudnhAoLqiR8t4+wCwJVs+q6l8Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790697851; c=relaxed/simple;
	bh=pLD/sl+DuidRCJQ62k4a8dX9KYvP7sK6qHRTuXkXRok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sl7j2i6saGV4ArOfOSsFoXDipdwCIORuJkzGburMrWeXdm6s+QEiSpqAniUMxFimOymvlf7MJX3DIvVHh0MwqZAl9N88DNbfPOWRrynfT1HBXCZ9XwfKivZG5uJib3fGeX/n904sXA7BHSQgGFQkO7MUNN4SmjNTd26ocuSaaDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVAB2Svk; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVAB2Svk"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so2718749f8f.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 09:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790697847; x=1791302647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pLD/sl+DuidRCJQ62k4a8dX9KYvP7sK6qHRTuXkXRok=;
        b=lVAB2SvkqU3/iBer8iA9jIDDUMLhtgPNp3JeVVDUoVL3RJrlgoR/CgK5qRxei0Vsy+
         CGab9xF4TP8/pfh2ZeNP0XgvyBBJ5BgKwJTga9jpBVrV9fH7lChbTuklDNe9+7ipkPhR
         iznV2J6xuyv79+qiWxND+qVxbyGS3zNKELK9YRZVMmdE2IMl4pEoaWl5odBOpvEeLyI8
         ble2N92lR7Bueq6i36hVWqZWt0khXs2Viw7aQi5pqiCiTiovg2i2qNKu306a41r4sRIj
         NNM7dw4PAESD14d/UD021KwceZvRS9U4/w8vmnYtd1ImtUhwPtAIWi4WVOm6+Y9S2apZ
         ucog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790697847; x=1791302647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pLD/sl+DuidRCJQ62k4a8dX9KYvP7sK6qHRTuXkXRok=;
        b=HjPNVumLxkyuTPFJrTjQcG0KwcA9e8oDmXjnKsukMHZyH/ULhX5f7HlDvks+XWknGY
         srjNU70KH3Po7+liat0wY8a7RMBdGgE1Rh7tbjlrynpBya/3ppdbAJ6hqzNONGTnY/FJ
         oKAkAu9ikH1rdXZ4Sy+MPssnUyrPFMiyg3SKWS2OIFMp7S6B3fr+pqh121Ys8OVPMGtT
         pIbCH6dnb3WNtsPrV0VVMJfQQMMiQBr9Cft1P86kF4VOIts5Lf3qhniZj/O0f/YemrON
         f/2nSKjDoay+ypmqnX9UAj0ODtxWClfqZYQ6QrloRlI67EBhgDGtZpKzw1xn0pX5zm7b
         zQfw==
X-Forwarded-Encrypted: i=1; AKwUvBzCg80YytRRVas8eR9xpLsrfcIrBo0Bi9I3D7XQm7pMgo8QvPVSHBCZKIy0e4iQPfSNZ64BrF9u0A==@vger.kernel.org
X-Gm-Message-State: AFq9FYKQHwm7iGwQbNk1KYhTqLVl3bJXjAIWu8NAjvhNf2PQYcD30UpJ
	dYV5V7V4DHg4N6K3ABbqcb/43dCbK0oFW5E6KDNLK+HdLwKBgrtBgew=
X-Gm-Gg: AYBFou2Fc6KSYxbGu5oE2cFZAEdO7gUWpPyW0/NaUx322HEsZ7l1LRCmW+HV7hV+zvN
	NHayUa6pqPncZ19CmT3fKJAaBc1x+EeQl0U/Hv7Bc0tR3jGsNmqgwjihcowokMIFS/8TY07nypX
	ZyBnrUdsgPGLRvCP6IjsPiy+eSNCzZ9wcN5qzAHyeYdJyAaJgmHsLbdrVFXsYu4dZ2acrRN9IjU
	IxjBOS3anUVg3joNzR3vX+JTWZGLRI7LGG216WtKVNLi3UzbFpqAJcF6tNSkM9pkhgJglT/drNo
	mLxgD4qPl9B7aWMTy2BeGYUUoj2sRtJ15/OYazXptkq8G5CMBreTBAvAAZHIJ+LkLUt2gILTgyl
	6fmvBgqLyP2qj1y/DpZft2StDd2ygcbG5ODKXNjwR5BP1W64C0NetniLqJIlzvXuB4zNswbZTov
	PaSE++WIssH4g6dK5i1Q8R9USTQ8vfU1V6N+vt8mUliw/LMsnN8Qr6xdmdrcdLVekqVvMoKwE=
X-Received: by 2002:a5d:64e7:0:b0:485:8c16:a34b with SMTP id ffacd0b85a97d-488716f4653mr29190815f8f.35.1790697847051;
        Tue, 29 Sep 2026 09:04:07 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af505e699sm5133578f8f.20.2026.09.29.09.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 09:04:06 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] thermal/drivers/airoha: Serialise access to the shared ADC
Date: Tue, 29 Sep 2026 19:03:56 +0300
Message-ID: <20260929160356.38468-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <5c0317c1-f4df-4b2a-ab03-2a7b7132b1c6@oss.qualcomm.com>
References: <5c0317c1-f4df-4b2a-ab03-2a7b7132b1c6@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 9/29/26 09:53, Daniel Lezcano wrote:
> On 9/15/26 21:11, Vitaliy Sochnev wrote:
>> Serialise the sequence, drop the cache, check the selection after
>> writing and after sampling, and return -EAGAIN if it does not hold.
>>
>> Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
>> ---
>
> Should this have a Fixes: tag?

No. Before this series each device registers a single zone, and
thermal_zone_get_temp() serialises reads under the zone lock, so the
current driver never reads the ADC concurrently. The race appears with
patch 4/4, which registers a zone per sensor; this patch prepares for it.

I can state that in the commit message in v3 if you prefer.
