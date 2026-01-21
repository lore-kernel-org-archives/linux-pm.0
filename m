Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C130843DA48
	for <linux-pm@vger.kernel.org>; Wed, 21 Jan 2026 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014647; cv=none; b=bwLR9qbSewuBukPtJMj5C/ej7cGN5wUApUaNISuUGH4PJm9ssBES6VK/6EMIk8VzbrMED3WV3R35ct/Wor+GGZL2YfyEDhFyZIca3RORwQSfADH4TgcL/CsyTu09xCV/RlyghsCWahiNzV7PWgOCm0AAzhnok+/n+LJyGSHrDiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014647; c=relaxed/simple;
	bh=0NuxRWSMVYoqYa2CdqKNGIwNkq236hLKM5PBVKb+OQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ddRxNshWFt2m6KBXaa2evv9Bl4L/6BAUi/ENNnoIYZOM9al74XqO5eBaOTHdOmvjoZmpb6UD3eFMMbqHYkZBPLb6Hu5Vl1Wbal3Tk0APxQBq2ZTvCgtH/fqaBOXvyBs+wNamd95NE7TeSf3X/tZUeJJ7aHnsgl7n+vRt4fQrbQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJDkxvZx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJDkxvZx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F164FC4CEF1;
	Wed, 21 Jan 2026 16:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014647;
	bh=0NuxRWSMVYoqYa2CdqKNGIwNkq236hLKM5PBVKb+OQ0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IJDkxvZxFlQn6qgqKMvCt2G8nP11/sb6jX0G2KcCiNBjCh+R4GBtb8/0hBWToG4Bi
	 dXpP3Cp7HxHkgbTE6tv3hOEoQfxFRc++Q7RJ1ceeGdEX9sDr8VVBBP4FrtDExrXpCU
	 xhIxWFngJy2Qgs2vkr5AQIzm3GZg0Nl2ELkXoD2qWNYKtg5nB0Wv0KsV0rAcd0onKz
	 Z/RORhkK5Q302wZbScYvm51YJzKrxcjy1OOPviFOO5/lUS3Tp3mhKkDJpzD9yL0S8a
	 ubCqJrZA49AbHVkJrsO8agTBzglgbq+lFFpJyPSxGnfKH4KRirHvelpR6At41yZ8bK
	 QDBqPzpge6meQ==
Message-ID: <050ebed4-955d-4694-9341-d18105b82991@kernel.org>
Date: Wed, 21 Jan 2026 09:57:26 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] cpupower: make systemd unit installation optional
To: Joao Marcos Costa <joaomarcos.costa@bootlin.com>, linux-pm@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com, shuah@kernel.org, trenn@suse.com,
 jwyatt@redhat.com, jkacur@redhat.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20260113132753.1730020-1-joaomarcos.costa@bootlin.com>
 <20260113132753.1730020-2-joaomarcos.costa@bootlin.com>
 <43461785-37a6-4228-abec-2364cae190ea@bootlin.com>
Content-Language: en-US
From: Shuah <shuah@kernel.org>
In-Reply-To: <43461785-37a6-4228-abec-2364cae190ea@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/21/26 03:16, Joao Marcos Costa wrote:
> Hello,
> 
> I hope this emails finds you well!
> 
> On 1/13/26 14:27, João Marcos Costa wrote:
>> cpupower currently installs a cpupower.service unit file into unitdir
>> unconditionally, regardless of whether systemd is used by the host.
>>
>> Improve the installation procedure by making this systemd step optional:
>> a 'SYSTEMD' build parameter that defaults to 'true' and can be set to
>> 'false' to disable the installation of systemd's unit file.
>>
>> Since 'SYSTEMD' defaults to true, the current behavior is kept as the
>> default.
>>
>> Signed-off-by: João Marcos Costa <joaomarcos.costa@bootlin.com>
> (...)
> 
> Gentle ping on this patch in case it slipped through, and any feedback would be appreciated. Thanks!
> 

I sent this up in my pull request to PM maintainer - will be
included in the next release.

https://lore.kernel.org/all/8cd367ed-3b80-4233-ac71-77a88782ed2f@linuxfoundation.org/

thanks,
-- Shuah
