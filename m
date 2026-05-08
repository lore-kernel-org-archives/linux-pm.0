Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFA13914E1;
	Fri,  8 May 2026 22:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278454; cv=none; b=RQOsG1lgYEhsgnu5lCW5EV9xE7vfFtfQFfB5AA7TnLaeJPhBlXALksX1a8b4WaWjCgzK/IiXPDlv/HGgHt7N/zz/5CPv6FSkiELJf4iurcIfDDedV95mACcX4NJiyysa8Dz+4jnaW+dzF82ifY9WaV+yrghVHr70QLOtdwgnFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278454; c=relaxed/simple;
	bh=j+3aKlygouCz5b+v8lfYPd6nsKPilgGpE0nlCIZpiSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ljWkBUR79EeVl7HLxpJ1H75/EtEgvcHwwHwdj3zd3BgnXvm5A9stTk1Gn7ki1ulK4/p5mAPFYwLkC0ZvjJRYvQhpErmfwPdRcKx8P1F5fFasuHXNFcMk8Ee3Xqs2i8hSX8OQj0mb7/4DSQGkHCEiIhuRdVYt0cjr/N+I7teANo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XK13vrcn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XK13vrcn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90948C2BCB0;
	Fri,  8 May 2026 22:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278453;
	bh=j+3aKlygouCz5b+v8lfYPd6nsKPilgGpE0nlCIZpiSo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XK13vrcn8bw5uQgKygpHNBE/wQrtn3RVeEJ0GkfJRGJ/cLFfB9EKGj4xdkmM1ZLlH
	 r6PoQ1XK50wIJfnjg9pPEiwGVf8LUoBibWNT5of5kkmjeIaTQAAv+X7Q9LjGBuYGZ/
	 B7FWByBEomN5KJq9PbmUPI/uCEDpyn7ya13I0Dr2sEf6VCKx50zgMAf0BVOlbhPTNQ
	 gNzlxOrrBBSNU0yE4RFLqZvH64qWvpOotffYdotkx/ZfIfdkPKbZFD9WPsqFObrep3
	 wnS6b/2Lj81241P7fBGG/v8EmknEY7cxuo5UldOl7hZUYdo5KQznX/YzwtwQN6xxfh
	 T0rB8JGC86fdg==
Message-ID: <0c116b90-1688-49f6-b97f-fbe78466221f@kernel.org>
Date: Sat, 9 May 2026 01:14:01 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] interconnect: Add devm_of_icc_get_by_index() as
 exported API for users
To: Bjorn Andersson <andersson@kernel.org>,
 Luca Weiss <luca.weiss@fairphone.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 Mike Tipton <mike.tipton@oss.qualcomm.com>,
 Taniya Das <taniya.das@oss.qualcomm.com>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
References: <20260501-milos-camcc-icc-v2-0-bb83c1256cc3@fairphone.com>
 <20260501-milos-camcc-icc-v2-1-bb83c1256cc3@fairphone.com>
 <af08-zMGzSSsw_NR@baldur>
From: Georgi Djakov <djakov@kernel.org>
Content-Language: en-US
In-Reply-To: <af08-zMGzSSsw_NR@baldur>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/8/26 4:32 AM, Bjorn Andersson wrote:
> On Fri, May 01, 2026 at 11:18:29AM +0200, Luca Weiss wrote:
>> Users can use devm version of of_icc_get_by_index() to benefit from
>> automatic resource release.
>>
>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> 
> Georgi, can I have an ack on this, or an immutable branch and a ping
> once it's available?

Hi Bjorn, please apply it.

Acked-by: Georgi Djakov <djakov@kernel.org>

Thanks,
Georgi
> 
> Thanks,
> Bjorn
> 
>> ---
>>   drivers/interconnect/core.c  | 20 ++++++++++++++++++++
>>   include/linux/interconnect.h |  6 ++++++
>>   2 files changed, 26 insertions(+)
>>
>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>> index 8569b78a1851..bc2e416dbcb2 100644
>> --- a/drivers/interconnect/core.c
>> +++ b/drivers/interconnect/core.c
>> @@ -443,6 +443,26 @@ struct icc_path *devm_of_icc_get(struct device *dev, const char *name)
>>   }
>>   EXPORT_SYMBOL_GPL(devm_of_icc_get);
>>   
>> +struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
>> +{
>> +	struct icc_path **ptr, *path;
>> +
>> +	ptr = devres_alloc(devm_icc_release, sizeof(*ptr), GFP_KERNEL);
>> +	if (!ptr)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	path = of_icc_get_by_index(dev, idx);
>> +	if (!IS_ERR(path)) {
>> +		*ptr = path;
>> +		devres_add(dev, ptr);
>> +	} else {
>> +		devres_free(ptr);
>> +	}
>> +
>> +	return path;
>> +}
>> +EXPORT_SYMBOL_GPL(devm_of_icc_get_by_index);
>> +
>>   /**
>>    * of_icc_get_by_index() - get a path handle from a DT node based on index
>>    * @dev: device pointer for the consumer device
>> diff --git a/include/linux/interconnect.h b/include/linux/interconnect.h
>> index 4b12821528a6..75a32ad0482e 100644
>> --- a/include/linux/interconnect.h
>> +++ b/include/linux/interconnect.h
>> @@ -47,6 +47,7 @@ struct icc_path *of_icc_get(struct device *dev, const char *name);
>>   struct icc_path *devm_of_icc_get(struct device *dev, const char *name);
>>   int devm_of_icc_bulk_get(struct device *dev, int num_paths, struct icc_bulk_data *paths);
>>   struct icc_path *of_icc_get_by_index(struct device *dev, int idx);
>> +struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx);
>>   void icc_put(struct icc_path *path);
>>   int icc_enable(struct icc_path *path);
>>   int icc_disable(struct icc_path *path);
>> @@ -79,6 +80,11 @@ static inline struct icc_path *of_icc_get_by_index(struct device *dev, int idx)
>>   	return NULL;
>>   }
>>   
>> +static inline struct icc_path *devm_of_icc_get_by_index(struct device *dev, int idx)
>> +{
>> +	return NULL;
>> +}
>> +
>>   static inline void icc_put(struct icc_path *path)
>>   {
>>   }
>>
>> -- 
>> 2.54.0
>>

