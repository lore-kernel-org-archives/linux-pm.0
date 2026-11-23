Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795413151;
	b=WPt0ss5EqC2tW3Grq5ACQ+3Loyjh7obQvxQ+4CoD7wZO2zRjrbneCkKRfl3jfwtre3pm
	 Zi5mLEkXuEJwOYbz5Mqlg8QjLdrJjQBaepzQ/4+KsVR9j7NCF3u4aEyUg6rOeQBlM5st8
	 UTVDkSmPHIyBJm6sJMMtuOAoFsF67T1d3lafEHeQtzTM9+RAKFC7jcOZVQKDJDdiTOqmX
	 35oRDZLMC9fqUY1kmLbJpZhlZxS4khChKF6iSS0l2HIX17QLCBoOlPE6XRLWfpPiwHHHX
	 qrRQOtfycMEssH7ImcEg0FjJcJuMxylxb9dPMqHuc6sbADvb+3hHiGRblOrso5sCE3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795413151;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SUu3oaJ8puWJKKOfHdRr4SqhOI+nPpr8oDOkprv0KLg=;
	b=DpOMCxbIdMz4w9vgKfZrKUmTSLWUhQPVacfbJyz6kmkSAy6dCfz8Z/3LN7nqu/jbPtau
	 RUPkhVgYOi3ZtjyOJ7jKMoapobx4urUwq2WJYEbjCgyykPTxi0uX1Yh8ZiyPW2LotQcKN
	 GMCwcb0FcC42H6aQVImT2luzQJshvm17C8hbJSGGMI3iZriWJG83hYnfHEkC5jHYvVTak
	 ZzmVDjjwCaLW1eN7psy0yTgDzsnvugQ9oc9vB64CttIF3r6h0NTxpvW6Om0Ho/etDDfMH
	 RCYGwK3oF+YAKt89T9TfkomraLeWZf+8JSfi6L5nOrtzBXPdJa6rMppN3y3AM6q851Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C7ofIZlg;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA0A606A31E
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0DA0A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=C7ofIZlg
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so5153767c88.0
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 21:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795413150; x=1796017950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SUu3oaJ8puWJKKOfHdRr4SqhOI+nPpr8oDOkprv0KLg=;
        b=C7ofIZlgBNILcEZpzytm5OfVAkteHyG3BUAnjDFQb98Kc3fmmIoSZLNwnkwPhPQosX
         Mg5RDym7AVeH9WCbrUhXkG2ZKsiUnXdTu/VzRgrO/5sOwmCrxBwtkr0Y6ezzShspRJPb
         +PDkCW1bKHuW7Xjr6vqEYYJVwD3iRtFtvcEmUj4HnoH/PtUMQcHz7m93QVCK0vRMoG1l
         UtM+9cnNd6HTPlDv9EnedN7l7fJc8j4NRoAWPS1k6gxcLyObFPD0SVv9GGNayE+zcRIG
         3hf9L/N6WT9KE8TomHCA9oUfdVRdCnQOjaCyZ50QQahJ0SPKGxbzp3KZvKpUIKAHWN+O
         EamQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795413150; x=1796017950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SUu3oaJ8puWJKKOfHdRr4SqhOI+nPpr8oDOkprv0KLg=;
        b=qj9WslruI0R+tsNcJEGGxg4uCKug6hHh8qYI95VPrU9v3rEP2SNZRfMb7PqFDeo76b
         g+YCi/3Jbz81CY98BusD2YR0crcr7u2MZNcSTPmTxcj5sHdUucmmSMqhVt286nLREgnP
         ooeLn/ipQ9y+MNu7LeA+fHi5pxEYA+iW2XJGtAMqPax6Kf9IRxU8A5ZxMz2R/0My2R3y
         2s4t0Vxd0z3XWy7IvOM965/CRGKKKGrsk7MJi2DZ+oYeF4KAn6LN8vaCKUDxJ5zx/GGY
         LGf/IfxKE1GibHEO+z4XB2Sa33+0lQlkX3Imij/uOQiDwv8GAudtng0IKYr3qT0PHvX2
         04Xw==
X-Forwarded-Encrypted: i=1; AL+hErEbjP9/zmNuiIiymsQAOWUmHNfpI4deE/0r1Ih4VlMHYvbUuEs6iLPvMJYSBXQfRtJCD+uXbABysw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+G1RqO085kt6Ki94CnRrDpLpNqyxfT3KnMDarV1J1BD7T6bV6n
	K1qVMkCF8ZbY53ZwPkFL9nZ0I7d/vFZ1YZNHqtjNTa0fI7+GxHQ9dMkA5YVepWiAKuQ=
