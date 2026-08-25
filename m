Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18936403B14
	for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 12:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787661965; cv=none; b=Kg2eRhqoBOIf+d5zNOMI1v7clLR19YLLePDSHxAFN0/cn1wPn0lTn8vvxNDW/zjjok5UxNzlu3rkPGKWmVYCtJ713YWBPUtr4oX/G9t+5EtGrsssZqwH698o3CO0LvxSO4LacR63t74dwWHLqToIaNj0XGGhqzFMemMhnUzKhZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787661965; c=relaxed/simple;
	bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJT0kpxrZiEMJWHl/K8BWRuaX8rDuNYD6ElEXHWIxapw8Zomspq9bOIhYI7OwKp8vTU8vIbbGjGdLoaAPMN0NKAnkokAj9swkr2SF/DY8cG+UhevCJc7YzhYmT+8L4NTOsVD87jPQQJWK4zIP0wtnFiL5N3Z6IugBX52/8QHfPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMFo5elN; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMFo5elN"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c082647cd0dso41983466b.0
        for <linux-pm@vger.kernel.org>; Tue, 25 Aug 2026 05:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787661962; x=1788266762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
        b=RMFo5elNyWrcaCCKk6vfmTulHfcAosuqU2jCUyENs0yXLScqjL5LIcVv5KOcY0nzqe
         xUYr2qHg1XjGgAe1HqIO3UfoTDNOt4n0J7pAo+9FrXW65f0ALwgOgnWZyTVsN2gETFfw
         6vdFKF+Y7YY+FVkF0SQy82qHxoK326tBJgB9u2Xli1xmCcheLN5LtwROOHKyHfhFWQBW
         zjKPlJMS/D1//uMr5PXr2YpIJ0X9de3nxh8d4fj7nvqP2l6yAKO4oOyd87k9oHxmjbmO
         ldSNeMWQcwt0Ss/+ZseTPLHlgcIiawFXLch3T/hHRCchs6/917ktg4bYGqr/BKHSXYTv
         6WIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787661962; x=1788266762;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZAN0remZKwTzPxuAENpiQH5fEVpl+tgiLHbVt5de6NI=;
        b=oOCRGs4eQMWQGy09RdVI7/5NlZUm+8Ahqm/PZ63wzJ09uKyJFh+jT08tWWjUbS9ta7
         tLc3egTegsme6L7ZXwPMsrZsX4w9jI8D+vLfWcL46CMaYXt13dcoldad7PB/5tOthkq5
         A3+sIvDhf2jnvJmQziJJ+kSb4tTNd3uVPZcmDbYDVPDD6vRAXb6bsZX/l16SxNTHhjeu
         iOlSROhXZ6fKTI+Bgu6sUj0UZwDF4jRvt3AoDoJVV8kWB1DkufYlHVORXl5PAgArGWWO
         Wc5l+luJt59ABj1JYHgZGQe7RTJ4Y1piagS3PGEz5A9PVhkcV5OqrdXsBvsaHXJ3S2ij
         LhDg==
X-Forwarded-Encrypted: i=1; AHgh+Rovqu3H54dDWVObSYuJ41YJf5P0b4p1UqKN9VRj+iuyRZ39cmiwefbwuywpyVg4Whj3Vczmqh84ag==@vger.kernel.org
X-Gm-Message-State: AFuF++kZofQoOvtZhoBDveFHaug4mQ3FmkK9fEbdRFpIcBG408acyylQ
	qgrrBV32x3PZoZPP7RWmKg1OVesdsl4nHMQKFXYRGxAqG09GHCYAZVa7
X-Gm-Gg: AR+sD12v7x3TEgm0ollePpKKUkLTlo+70ICSvh7dBKW7X9QC+739+uo60VuMFiCKLX0
	7Hu/lMaqxXovyFwobJKPsc7SCNswDwdzJ4BEQeitmAGkZGDxKBlnU2lRu1Lv+HOkXjV/lNrFU4Z
	O+f2UKUC9n4mHmyDVwYojg/LmxgEuBpvbByv8YBi39xRKBxAYSVr2gIFh70PjjiaLCZN2Cv0kXk
	pT+JDXoagDDeC0ZP4wmTShCJ/1gHvhMWcwx5gyDC80jlTn7R0vGjr3zhxPVChh5FbLp3K+HUhQw
	10QATfAtu3Ln8WE0gq+3aL4iymd94882W8bcp1UrSaTMQBkCw9UoWtGcEQK59ZB/7PExEv4Qk0J
	my1JGlyukHaN3jBYlD8DDC4B8Jg6h8vGM2AxMBkwmrqf3X8Uz3xupBpcv7NqclCfyhQO8LACfKj
	QehZMXm8B3ArL51AJ5iKhJdJP0nlPO8AdVfCtfg4034WS+XKz96ACezdaVmsXDVQCLDFVs3HZCl
	TdBVdlNqO7eeP43+56QHCTUdu/uLyTzu47c
X-Received: by 2002:a17:907:d0e:b0:c20:c5f4:e19f with SMTP id a640c23a62f3a-c246a65fe29mr2143386466b.4.1787661962050;
        Tue, 25 Aug 2026 05:46:02 -0700 (PDT)
Received: from OrangePi5-Plus (178-223-53-162.dynamic.isp.telekom.rs. [178.223.53.162])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249629929dsm1824340566b.23.2026.08.25.05.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 05:46:00 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>
Cc: Igor Paunovic <royalnet026@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Alexey Charkov <alchark@flipper.net>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 03/13] accel/rocket: let the core suspend after a reset
Date: Tue, 25 Aug 2026 14:45:42 +0200
Message-ID: <20260825124544.11766-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
References: <cover.1787568658.git.gahing@gahingwoo.com> <b5265e47492897d0ada844c2ff7f477bb715cd07.1787568944.git.gahing@gahingwoo.com> <CAEWPSH5MVzoQMaFOEQ93+1pOPmcXCDNfuXsv5j-X8Lb1fy_hrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

My mail client wrapped the tag comment in the previous mail, which
would truncate the disclosure when the trailer is collected. Here it
is again, on one line:

Tested-by: Igor Paunovic <royalnet026@gmail.com> # RK3588, three cores, induced reset, JOB_TIMEOUT_MS=2

Sorry for the noise.

Igor
