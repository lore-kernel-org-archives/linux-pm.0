Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793767132;
	b=d1LJOMB9eRDRiBADn1U5Pt8T/zjFWyEns4HUNizzRtGYk+/QoBXtEXWvhS1xecUBZZcZ
	 AmNK5018tJq5jRZ+8AiffXsWXSVhgSw/9HXqvEDrpuFvDAAlydB2Imn2VT/QEpXh75mnx
	 cJcXQ8zIvsxa8nCv6Y7SLTFkPQkDJ57ElTPbUOOVN2ArjxhL4eEkHOYJHiOfHifFf+0sA
	 8QXPhvysxuM2RvaJsri9WMyBj32zYaGifuS8a7VsOqZNoPvih+qXPojn4nt46yNSTQKsF
	 +696vuNKnW0vaJ7zLAiXzIqyKm+i8rYEs8FtY56PAg/iBDTPBOr6acgdjWXcWDBZwcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793767132;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 Content-Language:Thread-Index;
	bh=tYnCThg/dG4YJpxYPMx72lw/ZrZIkaXLiXYK7QfKBbA=;
	b=WUnNWMagXcXExeUG6Lg4mK4tN7B3Xay1yOF49Us2gsJtC7XrAXmZECheZTIpMKJrkStG
	 tDvs1lN68IRytvTL8XS/WZ9hiv9reNkadvmddsdtz4TPC1Zsm9MXaStc9qK/ULq1QXwmc
	 Lnz21+sZgOztvyYwb6E0l/zlkv7YfpgaC1Xkk3nAi2Hjp4efpCae3IX68qWmuZ90PPaeR
	 OFbkj7s+x9arhXBJhJw0BkWU2DBCPFfJr0SqixCzIvqUObnPFNPWIMwXjPwyL8DJ0aHkB
	 12++CkgGKkQsbqFzgzYSgVIX+Te9boeo1xlNpVUxYaOEqGXoKTbwy0J8/ZRqRJjb+Wg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=telus.net;
	spf=pass smtp.mailfrom=telus.net;
	dkim=pass header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=bmKf8iKr;
	arc=none smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA93606A31B
	for <linux-pm@vger.kernel.org>; Wed,  4 Nov 2026 04:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EA93606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=telus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=telus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=telus.net header.i=@telus.net header.a=rsa-sha256 header.s=google header.b=bmKf8iKr
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3ae1d0caaedso161979a91.2
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 20:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google; t=1793767131; x=1794371931; darn=vger.kernel.org;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tYnCThg/dG4YJpxYPMx72lw/ZrZIkaXLiXYK7QfKBbA=;
        b=bmKf8iKrhLu7HtMx8jcoaNGTkSvT+s30f1fqfdV/Hm+Ln3RhhEyADXnJCjxvJlbvPR
         K3OdhDAlPVtdKTjNBqnn73uDV4Etk/1+U9ttcOrh4ODXjKtcczCeb30s9NTPdHyHs3uZ
         yjBcV6VDHj6EjE17Pw3i9m+hSLNenHTc7QUZoZ1orGuRT9xCznSmzsQo9SSrvdiQE2oL
         asoes05kkjunGVZICdswtTOgj1tPjaH4nZoc57kNigysZ8WCbYPToWByqByudP8u3tS7
         yK4Br+XTS5xTOACj2miB3NjKF0YEH8IcWfSCngNFmRWibqBFwpnOdMSeIsFpAWqahS9G
         PFyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793767131; x=1794371931;
        h=thread-index:content-language:content-transfer-encoding
         :content-type:mime-version:message-id:date:subject:in-reply-to
         :references:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tYnCThg/dG4YJpxYPMx72lw/ZrZIkaXLiXYK7QfKBbA=;
        b=r2APXscvhdwUltpeiiByiE+CzsiJEDtM0F/9sLR/cdxTV/dbWPAmljjfwyEoFrLprE
         FxCmtHGzkIwj7twyEVJpeYr+xG/meTOB4bWFnkqGLXM6dfFUqF4NI2P1VYFrd2tOmk1o
         ruuwKzhbW70KALA1izLbW8nN9+4dkG82YxnBaMBT715tS9vrc6xHg8Tz0n1PyeCdgLIX
         6L5FcW4dfy57zkoq60uqdaKlEUJOXO/bmQMxPaSXZfmITR/LaIHnw0+q1Iw+w5QYqw66
         iyTIxcZMW4reIf37o/lg1SSZ9RJwEA77JHOIfm8ZxcUPPfl0Ug8iaurNVDn21TbhoZMb
         mCTA==
