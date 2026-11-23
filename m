Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795412095;
	b=smvebM85Xd4wPa5zlsBGLLD6BLzZ+WlNehIXgCCt4y5WvLWDojWa28QqIJJt0qNt8zTE
	 WZf4QqF1zIRcMaYsrlZCCNUXrCmkAZ8yKrMWDx1ZNgLBfbn/vs3SjU9ytETHMSU/9suem
	 KVL24RnY+uqRTqgU3wCna8gUQL7ucJbaHAeVDqTck4o46eDxg+ztanG3ND76sG3qcqspw
	 oP+GPk5rKtxq4bC5yUpYQ9Nte891/zGCL0K+YhCEZBa9aD+CjRfzqch75exGADO3NSngA
	 yrfvUH19pfxzH1etxeGgGCIp8VVkJcohLq1OyW9ybQGQwV+yv2qmVg+gB9O4ywlMZHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795412095;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=JW3ojJgWSSpYVKAj1rpR53Wt7zgOalc2QFQ9CWv61+4=;
	b=dZgKqKMrv+atuASx4I2I2xZomcLE5nQi3C74fweMu7UPcqG8CvgD/qYyc5z3ew+8AnFl
	 bfEm0fw+4aorNSizDCdS/hf+nRlv5p9D1d5BzWqAZtJ54vUk3JlMsxRdUyoRwiur4lxy9
	 8iq+CzNz8IeNx4/Dzf71jlLfjo3rlsZhDDfqvd0Whgg1gtwHR0BhiaX+PIuw0wLvhFEFK
	 Zya5VdKncblpNUai4T6rI4r4hq3+PIN47CZB3d8d+xhPQOlpN6R/5eWbC77e734eiX/Kh
	 l5r00mVXxBlNxqr1HY6DOJhCLKclb8ZRLKwlytcLlnZoTSoEforXb34PkYgLPJPa4Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zRhWVqwP;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99B0606A31F
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 05:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C99B0606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=zRhWVqwP
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b546061d58so6584479c88.1
        for <linux-pm@vger.kernel.org>; Sun, 22 Nov 2026 21:34:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795412094; x=1796016894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JW3ojJgWSSpYVKAj1rpR53Wt7zgOalc2QFQ9CWv61+4=;
        b=zRhWVqwPzRdS/S3SNWc6pwEH2rZiRiN1XxRt0Y7KM5Q6Fi710yUMjd4YtxarNqt3OS
         ktE28kOUcVycRnFnsqYdBhW3ccFDE1wODV3eL2dtbGGTHezxLtT2mi7jCscT+eRY0PxI
         x39GN01oGijKwbCMqk7V5ytBwIuYGuF5Q+mleloxdbRncsb6FVZXYcIFIS+ldK3FiJ9q
         5xrT4mwHcTPMx8s7k8COAd4eEHRNDdgFl7Hr35FkJfeH5vElDmse0ofxLKthcp+r6qVe
         Vc1kU/gWiYRu3zVYp0PRZC6n63bq1EVi76ixJhkMxZ1tRdvtpV89u9DsHRRSFKuk2qS3
         TpMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795412094; x=1796016894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JW3ojJgWSSpYVKAj1rpR53Wt7zgOalc2QFQ9CWv61+4=;
        b=KAzNlBVsYmvEIFxFkCsCvQN44WoDVM2u0sT8MFuGEu3zf2pY0JURJsTQHngs7Ldj8n
         mrknJD0Q/tXIQtYMHQPFfU1IVAiAN5N+ZqYrv/VoldjQE3/1zezaPXiezO1BVuA0JbZf
         ZKnfdENGrfZita7Wp4VYomiFlkDodk85OCQmRGfobfbfYplI/e8RgNho4wKpZv5Z8fUs
         AN80Nurfy1n0kw4Ey0OGVOwC+3GyLhnQXlOJjJH85ehLgPDYb4iTWYdnvF4c/TugNreY
         bqPHV7QV+yfHrgvCjCpeDa5rZrrXgDOFBLHsiqE+DT+zy0fLnLN4+qCuV3N0z0S3319s
         6MLg==
