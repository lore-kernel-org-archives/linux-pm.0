Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1739453A50
	for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785336229; cv=none; b=V3tGE69+iLF/2a/2yjm9KiqlXwcpXYtP0Y/bsGfyDX72+oHxzE9MJhWKnCKDke8645FedrBfb87UNMHpDlL7SYRoAaARMLRt44DQ3q8e6quVOQSQNE3uMhoE8Y956DNQkoogkfpJnodPdUCe85RKT4CBE6LVz/YqkHO0s/49Mjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785336229; c=relaxed/simple;
	bh=oLfEIwylLehkQEMAvc2D+SQKRav1vzUm+1RG6j/CQXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPbxXP2mTZFqyqJMupO97Bq2wqqLLCmZVs3OmQHspqeCIxC4AvHcCV37yT2rCqKKFfrxO99F2vVj0/7mzhvaRzoVLbOHj3AvDbnum4McrXxGHS/Xr/UjIu2QZCenVEYUET8vP9AHqsNfhYsOY4lykQxqWZ6o4VyhSWuE8WjtNlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eNkSppop; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eNkSppop"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4954aff6088so10114275e9.3
        for <linux-pm@vger.kernel.org>; Wed, 29 Jul 2026 07:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785336226; x=1785941026; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=50edlJllfkH6a8WONFuoYrMx0sLpIgYxe7t4UMo4JmI=;
        b=eNkSppop1FgH77FyDoSriO2/kUiGpbuM20+Ih/X8BatynvUiOAP+swd22Rd3QDlTMD
         nv9uod0DXgVx3eg886y6TtuK/aVjiGgVcShWjYWDfIchscp8/PXInthYMvKCYXxpAh9A
         /VeNNa70UbKkop7hm/Z/OM5JwTrRPuVtXRMXd03qNKv8O5SDI5ii0Ocj2jPde/eXsOQy
         yvSXkg8Ja2n2fb1nUEgjGyrtWON24TVYQlCMUxxC5YOVBcqgrAdiC3AL8Kmr1grV/qmP
         rEL0o4dl5uQXwBBHLmcwUArg7Y3xQuFdgSi0BpF19fTseY/roI5bnJB7d20oyFeS5fZ0
         QxmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785336226; x=1785941026;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=50edlJllfkH6a8WONFuoYrMx0sLpIgYxe7t4UMo4JmI=;
        b=ds4w2YhN3sfW2aHN8VtPb9icWSF3ezsTJ9tgCCgzJR1fG/BIGxAUF3mVaQc6nk6E/r
         IA115HTdrv40/tiH4CHMY+fwNEwE+9A7GF+QEGEyZO1M+yap1TQLdWndflr8R8F4i4CI
         Bj4MlSdYVJo1Yvetm132fmPZE0CFUYFMFgWUfet6z3umHtlpWU60zyo9YiGgEysbYrFI
         b1HPvF/TbiDQdsakSzZgG/FA/LdoT36Uueyf337nAzZ4hD9I6tq/uEvIkDkVk+SVOGku
         KHo5ObWdOpMasueQMlO5poEFehI+edvAvUnqWmmljb6FNX0i19zIokXts6iuZeNe962l
         b6Vg==
X-Forwarded-Encrypted: i=1; AHgh+RoZFRKV3VaHRHf9SyzqEN9NABOGLl1pR0y2m0t4ZYvIgay6xVDUIeoYMn9gIgOGTIMEovUQsv9Czg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxLKL+TdMnz4N6akFlMXzqobAqsj2Gj5vCysRebx21yM4sxOJDv
	Nr+0vEpklUb7eaOHttcAUpvtX3scJo1qLymY2ncHUb2j01cP1oio/WyYsxA6VhncumM=
X-Gm-Gg: AR+sD127QHbWYzfytdtKC/d8bssLNb93jvJyLquvUkXBzxO5FwGQWmWOKPuk5OSvgU6
	PxQsvgkTnHIc9aSiEYR6PaK+UD3f4BH07JynyeQcZr0sb7wBOEkGkYktg1UziTVv+YGQV5Eiqk9
	GaqteC0IBPwqOaEwdGRTwFQh6UuISLLLYCfVw+yr+FpcjwcQMuknQSXPZUBv9qGsVK80jEAbNpF
	OCxmIyHYeyq0gBW07Xp42unTCHclCR3v/7biXk++Yd81af+oEGbeykBxiEpGw55zF2BBBGhGyna
	6zKpZ2VVm6MD4iNjV4EYfrSbjHLNafG396NMN+44NtOcORr0/dYDZe1Td4d+82eNAFo59sbsqHB
	rhDJA7E2v/KjpUdDNOEFGvUmSTedB4WdiljTiLr5sibklnKJGF5lJCmvvBwhQ4R/vXhGceyRiwO
	ZS0ILmGXVSOM79DPLcImHkioeZKC/QInpW9NHKrVCC/dGHXR78M1iqdCc5grfZ11p9t87QuJ7vz
	lPwjQc3SYQkFFs55hfz2vycV9JnKe6f
X-Received: by 2002:a05:600c:8b2f:b0:493:b56b:c45c with SMTP id 5b1f17b1804b1-496c6581371mr69751225e9.30.1785336225979;
        Wed, 29 Jul 2026 07:43:45 -0700 (PDT)
Received: from ?IPV6:2001:a61:135e:f101:ca2c:3cad:536e:8acf? ([2001:a61:135e:f101:ca2c:3cad:536e:8acf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4976bd45fc5sm40613485e9.1.2026.07.29.07.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jul 2026 07:43:45 -0700 (PDT)
Message-ID: <5d36c6a8-bbc9-4d5f-8670-2993bdeb857f@suse.com>
Date: Wed, 29 Jul 2026 16:43:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/4] media: uvcvideo: defer streaming restart after
 hibernation snapshot
To: Alan Stern <stern@rowland.harvard.edu>, Haowen Tu <tuhaowen@uniontech.com>
Cc: hansg@kernel.org, gregkh@linuxfoundation.org, kernel@uniontech.com,
 laurent.pinchart@ideasonboard.com, lenb@kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, mchehab@kernel.org,
 pavel@kernel.org, rafael@kernel.org
References: <cbac4803-cf65-4b8b-a662-073189df478b@kernel.org>
 <20260729075655.1187692-1-tuhaowen@uniontech.com>
 <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <0e22e9d4-da39-4d3f-9492-5c74295be312@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.07.26 16:08, Alan Stern wrote:

> You're missing an important fact: If something goes wrong during the
> hibernation transition (for example, if the kernel's memory image can't
> be stored to disk) then there will be no RESTORE phase.  Following the
> THAW phase, the system will return to normal operation.

Right, but that does not need to mean that the driver has to be operational
at the THAW phase. It has to be operational before userland is unfrozen
again at the latest. The difficulty how the driver learns that the system
will not power down remains to be solved.
  
> For this reason, during THAW drivers must not assume that the system is
> about to power down.

True. For this reason the patch introduces a notifier queue.

Now, that you make me think about that it seems to be inelegant, as this throws
away the proper order of the device tree. It seems to me that we should
bite the bullet and go for the big solution:

Split the THAW phase in two, like a THAW_WRITEOUT and an optional
THAW_BAILOUT that is called only when the system does not power down.

	Regards
		Oliver

