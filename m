Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795644590;
	b=JxNIyYEd8T7jbSzT9vYPUjQhyC3wfLfBCStp2PkZyg0nx2RBLY6OLJdNUeToFg+lElKb
	 HNoCO0wD82lCpN9caFLj+2LZg0FCPIs9YHzMx9BsG8QvQk525QbHteaYe+nC/chAW8zy/
	 dWuk7leKl6nbsbMKZupRLLshKDdk1SDFZdQpOkbt7kiHWMx1I+r5Xzjp0zzl33mrevkcu
	 kHy6ZahgDL0eUyTHRBul5n6FH57fzc1EIR+mkSVdD1nhnIOQl2tFhgX3iGIVs4+Yub8xK
	 /YArzCmqiWyhYfXjQXVCypiB9f8GQEaJfLbsuDLAqdQzEXy996DeflPigdaFIPS6hRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795644590;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=69QiPt4URb262iAt238uz6YUHqN8J08GOomWHPYAIco=;
	b=lAc3gxhcqyBpTqnvq9WJyhcn5yi4Px9wrMj5OfGwuCJBq//LQ77tXpnD5B2SJfEx/QaB
	 bDgW6I+NkPQYKZP5lf7w2alBPod3NuJL4rosgk+W5jPGRQbeOyv1kPmsulXnDiPWZ43bW
	 HQ+uY555hQseo+L7wotapDbIVL1ZJwfKsswa5u6JXPmAqf3s6LFFRWEhYN8G1UBjAK+L2
	 Bv73ewxRcBShgfwoRQF3WsJZ+OzlaF2dc3yo0iw1nWsHROLT8LalyTv5mJ9d0zycJfSaE
	 zG9DGXD0z0LdrkYu76bwE83F7YT9CMu6dcaxwCrIhhU0aDmhSh6/PuWV3JRU0QR8FCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FZMtpI3A;
	arc=none smtp.remote-ip=212.227.15.15
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E67606A31E
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 22:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8E67606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=FZMtpI3A
DKIM2-Signature:  i=1; m=1; t=1795644588;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:M5JTnHv63hN5BE4+AQmZx8eVCid/
   xlxjZqZehi27mFYY0Yjc0fXWfnIM4hb89mX4jzBr+LNZ1q3aT8afUQooW31vKCpU0V8JStsBlmw
   8xKKhZbrcblyzTFOHPh2XbqeIwXIX25ZkkdyGQH1Ay73rOWBepju+rCHuE6N32DN9Rj9QzREIvO
   Vv7LAbFXfXBqPqgcnW/PPM62ckbo+O7XR5kSKvyz3MGmUZOXq/MHGxshR7LBbTNlpsuzPTk1wLB
   BRZKhCy6UgfyYWdus5SoEa2KpWw5Sl4RGDYyNQO7qb9rA8/EZrajGEmwXsHcz/acKeHCjZy9cLo
   BgrFIImLUHvreQ==;
Message-Instance:  m=1;
 h=sha256:
   3nh4NH1aO5aqtpTtQSQ2AgKZP8qjhiPQ591HlnBoCrY=:
   NWqmuIH5aoqvwrLBP/cPwHpby+lVWj7YyfWWpqfAi9o=,
  sha512:
   bGVaTc2/qdfnITP1LO5u+YWX5DyYrIuUrnFUWf6RaU6oBvj0TYofFbNXdy1AyJHR2ZwgWArSDi3O8JsKjM6VJA==:
   lcKw88MtHHCaw3heGixFUzqOia5aNanzfWVkguw0JIT5N47g96lCQ6Yjlx3aOhm+2qGZ6flUcSiOqyFvwH6Cfg==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795644584; x=1796249384; i=w_armin@gmx.de;
	bh=69QiPt4URb262iAt238uz6YUHqN8J08GOomWHPYAIco=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=FZMtpI3AprbL0V/csTiXyjaBiVobOuVzmiNtibI/IhEy7ZYt4mIjO8ASFnh0v24Z
	 7EIm7D2SsldlyhPJ90sjIlsBfh9n/+DBmlPTs9I323N7abvSZynxm2K1Ye11rr+JO
	 TZ6FY/68obj5QVCz+XINV/Sm5Y9MimFX8vy2DYfufY7BEmJUiIHxyi1Krp+UZXNy3
	 eEzWrvHRPQ61o36HLXRnv/ZgOCmG1TC63Fg1T8hnjrt1H+MpVT1za2q+GfWJ0Q+Ko
	 KkFsrkv+/SG648VOZtdc3/lo+mNuRY0fJbPh9Wj0UJl7tpRWRgOSvHrAXB9hajAkH
	 4A2S73XwyudTb4/nUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSKuA-1xytc02PKy-00QO3O; Wed, 25
 Nov 2026 23:09:44 +0100
