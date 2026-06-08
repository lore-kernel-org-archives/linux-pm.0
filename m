Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4DF29B8CF;
	Mon,  8 Jun 2026 01:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780880676; cv=none; b=QrRpV/NxyVskvnd86i3WU35jlVW8jAc0Yz6+6f0tZlo7ePSyZ8Yth+iWdSCTOFRM+F4lYwKELsnKmcAHJDAqpSdOnUh3sm0qks2afv2mmO9QZ4wWftpPesvf0fYAO1rV8TYC7BBxZWmyDYn3kXEIbKhswkOyzoy0w94XB+xfDGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780880676; c=relaxed/simple;
	bh=iEywT9iZ7M9GAZW3M3sgb/XD2i+6PVC4a4SEXz2ufGg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eW99TwpPj0qaB++/J5z8KQD8pLoaA8ZkI8Tf0QP/MnsEkRaf4Q/16JgGyJTop8MP/sYKfr7QgYOdLXIlpYUOkNPdaMlUjFkYq5S1BN+6nZgIjoaoJRu7xplFulaAvlKG8Ktq/udblGLUel95cKNpFdD3EVhttq4zWpxn58lazW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rEeR9dli; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rEeR9dli"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=7KUxNK4roQZlfzNGNej2nyL3RkJMcfEGaNe2y2Xztxo=; b=rEeR9dlixXYsxc8Vx4w9d6kp1p
	WTo7tuklDVjPcR4/I53cjP/PWOVyTdI7R9kSI5puqS+jw+3vk1frGcqLe7rWUtu8WF+X5TzXMyGTZ
	mHbXMaGY/eE+6QxMenRt2Jf4lxnQqeHSiQLBHHEmMH1ZUXKM3QiqLFeO9ZuCa4z0lfQfSbvyw+DZ0
	cLizJg6SDEwbCXTQbUcAiqT0YadCF29KWONJBfIDS3bnIIsRXwbxAKcI5eiz9jtLipbk3+RTXl4bQ
	tuD3eFTFeGDQ/8quneoDRGGjPHjR4sWHQLae7Wtbc5Ldp0ymz6CzXt1lD1KQUYwFZNUJ+a5Fo8oj9
	r1fvGAlQ==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWOPp-00000002fYy-3ACl;
	Mon, 08 Jun 2026 01:04:33 +0000
Message-ID: <60949d0c-fe4d-4a26-80e4-224e6060d24e@infradead.org>
Date: Sun, 7 Jun 2026 18:04:33 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: ABI: sysfs-class-reboot-mode-reboot_modes:
 fix doc warnings
From: Randy Dunlap <rdunlap@infradead.org>
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260426232705.422938-1-rdunlap@infradead.org>
 <CAMRc=McUr8Tuv9+LNQ0=ufj1z4Tstp_ujmL=r7bXrLaBXg4E5g@mail.gmail.com>
 <d7cd7bb3-520f-4e80-8242-583f689f60db@infradead.org>
Content-Language: en-US
In-Reply-To: <d7cd7bb3-520f-4e80-8242-583f689f60db@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/24/26 3:48 PM, Randy Dunlap wrote:
> Sebastian,
> 
> On 4/27/26 2:11 AM, Bartosz Golaszewski wrote:
>> On Mon, 27 Apr 2026 01:27:05 +0200, Randy Dunlap <rdunlap@infradead.org> said:
>>> Repair the docs build warnings in this file by unindenting the description,
>>> adding blank lines, and using `` to quote *arg.
>>>
>>> WARNING: Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:36: abi_sys_class_reboot_mode_driver_reboot_modes doesn't have a description
>>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: WARNING: Inline emphasis start-string without end-string. [docutils]
>>> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
>>>
>>> Fixes: d3da03025e6d ("Documentation: ABI: Add sysfs-class-reboot-mode-reboot_modes")
>>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>>> ---
>>
>> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> This build warning is now in mainline.
> Will you be merging this patch soon?

ping.

> thanks.

-- 
~Randy

