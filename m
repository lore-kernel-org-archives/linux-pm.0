Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7226B39FCAB
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 07:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535052; cv=none; b=aiF0fGBFzwyjYnOj/fgOZIJc6ehrd091tu4FLSzGvD41wzYxyOGpkEti+ugwrPANOwTmwHlByD2tMgB4tIYQZsX9wfmzxRiFRZb8WR5V0iJ/g9iSysgFrMk23H32UMvASCNYbkn0/Mm48yQhbZCFKg6ArT1m98RP4ETolXoV9Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535052; c=relaxed/simple;
	bh=xQAiWiKRZknMt4OiF6xRbP6A9xpo4UcsDr6nkkq1v3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXK+CEBLhalXU1hfXX7VAnRNDf3XiJqS2+yS/7Jn9KTLNbHl7RFzg8y1Ik0xYCgtiRrk2OXvLnxKjgFn+aR8iPQHsRNVI/Yc5xUpwBAAq62pIjwG6B7XFXt34m83TqvdVjRFDh93S6J2zmI795tO+6cyfVQtu9Jk7bfHvGTqFGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=bFb8c50c; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="bFb8c50c"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43fe62837baso318545f8f.3
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 00:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777535049; x=1778139849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xjr3lQ9N85a7v4wbfT9HJYQv0tAfWVt69OdXRIx5aeQ=;
        b=bFb8c50c50RLq/L6Hp4X+Dth1+9LEo8KPouDqKcw7hc7Zmg2I9MptGukJnHL2UaIly
         HD4aLwJHDl2u1lKZS3rWxYr2Evdu9D/Tmj2/xyktSJX+zACz83lAAxgmaleQK4feSVEz
         kUSCJvP0qkpcugfe2wNFildvbehSg6ONQ2TbDrT28NBbYfGKX3s7P14vw8UUy59aPItG
         vYrItOZtAJzlz6pJPfNtkbNHKMM1ci8zQCrYQQ4+JlhCf/BitBMdmf4UfzSQBMLu7+ye
         Pu+M8m215PqdOxmYrWr8gTzg/Y7sq6GuVefmNEfivraTkWxNKJyGkoURQDCcvUhQLsat
         ABMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535049; x=1778139849;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xjr3lQ9N85a7v4wbfT9HJYQv0tAfWVt69OdXRIx5aeQ=;
        b=MV9dLV10HIvtXLsjdTAbq6Rw2fCJOPsHOV6Qnq8g5aYBhMy4jbZOF9UhADGz/Kvl3P
         Rg5lKO8agQF/pSqeetGwR2IB1xDvdDQlghluRNWv5cv3DqtzSG/0XvnWaOSfqxS4m7sQ
         rSl7Gzz4yjUbKpHT4Fu6r0PjBK82MIUAui3kPmHrjh8wpa8lun6iwckdxD2fWM390u/y
         vx5hpumNach/+NQYueJiW161WP64Mt6xCueJkRAPy2eGmOuPpaEQ5ueDOanQRgtGCgH1
         F0geHsku/Xj080kya3UmO7BHUIblhlTkYZXihHzRobEV8WZC+AxeHTa+QOuflMyhchb/
         wuSA==
X-Forwarded-Encrypted: i=1; AFNElJ9S7oi8PWWjzWwf+JiTH4MZXUWnCm2ZRLpqyFy+kjC1iH1DSSrxdk8IuYT2BhaA2dTmk59xzUQogg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzN+VVYWhrpJD9QvkDOWkksMjOQRBT7Famb6rKQZEajVkL/tNlk
	J7W7UEqTo0W6x52LxYMx0Fx63sdkpR9YCHJt3jIVgCap3EQLHsassc+OZ4cSY8bYzwg=
X-Gm-Gg: AeBDiesBFMCraFfxQ8jC+heaRCUPJGekXZYc4J+e6sxgf24Jc+eNW5JoQnQPyQF5kzQ
	JLo2Hmt/I+hICpEUNaTDZy02o2FCbwJgtG9MQ7IVoCGEySliO//2Tx/yRXCRlOfgwn+2DDxRp/s
	1BL+3nH8hGCWWkU/+Kg5ftat7kDx2wzVxOvPODTFwte1ZWz0VTuuA2QlgH4GAOat3uwyZYStm33
	I7D6Pfb6mTVihFZ+ogqi+E7uCIjZkv/m5LhZkA7t37ZU9fpo43l5FCw+8u1Yije8NAYT0JpJDtO
	2ufW7KdHpe33yJ6ALj/teXbVw8ZVpCe01jGY0m5P5d+cnGHEhuHHJmRlgYabnw36p4g3rUeGGMG
	D8ybY1x3/r2OJMcw7kjHLBoSmrSahWX8OVSVCCpPIn0ai0ttZio49zEaWw0DjggJu4O97Hg6P6V
	u8OWrM8Hrz6uWKM/d37MV8HKcXdT9z8BDvTQ9leNBmrN0Aoztm7GJK30pGrhQy38OYs/DFX4u0b
	YLFMH77RISGpU9J
X-Received: by 2002:a05:6000:2389:b0:43d:14ae:1340 with SMTP id ffacd0b85a97d-4493f812569mr2534686f8f.23.1777535048727;
        Thu, 30 Apr 2026 00:44:08 -0700 (PDT)
Received: from ?IPV6:2001:a61:13b3:7c01:f1f9:97ca:8fa3:c597? ([2001:a61:13b3:7c01:f1f9:97ca:8fa3:c597])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b72176fesm10563356f8f.17.2026.04.30.00.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2026 00:44:08 -0700 (PDT)
Message-ID: <8591a0ab-2d53-4223-99e6-fdc15851f737@suse.com>
Date: Thu, 30 Apr 2026 09:44:07 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] USB/PM: should USB interface drivers distinguish
 hibernation THAW from RESTORE?
To: Haowen Tu <tuhaowen@uniontech.com>, stern@rowland.harvard.edu
Cc: oneukum@suse.com, gregkh@linuxfoundation.org, rafael@kernel.org,
 linux-usb@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 laurent.pinchart@ideasonboard.com, hansg@kernel.org, mchehab@kernel.org,
 pavel@kernel.org, lenb@kernel.org, kernel@uniontech.com
References: <37c9bf07-7b21-403c-b4fe-d54ff6f811db@rowland.harvard.edu>
 <20260430021433.2083281-1-tuhaowen@uniontech.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20260430021433.2083281-1-tuhaowen@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 30.04.26 04:14, Haowen Tu wrote:
Hi,

  
> But after your replies, I agree that this is not really a USB-specific
> problem. The more fundamental question seems to be whether, in the
> current S4 flow, resuming the full device set at that point is the
> intended model, or whether there is any room for resuming only the
> subset of devices needed for image writeout and whatever else must
> remain functional during that phase.

In principle you could do so. Your problem would be
a) computing the subset of devices that need not be thawed
b) error handling

>    1. a full THAW of the suspended system, as it is today, or
>    2. potentially a narrower resume of only the devices needed for
>       writeout, followed by broader recovery only if writeout fails.

Well, that is a question of motivation. Why do you want to avoid
thawing devices? What advantage justifies deviating from the simple
model?

If you really wanted to do this, the implementation would be rather
straight forward. The difficult question is deciding whether you
want to do it at all. Do you have systems in which going STD is
critical in terms of performance?

	Regards
		Oliver

