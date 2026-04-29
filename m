Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5083C3B635A
	for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 08:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777452186; cv=none; b=Y14v2cev5n1Vyltw+oEOm98IwqP7b11O5qTiMZ/XiDfIwo+DqeBMXvxbZzPL64s4TKfqxECO/MLBu3X0uT1EUluFlaIDYYu+WC7OSJM5keb1m1vYafykmwa1CtSIOWku1Kk9vkZT9xjqpeV3lquYgG0Bf+ZBASMEy5DLLQdGxuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777452186; c=relaxed/simple;
	bh=tupiD11ATds5ekAH11VAwc8M0ubbtZCVy5mgO77Hq00=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unVa1y1sZuY9KLG7rrMJMvZvasHktv2yI8fzAtncbV9oTeh3bJ1/8D0Ru7FWjnqTDJhjIAA5OkVrUbGEZuqnafFwHi1H1b1gSiXuviDCTV5ewnLGx4mcKitPWiGvSc+a6AUMs6Rsdi0cJ+74gMS/vAjRMkZde6q4AGg1IkYbzls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=f16KYBLM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="f16KYBLM"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-43d73422431so11404524f8f.2
        for <linux-pm@vger.kernel.org>; Wed, 29 Apr 2026 01:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777452184; x=1778056984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aEw2E2UxluXLM5FnKmomLkyyPldPWoTTdKM8dvkkUPc=;
        b=f16KYBLMIzZYLjPY3dRyCZf1zyHDvtBrrzWgpNSuIqO3GcXITs6GeAqF0JvIrgqkOW
         mX0wW+l86BtExzi1nnlBSa0GbxrigLA/1+FOKxZFU+9c9UjDQr6ZvA9jDjA+uV8fn4ns
         KhAaNI6HSY1HC8QWkqRRNRXSFzE/UselxsNwC9h3S7iOUnLmRSaczB34jxi7vLGL1oRJ
         S/dfS4BgGBgZq83+tKaPpycbUtul/xS/tABFk6t9VdkHUqjCWvX0vd7kCJrxNCB/bZD3
         WhDJ5QXHc+0wBjsqdnj1zCUkp6C/UM6djT04HvAaWIrsdBp8uhA5a4Y7EId83T/DpVc1
         /8jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777452184; x=1778056984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aEw2E2UxluXLM5FnKmomLkyyPldPWoTTdKM8dvkkUPc=;
        b=KIhsO2Cl2m+C8LCaXLWWjxRiTZa4yFu2MTZnCKTV4czw5werag6sW6oMHZ17RSXrNQ
         rf5FMuXYdZZvOo1E163yWTVqHPDnscka+T0Vb76nW+7RhWvKOkgxOfAUXvreqz0vTC6v
         M9bsfCoqmKmOPtadRViVe8MIMSLD3Q6a68rffF/yKpq40cp7q4kUyoOGWWoouASCpOso
         AoA1jej9eGTas+mcF5YA/teFAuuQqcUQkDv/Ey9v2trPrdaNQWmU7lB76RwzihztMWC5
         yPQNKarZWwo0+uaeGwI/SYVVeO7bzzYLKBgx7qGvsOOyONAg2hgnOXPHeulSvfdMkKNT
         SxCQ==
X-Forwarded-Encrypted: i=1; AFNElJ88lhVlqMQohzAzyz5M8zxxYtinRO2gry1J9gAAuEsMqkQqSMkykFHIyiuDdRXqU+aVSmPi50kyZg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhWvZQFp2sLMJtuZTWafaAL7whh2ESLyodLUpEKABGh8dSt1P5
	QiEs++r8YcBRYv5ebSE7rA3F1juPcfhJy85KG1mAz/eA806TVBTU7otZGpYy0CIIK1E=
X-Gm-Gg: AeBDietq2X0YZ1jUrB/ebUgEASj1KoxtrRwcx+vONBvVPcJdTYDDvVWg8SJjEjxUq3P
	2eckN4eKuQJ0VqlNCa3avK3OAP9w3YiVNyN36/p4KOR97YdFw8ZlHldEnUsrVtmLxYCrNus/69e
	uY+X6hb0qVVeMKxZ/nxUH9/SqGzIEu+ZQUu9+PGN8wrH/bZTnABlXmVbE564yKk/J5XmSuKEbc0
	3mxiJxlxoR+rntQEl4mtRLiTOwyCmKBLMWT3T/Ap7gawlnEKdoWy3nO46uGNMtRzgb+fZUS/i/Y
	SEuAlnatZTuHLgxHB17sIKiVHj7RZhftu/TqazT7EZdLkwQuITUv8NxOqmXzT4xf9mKn92oAUGv
	OtTWH9yAOzuEMMj7hLoVeq1+RGbzw4K9MpIvGCI/VgWromYBttd+eoRVUo7gjwJgPS9R4eLlcl7
	BguVRQ0qdDSRJQfJxaEk5InNCiavaR9izJqO80rWYr23iKvK0HM57lRu3L0JBMP6cUNFy9zup1c
	1/16g==
