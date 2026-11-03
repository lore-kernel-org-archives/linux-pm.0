Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793690256;
	b=DZDruyUOBQeadLEdAYnh6W5HgtxdbpNoqDQ8YdNvwq1LDc76vk/R0r0MB5t1AN18eyiG
	 yrLVMXqKs/WWb6MvFRbjIrtGkL9FTMmzwMtISAZ+bbdKtsxQzu8Z0767SHhMtQMhxIPSw
	 yRpIW5cl8Hrmf4mRFDiX4fA8QrGV7UQ1v3XL7NuEoE/Cs04fIJuGaBMyUCPU8aKyHR0y0
	 ll4jMxWhkM62opd2F/z7XODROERVxh2KDi8y9wBhyxKj2I5GYgPYi0tI/PZM7vEGmhmVc
	 6p5GpdXUo6G2WVZq+UssDEkhqxJr0r+y94CRLr8P3/W4dIge0DaHaOkS8k89u3xOsCQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793690256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Q2P/x/X7F4ZTrOHgMQhH9JkrLN8QQTUe8ldsYMVJ+vA=;
	b=vE6Qn+qjf9Minh61JIiE20YZH9ufdapgV19R9MPxdCAC8+nz6xGOjfuyVrPRpXbqnR88
	 fTs/oi4OoTxD1mZn15npQEDiVxNChsv5Fx+Ttk7vWugNd2+acfNtoGOlma+wwS4NsdiPg
	 c73nRgbq9FpHlO8/jlL4iLT7CpDQtswPMBSXp0Y0YD6LsoafBGBNN+R/6JJ6NY5R32iVq
	 dmqW+h8TKGZn++S2C73iexr0s4u1Nox22JWpU8yT0p4IzqchOB+/pu0Fizl91JxYPlZLG
	 XREEHFkqY1cmKQP7qvK1KUl12XKY0bYw6/7lKu9LR5RUYrYdw55ZTgECxXpov0pcWgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="F/GdtMRS";
	arc=none smtp.remote-ip=209.85.215.173
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3702606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 07:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3702606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F/GdtMRS
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-cc758830601so2327358a12.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 23:17:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793690255; x=1794295055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q2P/x/X7F4ZTrOHgMQhH9JkrLN8QQTUe8ldsYMVJ+vA=;
        b=F/GdtMRSzoyW44GbLemuevxSbKCZ4C4N/Xnz98A2GnYtlWbrzESnrLJ8CJfXfVxl6Y
         tVA0pvMyb9NDS9y7kBJPq64Chm9TVvmduPSPUO1TTWpeQfFxbiH4DGfQiz0jh/GOGsXA
         pV6uSNF2Zs+4YURzCOpvXXp/cNGKGBiDIqw1Yv8dVlVvIHHd/hp3VfsFjl+SYn3hnfTN
         6U3pNL/fmz4wegIJkWU5T9W7yyqgyUXbgMa6Eoquk3I6+KFNVi0MAjZLraY2a09QwAHO
         LWKmUMiIu+6XUZjBCgViM6xq/dQLAn69eRd/CMRh6ppqbsd1u+7ODdMMoT3isQC4qabP
         Bq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793690255; x=1794295055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q2P/x/X7F4ZTrOHgMQhH9JkrLN8QQTUe8ldsYMVJ+vA=;
        b=pkqgBQsGkKccECSRM+QVAonM69nnyHAuABvVEPthQJHWXqRcMtnh7I+cB3r+rfRrDV
         fsW8XCehE9CBuvUoZGrdpaU9VJraBHCLXy/u6OcOssA1aM1iWgS9wlaAzcphJZE94lH/
         ZCJKznajfksrQfnrGs/n0b4U+SEZpCIebvTZOhcIUKWzr+c7XmLGCF8eaQy7b3Wpn9NU
         +w2TmGS367g+IXmhBOYOaV6KQ5KDT0S3pMFN+sl5+lCs8dfo6Xhe6aSmTIXVfvLocd8i
         wyCyYnaO+A6QRBO7ML9dYfRzfrmk/RSzsiYA9MgUbbWq+od7u/12fLJVj+N6rZ2OaIu3
         OgCg==
