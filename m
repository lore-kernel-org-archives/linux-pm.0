Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794121953;
	b=4fWjw9ppZ6iYQJsso1diGH89wwA3IknB576EwxDC0PPonkY5w7TZJ0TCv+s93LHN/4u0
	 OqOte3P7RLPKMnBg16LanJ5iHkI0nEUfvi6BvEEv6FHTapPLFG5Ofc2sIWOCYqBVtN2jT
	 fLI76XYODESfogGgCH1LewrXEw1vJShQtksPLW2+Ip2MK0RvfUiyTOyolxcttYZgPIFhq
	 MVHfMrJzlT/FDrrwglImSjI2Ls1F+uVuBSJfadl6Gc54AkkiWfHHq4c358otpRS2zs6Q3
	 5eJq5vknZyFhdutKZ8pNur9OypFX8VpX4b2LtuXAL6JZFyHNMuRdBQAs62gPfVEiu6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794121953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
	b=L4PAcLCY6HWiUgA+RhfakYmiej6NQXH5GZ+WAbiqHN/3ufQMoB2lyPKxPoTOnEIi6CaL
	 bMjsyZrdMPEwAn3xAx3aWLBx4TEAAQLyA98tVGnwzb+LD5nqcdqjL0iPFWHwsTOJjw5MX
	 BaDcq6r/vBPdFv+0XoJAglMvhdofk6qfUT1Y9/96MIeAdL0HJLULnTxzx9q/VSDKLcler
	 a0FuYm9dV4lWqV79hIfozpKspl9QYYtaJ07w/kQJ/TmkeHT9Nc450Fr/NgVhq/Qk/rZcG
	 TDbiLKqEWxi+wkqGWo4TFia2mT1PK0JiqP/0Ga2nMrF1zhBEoxbw3Kpo41V+8F/M36Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhNZ3HwP;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42B7606A31C
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 07:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C42B7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UhNZ3HwP
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4922dbcee23so108690f8f.0
        for <linux-pm@vger.kernel.org>; Sat, 07 Nov 2026 23:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794121951; x=1794726751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
        b=UhNZ3HwPUWb+xsU+LrB9nBdbR1CFNHYoIhf8bYXVRaVpgKnz85xHpaEmfk/PNrPQz2
         mkMtHK2+IOess921ezEeH1kaRuBfb1gRfzVjCmdCWR9LH7w2KHZGG68DeZhrcceB2OU1
         nLjzBlJ96rhGWGjufIbJWTcZUd36JkJIaSs/tRDfWq1Spntglf+D+fYA+1Bt1w+Ques8
         VW75Ng9OJxgQQ7+E7v/TaEC3oUbpdnkI0pKBR5Swp4G9Q6ql8S3Gwo+ouc8SlzXxCVki
         17aStwfzlHx+IEg63Da0M4w1/j//VSshjYL7I284x4JTIumEQokRrMouIruXdmvbSUOH
         jtfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794121951; x=1794726751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QaX11FKlbrrxel5yt5lItqhWglhL95q0Q/UWvFGwSEM=;
        b=eWs/B401IcM/TIWyEOaIBk0kyMiNSRlSKiCvyOahSI6EtxdRvDFqqbL1txCkH1i1hH
         6qneN3h6ySyZdzqSMLJCDKXVkXwtXmP50dybm9Lu6/GY3rmW8C9fqf7Uq9qqx6azSDXz
         SBwbjNASNM1JKpPvqbM99MGTt5+nm1DuXDEUN9bK5YMagfXw3mME8CsEHiHCwhBRXidY
         1V5fqTI7371GMi91YF4zapEQzW2owu7HLV6s9vyrLpZUU6R9L6jLnw7xJ2w4z6deMvin
         hhYPfXnAQhFWDQe9Abn3M5yJhZs+AhOhjVbJ1Uc9I4o8aaqKkgCje9S58opjyw9tg4T4
         PWAQ==
X-Forwarded-Encrypted: i=1; AL+hErGwlF7eUqBtHlzS0himBJRo5dEW7nY4t7CrXoN/4aNux8CJyh9QFcWwSppB9V397fuXg9Prw+jrKQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8TCZn09dq65Wr+Bu61amBO/SMpQyctZVefTD6jOR4zWSEJTVLW
	QdwgwH04t0ClSU21wUvWR4YeMN/srIJcKUJEUNO9fziXiDRqT2puE2F5