X-Forwarded-Encrypted: i=1; AL+hErGXnvQSXJ3njcvf2OYebmG37wt1F2QkZQlw957aMcJx+22Jp7X/GixgYV9lia3yfAQfAw45xH68yA==@vger.kernel.org
X-Gm-Message-State: APuU4Z8xxVf8EPYqQCKkFsMuzrtbV4031A4Fr4p/P3B6ehfDHFK3U6ms
	a+YR19SQs/padIyGi1xaNDghSJQZLXYwJX5zjMe0nbH0vP9ZwH+VbihfUQao6ACfeBI=
X-Gm-Gg: AZFdTZdlx+F4IXnT0AXzoiqsH5mebAzu7pQ2SAyrmS9yUIImwEx7WsUqrmT7otOPHNh
	lTc+I9hPIUqiABWwnG1B0YB1cmDDTEDXhzog7zuDJo3RX3dQ03VT7QLl7LXPaBajl/ukNdJZjuO
	FDptS4fVFKRGaDOYuHNSm3FYtYp3fGlnFXBLFeRaM1q84+NpA9JhVWSGCOvb0uQPPz46hsSePd5
	cDFDwoWRrCZjpkdI8pRyUhcFMkC8+izS19MDiHcJlDURgKTUhJOHgj6Xb13VxyZjy03X4Xyk5h9
	sX3MbBb6/3upCwdhpx7UhkuZDlmRYXy7pXJEG8jd2sNmi3bzU//4r+kPqyjvZj+pN5KCel6BNWf
	y/bNwMHNAvpTmgPXZ4qYjI3IZkvJ6zVu/OwdRRHV7Sfb0i3lRsZ1qqbS9Ck2wJp1h01Bc4pXRG+
	RIEwNQdcv8HinJM891JXPBr9gZQUoxYnCxVsYa0cHXRbQb8zfsTFk2XBc4JEBLRTH3ruuCPm+3b
	eudoe6uzdsJkPsJdluUSuA/2UfnSDMwoZ0hEGpQtL016u2lwrprqbxXGJy/twIzARlYygwHvp0Q
	2jDGkP4Y6cvObeSZt5YD4Hd5Lljg0Q==
X-Received: by 2002:a05:701a:ccd9:20b0:1b5:7351:955f with SMTP id a92af1059eb24-1b573519624mr2091488c88.27.1795412093505;
        Sun, 22 Nov 2026 21:34:53 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5569bffd2sm23537896c88.0.2026.11.22.21.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 21:34:52 -0800 (PST)
Date: Mon, 23 Nov 2026 11:04:50 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: shyckless@gmail.com
Cc: rafael@kernel.org, peter.griffin@linaro.org, krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
	linux-pm@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: Re: [PATCH v2 0/3] cpufreq: Fix leaks on probe error paths in three
 drivers
Message-ID: <awPQeliuPmaBF8cG@vireshk-B250M-D3H>
References: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>
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
In-Reply-To: <20261123-cpufreq-leaks-v2-0-29277f2f0ddd@gmail.com>

On 23-11-26, 05:21, Suyuan Wang via B4 Relay wrote:
> Three small fixes for resources that are not released when a cpufreq
> driver fails to probe: the cpu clock in highbank, the three clocks in
> kirkwood (also on unbind), and the regulators and register mappings in
> s5pv210, and its reboot notifier, when cpufreq_register_driver() fails.
> 
> Found with a static analysis tool and checked by hand. Compile tested
> on arm (W=1, multi_v5 for kirkwood); I don't have the hardware.
> 
> Changes in v2:
> - 3/3: fix the Fixes tags. The regulator and reboot notifier leaks come
>   from e8b4c1986efb and fe7f1bcbff91, and e0e5b2b4f427 did not add a
>   leak (Zhongqiu Han). No code change.
> - 1/3, 2/3: unchanged.
> 
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

While sending a new version, you need to add the tags you have
received so far. Please resend with Reviewed by tags you have
received.

-- 
viresh
