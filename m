Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AFE434E46;
	Tue, 21 Jul 2026 09:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784625990; cv=none; b=MKQA9k+ym8FGCPF2k7yLmS7q7dbVETH+OF+qANpxJnaAgVHjwPnso9XYcRux2Whvp89OeVkdqged4ENUn5rOvIl6DqyysQYkQc52hGfB//kaBpkWmp4Te8m6eVxoL/dH7c9FXrrilNiIdFCKuqX+VK9NG8VMTv7dGyggEwELcvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784625990; c=relaxed/simple;
	bh=qwOlDh3wsIT5fX6vsxaqNsGuhgcl5N9ULQAZJLXX7Z4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Phfnn4nD37o1E8PirF5Kc6vGYZIaGN5HngUJC/bINXpMASDYScAzqLkWe4XI1M3UAtv5gzILNPoU7YhFwNL5rKF59ptW/Mc0ZMonenC8NeGHv/rgBBPxyRTrJtBN2zeDeSriABHbMTEx2E9g344dLMoDoKuHIkWBM7sXFu6e2C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BqKvF69F; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BqKvF69F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784625987;
	bh=qwOlDh3wsIT5fX6vsxaqNsGuhgcl5N9ULQAZJLXX7Z4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BqKvF69Fn5cA6r5TyaVHkD1Cf3atUMf7tbpaE22yDY0sTgcXw0d4JIIEgwI70da6b
	 BMOeLRB+7bMgAc9B3/MVp4XfHAETK2lXlzBt0RLLIKRIn5vveSR3YNuaGw+81g0M1Q
	 szG00ls59N59vvTh4aJYYjnUYRhuPPjXgdLeGn+x5iyvbRIlvcmsuhLXydD/BzvxB4
	 U7gZn44RcVGJ4dLfSseD+rZQWDgSg5hpj4mCnoFsWQeJHkHpafRNjs9O6suhSun9uq
	 ELaLQVaWxNHCuRdBZ2Kl6vCvouDK6R5YXfXp+UmjlZL2uWhyqNSdQ1z98xK3znGSfi
	 b6r6H9nBSw4aw==
Received: from [100.64.1.21] (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 65B4B17E0018;
	Tue, 21 Jul 2026 11:26:26 +0200 (CEST)
Message-ID: <88da7755-5175-4f83-b302-56c3fd8dffc2@collabora.com>
Date: Tue, 21 Jul 2026 11:26:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 00/12] SPMI: Implement sub-devices and migrate drivers
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, sboyd@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
 gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, sre@kernel.org, krzk@kernel.org,
 dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
 melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
 ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org, luca.weiss@fairphone.com,
 konrad.dybcio@oss.qualcomm.com, mitltlatltl@gmail.com,
 krishna.kurapati@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, kernel@collabora.com
References: <20260707111829.180158-1-angelogioacchino.delregno@collabora.com>
 <akz8iRW2emM7B7n7@ashevche-desk.local>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <akz8iRW2emM7B7n7@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/7/26 15:18, Andy Shevchenko wrote:
> On Tue, Jul 07, 2026 at 01:18:17PM +0200, AngeloGioacchino Del Regno wrote:
>> Changes in v12:
>>   - Removed call to of_node_put() for failure as it's being already
>>     done in spmi_dev_release(), as pointed out by Sashiko
>>   - Fixed usage of the new helper in all users (it's too hot today, sorry)
> 
> You have send two versions in a row and effectively ignored my comment.
> What is going on? Perhaps you need to slow down, find a cool place and
> start over?
> 

Andy, yeah, sorry about that.

It got pretty hot here in Italy, and I admit I was rushing way too much with those
patches.

I'm fixing your comment and sending a v13 right now.

Thanks,
Angelo
