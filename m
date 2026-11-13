Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794601616;
	b=NphNJRGtQY0MzWVbhMIRg2ey987HSoauMvJnvQNkhFQf9hM6Mr6HlyNNPVBIzSD58iSg
	 JrG5AYIhUTcaOCz8cWLNtd6iDD56Kgj+pDoHF1AQukFk0A2chDMNOh85yBFpoPkMIkvOe
	 mXZfiZOomb0PCS7gfV6BOmDlq06yAZ4Va+lSPxknHoN3vNYuvEH8OSSFBnerENFFwxBN4
	 pZEJoiZpLgHK0nZSi+/4KIirhh0a3jWlskHrBWNoh9E6Y/1hMtSVCK8WP37hv5LB0FhYN
	 nXk2H7jsqt7qk5WSnrIEHzU6VIzso3dsp6RN3gEk42QkiXvW6Fn4fPOssDDHyFOJKuA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601616;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=2O2TnvNsnknB44ezKCjK5OImxLFDNz8sdbJ2VBlzgdc=;
	b=jNVSieaq4b0+33EargCcQ1GC7+x7+Nouz3RNxC9im8Bo7iZ6klBu9jG7poiTpQnkUp7a
	 QMPRKKNS14+4KgdJhKM9c901xK6JM7lymMvBQQPg02OTXG9eWjoEcyWl5x8aZ21/nx/oG
	 YouEJ7rIsrJ/Hc59e/Xrnh82OhA5v18olbw+B1ZbG/hpm8BS2sUZPMQu2VDB5ro8iIbwN
	 d4P3vvdBTXClqPOvwTCQ3pO2MAp3thYnQyl92mBU0XbxZox2XBz4OhzuD4tdKbBozdiNd
	 RVThVo6LvaLxLGBDT1B9DWXvOxnUx2RB6DWj6PxncjlRbYoQhq7rpthgrgOsgu4vBUg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUcqmEYa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.182
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25919606A334
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 20:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25919606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DUcqmEYa
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3ae3b5b1027so248621fa.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 12:26:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601614; cv=none;
        d=google.com; s=arc-20260327;
        b=Cufvk/Y0XEMUs3GV3Q5NJXX80J8oCP8ze4Ap56rhVT1/bSWQsCUlWzxao5jRRh12sA
         jdoX04dHCSOFGadxTObatvSq6kVWb8XE+P1eUxio6TLuVQTQtynym6nmhRPp82r8xCT5
         GpH91nlVLWUg3z/pxm5R/NBqNLmExAfa3eiPSFo97jN0JY3tf2Lnk8duXiVvaoSiMQBY
         HHiWJ+q0ClJ2OYZnV1J08MLOenwzVC4PG/XTKCBY58gSL3HIkhGUq/XkJTa0BfIud8TJ
         qlNcEcxMrp8saG4/gDjedBfVHYPfsREW66HoRs4F8ihe6E9zxAeUDzaUXk53Z+cmbMCp
         Wtmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2O2TnvNsnknB44ezKCjK5OImxLFDNz8sdbJ2VBlzgdc=;
        fh=0upGPsgeegiiWFOiy8sq8vUKhfFGGJuvqxG50ebmaQA=;
        b=G32GbaAvVvQdfbelQjhxNLsxzEq9aMZ99ehNqbwqPVbZ0CEewcf8qPvOea43vsDgQA
         bQfX7uZeuCnbJGz4cnlKCYh5EzKA+5DnNs15cduF4Zpygvkf10r4wgUCiv79uQw3iD46
         pcC0dhWGslKVtE9AVmxp0wsmqjbxRkJ8m2RemTBzD6k1yOOjMcuGCwsWXmqNV/Ax7ebH
         Q0vVCoZEkCMiWGSxzoir7o9zvXuWuXIeN0jDkxR20XJXm50PjUb7YwEXLWaPvZGX4Eug
         6dHShj+9eM8q9O9PweTu3Amq7fPw/cilXmru6hDG4aOTOPa6qvczlztlGj+wn84sf5xw
         mQLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601614; x=1795206414; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2O2TnvNsnknB44ezKCjK5OImxLFDNz8sdbJ2VBlzgdc=;
        b=DUcqmEYayYoveruRS1dgsIUc5UcHBRASHp8a+d/bIN+Fs50f1gjQZ7Kk658yW7/nt+
         yr4oEZdZPuk1DmIXUBNpGF/uffpzVqxmL+I/T4mO5L1CPMdoePvIVGGrTZjkLdPjoV/a
         +3sQAX9jjJClmgcgkyUQGqNKDI66T1oh43/ArNUT4rls/tCqCNzVlJ1S5zyay0E36B2r
         v2wzxCKkLZEoN9TeonnoK3yxCyARxoW+wHUMnIHir0nm+5FJXY2cEBfBJ4i7sitCa+FJ
         mSIhgyvW8Z3p5jJ0IRGb+dFBJHT6ed27qbIsFNbK4ZlWz4BD6qHCaEkrOngoQW71W4wX
         PPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601614; x=1795206414;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2O2TnvNsnknB44ezKCjK5OImxLFDNz8sdbJ2VBlzgdc=;
        b=eQmnodLR4JWBDz7l8Y4xkxUNfYamJYJJwohbu/Qvyi7EhwE4i8i/HYmUGrqudVXQtl
         ZJlI46UvO4nC/95wkg10XXC9f8cnQtOpfmm7hNNQbDpuErboUr3+JOmvfcYrYSls3h38
         fJIo6NIVEON9h8kMpzSZkBsm68WRqFTDRtSiK0fCO+bAnirbIi/NZfUY/vfb3fGxTQtO
         2wHkFZSkaLBrgqG4/Kd4M0mcxACAe9Jhcq2fW04zL+0EatzkWMs9N1ZH2A71l/niYJCN
         QgEtU0SfvwbwByND1ddd2wlUNMY81y4Iu1cDDSYPT+mnsJJwhQ50BqqgcBnHYml+1Lzn
         QYKQ==
