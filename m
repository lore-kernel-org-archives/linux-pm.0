Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160660;
	b=IG770U2Udtw75tFsi8oEzqK/41yVhODTsGvZ0yR+XiNMq2urYzpSosMonVfKESk7g5Nc
	 b1SJ9ZItwJCBvmiTQ/BO066Yy+Oa1LRJ/l+F6+yN75FW4mCjkQYuR83WmDLR719rPv0fi
	 DOql2S0DBLo6DIHIRADsjyBwHPDo+9nCrsBF1F1kxNqKBSblQq8+Lz1ww/G/9IuLpLAIR
	 42CMew7lz01T9Ixsrh6TFwNK9B9KHY2Nk9jJD4caxmr6jxn3peRmbRO2+lYl0DPIk24vu
	 8BhukTjsuoEoN6eCIUxOLUkMyRJo5XRaFM8zxjJL556RvtSeNXNO5c7E9/GDbOQOETA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160660;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YhIr5RkufI76Hp177M5SL/nPXC4WeO/bah0MoOu9yac=;
	b=RrK6/fb3M7ENFLox8ZHmifL2dDTFAPMkYn3N3rmCQJFzn3DXP9YEYQqnZKog86H+KkZY
	 BjMQKp8Y8v92YPXGDkb7AY1a975eZLGgb0/q7aY78knTwRH6Lb1ax7gp0QJ5sKsoXpTBh
	 k2R7EwRPuRukn/u6KjpEDbkq1W/lB46essWjvnu21JKGVi/0HP1hC3hn5Yde6r6Q4sPv+
	 HxkkTafoVzmN3yRu/nVCrBpdkkehJFsWIPckHPk8e/NI30rlII7YOgfei7jIVjgpPJoZ/
	 EpcmO0W9QdCh0eF8Iftsf8LMa1nn+QD5Np12xTDmeGfm8vsB2TSViBdjkzhKeevjd9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MVdH0dbZ;
	arc=none smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4382606A33B
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 07:44:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4382606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=MVdH0dbZ
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1ae58d17cd9so617493c88.1
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2026 23:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1795160659; x=1795765459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YhIr5RkufI76Hp177M5SL/nPXC4WeO/bah0MoOu9yac=;
        b=MVdH0dbZECMyRVts4clMgTTtsiSNkQYMFVjvvp2uQ0gO+y1c1szeDBPX/F8uygQrj2
         SbfdAavURbpFr4fbi+sgpKV6Tddic53/AVIVaKgT8cps3fcivdrokWALa1iMft0nh9GS
         zybLQByYLe3b/CeAFZsS3ekpM+tsWIDsSuXTz0AcHjctFr1lue+uApIkOIU/GqeNqyXg
         cfYoslTPciTg5C51zrlXYz+BpV2r9fJPjsQOQ0Av/l6rCUmF1q0SqtRXDkV4d16oFXof
         WGYfZ2nyv126pilNMGwRY66ySZPAo6Dfw/gMG2s5Jfdgiwkeo+j3ZGp70xpYpx4KNoK5
         sP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160659; x=1795765459;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YhIr5RkufI76Hp177M5SL/nPXC4WeO/bah0MoOu9yac=;
        b=NT/tZsncYKWEDYHjV/DHo3UveVhRct5Cxd1XD9Y0MK0nddQPCApQKiBajS2Pu/mdUa
         gC+HGeIqgw4wD507Jqk+wLrZtR1UEMQyQKD830xeuWhTi9JlTR/G5MZ0E/BQKF3+RfCW
         /v8ediWaNMU9ZknxwMB4cgL226E+1qTOxssDJNkE1D0VrBGCh7bab/AjZEhzBqmuJxkN
         Nol9EGzKsGy8gUChmbTJEUMTY7gLqxemTgZNXaOEK/nlMcYWU1oLeMK2g062YhBzwmEW
         oIEGJqEp887yxX4pNWy52Y3z6UrwE/AAeYnQp6Rqfd9aFYjSS5CWsn15U/6VTuVL8WPA
         po7w==
