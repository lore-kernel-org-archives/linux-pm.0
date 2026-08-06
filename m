Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B43AB47E
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 01:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785979212; cv=none; b=koX4MFNsfq62fZ+Xb9mQ0Ok82n3pge2QZfZ3WKdCUmKeYsHWNqIxJs8fIlDddLxXtez8XPU4c/s9OTVTL8AxAB1/1C6S8APF58R7OBfXe6XAo7HB8D7Pt7DwZaP4zcaELVR9Y8e5y2MSaGj5snzyrpstj0gtI9IHvWyBiSkaxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785979212; c=relaxed/simple;
	bh=JbSIdz1Hs55nv8CvNDLovF4817NCnAQbvjf8YGcyOWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnTw8P7vn0hgWPocAvZNpk8perZfa+luQDOiuMSSxZx38CwVr2ADAG8xR6jH6/1wYzxJPJ5ZstSjB7cAEu/zG155k09GPrOSZG18zh1qHq50EFAsRb1D0X9oKmf8BjX/prmlAH+WEy0yjyoEXRqdZ3lc48180p0qXn6LcLyKwi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ERNhPKsM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERNhPKsM"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d032846c95so22125375ad.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 18:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785979210; x=1786584010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JbSIdz1Hs55nv8CvNDLovF4817NCnAQbvjf8YGcyOWw=;
        b=ERNhPKsM5cbPnWf1n7YOUog8IWSkEA+lRvj3GFrIsvk2geT+nDQwbF21eOe6cbsore
         pybM/AQeseqXp7jZarspP3IETMKDZvLPtYU8ZgULDrEKiPL9tjfuthSmx6qyBnc7N3Bc
         +0QRAj8uQmZ4eWqFcsajqqIJNWJtACj46EHDOe2+gP/981YNz3nIu/jBgKw1rIdaQ0M+
         1hknf1Zz/ArOYOB+Ww8at2eGwalPpXvCz+fQ1qItVniQ/rbqi7EwXX3WJCrsEuObr/sB
         xa7kFJ3XgxshwQ+sDlVUvF5L/ri9ivbgALbBPF+g3J3Pqx4ZTueVPF2xgc1MzgHmVetN
         mMSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785979210; x=1786584010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JbSIdz1Hs55nv8CvNDLovF4817NCnAQbvjf8YGcyOWw=;
        b=r0V166OPMtv8jdoS4hpRfUvmvo4+yP5bbDWDucjYbYgfb35MGMKbI/gUw0LxAM3j/d
         xAZ5pHVH4vVqTnNOVJ+D965kim+jdwcpMDPkmdUDxGK003F2IXS4kJvMcG+0JLh5K/YY
         j9pXx+VswxxqS3i1rff2JZVRcP+tpJuOPw5yA8uoyfGX7WMeK8dnj8O+r3Uejsuz8zyM
         ppCHVzg4Sh35A5bysCvNBdvqjR8gxn45uS7aLMKxClHeB3+tiO4UkWXxhV4E0sr+7SBF
         zxXd7HbuaSMqF/NsrGi562gFA1dPHg2Be8ApFZ5N3yuq/270L+87DlAbNd4BhLLr5Nm1
         rYtQ==
X-Forwarded-Encrypted: i=1; AHgh+RopX5Dwd6XVPSjo5X3tG1zVCPx/WiNvM5QGru2t7Z046Kw4CDcrk9u5t4Pe13f9GnLiv7VfmNKlCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwkGSr970cmY5VZyeL9hviuiacXABEAJOZPsQFUKoT/oJcE7xFN
	2h4dc9J32HBpQu6bXTjS9+Bbpkq74MaHDUFex6KG7LK3tAQJJbcu00L6
X-Gm-Gg: AR+sD12D3u0j/vMHzbC3REaeEqDGMRmysd+zxqf/8Qdz2oDZMM/YmFzCOZKo2HdYg7B
	WdxCO2jwHFXRyQChr8I3ABzeIaTl58Za/tZD4k9ClXuX6H5qJH9fINfUD+CBMUmtQwUY9zS7qqm
	HX+t32BNwc+r6Jq9bA6JpMi6qYz1TL38RfPb7JTgcaANJ16FI2eAgi5sriDsz9qZCLoYwkOGVsy
	7gDCPUTbun0bdm3NPepYFpeYyJw0m87+UXLdppTuRIKG0d/JM2Qtii484V7SbtldNnAAreNcdw9
	eosoxVvauT3S+OODqmjaO48rikBwuk25y1GNKMHSjwLda2j8ZK7CajmPdBwEOc0YBa1vAlgnKzv
	zFFrfZrfLz3Jm1OU95r8PbfNxK9RyXfm552yK6+EwzZLEpnsg60T8Tubp5cWDSJ2W8J/pAD39Q/
	AIRQwz8EEqkJjuzpQVzXOZBIDaQFTOuUnAFl9alAw+pm8wgq9XGDwiB0BARMh76oOMRwbPP2iV8
	YE17EadP0mP3l8BR0J8jKZ4Z6UMkZi7SRYLpYZt/Mpecrd+3bjEkCEkCDP1
X-Received: by 2002:a17:903:1a10:b0:2cc:f5b8:4c2e with SMTP id d9443c01a7336-2d0ca767b88mr146173255ad.9.1785979210494;
        Wed, 05 Aug 2026 18:20:10 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa0268b3sm22350915ad.37.2026.08.05.18.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 18:20:09 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: linux@roeck-us.net
Cc: lee@kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	mfd@lists.linux.dev,
	patches@opensource.cirrus.com,
	sre@kernel.org
Subject: Re: [PATCH] mfd: wm8350: propagate ADC read timeout instead of returning 0
Date: Wed,  5 Aug 2026 19:19:50 -0600
Message-ID: <20260806011950.27428-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <04a58bd8-df9e-4c66-ae19-8473d6ab9c41@roeck-us.net>
References: <04a58bd8-df9e-4c66-ae19-8473d6ab9c41@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 8/5/26, Guenter Roeck wrote:
> I am not sure if this warrants fixing in a 17+ year old driver,
> unless it is observed to be a real problem. It appears to me that the
> error handling was likely not implemented on purpose.
>
> On top of that, as is seen a lot lately, this fixes a rare issue
> that is likely never going to be seen in the real world while not
> addressing the many real problems in the driver (as reported by Sashiko).

That's fair, sure. The automated review also caught a real regression
in this patch itself: reusing `ret` for the voltage value in the
power_supply get_property callbacks means a successful read returns
a nonzero value instead of 0, which breaks the normal
if (power_supply_get_property(...)) error-checking convention for
callers which is on my end.. I'll drop this patch rather than resubmit a v2 for an issue
you've said isn't worth fixing here.

Thanks,
ivy
