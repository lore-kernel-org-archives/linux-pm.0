Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B071C377543
	for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776411227; cv=none; b=kq0lTZEVXcNqvz1MWVOFZAwpPhCClbwR05hl4ignwzIjUeO51K9pGe4++3dAlLumaRIFwoKWbV+Qd+l5zxFpnIIxsJNedPYWIvayyH4ZRLCJGLtwuSOJ0w3RLjqiyx/iqXhtdkHnXPbBplSt7SVS2Rw5A4qMZGEfSnu4h3Lv618=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776411227; c=relaxed/simple;
	bh=oeOG+ZszsRTbVirZ6pWNVku8hciqTAMTRMfyh9Yt8HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHuke/0SD+nN8jC1GQqiRWqUxxK6y4kL27OW6sC+5Px3DrZCWUwuxKOrmvrZD0h8IKToBIqHt3GP6TLbgOKCJ9fqZRatpgKxyYHUNGwXpcOoRFEmqH7fNk/8kelZxYon5LTR/NK5DgnqPZli9E+S1azFDSksXBSWP8gufsGc84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBMJrc2G; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBMJrc2G"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5a402dea4a5so412935e87.2
        for <linux-pm@vger.kernel.org>; Fri, 17 Apr 2026 00:33:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776411222; x=1777016022; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HgHTSvY/2XubmQ08/1S3AfuwPBtJv9x2QvMC8191EmY=;
        b=iBMJrc2G4CorKfkdxW8ZQhyL2VHjHz9PKIqnV3xcYZSk1TbvNiyHLIMsBCy8dLYib4
         4UOgkYmz2JwCTkBC4Dx8VrUcGuN7d7+8ER3bxAkN0s9YxSIBryjDCzgloz2zNJKIsc/3
         sPVvFZFZ0x+mcqHZeik9IHB7YuUQTOP/M6LHrsXBn83iOI1HFmno0maXsYYXmVzpec+W
         7zNM0zzRn4KBoeQ76fkZ7pvSS1tmXSqxAmEnwfnq7KGHdKjLjJFY7KxN/qAgtw9MxcxU
         a+DW409WBxrXH8ty43rltgv+Ka4YMFhBx7Xhs3c5aYIWgAcQaPp4UxTYCCrH7ml+203S
         NL8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776411222; x=1777016022;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HgHTSvY/2XubmQ08/1S3AfuwPBtJv9x2QvMC8191EmY=;
        b=rTRAlaIDuiVwOS8p4njVmZPz6w7m+b+YKc+kcglQ3dPAjHQTocg/zoVHkVtxGPDnFd
         wh0CxQjacHur4W62w+On2Va2EVTsiVA5e+X0obLOe0NMNkMTg99reqMfHKzEY2fTR1vf
         eGWciPZJqw8F6gSWlCJdl2dhGyGCEUl6Jx4MhqUpj5wzZpgikrIupnPalzaVIujto2uJ
         vn47e6Gkwd6Vvf3GkJ9Nb5XMd1R/JK//OnnWa+NZtwe+WC+0ofZ+d/iYp6JVS3ja5thr
         2IrKN3bWDBN/N3cuXFr7Wx/TTD/vp5BpgTzxnzCDBJAIwkomqKGQ2+kfMtZzFrCXpuQj
         PNuw==
X-Forwarded-Encrypted: i=1; AFNElJ+TqNt3aKy58QURy2PXlNRo+gfW4CiFYtJESPFiahcm+UfBYpLL6FfQsKJ7rsiBg5TQIpwcXCjvuA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbk+nYet9Lgsda7yi+ol1r15KxQP7Dm1sIQ6zIsu7ErKj1rr/u
	5Yv48u2Q7hxRmf141k/T8qFU3CqpRnJpBml0L+PdpIVUctPlrznZ59hK
X-Gm-Gg: AeBDieuT0Pz4mfTqRJtKqzT3M/m31592AE9cnnaTqLujLALYgBfAYam1gRJZW+1rdEI
	2tKbGjPwfPIHBuUBxkUDhAjHFfKgaZZgGJIFPmkXciGdTyBxt9S/ChIM0h6GhiC55GY5i0wkgyk
	qRiqTkqfPazrYtpjcckrJa8MUh/wIA20sbRNnf8Y2cENu8+r3CgbjYa2OnkYknF7XhKao4MfUi1
	qdps5iA6oMAjfMz/Kv2Rq1Ry5ueWTd5I0qlI4WxMR1SuztcPfSfZnPghnLvXZJfZOZLNiv2YsoE
	8pl67oMbZ2RBDrPmQOecc7+KXYoYEvebuPrFecDS8xOHk5cJRppMuJ0JM9GrtXMIIStqc2KV7As
	EWmz9cKRNF2EVI4gftjFl40A9eL3NU5rZL1iG7XrRNh1CfmLDPyXgo7bakre6PAfPu5Iwi72qST
	qLilSBcb+sh94r/zoxNsHj8qOKnXAsIs05k59Pn+gFX0E6ntpo0GEHlbsydOY9vC0nVXaFAX6F7
	dTmBZbuKbZd8AhSxKQSYCm2GckHdQ==
X-Received: by 2002:a05:6512:39c7:b0:5a2:a703:969 with SMTP id 2adb3069b0e04-5a4172f61e8mr477511e87.40.1776411222198;
        Fri, 17 Apr 2026 00:33:42 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4185bc58fsm178944e87.30.2026.04.17.00.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 00:33:41 -0700 (PDT)
Message-ID: <95c60933-8a78-4908-bc51-d4bd5a3f10de@gmail.com>
Date: Fri, 17 Apr 2026 10:33:40 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add input current limit property
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
 <a4c43b29-a1bf-4709-8521-c21ce4ee3e46@gmail.com>
 <20260415221358.59574987@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260415221358.59574987@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/04/2026 23:13, Andreas Kemnade wrote:
> On Tue, 7 Apr 2026 09:33:25 +0300
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
>> I am afraid I don't know your use-case for the control of the DCIN input
>> limit well enough to decide, if the BD72720 would need something similar
>> - or if the VBUS_INLIM should be tied to the same knob. If you have the
>> enthusiasm to write some more words ... I am keen on learning! :)
> 
> Justification for this patch is mostly: there is a standard interface
> for this functionality and the chip has that functionality.

I wasn't doubting the justification for this patch. I was more like 
wondering if the use-case of the functionality, toggled by the 
interface, is such that BD72720 VBUS_INLIM should be tied to this same knob.

> The bigger picture: Attach a power source with changing properties causes
> mess. To repreduce issues at my desk, I have played around with a labor power
> supply with changeable current limitation, turining it down to zero (so
> power is off) then turning it on slowly again, no charging will happen. My
> usual way around such a problem is to clear DCIN_ILIM_EN (will add a sysfs
> attribute for that) and set some conservative current.

Right. I suppose deciding if the BD72720 should support changing the 
VBUS_INLIM would require me to have the hardware to do some testing so I 
could see how it behaves with variable charging currents. I don't 
currently have that, and I haven't heard of any complaints. Furthermore, 
AFAIR, there are some differences between the logic of BD71828 and 
BD72720 (battery assisted mode in BD72720) - so they're not 100% same. 
Hence, I won't touch the BD72720 for now.

Thanks for sharing the details!

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