X-Forwarded-Encrypted: i=1; AKwUvBz22+HFNsTPRZlU+EGC3uuDePH9bwbXbQvGObOS37a0/SdIvPZeS6ItUY8vffbQyN4koiUnWN7KWw==@vger.kernel.org
X-Gm-Message-State: APuU4Z8hX/XflbpJob/wU4T8ABC3kr/U//Y4SmPIpi59VkN//9EhhZsJ
	h2Tu36Zi8pnOJHLYhk1ge9xPxI+U3rp/jJaohGEGXiNMUSJoiAtY66veLMbKKSOzKoYmD0FTQrb
	qBYFx
X-Gm-Gg: AYBFou0wzhgAHtSZj/4ykWtKb5IMEX6GDr1jqpPeiLPihaYONvBN6AI7gcSlNbkh9sp
	+fQjkJfOYF+W0AbvYUkm1stwJwApMYxMt7j6gd82dGxQxx+VPN4dNd5mun/VtXDJzTwI/8vo2Gx
	nm5ABtgiqbGqkEFUXqauK7Ep5G0SoszMIV4gHZlgWyY5rAtxzc7O27ErxYH6OkomHdwIc7EdVZ4
	J85tFyF4O8xQNNl8zRmEQVqnWNAm4QlSrujGmCX+p5Y9xPn/2lFivsN0Y7v96dpBMQfJlvCc0+o
	P6TkozCVTmYcqMrdeSHI5aPe6Ixnfzjn5Lt+ct1im4a9+efwJ+FUWODBA4d+TBf2NRFH/74X0j6
	k6I4ruHm2CHFBwR1KZC5VC/jPfzynHHQzleBgPf7aQ0Ee32L9GFKUR0Eyl9rKiDkz/q4ROzsTnW
	1X/8K7NE3ukKwMrwxefGoa8Ne/BaoTGqoNpETWOl4vkHPv8V+unoewKXRolTLfBQB26V22tZUzB
	84AFzVLrfLYqpMfvOPLdUmOadHCTSySzdSVEIBZ3wkm/9IOIB1jOzUtU6oAAUKuzLzOfbRibOG/
	ADtijSLqdPa6xHGTIySoFNyuX3E0PPEur7M=
X-Received: by 2002:a17:90b:4c44:b0:3ad:9ecf:2b88 with SMTP id 98e67ed59e1d1-3ae897356e2mr11832342a91.19.1793767131043;
        Tue, 03 Nov 2026 20:38:51 -0800 (PST)
Received: from DougS18 ([66.183.142.209])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0945104dasm2012810a91.17.2026.11.03.20.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 20:38:50 -0800 (PST)
From: "Doug Smythies" <dsmythies@telus.net>
To: "'Rafael J. Wysocki'" <rafael@kernel.org>,
	"'Linux PM'" <linux-pm@vger.kernel.org>
Cc: "'Viresh Kumar'" <viresh.kumar@linaro.org>,
	"'Christian Loehle'" <christian.loehle@arm.com>,
	"'Zak'" <zakbrightonknight@gmail.com>,
	"'Srinivas Pandruvada'" <srinivas.pandruvada@linux.intel.com>,
	"'Mario Limonciello'" <superm1@kernel.org>,
	"Doug Smythies" <dsmythies@telus.net>
References: <6065833.DvuYhMxLoT@rafael.j.wysocki>
In-Reply-To: <6065833.DvuYhMxLoT@rafael.j.wysocki>
Subject: RE: [PATCH v2 0/3] cpufreq: Fix synchronization with system suspend/resume
Date: Tue, 3 Nov 2026 21:38:53 -0700
Message-ID: <004d01dd6c16$6580c0c0$30824240$@telus.net>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQMB+uXy+YK9k9QOu4KTN4Bfvhx17bTUNc8g

On 2026.11.03 12:42 : Rafael wrote:

> Hi,
>
> This is an update of
>
> https://lore.kernel.org/linux-pm/5162355.31r3eYUQgx@rafael.j.wysocki/
>
> that modifies the first two patches in the series (to address Sashiko
> findings) and drops the last one.
>
> This series fixes issues related to the synchronization between cpufreq
> and the intel_pstate driver with system suspend/resume mentioned here:
>
> https://lore.kernel.org/linux-pm/CAJZ5v0hT6aoX4tuJM+rO_5iequFc_7rEXCoaFnHoJBaH3JP4KA@mail.gmail.com/
>
> The first patch actually prevents governor operations from being
> carried out on suspended cpufreq policies.
>
> The second one forces the driver .target() callback to be invoked on
> the first frequency update after cpufreq policy resume.
>
> The third one causes intel_pstate to invalidate the cached last
> P-state value during suspend.
>
> Thanks!

Tested-by: Doug Smythies <dsmythies@telus.net>

Test computer: Test computer: i5-10600K, 6 cores, 12 CPUs, HWP disabled, passive mode.