Message-ID: <a632ca1f-d67c-410e-9905-fb83433d9069@gmx.de>
Date: Wed, 25 Nov 2026 23:09:42 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] ACPI: fan: Pass struct acpi_fan pointers to
 functions
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
References: <2859850.mvXUDI8C0e@rafael.j.wysocki>
 <1976174.tdWV9SEqCh@rafael.j.wysocki> <awcYhE0hvgBQMT6_@ashevche-desk.local>
 <CAJZ5v0g1S2EppsW+Co_VD1Rbmv1bAsVDNmQ3a58H_exUFjuyXg@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CAJZ5v0g1S2EppsW+Co_VD1Rbmv1bAsVDNmQ3a58H_exUFjuyXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ithj4kprfKAR7fHSENyGOhpDe4iX2gbTNJ8FFlL67tT9P3d0LjK
 1Zc+s1KZEeUKXnc1cJkqEFw7Vwv/kT/unAeBYRcRKY5XzEqC+jBjVpDONP/KBZ9PMK5zih4
 zAoWrNAGHdKjS3h5sHlSIM8lrJqNzwYZ5uP5jw/juDPD+JJNqpoBs3iA7kBDVTykhYJPk3/
 34hTO2yGVGIl5j37PYBCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:C9/u2Efu+9s=;wBc6pMTwJ6kEMAg6CspgfsHUqr5
 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

Am 25.11.26 um 21:34 schrieb Rafael J. Wysocki (Intel):

> On Wed, Nov 25, 2026 at 8:29=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Wed, Nov 25, 2026 at 03:07:24PM +0100, Rafael J. Wysocki wrote:
>>> Pass a struct acpi_fan pointer as an argument to several functions in
>>> the ACPI fan driver either instead of or in addition to a struct
>>> acpi_device or a struct device pointer.
>>>
>>> This allows acpi_driver_data() usage to be reduced and some other
>>> simplifications to be made.
>>>
>>> No intentional functional impact.
>> ...
>>
>>> -static int acpi_fan_get_fps(struct device *dev, struct acpi_device *d=
evice)
>>> +static int acpi_fan_get_fps(struct acpi_fan *fan, struct device *dev,
>>> +                         struct acpi_device *device)
>> Hmm... Can't we derive 'device' from 'fan' as you done elsewhere?
> It can be done, but it's rather cosmetic IMV.
>
> It's just a matter of whether or not dereferencing "fan" is better
> than passing one more arg.  Anyway, this change can be made
> separately.
>
>> ...
>>
>>> -static int acpi_fan_dsm_init(struct device *dev)
>>> +static int acpi_fan_dsm_init(struct acpi_fan *fan, struct device *dev=
)
>>>   {
>> Now 'dev' is used solely for dev_info() call AFAICS. Hence when you mov=
e to
>> acpi_handle_info() this parameter can be killed I assume.
> However, I'm not sure if using acpi_handle_info() would be better.
> After all, the platform device is the one using MSFT extensions.

I agree, the idea behind this message was to inform the user that the driv=
er controlling
the platform device is going to use the MSFT extensions, so using acpi_han=
dle_info() would
not fit here.

IMHO passing both dev and acpi_fan is only a minor issue.

Thanks,
Armin Wolf

>>>        union acpi_object dummy =3D {
>>>                .package =3D {
>>>                        .elements =3D NULL,
>>>                },
>>>        };
>>> -     struct acpi_fan *fan =3D dev_get_drvdata(dev);
>>>        acpi_handle fan_handle =3D fan->adev->handle;
>> --