X-Forwarded-Encrypted: i=1; AL+hErFc+TXN9+qS90CyXHYcxNY8Ar/yEhFCm81kGspRa1QCKqInAcMcmCByb7TkbCwqgYtfQDBE2DOpeg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/dCMbZrVqnAaonRjr2nwRsLLaDeCae58nwuskoeHunZ3sUVYqu
	GcBm/PoJScXsi2Xf2ApPzfuWlt6fR4iqiKMvM/pXpuF77AbRO8yd5+COkjy+mYFe0s/RtNz9jSj
	wBPKHfPKxUO3hRbZHy+D8uN41ZfiACYslShLpiERkiA==
X-Gm-Gg: AYBFou2MGnIZ7zVv2zThw3o1/RypimBd9C/uYBfD6c/dTsXR9mREYWzvvdGXmbLLBtR
	RRCgcLNNjSI+1XJmT4JND1xtEUaOaPVbOxIYEpyYua8KuA+DKrF7JYFTz6yg5rlkGMKHvDE7rY1
	hrb8OrUP2Ci6cBvswUa3XZEffcWNrfxHbkGAjPahV510SPjTngJj9eAA2j5PMaYBJZq7jBxvc+F
	jF6CFN37UJAueVs0odCyaPGMk/2Z66ORKyAtIIL+tlty2IcR+35k5NPE/lnpIY2dQXYYFeghI7T
	2jVc7QUx5J4Txg7Pc07CSCgu0Uj7SyDRs7+80HQqroqVA5rU5iHpuPOAwWqW6qn6hhxmulnQt5H
	+J342sV9CQ7h3a5/V5Yq+b3BopAM6EqxvnW1zfaCu8HFI37bn1miNE2B9uBT5JGlqd9ITb1A=
X-Received: by 2002:a05:6512:3d20:b0:5c1:4a47:b86b with SMTP id
 2adb3069b0e04-5c1709e0a05mr1672668e87.3.1794601614323; Fri, 13 Nov 2026
 12:26:54 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110-devfreq-resume-freq-v1-1-90de450ccbd0@gmail.com>
In-Reply-To: <20261110-devfreq-resume-freq-v1-1-90de450ccbd0@gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:26:43 -0800
X-Gm-Features: AclHuK-ahf_hbv0JWK-ZmP02YMwbUIbSPumHjPuGK0NbDWVoZDeErVULM14wNLg
Message-ID: <CAEy9hNXV1Lr01gy1V1rZsDwWOt328nZOxsNomEk=vKLqXhNMDA@mail.gmail.com>
Subject: Re: [PATCH] PM / devfreq: Resume at the frequency from before suspend
To: aiyengar1990@gmail.com
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, 
	Chanwoo Choi <cw00.choi@samsung.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

A correction to the commit message: no mainline panthor platform has a
GPU suspend OPP, so the panthor example does not happen there. I hit it
with an RK3588 device tree change that is not upstream.

A mainline case is lima on RK3528: the lowest GPU OPP is marked
opp-suspend and lima calls devfreq_suspend_device() from runtime
suspend. I have not tested that board. The fix is unchanged.

Arun
