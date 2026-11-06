Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793987539;
	b=V7u6FGNsB1h17mNYtIl1fenbHK6TxPnzbXE7gT73QsCUnxJQDp8nWffkcLqEgPTLTQtX
	 4WY4QM0J9wGu07NhG+WRNpKOo/FegZMCtlTOwm3Wox9pIq3Vp0KI8jclHe0D0Py5Spv8H
	 QAuseJxUiUcnZwt5kV1Cb5164qox3zoqp3llbDRU9nqs/FCtFZU4/tdwUKSSpuGMUktbs
	 wTUf/m+OkY+ILZZiFzgqNxgHRN6vWBy7HWhB1Dp89juDpnGeqzPVDk658/SPHMw8CFOT5
	 lGuTNOf23yHDkHsmhxbxGcgYXXxmVxl4o2ldamIgVKR52eYFAxuUPmX9x2AJwBzOK2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793987539;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=OhbBWN1W+Znxr4DvvAnmIHPGTVMobupDzycWw/6MYfU=;
	b=utMF8NvECijuPiMz8A6FfJ5SxfI4CN1xOiAqmN2hJLY2fu+648aM51e/YmUQVAbNZgVd
	 NZ/WNTl63fHkkLqnhoMj4eYCkOLOO85fNPUKok8g51/rFlOQLqtV9vW3Jw4p1fx4NopWi
	 K5DU48tItau64Q4pxguxgIKImH8cMfgJEgHuX4MqH9XGE3X0NjBWTZ1n85SD2CzjJamQ8
	 xd53225UQDA/cXLyghDIegtBQvt+xsmOgsJUjZxDImxkwU/WHayYJX6hi9QzcgPN1n1ct
	 nsxYUT88hGoIeJrxZN4UnBORZUY0fGbA9CxoCxdDLCttWGq0sQI8c6JM08O/c8D8wxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YZJ46xaj;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF913606A329
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 17:52:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF913606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=YZJ46xaj
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36cad25b8b0so1493684eec.1
        for <linux-pm@vger.kernel.org>; Fri, 06 Nov 2026 09:52:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793987538; x=1794592338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OhbBWN1W+Znxr4DvvAnmIHPGTVMobupDzycWw/6MYfU=;
        b=YZJ46xajYRMnoiAIc6MB6PeAo7kxcTJ/gpUv2GOhuoOq6UJohaRpfLi2Q8xyR4Vplv
         IWCaVC3CZpqNzu1Ea702TaZsJ5uMZD5kgJlt8v9yee1JMrnzZHhG18Yv+fszjHXSc7dt
         X8FbMSt9qZQh2MAwQJG/scljBsX7TF3jC5bPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793987538; x=1794592338;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OhbBWN1W+Znxr4DvvAnmIHPGTVMobupDzycWw/6MYfU=;
        b=1rkBEUTXcR114Xpp58krIGYg13PoioDrpU1kRnxhXWCXCKych6nf1fvEyQLJnyOVlE
         ++SGm61R6rtqg6iyTYnuhd2W85JvlqLcDCPq0zYAQeHYs5R3BetVmO1SHVsHp8ZCprEp
         d5bPf+26pQsjZkrLgGmEeso2UD/KoKQA6/yj0JALIpV2mtpektIrkZs0r0Vs89MEbmJb
         MB4E7TdMTWckYg8GMXA2NAAg+tGd87TdFjACFSg/5RyLLOfQ9Oi2ciGhKr4SjOZIHqYc
         U2b/QlnxWrCfEBVqJ6sG/abu84PI70QpU9VBS/An2u/XEfDPPoglvnunCOmL57fFWv25
         M/hw==
X-Gm-Message-State: APuU4Z96XnciTVI94Lsk87eerbOcWzKHanEzpqak2H/AVtgXzLOwnGTO
	10pGb9KnDaw3YRXHBlHwRTvEx2m1AqUN697gWA17uOJPPXMV75fhOpfekXMvwRSRxg==
