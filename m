Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4623F0AB1
	for <linux-pm@vger.kernel.org>; Wed,  1 Apr 2026 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775058343; cv=none; b=KYZ/jn+Dul4adgI7dx1AYw3MI2JSCjjhixNg79eo/+v4P3n9OY4ZJ2MrEOyb20uFhB147qDdhfNqGRews2bwDVqKJGB6anl6wGJsrF8S/IGekgRChavbf6R7EoiE1yEKoZ/g1shDyHy2rV7eh9LqHVUMP8DQ7OWuKq/hzlRyPRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775058343; c=relaxed/simple;
	bh=NM5uFeeSvuv7adnI5V60GGtN5WPUAUteTNbrV3VO9pg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XAvBRiITGNcIWt/rJOsLRrn1vmYDika/Ihcnar3NcsTdCzsEkBc485dVvyTiZ1fzU7CnEpMjoCNn++bh13Q5ORn1et+ocZO2qik9NVWi3Z7dFQv8QkwB3Wg3gdYsCsoI8UUkYIRoq2Va+qPgV4TxbtuvUCQPVGpRxHZkONtSBDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zp7xGtqJ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zp7xGtqJ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d029f346eso2572791f8f.3
        for <linux-pm@vger.kernel.org>; Wed, 01 Apr 2026 08:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775058340; x=1775663140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jkjla8CaRyFo0jGmemy9X4FUXjSTK/5CQirIzXT0fE=;
        b=Zp7xGtqJK8NHfK8BPOUXMC7sXDQtwlDs/CPc93iGuoZj+AD43N4BDsciz5XwIWk+UL
         v5wkNjcntqiyQQF6JkcrM9XWXNtw+++IjYebL1SnUd0IbBQgHviOOeOmGRJ8dvOAcBfA
         Iuv9TJ6A3u84FNG63SWCjO/5edbbljafgvmOQcX1Us6FPm8uIQ2poT2OW+F9BCcaWeHx
         mYUKDxgNMQ2Q73M8Z6dL4deS7yYRuVp3qx2fBFBOqOj/40HYk6ULmH0SlIfKNFNaxXnt
         /ZVLyMrq3e+w51XiBX9R363ynwo1liOzrD4JAvvphE77Kuuw86IR2GGw07GtK7JyMZkw
         vIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775058340; x=1775663140;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5jkjla8CaRyFo0jGmemy9X4FUXjSTK/5CQirIzXT0fE=;
        b=kJQGgGvqe/8cahwNwp7XGXLL2fuqnDJmpcG8I8ez/l1R5Ann6va8FYieIGEXBfBMDg
         pI9XmCm1Ihqj+vPddSRI8up85lQD4siu6hJeebMl0Llev2+tEt08xnmb8lIUO7Mui5fW
         mEkRlrXt48UzJqfqdUfAGIwWFxM56Nzy8czFX60Qkn/OnYswcdVgGb/1sXDbr7mXG4Fp
         Dm1gldYDw6ZfPeep2xJWnx7slcysbNjWVBxKFTeebGaLbcc+zYA92uK6BUouzaVBJPa2
         Ilv8rouxML61WGwEBN5D0FdlZ7kqmPb0UYxtS6R/vc1hX7EFbBkriy/ZpT9ppXmnpn1s
         QkmA==
X-Forwarded-Encrypted: i=1; AJvYcCX9FXuYYoQBOMd+HuYmhtDn7kw2VnOKRWfRPwmM6HyC3tFuoIZdXdxqOD4YiLxsvNfxtthoeRuB3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEe+9zmGqWsgVk+UgRKK/b+XEB+gQKe4SeAxSuepa18QI89PI
	wtG6xmeBamKP9mNjduNdKDUANg6bVYnguB2X2UIjJFHnr3zUxI+LHHVW
X-Gm-Gg: ATEYQzyiGCP5hw8JtOcM7sUbOfQBwYrIQgJQmDD9n0IhyST+oAEC9dX5IJFZQ59O7qI
	e/LTZ5KkYZ8yTemIVbtfBoQbB2Zfm0fNVDuq6EPEPw67Wb8vrdMxFdj1k5qoys+l9OY6BJkIEuo
	z0uyYVJpD5BQe7E9tDDoN3pCaFDZvfu/3glrLefVl1TpJiS4o5FGOvCz5/FodbEiYUBxs6uassO
	5Dcq5pUoMcMWJfeGUMturLpkEoCpXcZEo0Gw6ZoPB3KitFacVoW4nuXaT8e4sDbeaIt0wwF4d0W
	d5IKTCtIuE1lTR7v+snQfFYNknfU3m8XTMHtcwT/OwsHL+HggXiXAScwJMw60q2wzry81YmkrUi
	sJYaOc8HaGCCxhit/wlKywl9iB3N7OrOR86csASNLdE6TJbElCELzwDeE+UWcEVV3DIcsjT4j+m
	4QATJOlHpUC51/eK0vixCA0bUlbASfFTMmqWFiFXLqRnLO2uwrHWNkkwks+0HehblCvVKPRbfbD
	RH/NoTGGfi+mH9+O/vzy9Fl6Gk3lzxu1v3U/7JMOLRwx6ubN5nSBijEpcELLxY=