X-Gm-Gg: AZFdTZezdQSqICrBIfoFDueOEvZCQbmC0J1q2r9Lgitimpup7KDmHK1aMy2j9Xr+PTX
	F6iHXatWs7GKlC/Srqca1BVLR7lT2GkM7+5/w4xt3L6Hi2QVMOlI4fsJ8zKBoACyvBeiGBmeYCq
	2WtqH35v5zULtxkNlhn0fWoM/6wqI6pLsmzPTLqmPH7ucKCaffCmxSa/qrcJOUIO90/WXLCXiVr
	W208ElHfNgi3Tp/0zlZGA3O8llZm/5BgO5vB+lWAt4GanXaUPHl4Tshjhq74OZSj7ONQS79XD2z
	EzWVgFRDZWFkyQF5pMDfszmS/aYIjTYyu/wGiDrnsoOg68EFhwGuT9OlRosF206Oio0C/lt2+hu
	dITJJSJEAb35fhowI0VPJI8MAa1CLFbI80XWfKVDnio5Av2RzdHnmTW5mNJQa8LETGb1FVBCV5l
	EUMDDezDReh1Ct4qt7rlmvUXNueD5PL/GmQAtazIBR/ecoP4MQSuzRWFl2mx6Zz012PHXbHADPB
	Be91kacQsZ45Lu7BhVZ0uuZCYonSuW/t0KrrCYXxySTr5midqf6ygecc+IhijMnccZx6qi4TSYK
	SWIiAeqa+R+Zl4pyxEL7YjodmDMaSA==
X-Received: by 2002:a05:701b:4555:20b0:190:8f72:445e with SMTP id a92af1059eb24-1b556877915mr12166436c88.11.1795413149986;
        Sun, 22 Nov 2026 21:52:29 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm23669790c88.0.2026.11.22.21.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:52:29 -0800 (PST)
Date: Mon, 23 Nov 2026 11:22:26 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: shyckless@gmail.com
Cc: krzk@kernel.org, peter.griffin@linaro.org, rafael@kernel.org,
	linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com,
	alim.akhtar@samsung.com, linux-pm@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] cpufreq: Fix leaks on probe error paths in three
 drivers
Message-ID: <awPUmsmWWBKdVUyQ@vireshk-B250M-D3H>
References: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>
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
In-Reply-To: <20261123-cpufreq-leaks-v3-0-1f1e3f4f5a7b@gmail.com>

On 23-11-26, 05:40, Suyuan Wang via B4 Relay wrote:
> Three small fixes for resources that are not released when a cpufreq
> driver fails to probe: the cpu clock in highbank, the three clocks in
> kirkwood (also on unbind), and the regulators and register mappings in
> s5pv210, and its reboot notifier, when cpufreq_register_driver() fails.
> 
> Found with a static analysis tool and checked by hand. Compile tested
> on arm (W=1, multi_v5 for kirkwood); I don't have the hardware.
> 
> Changes in v3:
> - Add Zhongqiu's Reviewed-by from v1 to 1/3 and 2/3 (Viresh).
>   No other change.
> 
> Changes in v2:
> - 3/3: fix the Fixes tags. The regulator and reboot notifier leaks come
>   from e8b4c1986efb and fe7f1bcbff91, and e0e5b2b4f427 did not add a
>   leak (Zhongqiu Han). No code change.
> - 1/3, 2/3: unchanged.
> 
> v2: https://lore.kernel.org/all/20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com/
> v1: https://lore.kernel.org/all/20261122-cpufreq-leaks-v1-0-96fc17ff7339@gmail.com/
> ---
> Suyuan Wang (3):
>       cpufreq: highbank: Put cpu clock if clk notifier registration fails
>       cpufreq: kirkwood: Put clocks on error and in remove
>       cpufreq: s5pv210: Fix resource leaks on probe error paths
> 
>  drivers/cpufreq/highbank-cpufreq.c |  1 +
>  drivers/cpufreq/kirkwood-cpufreq.c | 15 ++++++++++++---
>  drivers/cpufreq/s5pv210-cpufreq.c  | 12 +++++++++---
>  3 files changed, 22 insertions(+), 6 deletions(-)

Applied. Thanks.
-- 
viresh