X-Received: by 2002:a5d:5d08:0:b0:43f:e7fe:421f with SMTP id ffacd0b85a97d-44790efd49fmr4716396f8f.40.1777452183598;
        Wed, 29 Apr 2026 01:43:03 -0700 (PDT)
Received: from ?IPV6:2001:a61:13a6:c701:bf3c:e2f0:87b2:c525? ([2001:a61:13a6:c701:bf3c:e2f0:87b2:c525])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b3d48131sm4260624f8f.3.2026.04.29.01.43.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Apr 2026 01:43:03 -0700 (PDT)
Message-ID: <6d0f7bdc-bdb8-4d9c-887e-8a5f3d4c6b98@suse.com>
Date: Wed, 29 Apr 2026 10:42:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] USB/PM: should USB interface drivers distinguish
 hibernation THAW from RESTORE?
To: Haowen Tu <tuhaowen@uniontech.com>, gregkh@linuxfoundation.org,
 rafael@kernel.org
Cc: linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org,
 pavel@kernel.org, lenb@kernel.org, oneukum@suse.com, kernel@uniontech.com
References: <20260429033617.1954257-1-tuhaowen@uniontech.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260429033617.1954257-1-tuhaowen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.04.26 05:36, Haowen Tu wrote:
  
First, to which extent is the issue specific to USB? I suppose
you'd see the same issue on a camera connected via PCI.

> In the hibernation flow, after the memory snapshot has been created, the
> kernel briefly resumes devices in order to write the image to storage.

Yes. But you cannot just restrict the thaw to storage devices.
You also want

a) displays (to show the user what is going on)
b) keyboards (sysrq key)
c) anything used for logging
d) devices for the visually impaired

> On the successful hibernation path, the system is then powered off. For

Keyword: successful

> a USB camera that was actively streaming before hibernation, this means
> the USB resume path runs during that intermediate THAW phase, even
> though the final RESTORE path has not happened yet.

Yes, though it will not happen if the writeout fails.

>  From the driver's point of view, that THAW phase is not semantically the
> same as the later RESTORE path after booting from the image.

That is the key point. In the error case it is.
  
> The difficulty is that USB interface drivers currently get
> 
>      int (*suspend)(struct usb_interface *intf, pm_message_t message);
> 
> but resume-side callbacks are only
> 
>      int (*resume)(struct usb_interface *intf);
>      int (*reset_resume)(struct usb_interface *intf);

That depends on whether the device has lost state.
  
> so by the time a USB interface driver's resume path runs, it has no
> direct way to distinguish a hibernation image-write THAW from the later
> RESTORE path.

That is not true. A thaw should call resume(). A restore after STD
should call reset_resume().
  
> The immediate trigger here is UVC, where resuming the streaming path
> during that THAW phase can turn the camera LED back on and cause other
> visible device activity even though the system is about to power off.
> More generally, review feedback on that patch was that solving this in
> individual leaf drivers would not scale well if other USB interface
> drivers ever need similar behavior.

Storage and UAS devices need to thaw. As well as the devices listed above.

> So the question is whether USB interface drivers should be able to
> distinguish these two phases, and if so, what the right interface would
> be.
> 
> Possible directions could include:
> 
>    1. Exposing the phase distinction to USB interface drivers
>    2. Handling it inside usbcore

Not possible. Some devices need to be thawed. Writing an image
to a USB device must work. At the very minimum you need a flag
and a mechanism to handle a failed writeout.

>    3. Adding a USB-specific callback or other mechanism for this
>       transition
> 
> I'm intentionally not proposing a concrete API in this RFC yet. I'd
> first like to understand whether this should be considered a real USB PM
> interface issue, and if so, which direction would be the least
> intrusive and most maintainable.

I am sorry, but your basic assumption that all USB devices can be handled
in the same way is not correct.

	Regards
		Oliver