X-Received: by 2002:a5d:5c84:0:b0:43c:f45f:dcc7 with SMTP id ffacd0b85a97d-43d150419afmr7950699f8f.3.1775058324254;
        Wed, 01 Apr 2026 08:45:24 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f29:9c00:4967:922d:98a9:84a? (p200300ea8f299c004967922d98a9084a.dip0.t-ipconnect.de. [2003:ea:8f29:9c00:4967:922d:98a9:84a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e221bsm657273f8f.29.2026.04.01.08.45.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 08:45:23 -0700 (PDT)
Message-ID: <744440a6-e1cb-4792-a848-57755de0686b@gmail.com>
Date: Wed, 1 Apr 2026 17:45:22 +0200
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
In-Reply-To: <CAJZ5v0iMfiqjkkvOMU6jWEZ+nBvcRtWNwjvBW0pEva1G_owFcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 01.04.2026 16:19, Rafael J. Wysocki wrote:
> On Sun, Mar 29, 2026 at 6:14 PM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Allocating wakeup_class statically avoids a little runtime overhead.
>> Define groups and device release function as part of the class, so that
>> we don't have to repeat this for each class device.
>> Whilst at it, constify wakeup_source_attrs[].
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> Can you please have a look at this and let me know what you think:
> 
> https://sashiko.dev/#/patchset/0fe1b679-ab28-4505-b0db-14e7ac3ba749%40gmail.com
> 
Interesting finding! I think the diagnosis is right.

But: I would say the current behavior isn't a nice solution as well:
wakeup_source_device_create() does: dev->class = wakeup_class;
I think no reader will expect that wakeup_class may be NULL here due to
initcall ordering. In addition this behavior results in such early
wakeup sources not being shown in sysfs.
But I'm not sure whether registering class "wakeup" (and registering
classes in general) would be possible early enough (core_initcall,
or even pure_initcall).

>> ---
>>  drivers/base/power/wakeup_stats.c | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
>> index 308f8bde9..72beb8fce 100644
>> --- a/drivers/base/power/wakeup_stats.c
>> +++ b/drivers/base/power/wakeup_stats.c
>> @@ -18,8 +18,6 @@
>>
>>  #include "power.h"
>>
>> -static struct class *wakeup_class;
>> -
>>  #define wakeup_attr(_name)                                             \
>>  static ssize_t _name##_show(struct device *dev,                                \
>>                             struct device_attribute *attr, char *buf)   \
>> @@ -114,7 +112,7 @@ static ssize_t prevent_suspend_time_ms_show(struct device *dev,
>>  }
>>  static DEVICE_ATTR_RO(prevent_suspend_time_ms);
>>
>> -static struct attribute *wakeup_source_attrs[] = {
>> +static const struct attribute *const wakeup_source_attrs[] = {
>>         &dev_attr_name.attr,
>>         &dev_attr_active_count.attr,
>>         &dev_attr_event_count.attr,
>> @@ -135,6 +133,12 @@ static void device_create_release(struct device *dev)
>>         kfree(dev);
>>  }
>>
>> +static const struct class wakeup_class = {
>> +       .name = "wakeup",
>> +       .dev_release = device_create_release,
>> +       .dev_groups = wakeup_source_groups,
>> +};
>> +
>>  static struct device *wakeup_source_device_create(struct device *parent,
>>                                                   struct wakeup_source *ws)
>>  {
>> @@ -149,10 +153,8 @@ static struct device *wakeup_source_device_create(struct device *parent,
>>
>>         device_initialize(dev);
>>         dev->devt = MKDEV(0, 0);
>> -       dev->class = wakeup_class;
>> +       dev->class = &wakeup_class;
>>         dev->parent = parent;
>> -       dev->groups = wakeup_source_groups;
>> -       dev->release = device_create_release;
>>         dev_set_drvdata(dev, ws);
>>         device_set_pm_not_required(dev);
>>
>> @@ -212,8 +214,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
>>
>>  static int __init wakeup_sources_sysfs_init(void)
>>  {
>> -       wakeup_class = class_create("wakeup");
>> -
>> -       return PTR_ERR_OR_ZERO(wakeup_class);
>> +       return class_register(&wakeup_class);
>>  }
>>  postcore_initcall(wakeup_sources_sysfs_init);
>> --
>> 2.53.0
>>

