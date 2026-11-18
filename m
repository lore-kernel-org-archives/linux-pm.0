Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018067;
	b=Z7/0Lb2Ki2dIr+q9wX0KQn+wxy409WhTAsHUCpzvK+OLPHPTkBELkX1COWyFVzmwyYvP
	 Jjgvf5rtIdTln84z93fZg1mMxtJ4fTvDon25tRNodBGy6v2yl9WCOkAauWWlOI9jtG5wy
	 UuZiKoi2LWAZBoDudTAjQ6jQym3+XhWRCGiW/EQytsGyR4lDOh9VDSAPx0z3CpKWF55/Y
	 38bGWRpf6FoyHtnFnygDG4MVdamafBrbAAwDa4foJ4XdddnXUysU/55s/IxqipcFv5GuP
	 qsigRNpUyNWhw9/8A8ljyNn2RlZl52/S6vd/S3TE6OcS8jErMig9+aVbtWGuQZe0H5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018067;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
	b=sZqJKLaxxJb1ZpLwUtcjpOIoOCF3A4zR0FE7tun9LahTuHO1Aju5gHYcmohq7IxZ41Q/
	 Ki4eWdn8G7i7MbG5abUM8M/czuhKiJAkHLAKoxUbzumTFaSdBr8GhiqyVqbr4NrLSMki5
	 qLs8iaokNPvt2N/rHYALL+uhQzmHaN0pxf4wVbUURqiXRZbP0OajlQtwQ1PUtt40GLb3K
	 UOybzlZZlxg7BV3H3W5422Cj17jUvQJoAdgPBTu/R/RdowRR2X4LWUKTYcWUoOSPMKMva
	 2j86OEAZQJH6w0XBspzkE5e+27H7hMMaynxMPo211RIgyV7R1BZd/mS1dRY0th/C2Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut;
	arc=none smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA97A60A3818
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA97A60A3818
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=rfERdRut
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4b563403c7eso353917fac.1
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 08:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1795018066; x=1795622866; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=rfERdRutCiY1Lz5trk/rT3JitdkQbyeRpy92SAEBTr0SmwHHW7GjbVlsL6xi4GLvlA
         eIy6I8HWFFPJEAko7lPdUqZJ0ASfQs39uGsb2kxFW41b1JV5vmuNw7JyeQ7RyefPZ0K/
         9xQMAXHoHzpNH4wuyizF2fSFPUA4p28V42dt2F4Kqw0BLpetMDyzdYPIEpOPJPmRoJPR
         CA0R4B7acExX6CwARQsZdifC0Die7wBlG1RRQSCl2BNtFRelYwu0NbJSKXPCQplp7vXG
         14ey5H5NU8zd6o0RiLfoiNrrbcb/neM2Pssr4bC/1VTI7DlntKS58QKULJCOW7HRil/c
         C9OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018066; x=1795622866;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=miZOpsXXWqTDg4brI3XNa3nMkTf1a4j0jITu5ECiOM0=;
        b=RYQmuynWFra2TdnxxT02yMmIcRQOImEVKWCJ0groXH96eWbpmxfdyi0bDamsZCD/Fx
         /5QsGg0ENnZbACAfIjOoAuiD/1fXublOiS8pgIioBufM3XWv6HNPKLpckMQKC/dKSxYA
         4aBGC5wFMcIu1CV+aQHY1bzz4Y75YszKbg2XUXr+R72fZmSGPTp0ITlArlfY2Xan4S7T
         ywOPyldPotRGe+GPYkDFR6LZkYFRAZZMe/yROeNd9usV64Lb51jIYMgzYi+WGQyCB6Rj
         6td9D5rT4ISaZbMcNhcQMRkJvMBy/6s10Fd+5xaWSWedcCS/ZXy05qjlO/iKSytgzmD/
         iPfw==
X-Forwarded-Encrypted: i=1; AL+hErE0HruEEz/8/0eRRHfRuPpV67Gti26OpLGaTnRA1cOM8Fn5aVWTi8tfBUdC0bhycPBWhNQf/ZFcjA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9tqVKCFjTZDOUByScq3exQ74V42jeE5tboBbkkcmA26nBq4zQI
	a8kmP6mFJjPNf/JrPf9AlKL/S7h2pM4feQt5HQt/2hSIZiSyGjnumU9pAbf9mZFjqnHWLiAmAMR
	E9SS/DtM=