X-Gm-Gg: AYBFou0l8OO7z8+VK06cpP7GWiveL9m+GoNdgE32hEjV55/1i1Izi3V12HG7piGFFpM
	En22p4X4GT15RSgaxgHa6mr6pa3PYbxXvkv5B2S5e94i463ltTwiz4ApEF7tOht09MOY8eUMWkj
	qDmXZcJvFTfBqDrTn98+WBZBHJPDFli4guJ/2WCnP3m1b/6d0JltyWBrOgTc4Wiro3dvVIyYBCE
	3yGFyDZeP2SoWNSPZ/Z+NMBZneaDIjC7tvmYjIGiXoueSVO1vbexSAlA0LpfYkfRDwpOJ5Au2YF
	sxHmga5TmOMF1TwUH4TjCioV/IG0+F+q2m20pX0fJetygLO1NsCK5R+Rme36JCUrPpiUvl13YA1
	Z5fydrcQDb2XfyB0dqL1iC2NVTKyP9fZKQwanyrwjFFKt+NcK1AC/X59q3YORsYtMv8268taZEX
	gmgZHyCj+/gY0ir215qvoNWEkxlItL8Qw2vmEzT0cCTOVk1/4njDDscaS3C9OoQVcgzECbe2vc8
	E3j9+y+eZJwBlfUgbkLusQk+uJCZN0VIhLP62yWaC6/yrTOwZrSRC9uHzraX2D4NEN1WFUnpY2n
	8WZgGKltStQSYfuaIefekqUc8g4Kw15XzjddIvBfB6RwRMJHLt9l2u+DbNT8IFBKomo=
X-Received: by 2002:a05:693c:884b:b0:351:7e5d:2de9 with SMTP id 5a478bee46e88-36f723e73cfmr640732eec.1.1793987537573;
        Fri, 06 Nov 2026 09:52:17 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:bb6d:e00d:d359:7933])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-36fa9be7077sm8332172eec.17.2026.11.06.09.52.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 09:52:16 -0800 (PST)
Date: Fri, 6 Nov 2026 09:52:14 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: Re: [PATCH v1] PM: runtime: Update last_busy in rpm_resume() for
 active devices
Message-ID: <au4TztbFDYqWR2BX@google.com>
References: <13032301.O9o76ZdvQC@rafael.j.wysocki>
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
In-Reply-To: <13032301.O9o76ZdvQC@rafael.j.wysocki>

On Fri, Nov 06, 2026 at 12:31:41PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Setting an autosuspend delay for a device can be expected to cause a
> runtime suspend of the device after calling, say, pm_runtime_put() to
> be deferred, so the time between the last successful attempt to resume
> the device and its subsequent suspend is at least equal to the
> autosuspend delay.
> 
> However, that expectation is only met after the device has been actually
> resumed in rpm_resume() by invoking its runtime resume callback.  If the
> runtime PM status of the device is already "active" when rpm_resume()
> runs for it, the device's last_busy timestamp is not updated which may
> allow a subsequent pm_runtime_put() invocation (or similar) to suspend
> it right away.
> 
> This is arguably inconsistent and confusing, so make rpm_resume() also
> update the device's last_busy timestamp when it finds that the device is
> already "active" and it is about to return 1 early.
> 
> Fixes: 56f487c78015 ("PM / Runtime: Update last_busy in rpm_resume")
> Link: https://lore.kernel.org/linux-pm/CAJZ5v0jTX1FgeS9FCV=+V4uacSgLQBVsSPnU27ybgUGg57GUOA@mail.gmail.com/
> Reported-by: Brian Norris <briannorris@chromium.org>

Ha, I suppose you can call it Reported-by, even if it's somewhat of a
tangent IMO :)

> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Brian Norris <briannorris@chromium.org>
Tested-by: Brian Norris <briannorris@chromium.org>
