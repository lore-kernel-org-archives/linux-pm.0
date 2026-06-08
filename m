Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A12E324B2C;
	Mon,  8 Jun 2026 06:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898863; cv=none; b=AywV7ovkph7lryHEIa6JXRmm8NLzW8ppT1efqlcY9ZunZNwSR8Fy8Sfsem4xtYes5Kgrh6XucxNpRdye2wVRkDaf7gKXAvFPLHuJUjBKD9uJcTmbgz9zlcKwDVqPC25p8UiC/8JJu2CRVpoDQg4H0svAb9SQAbW6o1rjc1YChE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898863; c=relaxed/simple;
	bh=+dcXv4zWRWzCmRcsErz8MQZtU9CNwLr2zjetIe+6/mU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xn2AVMx6wEWrQ2FEEdJXgRvO9u4kupEAJzXP3YAOD8C8vv0aHOa7IgzKwUS6qEKpbdTJFbSBROKKpX6itwCek0LZXGB5+P+VGqgPe8cGA2zWt4lDwZpdNxPmR6mIvNnV9xsS1WDXHSKlUfOG2Y8HHuEsSpgeW7/GernjFPLCF0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=cC6g03sH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="cC6g03sH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1780898531;
	bh=+dcXv4zWRWzCmRcsErz8MQZtU9CNwLr2zjetIe+6/mU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cC6g03sHSs7sp0X5XtqVYnhJz00Uw3zFpcwqUhkUucc6F0kHJCHwMQNJxLBtV4ddH
	 CAOXalB+zZrHkCubP+10Ybf8fcDusR7qJNzEoSHS+mi1S2hjID+glOPxE9hcKwlgyQ
	 wL4qXWKoA66eKfBt5qmagENkIzxnE01oQcxp6z47lc/OTeUHUXzeYqo/nhAJOxUIku
	 B5dZfirRuaT5Spp780ySds1KFEkboyCM0lRaxl+oPRZXE8TTr9LMMmJqgrjdIGtuDD
	 6wtnI9i3hVY0sPv/twP6cDGJzieUteCMN6mTL4CzOi5fGQdyzLQOS9vPWLxAdJ6v6T
	 BOm6jWb0VfGMA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66B0217E0416;
	Mon,  8 Jun 2026 08:02:10 +0200 (CEST)
Message-ID: <4947ceab-e60e-4f11-9553-5341cdd12a47@collabora.com>
Date: Mon, 8 Jun 2026 08:02:09 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 00/10] SPMI: Implement sub-devices and migrate
 drivers
To: Stephen Boyd <sboyd@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
 krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
 melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
 ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com,
 konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com,
 krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260511100805.121432-1-angelogioacchino.delregno@collabora.com>
 <20260511141743.251a47e4@jic23-huawei>
 <07739437-4720-4a15-87cc-40f6f92f3759@kernel.org>
 <178001901320.7182.15120759905441640016@lazor>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <178001901320.7182.15120759905441640016@lazor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/29/26 03:43, Stephen Boyd wrote:
> Quoting AngeloGioacchino Del Regno (2026-05-20 04:51:26)
>> On 5/11/26 15:17, Jonathan Cameron wrote:
>>> On Mon, 11 May 2026 12:07:55 +0200
>>> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
>>>
>>> Hi Angelo,
>>>
>>> Why the resend?  If marking a series with that I expect to see it
>>> called out as first thing in the cover letter.
>>>
>>
>> Right, forgot to mention why.
>>
>> The v8 was sent on January 2026, I pinged maintainers to pick it on
>> March 2026, even if this was fully reviewed by multiple people nobody
>> picked anything here.
>>
>> ....and I've resent it because pinging multiple times didn't work, and
>> because the series got old all that much. :-)
>>
> 
> I take it you want me to apply these patches to the spmi tree?

Yeah, sounds like the easiest option.

> Can you
> respond to the Sashiko bot comments about why it's wrong or fix issues
> it found?

I will do that asap; sorry about being late but I just came back from a work trip
and might be a bit too late now, but still, I'll make sure to get this done between
today and tomorrow.

Thanks,
Angelo