X-Forwarded-Encrypted: i=1; AL+hErEGVKkVjKMkaFdjpF20b5zXkksne00OVQjH8cbLqIuoAk56/DxnEcOBcm7P7boJ1MU9qSb92aSjag==@vger.kernel.org
X-Gm-Message-State: APuU4Z8w6l6cfUWwAwQi7Hu7+KAm8HesS6R/P6Ib7C7L8iAwHrikK5Rf
	b4MidlLX8a7uyMIjyOBWvzkVHCs2PjP30G9PN3bJYjuxPLQ71cDJLrzP/HRAKdI5yPc=
X-Gm-Gg: AYBFou2jzDarg1tclgrhAtqpLwThZiIIRUBqdYXHNCN3eFUAEycVv9YpxW65HJg9f5j
	VYd41h5u/3CRl4Xdy0Y3N6+uvtmXbru8JdAg3P4xR8AWJP3T/ilZCTCU8OURILhCXmi9Q4JJjsN
	iZnZ1cE2BqfeESgDZPUIUKOVNp4qEZH0FiaXrm0dGyb4P7OV/P+r51+Rf7TYoFQyQ3KZVdtF6xS
	P74tfyCMULsl2NTfmW8nvUn3HBpJJoy0xPFr89CKKMrPZuv4/lNqpBWnVFhvzCRM2hdzHeyMtNd
	qzIu5R2Y8qwEIqd3btt+GX/YjJ5rwQ2ulXuftc/XH+QsYfoAyvUq3nDUJoyd1FOmmOwTQBrIXcB
	pHH9wDoxFceQfbeQ+5suY8EuSwfXISk0cXFt22QeMnl6P+VnPJRgZrlUI8LTdKTEGcVqUWFwvGL
	/yo2Kw6JCgNOqxbgexmoziTvw/jrdmPguM5c3N60NI0uNkEpEJiIoJs6Lj0e9dZJ772NRZSL6Zj
	Q0w72P6NdBGdfHsfQ6CBfZNH/AABWBRoqEXRmKLWgJVn6d1Noym6dazebsVQlQmTnVJW82eZa7X
	ZV1FCRex9IhbEIJSo3ISy4R/635nxw==
X-Received: by 2002:a05:7022:f50f:b0:1ac:1022:b60c with SMTP id a92af1059eb24-1b5567b2091mr1764911c88.1.1795160658571;
        Thu, 19 Nov 2026 23:44:18 -0800 (PST)
Received: from localhost ([122.172.83.36])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556831d45sm6769427c88.11.2026.11.19.23.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:44:17 -0800 (PST)
Date: Fri, 20 Nov 2026 13:14:15 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: rafael@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	zhongqiu.han@oss.qualcomm.com, conor+dt@kernel.org,
	treding@nvidia.com, jonathanh@nvidia.com, linux-pm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, bbasu@nvidia.com
Subject: Re: [PATCH v3 0/9] cpufreq: tegra194: add Tegra264 support
Message-ID: <av_6T3bqEygaKK3q@vireshk-B250M-D3H>
References: <20261119111217.902071-1-sumitg@nvidia.com>
 <av_R-8aMX7lL83ln@vireshk-B250M-D3H>
 <61d207b2-3155-4613-bc9e-588c68f276fd@nvidia.com>
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
In-Reply-To: <61d207b2-3155-4613-bc9e-588c68f276fd@nvidia.com>

On 20-11-26, 13:06, Sumit Gupta wrote:
> v3 was on linux-next, which has commit 4dd10fbbeb9c ("treewide: Convert
> devm_kmalloc() family to the devm_kmalloc_obj() family") from v7.4-rc2.
> 
> Your branch seems to be on v7.4-rc1, so v4 on it would conflict with
> that commit in mainline. Should I send v4 on your branch, or would you
> prefer to move it to v7.4-rc2 or later first?

I moved to rc2.

Applied. Thanks.

-- 
viresh
