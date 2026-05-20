Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD932E8B64;
	Wed, 20 May 2026 11:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779277895; cv=none; b=l0M9zuI1r14rFwUUN7I2UW0rI4DMpRN8OunSyWHrlOGHenmx0mizylcnItvccdOYQJ1Ra7jt/jqEDVrLgF81MfRKWg3ToJz7jv/y9o3wbem5G26oHjfSRmNOGAV10zXpDuuW+KMtF5W3Gu5+WREDoLYyz2u3Ovu3xjbSsxFl/BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779277895; c=relaxed/simple;
	bh=yyDU9KwLvP8JNcMoT/S4fUI5/eacAI4JGK0D9tUG0ZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddOYrtexdOUfYCgYKlGWpDqEWpUWaOEsgMN3SCm8jXU19Mh+R7PglbREBCd6yiljLzM9LMQoc8nfKvF91ucTCQbTo6uDuS6y5cvha1T+Rue3lRDkZcJ5S+C4wWgw9PC/lMKPc8Vdt6N6S5E8SKKjtRYwmNVARdBRpjGspHDF/bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kqkK6DFH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kqkK6DFH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444501F000E9;
	Wed, 20 May 2026 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779277893;
	bh=JHA2T/KyUeaBszSGfgww6SPBWhnX3PZMY/vXvIO6sQc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kqkK6DFHrI8lgimdoKWRSBJpYDypKrZ11ISNayuMGXE6iWMc7LxnQkf8Q8y8HcYHI
	 +k9IDkqra3CjHM4DH4+mOidsDa//dmww5hvFw0vZ+kvtnrcAtFYyTw6J43K0h/UZNY
	 1cS4X6zc6XW3hYTQOhmWVcz7pvUB6d/5V3RP5bMIvAZIy4uAvG5aVSBMBSYTltwXWw
	 50GGFIDp2VNPRtHt4GIporwT4lCCCdMub6AXmOVGIxnP0Y7gfaKZAqx4/Regu9VUkZ
	 rOayFPcPqZd1+rCtmFnKLBeEtXqYUgW4RoCYJiodvWMmEp1R5XFp8ED2KG0MZAZQYC
	 n+ksabzXuBIDw==
Message-ID: <07739437-4720-4a15-87cc-40f6f92f3759@kernel.org>
Date: Wed, 20 May 2026 13:51:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v8 00/10] SPMI: Implement sub-devices and migrate
 drivers
To: Jonathan Cameron <jic23@kernel.org>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 arnd@arndb.de, gregkh@linuxfoundation.org, srini@kernel.org,
 vkoul@kernel.org, neil.armstrong@linaro.org, sre@kernel.org,
 sboyd@kernel.org, krzk@kernel.org, dmitry.baryshkov@oss.qualcomm.com,
 quic_wcheng@quicinc.com, melody.olvera@oss.qualcomm.com,
 quic_nsekar@quicinc.com, ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
 luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
 mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
 linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260511100805.121432-1-angelogioacchino.delregno@collabora.com>
 <20260511141743.251a47e4@jic23-huawei>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@kernel.org>
Content-Language: en-US
In-Reply-To: <20260511141743.251a47e4@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/11/26 15:17, Jonathan Cameron wrote:
> On Mon, 11 May 2026 12:07:55 +0200
> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
> Hi Angelo,
> 
> Why the resend?  If marking a series with that I expect to see it
> called out as first thing in the cover letter.
> 

Right, forgot to mention why.

The v8 was sent on January 2026, I pinged maintainers to pick it on
March 2026, even if this was fully reviewed by multiple people nobody
picked anything here.

....and I've resent it because pinging multiple times didn't work, and
because the series got old all that much. :-)

Regards,
Angelo

> Jonathan
> 
>> Changes in v8:
>>   - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
>>   - Changed kerneldoc wording to "error pointer" for function
>>     spmi_subdevice_alloc_and_add() (Andy)
>>   - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
>>   - Used device_property_read_u32() instead of of_property_read_u32()
>>     in all of the migrated drivers (Andy)
>>   - Changed .max_register field in all of the migrated drivers from
>>     0x100 to 0xff (Andy)
>>   - Kept `sta1` declaration in reversed xmas tree order in function
>>     iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)


