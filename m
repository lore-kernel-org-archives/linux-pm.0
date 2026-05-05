Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBC3A2549
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 05:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777958565; cv=none; b=N62K8ASdnS1P9ncMoZrhhCAVps8X9yItphaaPkaZiu7xYg26q118w2gKvdyi3bV/tk5XFNJq892dNi0UZCpjVV+W95cFq9fKsFqhGSnGYUMs6qR3hHzSJb7pwsTb8paqtuoTouYnsYzJLQAHERZUUM8tB3JlECb3bnMmneGX4k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777958565; c=relaxed/simple;
	bh=EOi4TAwl3YUZFQKJIcnrKLIVIfRvs8P9dfqnYJLJoO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bviSDt+siVjskDMK/zOP+SsROM+JdIsKCc+dJpcAT32GY5O/3LaATgSPaHIoj97B1L/j/CJnMKTRrRJ3ZRrgKb1XQvWbQ4vOGCz+VdkFRoCjzFSVqialNpLF6s4riEcQrAhMWEPeASHIsKkaFOwvQzKxYa52WTLo86bTkZjQVwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caacW0lW; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caacW0lW"
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39396f873adso21411181fa.3
        for <linux-pm@vger.kernel.org>; Mon, 04 May 2026 22:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777958562; x=1778563362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Aba51GwM9UB4W9+FPoqr3t/xf8nQUS2E+pg65Y7QmBw=;
        b=caacW0lWz1X8VD2QF99KRc6+QXjGrh7O8xnGTHMAY8c5lmXWg+8xH230EnEPOl0W26
         4SfcHKTT6j7sTr+4c8F1cGEl9uMccnqYa7LGXKSbNk1yY4yv8iYlcYXViHjn5GF++cQc
         h54PN4Tsw08VZyohk4HHqQnsFzu+ex2G1Yckn+dfHebxywSoxzjv3FdQhoOIdNupXGnJ
         BO7OjwbLmoVYNSPsoie8K94Y8qHukzXswhjgtGEV1oZf6AYXMNZjXqUpZTOs1UCh2SXf
         lFc8bayMxypcgMY2zjbD2xplOk0dGuntdKQEansHcDWAwpqsR59T+wY73Um60RgHlvBx
         AtJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777958562; x=1778563362;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aba51GwM9UB4W9+FPoqr3t/xf8nQUS2E+pg65Y7QmBw=;
        b=iH50M52pW3lWfFEfrOPrr7NWrA6S9FnzewEqlDDphSR+3QfbsNHsj3BMpD6s9AD9qq
         cV3ftbAssiG8JlNQ0QfXEPLX5sCwyFyp78KS8BPCu/UcIVQW0l3FySGijr4QMSKt9gWa
         ceohH4oFKYC5yl5UPPk2hNwLOatohV/xmB2yJD/bW1S2H2yGu4e8nliRGJmkd8bzQKB1
         wf8wcTEmo1oRui66IQfappVs3ecjxBH3Q3gBm//4yTRIeMIBANgIXx38nYNzqy2mKi+q
         ybApR6y8UsneEDNkSUvqF1bwLoFuhSUQjrDjKeLyres9w0URNuNpAJwvOIXj2CKuS8+N
         0OBg==
X-Forwarded-Encrypted: i=1; AFNElJ8h9HJo2dUApCiB2isE+1dEHdnfxjLgP2TT2HqnKD0RMFECZ5pLjSsv7HLgNWOcPk/EAi6nI2an4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyDxRBsqBMRFh6vn3bpnOgiVf/u2ZlrRN44jGskf68tkWJ1J3zD
	AtYSasLkJ9E9FVRSrWVx2+CfltQD1XecL9a3GzxMcEQ2UdBD2WW79u1w
X-Gm-Gg: AeBDietUt6R0uHRrZ/QaGMYjZsNL3JP85XoD6jvGqSiVVd1ZRiMpOLl/uBiAZRHOj7V
	7bTYn6AeRNnUsDqAwoBbPOfmk0X9pkkJIvzNghlHw82Cm1nvdqrnHcizs53z8y2oUOQUHuBjMSL
	9ixkxRn7bkYBNoGO62smTgAKymfHQQCH3xe4RA0PYcKCPypCkFuuhUwr9M/u771FZxpRCaqwLjE
	37YKjpjqupmks1xYHCnXr4vkX+33ctwMbKBt/8gnprrhsNFwrmpDP6LdSnwKtc8k4AVGbuFhgxJ
	vISnByfqQyMtVYW3yemgWBNAmw/Urj7yCehoeX7Z04w0/G5I1NZFdE/tol6dm0YWV49BSgL4heo
	acEAN1VCdDrrYB+U9TVcobD6rHQ3Ij8NcrGvo5djmN4Tm9QzHbXiP0lqPKC1WI/xkXTXlyX2WT/
	5ywAvSzJr3g5HOCKC9Qonjo/z1hdHZj6An/YlirojxO7Vh4Wqk325ezQJS586z1JfS4sJlWQzYa
	zBfCNspDYCVeUi0hDk=
X-Received: by 2002:a05:651c:325a:b0:38d:ed1a:a140 with SMTP id 38308e7fff4ca-393b4da5360mr4570501fa.21.1777958561916;
        Mon, 04 May 2026 22:22:41 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3939fb319fcsm16854871fa.13.2026.05.04.22.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 22:22:41 -0700 (PDT)
Message-ID: <53fe896c-a357-46d9-86db-4b0381f8c066@gmail.com>
Date: Tue, 5 May 2026 08:22:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: sysfs for auto input current
 limitation
To: Andreas Kemnade <andreas@kemnade.info>, sre@kernel.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260504164017.467679-1-andreas@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260504164017.467679-1-andreas@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Thanks Andreas!

On 04/05/2026 19:40, Andreas Kemnade wrote:
> Add the possibility to disable the auto adjustment for input current
> limitation via sysfs because it gives strange results under certain
> circumstances e.g. when powering the device with solar panels
> resulting in no input power usage at all.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   .../ABI/testing/sysfs-class-power-bd71828     | 12 ++++
>   drivers/power/supply/bd71828-power.c          | 69 ++++++++++++++++++-
>   2 files changed, 80 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/ABI/testing/sysfs-class-power-bd71828

// snip

> +static ssize_t auto_dcin_limit_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct bd71828_power *pwr = dev_get_drvdata(dev->parent);
> +	int ret;
> +	bool v;
> +
> +	ret = kstrtobool(buf, &v);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_update_bits(pwr->regmap, BD71828_REG_DCIN_SET,
> +				 BD71828_MASK_ILIM_DCIN_EN,
> +				 v ? BD71828_MASK_ILIM_DCIN_EN : 0);

'nit'. I am not a big fan of the ternary. I would consider using an 
if-else or the regmap_assign_bits(). Not worth re-spinning though.


> +static bool bd71828_ac_sysfs_group_visible(struct kobject *kobj)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct bd71828_power *pwr = dev_get_drvdata(dev->parent);
> +
> +	return !!pwr->regs->dcin_set;
> +}
> +
> +DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(bd71828_ac_sysfs);

Ah. I didn't know DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE() existed. Thanks 
for teaching me a thing again :)

Yours,
	-- Matti
-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
