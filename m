Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F259B679
	for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789659550; cv=none; b=tJ+8MfCF+EeGFnS42vT8h3gn9ICKfAE45bUME1Q29kEsZPW5BQbhiHd2RMP7QbX9lDseXk+ip6+BVsDej8N7Z+m5fmtKRSZBmJafXC1DdboyHtG57ej8moze+jkE2mKMVoX2wK/I+2AfwNAaAgNf83Z2KPKqLCVeAe3UFIK5Aro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789659550; c=relaxed/simple;
	bh=tL1lU3S6y66CYudldJj/uj6mbDDp8Lup5C09IlTTtlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b3QL7DMTJIyXCFdM8d9aR/GqA5AcbAmGLNioDxQ8TATtGplqate9xGu9rWDfPr36dM9mAFUVb1QwWTHT1Hvmu9owE5jZOYiYcoWiiWzF1Ds1XiWvOtjPg6rMbKm7GN7ZOaCRCPh0QF/KeBr5heTy/gcgATlqq3rHS8Wx2swPzqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dITHWZII; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dITHWZII"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b24c3so612356f8f.0
        for <linux-pm@vger.kernel.org>; Thu, 17 Sep 2026 08:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789659537; x=1790264337; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tL1lU3S6y66CYudldJj/uj6mbDDp8Lup5C09IlTTtlc=;
        b=dITHWZIIOXYOGvtQ7uv4SXeffJmzqUnQPhv2Uj+bOODsz72IkLCgMU7zwkN7FeI+dO
         hfU99AIIAaXivM9mjUCJpGL1hY+8u3VKWgMJLdpxjZ3xQb8E1+3IESxigo/YKKeVFQ7r
         TOnFk47UzukMreeoY2IKO7Vp4WtqB8Ri3iuILcTW+IXzLWTs+LrPGnKuAO1KjlB/A3r4
         QbiZ/EiP7ncRnU/4WRO/IBG+Sed+rTmZxdVv1ZeZULsN47NUANA0gkrFQfDCcB2chWJQ
         OoVjyCOOO5+pA5Fr6VC/loA5fevaJJgAcbmYPXb7Kks6UsRKrsT3oUSYsrO6OBkMaJUh
         RMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789659537; x=1790264337;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tL1lU3S6y66CYudldJj/uj6mbDDp8Lup5C09IlTTtlc=;
        b=jJBIo7bLC5trrKDKHq4iLTO7SP0cbZbsL8JcHUne3Kialigq0cbbTWpcesBBDDJQBc
         r9sR8pFe0AHxqDrq/p1Y7Z1EBlbJha65Sfz7+xxe3RGTljP5+BW8BxdRvy0Ocrl4xAUQ
         4w3eed9tQtxY2LtmiegWMA5uHEy9Epv+lHLv3ZS5i+1c+UmK42QZzK/OHBN97e3fQ2Qv
         QuXPJ31w8dEWGziHaVGjA1JCO4zO4BwXiVaAjf2ZA83/jGwhabiD/eWQaV76eJtN5vSO
         sdtnOj8plpkxIFTPTJtjHdDhGxr9JbyvhBn8IMi48ZYkgB4yjTN2imP9TZhMzpV5u3nX
         fRqA==
X-Forwarded-Encrypted: i=1; AKwUvBzGWp8tQSLiCTsBnGO5hms3nz5jA5GSpP4kF3aV/Na56mYU37QH2MNhiLoYfURd3Bw+sXk2ueqfbw==@vger.kernel.org
X-Gm-Message-State: AFuF++niQ8+GJgPfoJzHjtAJ6Ia+bQSLtSy/3KGnvqQRitle6/rNJRJq
	cwRyDFv3FPucVrKNNafD1o6hq4Sjp6EvpswZ5LOVkuBmYsT3yJD7wDuM
X-Gm-Gg: AYBFou1+19rrJ1U5sy+YYLQ2KbOSitCDtQI4MvOZjXgfjW1xZan8of2ckL2dNL24zve
	GF/9e3SAwApzhjV/QZBp5b5bBtKgU1dLEC5yFSXBNkEOeMlMWWGJoxzZFKla7FwILOjUKveDGbl
	LBewDD+XDTOVQN4a/0jq3CE0buB9B9B+pXS9aWTXcqNydLX2IMQjpOYyVDstVcMSh6xlAUwkXv4
	qsZLyM0KP/GbIMQFferKKD6hNz1TcF+kobd4WQxnVfVq5lNdEFzvq9VCLs03pKGTHfqG1cm2Pgs
	Tawij3ABQjFsZBqrHryCZMMwGhOoaqIEk/WP7s2Civ/bU3u2R5rj5y6cwVr1qmUPNzVuo5kKDO+
	0mZxvfNoBLQSPEzxzE0TYlS3t6q6W6QmUTcsQ96zUFfcneZsuQFboblibqqMCB9WiVer4e97dns
	VXZJ+qgQvghqnYOqG4sa3D46qKtTuZAm20EoINB8FSmM/J/+ri/aNkPd3mufifcuVhIYDZG5EBH
	SMKLdTLa3GH3h20q9U=
X-Received: by 2002:a05:6000:644:b0:487:4ba:97f2 with SMTP id ffacd0b85a97d-4870cf27ad0mr9119569f8f.3.1789659537241;
        Thu, 17 Sep 2026 08:38:57 -0700 (PDT)
Received: from localhost.localdomain ([94.252.75.113])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bf462cesm15872185f8f.37.2026.09.17.08.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:38:56 -0700 (PDT)
From: Oleg Keri <okerixx@gmail.com>
To: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Ananthu C V <ananthu.cv@oss.qualcomm.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] arch_topology: use the boost frequencies for capacity_freq_ref
Date: Thu, 17 Sep 2026 17:38:47 +0200
Message-ID: <178965952769.2757.5034972953349001664@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <bddc9273-fe02-4984-bfe9-5078e9e6e111@arm.com>
References: <bddc9273-fe02-4984-bfe9-5078e9e6e111@arm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Dietmar,

On Thu, Sep 17, 2026, Dietmar Eggemann wrote:
> Ah, you want to fix this for 'frequency table' drivers.
>
> IMHO,
> https://lore.kernel.org/r/20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com
> is trying the same at the moment.

Thanks, I had missed that series. Please drop my 2/2 in favour of it.

Patch 1/2 here is still needed, and becomes a prerequisite for his series
on this SoC: with the reference at 4723200 kHz from boot,
arch_freq_get_on_cpu() wraps and cpuinfo_avg_freq reads about 524283 kHz
unless the multiply stays in 64 bits.

I will test his series on the Yoga Slim 7x Gen 11 and reply there.

Thanks,
Oleg