X-Gm-Gg: AYBFou2VfqjY+1Y31yQnE/ty+xm5Ei8ltC/O7Q3lntkyU0AHqv/VHzojQvyh/EFv7K2
	cFxgiMHA44idZHFETDIvshsNyvozqF/1RdhMWNmDDFkkB1CNgFRpamLro07TlytEPc0SMhy/oEs
	p8gb5mj3TZ/xHdHb8XRTmaNmx6R+pBEjxbLuscYS11TXOxbAxTOCi0O/I4+PyJ35uHbYmDRPa4U
	6Ia2ph2ZuIOMvGQvkD+Twczsk2D+5wrkvhUfQH7bJYt3+VFs42D52imiizYjDmrEJ8xWVDaVrmZ
	1nav9WJ5EjGApM0CNN0fkfQhjKNCSwOekZgk+PhWFWcyNa8NAw1xMLiEITC27t+VOYkYbOsBDCS
	ZWpY7404WlQdWLZ9KG3Oc5Ld0nn8OHILt5VRvwy8QHzyXuE32/BBWUqX+vFjF/RRJt2Vw6sgQKs
	ViLV2D4C5ehMRVLA4d5MsfI3BUaycjen9EqEGgPKo9uesdxdTKWPYGUtKJhgq5MJSM4A4CmMFSI
	JSEVOGpWx+pUHoYamg7/cNIQpdgB+73/k3bjvfezYYmGabjSPckEkg6O8aXlw874HagKVXfV+Sy
	2wYvsyN2uhlRAyzvC0A5TAHPyaqWNQP6Gz2lti6Wa08raVynRWRrg94joI4WcuzMvn4yigliWDW
	tXHeOBcmcpnYkEPWFbgOQ4o3xmpwIp7dTnt7LUIx8ps3B3DXMOBjbu7z24tobGmWCSsRm6NZo
X-Received: by 2002:a05:6870:8920:b0:49d:c8ab:967b with SMTP id 586e51a60fabf-4b7620acf02mr2521246fac.47.1795018065606;
        Wed, 18 Nov 2026 08:07:45 -0800 (PST)
Received: from [192.168.11.112] ([96.43.243.130])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4b743721fe9sm2624231fac.6.2026.11.18.08.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:07:44 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Stanley Jhu <stanleyjhu@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, 
 Brian Norris <briannorris@chromium.org>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Praveen Talari <praveen.talari@oss.qualcomm.com>, 
 Alan Stern <stern@rowland.harvard.edu>, linux-block@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-scsi@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20261104112744.1630864-1-stanleyjhu@google.com>
References: <20261104112744.1630864-1-stanleyjhu@google.com>
Subject: Re: [PATCH v2] block: Keep RPM_ACTIVE in blk_pre_runtime_resume()
 when already active
Message-Id: <179501806424.17649.9429091372346585775.b4-ty@b4>
Date: Wed, 18 Nov 2026 09:07:44 -0700
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Wed, 04 Nov 2026 19:27:44 +0800, Stanley Jhu wrote:
> Since commit eef1d74bf88f ("PM: runtime: Only set runtime_error on
> suspend callback failures"), a failed runtime resume leaves
> dev->power.runtime_error at 0 with runtime_status set to RPM_SUSPENDED,
> so later runtime resume requests run sdev_runtime_resume() again:
> 
> 1. A runtime suspend increments q->pm_only from 0 to 1 and sets
>    q->rpm_status to RPM_SUSPENDED.
> 2. The first runtime resume fails in the driver callback, and
>    blk_post_runtime_resume() sets q->rpm_status to RPM_ACTIVE and calls
>    blk_clear_pm_only(), decrementing q->pm_only from 1 to 0 so recovery
>    commands can enter the queue (intended since
>    commit 6e1fcab00a23 ("scsi: block: pm: Always set request queue
>    runtime active in blk_post_runtime_resume()")).
> 3. A retried runtime resume calls blk_pre_runtime_resume(), which
>    overwrites q->rpm_status from RPM_ACTIVE to RPM_RESUMING, so
>    blk_post_runtime_resume() sees old_status != RPM_ACTIVE and calls
>    blk_clear_pm_only() a second time without a matching
>    blk_set_pm_only().
> 4. q->pm_only underflows from 0 to -1 (triggering WARN_ON_ONCE in
>    blk_clear_pm_only()), blocking non-PM requests in blk_queue_enter()
>    and __bio_queue_enter() while the device is RPM_ACTIVE, and the next
>    runtime suspend increments q->pm_only from -1 to 0, letting non-PM
>    requests dispatch while RPM_SUSPENDED. This hits the UFS device
>    well-known LUN by default and SCSI disks with
>    manage_runtime_start_stop enabled (ATA and FireWire sbp2 defaults).
> 
> [...]

Applied, thanks!

[1/1] block: Keep RPM_ACTIVE in blk_pre_runtime_resume() when already active
      commit: 657d7c48b84f2ef0bf885b47cf2318823bc72970

Best regards,
-- 
Jens Axboe



