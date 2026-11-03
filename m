Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793738495;
	b=dnUqE9tRNp3rVYoHZLCgpY0+vvECrAhLXvc2O5jsRgDHxOsoIMW3tJT4AGfjdCnYIigD
	 i5IAKka0tmqnNRFIhPV/KDcN36wrtxJYC4UKvg53IKUA2n7gRWn+4bAhAB8Z/i3AFEsHk
	 daHPMfYE/YA/Z+4SAFp00WzOvp5VZBynKHiJcdPxaIy3x25urAJVNzWisosymPQFzYsLM
	 rL/DLrNSNVtLhlNUzK2kkLnDnY3fCazQfztXf9bHnfhokiwOD/kSvMBzGaK1qp+dSAcIc
	 gT0jeaN2cpex1TN/aR51ym8ns5n5n166RTqPjToyYah/OGkqK5/YwKoUGtd9EJSEWRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793738495;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YETm+Up3HiqhI4HFEq9kpUZu0+ZMnC5rPWZMwVWWgSM=;
	b=lvCUNN+/VfZPw6cL0OY6/FfBQyEVm/uZr6b86z3xca3+sYW8g+l9Bs1wf/rZhr3u4nKf
	 CMQHl1ATyN9nq5wt8qR3lfU2cAkaBNJuZflbXmjHBdVygRt5Owul8AsOTKKn7rMZwlnJr
	 t8sg0LunmIIvz5I7J+yn6AU1Sw91FnagsE26FWL15aUGo54iQJR7QjrRFfg3rQyrnEKhC
	 MAX5fOZ3bKq7aMNKjJtckPUEm8xwYEJuDKETkJ4z9QMAz9yfIqmT3tBE6Sbk553/896Ug
	 CDmp5XeUFHHkBXlb8T225NZ3YZr/E/SR7eB4aOqgOrTLDNWuYfHyVWY2bQsnpZysV2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HSTSqJMR;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D88606A31B
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 20:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00D88606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HSTSqJMR
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4a2069b9710so39649685e9.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 12:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793738493; x=1794343293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YETm+Up3HiqhI4HFEq9kpUZu0+ZMnC5rPWZMwVWWgSM=;
        b=HSTSqJMR+jvEo7ahjNsMaM9qSyGCUVmfTGwVA2e8aiMWGnRNXOoFjjT33oaJBoYquX
         RzwiNuqcFYR6QHmjbTuWi+SEjZL8eJkpRxntpXgz9zb5jTEL7o2tpXZMc+aHbXUrfrDK
         sdXBdeLSeKFdOjKMq5rUA3Yeelka88N8ziOo9B5uD4PXEl6CIOKPBTH/MXVh4BVMvpiX
         9XIpEdm69UYiebiVZSJ8g5+orD9Xhx1CBwqRXOMljrDP/uHgP5/DK0/xVJq8uyj0eNn7
         p/eOYxSVzywNomXd/v66nUicck1CmOOGUj9nCrsdPwtAZRmcs4JMcOMUlnmBDkLTA7xo
         d6zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793738493; x=1794343293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YETm+Up3HiqhI4HFEq9kpUZu0+ZMnC5rPWZMwVWWgSM=;
        b=MXPchzmZ0PvWL4l9jJpx3wa6AnVhdP8HGPQE8l/8eV+4ewy75H83KleHU1+ROg5RC9
         Vm3o0GHT6VxJnFYq0bGfoNjkpBLhrDWBVasTAyqJYVWLa0HTgHxglivCOxFeZvkrYCOy
         nYI5YO5+T9G6WTF3vkMK6RschfDkCWyCUCrFawk++GOE4wATlHK00HlMU4EJylMB/5R3
         FzZS6lc0wvSVf3WILMn5oNC2L+2GvbnNA6ZFhbue7ng2602Vt3miyKmoJscGhBiEp0J2
         ocKM8G2PFA/ur1dOwefTRq1znkDlEVt3OZRwa0DnvNV2D8whs9klpld76X5Rpf/DYuId
         jRIA==
X-Gm-Message-State: APuU4Z/fZCRbBh1kkjBoYP1AEqAYy14jmo6U7Dk/ij3/VsVO+5GjPIlF
	HoonAFadPpFIPEY/DaGnCIZLpIZnl2YrgfIxzcK9O3voszM6WqasTLwP+rupkLPx
X-Gm-Gg: AYBFou1fJ4eiiqzxjoTQg3W0Czvc64N/5mNzftkyE1tMDiaAGQsUbliOgkt3Lstn+Fs
	xZtiKjYsh/9pAtJgzZhPWJJzlZ3SIm6WSdRYSJ6acW+xz1Kl0OLvN5NoaGMma0PlgcmmnM6bvNN
	qLXpgXTmng2YQRKBCWxbobSG5EsErzZ61L+GFM01x4jJujVA337z/hStQK0qtQOELHaZdv1Oyr7
	wM4PGWlKsT9U4hHa2lhP+fhiv61eCPmzw3stcMmcktvpc7j6hTV6VpUQ+KVq8okhqDKwlpv/528
	wwHjazTiIt7GIUc5svvWyOPYrVZrT80t6Gp7zRq16y1aHT45s1TmoRlsAiyeANfzeEYSQWlRluB
	EmSzV6yn8OZzH9k9q6g5PcPpeutIZYeApfzHOjNRpDzAWcIQ2BgfCijFuWa8No+/WCtoknmH+5U
	NVxI68L/K9xC+93tkI+ZaJJsuSRuNhHa/XugDWr6t58cjJxno4tzmUl7x73g+9f7ud2B0mntFqv
	/BQjqkNENXeS3mG2auVccYznWGUT9BLygI/Y+nHFiYFjRzMcPw4AWK2i+8IVmO2k3JdOf5zS7gv
	40D5bqMkwqyekspWctNLHutD0gNAOS7FkrXEV7SWNsr6P7YrbqI4fEpT4o7eu8rd8c4XZF5KQ1y
	0NKYHnPTU7JxmGQ==
X-Received: by 2002:a05:600c:8b04:b0:4a1:db17:c7e6 with SMTP id 5b1f17b1804b1-4ac150b2044mr321941285e9.2.1793738493245;
        Tue, 03 Nov 2026 12:41:33 -0800 (PST)
Received: from notebook ([93.189.202.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4134ff2a3sm6859995e9.2.2026.11.03.12.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:41:32 -0800 (PST)
From: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>
To: linux-pm@vger.kernel.org
Cc: Rinat Muhamedgaliev <rinat.muhamedgaliev@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	=?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	"Andrew F . Davis" <afd@ti.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	David Heidelberg <david@ixit.cz>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] bq27xxx: support interchangeable OnePlus 6/6T fuel gauges
Date: Tue,  3 Nov 2026 23:41:29 +0300
Message-ID: <20261103204129.278715-1-rinat.muhamedgaliev@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019-master-v8-0-2517e41c8992@gmail.com>
References: 
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

Hi,

Gentle ping on this series. v8 moves the DeviceType check to the
bus-neutral core and uses the existing register access helpers, as
suggested in the review.

Please let me know if any further changes or testing are needed.

Thanks,
Rinat
