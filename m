Received: from courrier.aliel.fr (courrier.aliel.fr [65.21.61.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A93148CF;
	Mon, 13 Apr 2026 10:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.61.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776076328; cv=none; b=MsMKgKRmVczFnjeUJLiN4o3wg40gNIpKTVVQfsUdtJep6Egzsckv4Cdd4UhsmSE2ETzUx3nMB5HP4mdCkh5uPvmc+wfehijwpFq8upxamY+aXZuuZhyw3hcW5B5gwQXjU7WcZD0286e0f35IvBjLrPqh8v10W7FhHYBDtcjPL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776076328; c=relaxed/simple;
	bh=ZqPutyXfURY4JqAzvot3E4VaS+HrR8bVUot2j45xsQg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=OsTjzGfXXUEJ2acLXCg0PaWJabg+W1s1MNKpWZti2O1AWyL/XwkWXqZhAr2YaSeI3XCSjV1T/RTafRIK8gRed1bGsHd/kzKhHzSiLF7NHC8wM9zn9NP3NiSXOE1hN+xGIQGt/3pI8GE3JP6UYAWrTOsjoR52CalnU2MfjoIohlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr; spf=pass smtp.mailfrom=aliel.fr; dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b=VW4zImkQ; arc=none smtp.client-ip=65.21.61.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aliel.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aliel.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=aliel.fr header.i=@aliel.fr header.b="VW4zImkQ"
Message-ID: <451ba56f-83cd-456c-81bc-c09e2594df1a@aliel.fr>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aliel.fr;
	s=courrier-s1; t=1776076318;
	bh=ZqPutyXfURY4JqAzvot3E4VaS+HrR8bVUot2j45xsQg=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=VW4zImkQz89KLlouelDsZND4ph6bmMU0+d0qca5XJBMBjxMbUvxn6n0PXW1tWhMTX
	 kjD3GTvokQ001Fcj0A8STZTQ0ZC5LKE0o89NclXOWONePbxi/XQ4eUoNOABQg8+NEm
	 e7rotYrheKjtu5qvYBubSQUreNZkJ227bWbb+gxc=
Date: Mon, 13 Apr 2026 12:31:56 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
From: Ronald Claveau <linux-kernel-dev@aliel.fr>
Subject: Re: [PATCH 3/8] firmware: meson: sm: Add thermal calibration SMC call
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-amlogic@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Guillaume La Roque <glaroque@baylibre.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20260410-add-thermal-t7-vim4-v1-0-19f2b8da74d7@aliel.fr>
 <20260410-add-thermal-t7-vim4-v1-3-19f2b8da74d7@aliel.fr>
 <6200b372-149f-48f7-ae91-a5364562058c@kernel.org>
Content-Language: en-US
In-Reply-To: <6200b372-149f-48f7-ae91-a5364562058c@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/12/26 12:47 PM, Krzysztof Kozlowski wrote:
> On 10/04/2026 18:48, Ronald Claveau wrote:
>> @@ -245,6 +246,14 @@ struct meson_sm_firmware *meson_sm_get(struct device_node *sm_node)
>>  }
>>  EXPORT_SYMBOL_GPL(meson_sm_get);
>>  
>> +int meson_sm_get_thermal_calib(struct meson_sm_firmware *fw, u32 *trim_info,
> 
> Exported functions should have kerneldoc.
> 

Thanks for your feedback, I will add it.

>> +			       u32 tsensor_id)
>> +{
>> +	return meson_sm_call(fw, SM_THERMAL_CALIB_READ, trim_info, tsensor_id,
>> +			     0, 0, 0, 0);
> 
> Best regards,
> Krzysztof


-- 
Best regards,
Ronald
