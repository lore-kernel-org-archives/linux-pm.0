Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24C39B971;
	Sun, 24 May 2026 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779662890; cv=none; b=N4igUe/F99zjbw+K0+ZGEWmH0gbCcgYW+72CmuBx3f/q2RXDIzBl8rDlpdekpu4kHtTb54fX94m/ErRzhSyTz5G5WpilnWcOAFAxJT2fp+X/mbvObZGWrxwmKIKq4GBQprURMW/ZCd0JR8ZRxCebBWi5jT7PdXt9/DagyGozbtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779662890; c=relaxed/simple;
	bh=mD0gNpVAUkSkL0hg7Ggs6OpxwXKGMnP+lGaapPLk3ew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Um4rxX96NszXBAfYLVhe7gszQ/OxNJb/Ol+7gx5B1uJGfKW6F9LLoGOJ2y8oUHEOz4uif3uej6OvIm5PlBRQY4By0npO4wzDriGRaqv28fyw0lGlclss82KMMBYX5UEwgfVgyyeaUukBpSD3mO3HcW6vv/86m5h5tqPBN2gQC28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qct1oUeD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qct1oUeD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=UufSwSgpRgsAqIYOsS0l8pXjHiLkYpufOZ9F11/DJSA=; b=Qct1oUeDOPS+yRcmYdthiNtFuM
	3j5XmZ3LMMYoHSh4rX8UxTQxfFBsoKE8B5cj2TbaAQB0+4MiLukcxpNcoENt0d3wX9G0SfjDpnHnx
	BnU5t7677x7cT0bdgbJ+eJ64m9q+QmRuGJxGjwZ2ppJ0Y0FQdPdP07HcCVuw/qUR2aFFqgPwuzvHy
	FbjoNvs3tH2g0UpfTd0m0LMtfV1fyOaVLrUzbv9OFuJrYi8Q8lzxXb9c0D4ka9/QY8yt3e3UJ6WUs
	Spsg/QYV47S75uQv/ohh7QqVuIC78+XmYs5rEFT2WitTaxUAIaPiTEEPbbTc409UXAd2T31LJzoVh
	XPo9YXIw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wRHc3-0000000FnRw-0sHy;
	Sun, 24 May 2026 22:48:03 +0000
Message-ID: <d7cd7bb3-520f-4e80-8242-583f689f60db@infradead.org>
Date: Sun, 24 May 2026 15:48:01 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ABI: sysfs-class-reboot-mode-reboot_modes:
 fix doc warnings
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260426232705.422938-1-rdunlap@infradead.org>
 <CAMRc=McUr8Tuv9+LNQ0=ufj1z4Tstp_ujmL=r7bXrLaBXg4E5g@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAMRc=McUr8Tuv9+LNQ0=ufj1z4Tstp_ujmL=r7bXrLaBXg4E5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Sebastian,

On 4/27/26 2:11 AM, Bartosz Golaszewski wrote:
> On Mon, 27 Apr 2026 01:27:05 +0200, Randy Dunlap <rdunlap@infradead.org> said:
>> Repair the docs build warnings in this file by unindenting the description,
>> adding blank lines, and using `` to quote *arg.
>>
>> WARNING: Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:36: abi_sys_class_reboot_mode_driver_reboot_modes doesn't have a description
>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: WARNING: Inline emphasis start-string without end-string. [docutils]
>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>>
>> Fixes: d3da03025e6d ("Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes")
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> ---
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

This build warning is now in mainline.
Will you be merging this patch soon?

thanks.
-- 
~Randy

