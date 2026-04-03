Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77315B0EC
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 11:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775214179; cv=none; b=pfOafhz2aQWqXMaSvUa+3xNrTJMWN9hcNkGSJ9NmzhA+VD1jxcyqKXo8wEqShEwJXdWWJ8con5VJVqXnqBq/V9X/m7HFe4uANR75SXqpPz9DbuRPfXu770kaBKarZetV2SB9Tu6Jkm7jEDXukFqeUsvzS6O/Eru/mZjlILSeUkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775214179; c=relaxed/simple;
	bh=+bd/o6zo/Dz4hDZT1f1AfVLw2z7eQQ9XFvt1pNeQfr8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvEzK+Oo9Eg4F3p+JsW9+6l2P+gulABReNw4artNE5SF362dw1KOK3MTdsuxabc3QxvcBSInhYGcwRS5SA8IuoEHG1c5T4UHUFXOpRWHMycANYEMoZADBD1sr+UgoSyAbQCgPJpSykgXmTnuAvUzMZiNV6BNsUvD07EuFyMYzg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDfq81eK; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDfq81eK"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso17958545e9.2
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 04:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775214176; x=1775818976; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1Ju7lTcPs57QyWbn0I8Mi64jjvZvbsJY3R3w9IS8LCw=;
        b=jDfq81eKUmdCJjNvfQxI/+tK48Se+ro7FKbUY1YKRMNyqsAmnb7NZY6hjthyLijG3/
         cFI6FGgItKlqzeLVElcM8pJttYickhabOK7oHWDrwLBgBFahuD6e1RR1oK4G+6lbFrXB
         7IDE0liVElnRgryu12Y8Sa1NXRyagdEduBZUicSZtRrTfMsChnRdbstdOWS8w+BpGsft
         MTWn46xDBAK2udDkHMh4N0D3nIFZn2qqtGqUCQxDxKUQymqPd7gtZy3VY3kSJ/VlXyYH
         4HD3X1zdtCtQ9/8z+SOttG6D7TZUSTvc6rXBsHIWDlv8RhzkxACUfYlUncvxFad0RiEa
         ZoBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775214176; x=1775818976;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1Ju7lTcPs57QyWbn0I8Mi64jjvZvbsJY3R3w9IS8LCw=;
        b=LpUipB/k96fm4HMvFnjECGS5K+ARRnLI5QHTdGHZaXu4upR0203FUiWbJ6/eZPZ8hS
         RmwmDRKimijly/OiPgDtZnTIoFSaiPKqt5bdbQdOWFF8hPee25uinRypakFMXDYQAJwa
         F3iLi65gWrCHoToYaVfeptlEyK0VzrI8VGBzsNlqrQn35Bzoe7wPfgNzEdrHzN/iuc2t
         oMMXANp59yOHuL/fy3ay/ZeXWOLyUGTRARyMvPLiP5CenC7cjqm6AsA/NDM5VPn0h27d
         30Fs5/oWwMIGhvi9gBslLvABb5FFNWpdwvOHp+C//YcCuM658RGZ65tRkIeff9g+DUZw
         L/SQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoa73jkhBgeBamcFQKgOgBy9bso/8x5kXxfp7JdB2nzzU5iPlndnA3X8SefctKTOUrov/MXP0vrw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxexy9UbZL0SAJJChZyj8UkK4pCGu0rIvlyeOwaBa7ckllx8VJb
	wK3tLJ/zlnONNJNqVLDVlXiI3vwtgoVB5KaJcrShf754kfeVMt6991B9
X-Gm-Gg: ATEYQzy3vH3rHyC6zkdweFLaS9NETmKGHGYDLKN2U+0+fiZbsgGySjBJWcsw0H/6vKk
	kBzj3gyv1wPQTdJqo/UqImiOi8XdjxPFNa0Ds6KUCNsgJvRd7wgPXySGiZuWv8Zgqa2joAtP4pw
	yFANNttwr/fjQsqsjj3QA0uMdIh4vhU0lBAqS41LT4Ne6ZRot3f4tAGB+uoYCnSUan5ANyIAdqK
	RP7pc05QXGzSJ1ANsF7KSpndrG8tVZJ54nWaNo2NiR5TpiaX8Vr+UhM93zyh1ws67HmNwaNUQiF
	jwLEsUNUfR3aTK+HwyX5M1clBZj+X8lZ+cOwCFPwr+pH5rYyfBM71VSi7f9rnbpd1I621HVv9Q8
	65EGJtIiJ92gNXRLA6c3HXkFkhgP3EdgOEdje2bBH8j80v30CLrLOZWq/BPHj7V3Kk8B1F4XS0I
	lbixN/eE6vIN4Z4uu0CqwouC/dDnh1rIIjstwSLrdSDRoJ5wiL0g6+iOjts98rrhfuJ86ECn/Lo
	sNc/tqdoR7cmFPxzWlDJd1SYGG4nUBbHF7YP/HTfGVtURwcXb2z0NGSGODI5neXNH8Brr5MtC4K
