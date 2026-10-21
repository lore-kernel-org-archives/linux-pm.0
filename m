Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555015;
	b=x3/HPnT0/IG/ZQuQNnEhyWoBv94RpN3/ozKTl39+jDisWNwq0h8Xzb3YR8ZqKcXjHqor
	 9CJbI2jihMUee3jUWd9QnfSAk5arJgyoHMrK8gzYcHr4ynqLFJVwauhF89yHcLmm8k2g7
	 zYlokv74nR8rfV1+U3gP7Wm5mB5aXXbyklfI8UzOcM+nKNrK+8h1ovXtMCM9iWNVGaijd
	 A+cWAoUPGSbl/KSCO36dUuFbrVibsyWCRmbAICitWMPZRLwjnollppXnuOVzbYyJwfHKc
	 FN4eEX4MS2zBCkJk52Yy7KrrEv8Ug2/NzoBlAAquCWEnoPmkftAT8M1KCMnR/mkKm/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555015;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9hCF0mlcp/ziupFrj3DR7yTQMLI+9lDhDQnOx2f3Cow=;
	b=jLe7Ys+Zle5BcsP5nei48vfRT3gLYkYDv83+TYsH+Ourh424PQKaNm7O3koNjNenKgN7
	 rvguyKLmY6uKEEyAI7k/FnAcmU2D4Hf2zyJaB/q2fIINVgIxtBecoUFPHSJqILLQ/GXwJ
	 SCr3ovIo0oErH9FaPtO/GVoxQQhDPoLGVOEYueLO8kyYRErQhMgSXR4n3sFB2Rm5tR1ld
	 xwLnXr2QbCHoJfLZxt3tljmoIMSHpLrvv3ppBgOeD3dlflBxVVcYfiLFTtTvJg9UJFDcH
	 w1U12vDKxmSesiih2iBW7Nwq+bs+VDaGAyWnPOTiyEljEy/PRkeZ11MntJBmTOjfe0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t32U+W81;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C41606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 03:56:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 88C41606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=t32U+W81
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-35c76e9614aso508565eec.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 20:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792555014; x=1793159814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9hCF0mlcp/ziupFrj3DR7yTQMLI+9lDhDQnOx2f3Cow=;
        b=t32U+W81DI+uRXHeY5SOqR6nLWkS2rbrPfnLWOYOVJoroMIPjGKr8szG4I8VAKLlEF
         6ktTVtCI+TfbfWuHU08TpOsNiGTRo1QPR95hbyLxgtZSDlqN4RBb2zd4WPjKoNS1/iMI
         Hv3CyDtwP0DE/Absgsqh1k8ylM1GvSMGh78wXZWxFYdxUOQf4TWUzgXSHkn9UTvl83hn
         ggKZB66C5I1KNQOyzj+fAnslridvRWku2IQI+cxpmFVxYqRTz60h2F3UV0agDFFCs6bl
         5NUinfyn75y91WkHVbmujPf9BorzkSucvQLSi6sZ6Gf3kUYk3W0IKpT2vOl5iobevJEv
         vPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555014; x=1793159814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9hCF0mlcp/ziupFrj3DR7yTQMLI+9lDhDQnOx2f3Cow=;
        b=Nrz6cYjW6jCqYkEg5w06e1mjepGYWeqMO3DRbYPA9SykJdUFhNFPDXzZPdBqWhm6o1
         DfdNBFNjK490J3l7RAaMr+tXF2/P98eojBdSGKzsMySRBqfHaSVPWEXxK8a594WgNxNA
         PoMDjs4khwbadZQfpFLbuznZBs/lLWK/PM5vS0D2b/iuRAyiBQiejkqhtlPFVeDuD4jR
         y7HsPppNtdmdnnNGCm/u6M/G78EK1al/F0xolkQ2zK9RhZNxy46TnlNMsng+xrL1mrwF
         AYlkIU6hPBvc/daHuLalCcRxFUEhxl537SV+tMDFDANyBy0CCDFGE+Dr23jjC7lW9SYw
         rsWg==
X-Forwarded-Encrypted: i=1; AKwUvBxa8zLAgn7q1ELebKzdcWq2eZIkPDlWVnXj85Y3V2gC6GyTtB1Mn78b/rXHtvhT6g+fIGdFpIy4dA==@vger.kernel.org
X-Gm-Message-State: AFq9FYLTUc0ryBdN3CjpfRq8YZNk4SPqiORJUYtoSYqytVPHkel4ZycL
	TzLDpHIU8opQTmhNQ7tOpJBwQKvACGjwWhVpqT1RtuDiAxFP/kAdv9KDBSASTck0OOg=
X-Gm-Gg: AYBFou0BjeYIvPmhGf4kcQI4FDrMbfLB9+FTWhbLQO6+8zaeIXJb2rQqf/lkhVpwgnR
	2hFhfR90ZWSs/Pyim8AnHeepHc9hBJKQdmfIEc8LSnlPazk09kXml66aHeCb0OoUxoaKnl1s2Tb
	1PoTzjk66UUtVrvXQXfP80e8SwQMDbX6EjZS7O3luuiRA3SkRckXDaw3GO1iKmkXXLYrQcVV/we
	Wo1RSZ4v03yWNLIa10PnRwmjYD0JPDsnRooElsW/WXSFjRjGA2iMdfs0O8kzwrv0KXcf5gc7jru
	0Ym8ez9lOMVq7O/fMf1gMQ+lZQx1BLqztbsq8whYbGiVbpr6h6dLTrMqHYF0JidsJrEe4UBzTjM
	wEaVzhhtoyANeBxlTIgGbCGmAl0slFCKMdiPFh8hHzfuJ5BY+sr6/+jCu3Atj6sVdfkI3lcCbu8
	+vml3ZQcjX3/Up+mUiNPPqYZrzrz7Tg2aEC+2XsGAdAE+KKx9CHZzbiz33Z9OyJL52s+Wg1J8JQ
	GJ9twCi4yJE8uXgh+3s2zdk/gmydbKEVUhQFDEhXlSBYH1UwBGHi4VbOg==
X-Received: by 2002:a05:7301:d594:b0:35d:3370:d8e7 with SMTP id 5a478bee46e88-3674b53009cmr1815104eec.2.1792555013393;
        Tue, 20 Oct 2026 20:56:53 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3674198f1cdsm3507906eec.25.2026.10.20.20.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 20:56:51 -0700 (PDT)
Date: Wed, 21 Oct 2026 09:26:48 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Manuel Ebner <manuelebnerli@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: longrun: fix kernel-doc warning
Message-ID: <atg4APgeoSHQWNeI@vireshk-B250M-D3H>
References: <20261020071913.1677196-2-manuelebnerli@mailbox.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020071913.1677196-2-manuelebnerli@mailbox.org>

On 20-10-26, 09:19, Manuel Ebner wrote:
> Replace kernel-doc comment with normal multi-line comment thereby fixing:
> 
>   $ ./scripts/kernel-doc -none drivers/cpufreq/longrun.c
>   Warning: drivers/cpufreq/longrun.c:21 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
>    * longrun_{low,high}_freq is needed for the conversion of cpufreq kHz
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Suggested-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>
> Reviewed-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>

Applied. Thanks.

-- 
viresh