X-Gm-Gg: AYBFou0T6HsV5eiLL8mG8DV+i4vvg8Y/YvQqadIumiG6sYZbXKONpt9HeuE0KddDUuU
	w0WcF8vQAngZT8GcJ4p10WcQa+Bs7TV1oOeEPJA/o2Ua7n1xugz4dG0geSMEaMm2aI7UEwvMECX
	yhwhqkrA0EHjaJ6XxEW9Uqjg/KUvDwJcaonUgk7m3yxposUPsjU0vYkclh0pKdrsQirn+fpqFC9
	0OVYxRDRIGiz+5BTwQjdkTmsVBMY9OUu8B49poZUF9wxG5khi9m0vwfh41Bz2rsRCumrsGCapNV
	k7MFh8LRgyDqNltDbZQ4chUCLk52VROplVdyb+YuLQTIlARxgMO+Iy0EKFo0zkRr23qOSRZRNm7
	olgtUsRMBrnIgoRZA1gb4wj3kHQ990SGeq8bSVL8NbAD9RhNDs20w3Qq2AMRdRBveMVoMvY79oh
	zzLmP9NjdSF67i1aP0L/WL0ydE5yhWtTCvkOcg6fQk/cwoWIVVxgkhytPOcTRbaS8ObBZPElkJn
	QRRjXWTQSLY3K/+Y2LsKAvjs8MUPquF1asdpvcP5eXZtNz6o9ymtqleyNNak030dScBbJ+6R2Uk
	enGvtEfPtKkXby0Skv+bauAT584NblkW4KdTfiuSN4jzvi0+gvdJ3jA4R8gvqGexI+OfKy+ZTfc
	8i/o3LaDIMxU84LYRlA==
X-Received: by 2002:adf:e193:0:b0:491:e28b:1e1e with SMTP id ffacd0b85a97d-4958335a7efmr1603970f8f.28.1794121950867;
        Sat, 07 Nov 2026 23:12:30 -0800 (PST)
Received: from localhost.localdomain (bba-217-164-30-115.alshamil.net.ae. [217.164.30.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-495b90701c7sm2609204f8f.10.2026.11.07.23.12.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 07 Nov 2026 23:12:30 -0800 (PST)
From: Ximing Zhang <xzhangjr@gmail.com>
To: Hugo Sales <hugo@hsal.es>
Cc: Ximing Zhang <xzhangjr@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Ashton A." <me@ashtonantila.com>,
	linux-pm@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/4] cpufreq: intel_pstate: Send CPUFREQ_UPDATE_CPUINFO on max_freq changes
Date: Sun,  8 Nov 2026 11:12:25 +0400
Message-ID: <20261108071225.54656-1-xzhangjr@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261101185807.112449-3-hugo@hsal.es>
References: <20261101185807.112449-1-hugo@hsal.es> <20261101185807.112449-3-hugo@hsal.es>
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

Hi Hugo,

I tested the four patches unchanged on an Intel Core i7-10510U using
intel_pstate in active/HWP mode, on the stated base commit
5854d2ce4b0b9ccb37b154319d8283bad889a694.

Cooling states 0 through 3 followed Turbo changes in both directions.
I also ran 100 CPU 7 offline/online cycles concurrently with Turbo and
cooling-state writes, followed by the same sequential checks, and a
suspend/resume via rtcwake -m mem -s 15. Turbo was disabled before suspend
and enabled afterward. Those checks passed with lockdep enabled and no
new warnings. The test kernel was already tainted by unsigned modules;
that taint did not change during the tests.

There is one remaining Intel hotplug case: changing Turbo while CPU 7
is offline leaves that policy's cpuinfo.max_freq stale when it returns.
I reproduced the same stale CPU information on the stock
7.2.5-1-cachyos kernel, so this behavior predates the RFC.

On the patched kernel, starting with all CPUs online, Turbo enabled and
cooling state 0, I ran the following as root:

    cpu=/sys/devices/system/cpu
    cdev=/sys/class/thermal/cooling_device0
    echo 1 > $cpu/intel_pstate/no_turbo
    echo 1 > $cdev/cur_state
    echo 0 > $cpu/cpu7/online
    echo 0 > $cpu/intel_pstate/no_turbo
    echo 1 > $cpu/cpu7/online
    cat $cpu/cpufreq/policy7/cpuinfo_max_freq
    cat $cpu/cpufreq/policy7/scaling_max_freq

These report 1800000 and 1440000 kHz. The policies for the other CPUs
report 4900000 and 3920000 kHz. With the Turbo transition reversed,
CPU 7 returns with a cpuinfo maximum of 4900000 instead of 1800000,
and an effective cap of 1800000 instead of 1440000 kHz.

I restored the starting state with all CPUs online:

    echo 1 > $cpu/intel_pstate/no_turbo
    echo 0 > $cpu/intel_pstate/no_turbo
    echo 0 > $cdev/cur_state

intel_pstate_update_max_freq() uses cpufreq_cpu_get(), whose raw lookup
rejects an offline CPU. The reused policy then takes
intel_pstate_cpu_online(), which does not refresh cpuinfo.max_freq.
This appears to prevent the new notification from covering that case.

Is this case intended to be covered by this series, or would a separate
intel_pstate follow-up be more appropriate?

Thanks,
Ximing
