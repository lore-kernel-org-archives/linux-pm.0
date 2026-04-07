Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38978355F2D
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 06:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775543610; cv=none; b=WUOa7YAqQ3q/WLJk4QGqGQpjEoiCrNkFeUQXujwxHACbVuaRRSDiQopGCzN/A+9D4TvEBt6p827D4LnjQf5O6M+tGhnpUSP6Xf0bMQpUGdy/tmw5qG0Lif2LbOmXMTo9JIfJlGzGXtFfZQfqXV6PSvf0HwQlpg/5gFAQAzi+uDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775543610; c=relaxed/simple;
	bh=Nc3bOboW8G8YyE8KUlVfkkXGtFcb/doRT+XqIXAl+cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ULw/WNGlt4Ht/qH7UzBBy0lLI7ib5d3X+Rqf2UA+qiHGBcTyvMFATCiXs7t9SxBl4mQ7+pPp0gcB05cE1fHihBQgkE07ghFwX1m2JjwzB7gtcgKcs7orot3fD+3suh+M0eeqXJBPwlGwH8c2lvyovxgVg1QihhDdfLStEA3Rhhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y0OAcLTX; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y0OAcLTX"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so5229136e87.2
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 23:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775543607; x=1776148407; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5hh7N0O0yJ7/rQ4HnXnBh/0FAbt8/xLYUBmuoc28N4=;
        b=Y0OAcLTXjRUAgB4az8YoTWRgIkIZ9LiO9kVXdbGNKrfETFjP3uK1QA5M9cHZ93fJ9h
         lUqCkz27MXy90T2WVvTrUUpBuih1L527iejnzZI2Ugscnb21jSQU0I2+9WYqBXjZvkEt
         LvilwOLuXeFStGr9scXUryTyIkDnYOAeixt/t448iwgMWSJo7j/t6zVO+3rwyBgF1rO3
         rYzugylhXApVkfsmUiw6gMr07qkmVJrhWH+g+bW0z/Pdk7DVuh/F1G6PfBxq8z4o+q7U
         bSspnOAvxsnd3Eq6PLg8UGzcvtlEIwCM3Gb0QMkU+OLU6sgwZDRB441NpRhPTfoPFRX8
         e1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775543607; x=1776148407;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5hh7N0O0yJ7/rQ4HnXnBh/0FAbt8/xLYUBmuoc28N4=;
        b=VH1Aynqs7tgUm1aLKGKDQt9vdwelUQYNqUVQTap7bU5cpqxLbEaM59fQ+RMcWd72VJ
         aM2YQtFdaqIjh/2ZPNPhwk3DiNnEQ26X4j+u/UwBdFHM2YhjjIXJ96XylF18JU+B3OJm
         S5ia/N6I0I25Yw/znWktWDmkyMrjR8iwa1snFDWBfYltc8404wCXqQo9k7yYEWgKazV7
         uLWwjZKLHRuVCF88mnnLracQlZNDl5bl9zDQnpf7oAnAK2G3jlFhQ9loXQxHMND0SzMk
         vbcpiUN5USazjmsV/Rbu5tIsZIuuTLOqcMqGPIlFD8dAodFRMECjrltROPn82jFmwLge
         prUA==
X-Gm-Message-State: AOJu0Yyp0DcvO7NK8TeMTOkpbv6qHWJfMM2B6q8RaOEZAxKRqg3G1zgn
	OAcz18rE6bx5MbteZiMvXxMhaM4iCj6Zqs6qcB1LDklmPoyk9EGt/ZTP
X-Gm-Gg: AeBDietQ74ljKAi+vWv1DJkSXWio1Z5JXamVw/K59nI6DppbVJDh39zhUkZBPAy/i/V
	MQtaI1xEL+5SEf+LSSHMz21FtUHeAfiecONs9jbSYnoot7WlrRuSN6EG8zk0Bmj8FUqTF361YO2
	szACSuPFuxs8b/RkxQW8Uw5ro0b8XKj72lydGqtH95ygEEbWse1KoiakBCP523GJ7IHrPGtRf1i
	HEQ+CMrlHxkkihNAyR8zKq7oiVJvBefhdUu2dlOvMqdNlzGDkp5I8nZaAZz1lOC82t2yiFuhTha
	u9PjKc5jdrgmFL2JlBEGUd7iqgdtr+CdRZcBiLglOOoKHl/70a5HQD90Ka8uOGg2qrwpWk8hTdE
	lx7pS1qIKRA1WP5TnND5O4AQIUptzAeNCR8PS0TsLZDpJUumN79TJa2CdMHWCAy1NDR9qHLAfWV
	vEkisMwaPfpIA8tTImLm3l05hgyZMuDkRIZxOw/E9VVJSRwSXV4YBNWEoAMFtroMZLYJ6n6whOG
	JkZRcMPqChT6a/qmxQ=
X-Received: by 2002:a05:6512:15a7:b0:5a3:d302:bce4 with SMTP id 2adb3069b0e04-5a3d302bf4amr3877138e87.39.1775543607211;
        Mon, 06 Apr 2026 23:33:27 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6cd6799sm3831813e87.81.2026.04.06.23.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2026 23:33:26 -0700 (PDT)
Message-ID: <a4c43b29-a1bf-4709-8521-c21ce4ee3e46@gmail.com>
Date: Tue, 7 Apr 2026 09:33:25 +0300
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] power: supply: bd71828: add input current limit property
To: Andreas Kemnade <andreas@kemnade.info>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20260401-bd-inp-limit-v1-1-689eb22531e2@kemnade.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2026 00:17, Andreas Kemnade wrote:
> Add input current property to be able to work around issues created by
> automatic input limiting and have some control.
> Disabling the automatic management is another step.
> 

Hi Andreas!
Long time no chat :)

First of all, thanks for the work you do with the BD71828/79! I do 
admire the effort you're willing to put on it :)

I decided to just take a quick look at the BD71815 and BD72720, which 
can be operated using the same driver. I didn't see similar control on 
BD71815 data-sheet, so I just decided not to dig it further for now.

What comes to the BD72720, there is something:

The BD72720 has a VBUS_INLIM, which is a configurable current limit for 
the bus. This, I believe does NOT directly correspond to the DCIN limit. 
It _probably_ has similar impact when the DCIN is supplied, and when it 
is powerful enough to run the system. However, I believe the VBUS 
current limit is also having an impact when setup is powered from the 
battery, or when it is in "battery assist" -mode, (where the battery is 
used to "complement" the DCIN, if the DCIN isn't strong enough to power 
the system).

I am afraid I don't know your use-case for the control of the DCIN input 
limit well enough to decide, if the BD72720 would need something similar 
- or if the VBUS_INLIM should be tied to the same knob. If you have the 
enthusiasm to write some more words ... I am keen on learning! :)

Yours,
	-- Matti

-- 
---
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