X-Received: by 2002:a05:600c:4e0f:b0:487:288:1198 with SMTP id 5b1f17b1804b1-488997b7b22mr41612765e9.22.1775214175997;
        Fri, 03 Apr 2026 04:02:55 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2f:db00:6561:9024:520b:6259? (p200300ea8f2fdb0065619024520b6259.dip0.t-ipconnect.de. [2003:ea:8f2f:db00:6561:9024:520b:6259])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e832585sm486166925e9.6.2026.04.03.04.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 04:02:53 -0700 (PDT)
Message-ID: <f0ac89b0-2b6d-429c-9716-51a00832d7b2@gmail.com>
Date: Fri, 3 Apr 2026 13:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / wakeup: Allocate class wakeup_class statically
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 driver-core@lists.linux.dev
References: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
 <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com>
 <744440a6-e1cb-4792-a848-57755de0686b@gmail.com>
 <CAJZ5v0i5dSuQ7f8Okb-Ch5igzNn=L_Fj5d3H4pftvxoEVBaDUw@mail.gmail.com>
 <0758441c-e88d-475a-80ef-061b227ae7fc@gmail.com>
 <CAJZ5v0jTTdJDPDk3ACVpjP=S5nrA-vddfKBnFRyWSbHCuWWKQQ@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAJZ5v0jTTdJDPDk3ACVpjP=S5nrA-vddfKBnFRyWSbHCuWWKQQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 03.04.2026 12:45, Rafael J. Wysocki wrote:
> On Thu, Apr 2, 2026 at 3:05 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> On 01.04.2026 19:32, Rafael J. Wysocki wrote:
>>> On Wed, Apr 1, 2026 at 5:45 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> On 01.04.2026 16:19, Rafael J. Wysocki wrote:
>>>>> On Sun, Mar 29, 2026 at 6:14 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>>>
>>>>>> Allocating wakeup_class statically avoids a little runtime overhead.
>>>>>> Define groups and device release function as part of the class, so that
>>>>>> we don't have to repeat this for each class device.
>>>>>> Whilst at it, constify wakeup_source_attrs[].
>>>>>>
>>>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>>>
>>>>> Can you please have a look at this and let me know what you think:
>>>>>
>>>>> https://sashiko.dev/#/patchset/0fe1b679-ab28-4505-b0db-14e7ac3ba749%40gmail.com
>>>>>
>>>> Interesting finding! I think the diagnosis is right.
>>>>
>>>> But: I would say the current behavior isn't a nice solution as well:
>>>
>>> It is not fantastic, but it doesn't have this issue.
>>>
>>>> wakeup_source_device_create() does: dev->class = wakeup_class;
>>>> I think no reader will expect that wakeup_class may be NULL here due to
>>>> initcall ordering. In addition this behavior results in such early
>>>> wakeup sources not being shown in sysfs.
>>>
>>> They are registered too early to show up in sysfs, but they can work regardless.
>>>
>>> I think that it's just pointless to call device_register() for a given
>>> wakeup source if wakeup_class has not been registered yet.
>>>
>>>> But I'm not sure whether registering class "wakeup" (and registering
>>>> classes in general) would be possible early enough (core_initcall,
>>>> or even pure_initcall).
>>>
>>> driver_init() is called before do_initcalls() is do_basic_setup(), so
>>> class registration should work for all initcall levels AFAICS.
>>>
>> When testing the current code on my system, autosleep is the first wakeup
>> source, registered in a core_initcall, and it's not shown in sysfs.
>> Same result when class wakeup is registered in a core_initcall
>> (instead of postcore_initcall). Registering class wakeup in a pure_initcall
>> works and fixes the issue. So, would this be an acceptable solution for the
>> discussed issue?
> 
> I don't see why not.

OK, then I'll send a patch for it. I was asking because comment in init.h says:

A "pure" initcall has no dependencies on anything else, and purely
*initializes variables* that couldn't be statically initialized.

