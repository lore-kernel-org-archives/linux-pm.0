Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE893A7F52;
	Tue, 31 Mar 2026 06:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774939507; cv=none; b=be0Hxdes6jOXNaWqeJLSKAC3puIpWp3AtYrItQ0ocjCq1dVVkRDC4olEmTaJBfl4qBzUm+w0Cmnx3Q1lHrWXfHIZAmUTBCtcmqNh0x9mlNdll2WxZkZoLuxKt6lwbIZmtBI8aoxkYQESlUTuTb6fKf8aMa/U6qVWjvmKZ8cqm94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774939507; c=relaxed/simple;
	bh=UJPDCQGho+cB8NoQ3IrBIyqzHB96chbjw0XPqjShjfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ALAZ+znCxz0O4Zt5wheWIatXeI82A7vbK/xeLNjh37mjaWqo6JhYDO4K3qtjlOckoSl/IbkKjMsdqN8nkD0rQM4wQy+ftqEqnTT0LbnhYRx61VGxbMEAoxyiYpsS2LJge6zzC9AU1Ngi7HFz38r0s+F5MfUmrWnucnWrb21L71A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=N3pTcyxv; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="N3pTcyxv"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=W8U3w9BWbpd4stCsKJWLINgp+bKDuAkU3c4MY+SKr7I=;
	b=N3pTcyxvVPncnPZ6VO4Au35DMCY8/FvtOMP+3lMu1IPoYZTANFtw1vnd30oiBskIgSgl3LJ4N
	NbR1OBVikTtOhZaephM09BwNtQvW490SzQP0vDOfwtw9wxXx/Dylq6ccyykCZWG9OaJZrbwkNY8
	WMuusXDpwqmojt7BSW91kCU=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4flJNd5XM7zmVWp;
	Tue, 31 Mar 2026 14:38:41 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AFE740561;
	Tue, 31 Mar 2026 14:44:52 +0800 (CST)
Received: from [10.67.121.90] (10.67.121.90) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 31 Mar
 2026 14:44:51 +0800
Message-ID: <fbe74184-98dd-42f8-a851-8a8b5d001f1e@huawei.com>
Date: Tue, 31 Mar 2026 14:44:49 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpufreq: Allocate QoS freq_req objects with policy
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Pierre Gondois <pierre.gondois@arm.com>
CC: <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, Zhongqiu Han
	<zhongqiu.han@oss.qualcomm.com>, "Rafael J. Wysocki"
	<rafael.j.wysocki@intel.com>, <linux-kernel@vger.kernel.org>
References: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
From: "zhenglifeng (A)" <zhenglifeng1@huawei.com>
In-Reply-To: <a293f29d841b86c51f34699c6e717e01858d8ada.1774933424.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf200001.china.huawei.com (7.202.181.227)

On 3/31/2026 1:03 PM, Viresh Kumar wrote:
> A recent change exposed a bug in the error path: if
> freq_qos_add_request(boost_freq_req) fails, min_freq_req may remain a
> valid pointer even though it was never successfully added. During policy
> teardown, this leads to an unconditional call to
> freq_qos_remove_request(), triggering a WARN.
> 
> The current design allocates all three freq_req objects together, making
> the lifetime rules unclear and error handling fragile.
> 
> Simplify this by allocating the QoS freq_req objects at policy
> allocation time. The policy itself is dynamically allocated, and two of
> the three requests are always needed anyway. This ensures consistent
> lifetime management and eliminates the inconsistent state in failure
> paths.
> 
> Reported-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
> Fixes: 6e39ba4e5a82 ("cpufreq: Add boost_freq_req QoS request")
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>

This looks much neater. Thanks!

Reviewed-by: Lifeng Zheng <zhenglifeng1@huawei.com>