X-Forwarded-Encrypted: i=1; AKwUvBw/P8KEG/jZB/IylizCJQ03UV4jRGYdC5hsWcSs6RbWhwAzcRuRP3sfNJsD0Hp15aoAcaWWpfbHpg==@vger.kernel.org
X-Gm-Message-State: APuU4Z+v76XnpAydDsNYkV+w3pjC/JlWrETP7bdu7RV2ochDjD/pbkRX
	gTx1tJQEA9+a0QHU51svTmDSYw8T+U6Nrbeg4W4hTchRJjPcilc/HkeH
X-Gm-Gg: AYBFou2pB9oXtWYkS2accc9jWV3XqSNhn47QvyoK/E1svaS7HSnNwM/0I+iSW1k7E0b
	cNhEe+cG6xXX1y6QhwTHKEmlJ7Dqd7rtuKdEL4n4l2CVRnhGVPvXnzRYzlXY9CuxErSufygyvRm
	lgbI2d6zHo7lYZyNM4mw1Drja0yFhgYJkdRASdfsR+84bQZgCIZdfmePk34ug96gNFcKT3wt/lg
	Z/dafxTfgkhrzJ5vE0KwnFruZa9g7d0bQLIs5J9k6+88Dg3S6AbSBVeNy7lLWOgLs0HPDdYKzui
	CxzVFREXidp4TuAFyQ2s0FYLmLG2v0P5N6Z1LINEYNS6Hzx3Nv1Kqzz6qDZmXgtNMRQ3PuEsv46
	qRzBIsRgmMoObrcIKVJojxsQHy0wkLIHMN4rzymKmsblAIFXf+mp7QUHhOFdIFAHi9H86aa6yeM
	h4Pq1XDUDnJaTW+O+gjetRmeq+s497dDIrY9mhs6AeF0BDTb5/5DGkIDL+i2/yUKXIWuM4/NO3y
	14GV2c5bDf0WkYLmmQRBP5OOmC20p+u3DKN04Gb2QLdjAoSHgyXJU/Tcu+2IBFW/VxqYUYB2N/H
	uW1/wuadIJBStZhCMVgi+a900X6EqSzVWJnDgk3YfurO544=
X-Received: by 2002:a17:90b:440d:b0:3ae:2969:9031 with SMTP id 98e67ed59e1d1-3ae8983eda2mr10921492a91.54.1793690254847;
        Mon, 02 Nov 2026 23:17:34 -0800 (PST)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c2ab1cdsm3012167a91.0.2026.11.02.23.17.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 23:17:34 -0800 (PST)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
To: thnkslprpt@gmail.com
Cc: rafael@kernel.org,
	viresh.kumar@linaro.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhanxusheng@xiaomi.com
Subject: Re: [PATCH] cpufreq: schedutil: Skip busy-CPU hold when NOHZ is disabled
Date: Tue,  3 Nov 2026 15:17:29 +0800
Message-ID: <20261103071729.1556217-1-zhanxusheng1024@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103061557.1235129-1-thnkslprpt@gmail.com>
References: <20261103061557.1235129-1-thnkslprpt@gmail.com>
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

Hi Avi,

On Tue, Nov 03, 2026 at 08:15:57AM +0200, Avi Weiss wrote:
> +	if (!tick_nohz_enabled)
> +		return false;

idle_calls also never moves when nohz is enabled but was never
activated, because tick_check_oneshot_change() found no oneshot clock
event device or no clocksource valid for high resolution. TS_FLAG_NOHZ
then stays clear, as with nohz=off. tick_nohz_is_active() covers both:

	if (!tick_nohz_is_active())
		return false;

Thanks,
Zhan Xusheng
