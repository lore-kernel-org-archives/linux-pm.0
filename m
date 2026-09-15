Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D386333064D;
	Tue, 15 Sep 2026 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789512429; cv=none; b=uHLNQv/XUY1nV2COu4Gj40lRVXCgCUNyoVNehnmwtViHIy19dhJKIPrOxsh0PbS+b5azmIpCISlwtAJDRdGvvyx6lp4vTMPMoZIcyZ8xrFETGBquaAz/EHkaf0J2p6R3epioPxEkhfV0MA9F2o5ZoRmPbDLVNEAmZTS1vGgqhFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789512429; c=relaxed/simple;
	bh=09bEKkrAQ6evoRQnE+/6I6r4zrScGTzu6bRQiAt7xeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U6/jfhWImpqHUnfwv39z6VNOBneXTDjo+MPr1Ilk+6JvKpLQjWsvRrD5WR/jxLdpntyOQa3Q1qMQMOcAmX5/1+s2v3HY123vHfA4SL2HTFrJRHG1l1fkK31pIDKP7eo3WTears8Zk7EHHPI4LokxAHf/FGOInX/v8EccPIh9niY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UOdbI1PU; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UOdbI1PU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xOQT/3q2OYyCT4rjMqHcsKLwm9oUZFfMFiMm4p6KLC0=; b=UOdbI1PULOKFgQAcQ+Nf3vezGJ
	dJNwppl2Od0Xe0VBQNzp5dV8/rUhortlGp0SfhG6VzHRRqFZKHM4jQd6S8r7gL/Ip37thgbFilowE
	XKsJ+IP4bGzX6nCAesqCUuplp+uFrwAYo0OZAdJu4jYSJgzcSUdcGyriduiqqJW25wn1tPq7UcwY4
	1SLFSsF6MPdLZHZ5tGMSxzLEYV+GjwPrQDvRi8Fnxd80BgCGHtSGrWIvtS+QUFJ3WvQP/R10vwTRN
	d/IcaGMnVz1mubHBxWdshKM0q8FkGzTFVl+WvxrmXX70NqiFb2S/o5Qds0toL2RmuqPP8sqDIVLhO
	MX1sE59A==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x6bvZ-000000082HU-2IjM;
	Tue, 15 Sep 2026 22:47:01 +0000
Message-ID: <fa9f518f-e10a-41e4-99ba-b281741c22db@infradead.org>
Date: Tue, 15 Sep 2026 15:46:59 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: power/cpuidle: Fix repeating phrase
To: Syazwina Fazrul <norsyazwina.fazrul@gmail.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
 Christian Loehle <christian.loehle@arm.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260915220105.14655-1-norsyazwina.fazrul@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260915220105.14655-1-norsyazwina.fazrul@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/26 3:00 PM, Syazwina Fazrul wrote:
> remove repeating 'with the' phrase
> 
> Signed-off-by: Syazwina Fazrul <norsyazwina.fazrul@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Thanks.

> ---
>  Documentation/admin-guide/pm/cpuidle.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/admin-guide/pm/cpuidle.rst b/Documentation/admin-guide/pm/cpuidle.rst
> index be4c1120e3f0..e91ebd432f6f 100644
> --- a/Documentation/admin-guide/pm/cpuidle.rst
> +++ b/Documentation/admin-guide/pm/cpuidle.rst
> @@ -316,7 +316,7 @@ interval" value.
>  
>  Now, the governor is ready to walk the list of idle states and choose one of
>  them.  For this purpose, it compares the target residency of each state with
> -the predicted idle duration and the exit latency of it with the with the latency
> +the predicted idle duration and the exit latency of it with the latency
>  limit coming from the power management quality of service, or `PM QoS <cpu-pm-qos_>`_,
>  framework.  It selects the state with the target residency closest to the predicted
>  idle duration, but still below it, and exit latency that does not exceed the

-- 
~Randy
