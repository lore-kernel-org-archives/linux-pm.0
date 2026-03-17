Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16369318ED6
	for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773758131; cv=none; b=cf4VkMdWro5dYhIN1j3ATyEOUIUzoFNLTfLJqWettjmqNHq0qyo0ZFoQsF7x+1KPHJMlgOTUZ7hs/HMmQ/7n9/3vD34kzaoFrfo1paz8XKTXVxTq9+4fO5Fe8wjcvcA3eSP2JHTHS02RZZTW9gNb5/QMpFJB9d/32cyMyH5iewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773758131; c=relaxed/simple;
	bh=VcSxu7+Rt6pjbVzIfjpQ5S4/EHYXb1jK8VCuGDXYnXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4HHGmtIS0i0YV8EJgQB5HEsVfykH9x9Xxps2jMrQqywUmC3WNbeT0pJtZyGoZlaP9HTWs+3WgieUcYsao1iUjcG4ES5jcSKux6EJPseG2C2akNdMV8VxMLZbX8HtzleLu9G17uN1ZR82PqYHWuz5k3/WP65u2M0DcaHZjBwwPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MH9h2pPp; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MH9h2pPp"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso66879125e9.0
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 07:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773758128; x=1774362928; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9Cwk0sufcQW5RoTCtoeXyYyIvZ59fFS2/mrNoD7ViYI=;
        b=MH9h2pPpOYUB+MNhiRorZ/kSJVTA/4li+JmIFIVVE4hMYPlycdOlZEKiw8qPMhZPPh
         39dckjk3pyeObUdQnWl6qU30duQYaMoCQ1TkMGAOuzzho9QxZVDa9ziXpLHNqk7pMglS
         TF0Nji6FOWJzOzTiebIixKwt7GzQCwzvzJmvC94nOKYg3HYX8GbwnIplZ61s/N7JPS6u
         3iPx5BK3xWPtnnzF7RbCSr+kFVVvkroRu2O3qeLXMvkNKQRttPQR+pat7fOpSV2N58Qd
         eE/E8h+ZZt+Vz4HU0z1RFQGjk3Agv2b0UYk5i1wqS5ErsaX0PUv4N8F5kK7a91rebVzI
         zyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773758128; x=1774362928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9Cwk0sufcQW5RoTCtoeXyYyIvZ59fFS2/mrNoD7ViYI=;
        b=j6cBBQ1mfBoTAVCfSzbRbpFiOIBpN0CDloRiNXNMUY8HikeFyFK/lISVumVp3PZ+DJ
         CFedRDHzrAFmlgykhenZbqoTDcMR3OMtRY3GYw8vwkuI689yAqjyctVlnOliAWeTmfAF
         H/zSIL/aOYJ90XQ+vgGucUrs+RD/7yB3NC0EbM1E7QCMN76wgGoNWAxmTd8VIv3iMi20
         NUDv8mE36jpKysu3Zgyvv3s/hlKktnw0cQUKErF7RXA4iBqp9NxNzZh7/Qf8aZiu4BQf
         n7zYkukYcaLiedT5xIsK2Mn3Od3I0WMXNzBHhLZT7IJfFUCabhlB/PJYJ3xp+OT1i6OO
         BaFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsHADI1VPaZRSVake1EOyOSdzEt/a/9d5T69AIidZTNY/WnorWs0Ue6nJlklEDe0HvoEBUftAgQQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywcx9C9s4NycCM13O2qhWyT0OMYYZSrXCYK5ek47Vn4glb6FbXS
	XYQa8jBp/vE6I8VYWAYFNef5VseI/7y2IkG5c1Y5CIyAroiDqa6tBbtx9qd2ICgSKkKuR34TQ+q
	68zU3
X-Gm-Gg: ATEYQzzVBQ4FHIp457lxHXmpOHtQmqEfuXKyHOpVbixIxtSaUUH6oIrp763C+r97PZS
	5ISqBcYjwCyxhPnlhzrjJxlolDQFZfjg+t8jsqqN4+W2RdsiYDXqSQqyFwZhoOVUt0Gp1LoCrgs
	u/1ttoUrBVB7Rk5/eg3w4MlaKCsR9DuqktiLtEywMlxJlKq5btmf1ojfz+t67ewTGPKcp9y8obV
	EsB1333t/DKUkfAU9u0D1oEEKzaUDzdhG2c+F4QJgqP97m09onruD1KRUeenzwF4zi+rOBfPOqD
	7O2DDF9TMlRM+WkJW+ESR+oZB3Da1emxUpcD6haKuoyFZ5neS3M5ZHrKWCgVxaRmOGT1fbUPZgB
	ljr08dLW9GuSj0og72mg73ZSjAiGCgP5Q9tuST2Tn/PWW7moxq61Zle5J+1dmog0X8iAQwz50hT
	cewTOCniGNDg/FgcA99t1HPjcgRWULCW1WyNVYwMQQyfvMrJWwvOjIy0nUccW5Uoh0Y6c=
X-Received: by 2002:a05:600c:4e8e:b0:485:34b3:8587 with SMTP id 5b1f17b1804b1-485566d7035mr274762245e9.10.1773758128320;
        Tue, 17 Mar 2026 07:35:28 -0700 (PDT)
Received: from ?IPV6:2001:a61:13ea:b101:88d5:cd46:69d7:10e4? ([2001:a61:13ea:b101:88d5:cd46:69d7:10e4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557a74266sm112003685e9.17.2026.03.17.07.35.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 07:35:27 -0700 (PDT)
Message-ID: <03344b43-b3aa-4800-b4dc-0b5a2b2fd5b4@suse.com>
Date: Tue, 17 Mar 2026 15:35:26 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATH v2] usb: usblp: add the reset_resume function interface
To: Alan Stern <stern@rowland.harvard.edu>, shitao <shitao@kylinos.cn>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
References: <20260317125614.3215254-1-shitao@kylinos.cn>
 <c4f66c3b-7cb4-4bcc-868a-d3aef2d9e521@rowland.harvard.edu>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <c4f66c3b-7cb4-4bcc-868a-d3aef2d9e521@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 17.03.26 15:06, Alan Stern wrote:
> On Tue, Mar 17, 2026 at 08:56:14PM +0800, shitao wrote:

>> 9. Result: kernel panic in pm_op() with use-after-free
>>
>> The bug manifests as:
>> Unable to handle kernel paging request at virtual address 006b6b6b6b6b6b93
>> pc : pm_op+0x50/0x80
>> Call trace:
>> pm_op+0x50/0x80
>> dpm_resume+0xdc/0x200
>> hibernation_snapshot+0x234/0x3d8
> 
> First, are you certain that setting the reset_resume callback equal to
> the resume callback is the right thing to do?  Don't printers hold some
> state information that will need to be restored after a reset?

Correct. This will not work.

However, if we take the trace seriously, it means that resume() was called
after disconnect(). That must never happen. Yet, if that happens the issue
is in the PM core, not USB.

	Regards
		Oliver

  

