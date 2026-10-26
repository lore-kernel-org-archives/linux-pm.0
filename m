Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793045633;
	b=bGT4pAjiiciqNhnvNpWPfPzEhNa8aqIj1sRqpxbSraXOA2+s+cPHtm+yhEeKGRvCZVP1
	 Pl6gfc/3nK4MngxB6dPgowbskvhOpxflS38SqGic2okNPnNuh8f8YsnCzqq6Qlt//o+EC
	 7+ZZKsD1wyXZiRe192UXtXbfxjvyIHtObt4jCPKDCd7sFyuEGe+OibuPzaxAGljjdFcEl
	 KIYxzls4YjYvF2Nk40xtLgyghQJ1Do48kxc3t7tTcti3BjPX/3FGpIABuBQvx5qX1NT3k
	 NEBIUPxtKJ3GRwG9Fs5bJMp6mqg62v1GuJxoBIsxfAPdwHrAUuRhBnpcDVsK6KIx3yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793045633;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZFEoz4zAnNP/e2CZdR6xrHUiI8JHFR28GWwihmBnonQ=;
	b=FFGhT4AKmPR+6D72V+MK1hSVPLp/TEh08s1XA9g/pMnW6grz4cw7/zHh0u0ADKUhBgj6
	 hzyCOEF4MxkxptYjkT1hvNf0P25wab4wt72epTB5jeIC1fQ4N87U61L4N7m6dxTnjSFaf
	 Q3BMp9HWgWaPOXkYcDdtsHA4CptF/k0SVaR+in7eQQ1h7te3bMAVXw6XyhaGyMKTeiKG9
	 T/XonN0ZgChC/spODVToISGIKCqTYaf4iQDSrf0TEGPhWusummqy1vn1/mnokXxli70tu
	 tdSSUsDS8PeRE7YGDOTpnJj/1D5tJ6oxFzWod6wyh4qZaKFNCZgFUfl1bqm/6XhGWQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fYT53Vx2;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D67606A31E;
	Mon, 26 Oct 2026 20:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95D67606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=fYT53Vx2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ZFEoz4zAnNP/e2CZdR6xrHUiI8JHFR28GWwihmBnonQ=; b=fYT53Vx2tLwuv3kAl7B2FqH8br
	kcYZT6KxYso9fB6zwWepCQafujHWHtRYTwauBP552d0J6ICs6czTL2dgIwWDi99j8vIUjcGKxdGfQ
	0yWLAuWaoRY+shgcTPjSzJoWSBUPlXogBcdFCIc5dbqdiGeD07wGJsmzHSvAqGpBk6gYpH8R1Dl4H
	6UJGb2qGUEAfFB5EtNGivqRiBu8WMoyAlMl3XqABsroJ4WmNSuGIyOO7CLAkKcES0MBouGsfnaxRX
	l8MXg90/BqHtEEoTlLrPcQLLITv2ZdJ+uSdBM65Rc3k24MpbmG+PdeovQ0QgqpkOZ3SJhXY4yMhvk
	ClZxbWvw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLR4o-00000003Cv0-2j7I;
	Mon, 26 Oct 2026 20:13:50 +0000
Message-ID: <4ab3e196-0326-48d9-bfdb-ede2f8cfac64@infradead.org>
Date: Mon, 26 Oct 2026 13:13:49 -0700
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
Subject: Re: [PATCH 1/7] docs: ABI: power: rt9471: Fix invalid inline emphasis
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Sebastian Reichel <sre@kernel.org>, kernel@axis.com,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
References: <cover.1792965060.git.waqar.hameed@axis.com>
 <ba11515d8e0dc45ad90f162302bcd1b20db9bd92.1792965060.git.waqar.hameed@axis.com>
 <004fbff3-7fbc-440c-9c44-44585795521c@infradead.org>
 <pndse1svbin.a.out@axis.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <pndse1svbin.a.out@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/26/26 6:26 AM, Waqar Hameed wrote:
> On Sun, Oct 25, 2026 at 19:39 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> On 10/25/26 3:05 PM, Waqar Hameed wrote:
>>> `docutils` warns:
>>>
>>>   Documentation/ABI/testing/sysfs-class-power-rt9471:1: (WARNING/2) Inline emphasis start-string without end-string.
>>>   Documentation/ABI/testing/sysfs-class-power-rt9471:20: (WARNING/2) Inline
>>> emphasis start-string without end-string.
>>>
>>> Fix this by escaping the `*`.
>>
>> I'm still seeing this issue after the patch is applied (same for patch 4/7).
>> Maybe we are fighting a docutils your-version vs. my-version problem
>> or just a moving target.
> 
> Hm, that's weird. What output do you actually get? The '*' is escaped
> now, so it shouldn't complain...
> 

docutils still complains:

Documentation/ABI/testing/sysfs-class-power-rt9467:1: WARNING: Inline emphasis start-string without end-string. [docutils]
Documentation/ABI/testing/sysfs-class-power-rt9471:1: WARNING: Inline emphasis start-string without end-string. [docutils]

and running the command that Mauro provided:
$ ./tools/docs/get_abi.py -D Documentation/ABI/testing/ rest --enable-lineno|grep -A20 rt9467

gives me:
.. LINENO Documentation/ABI/testing/sysfs-class-power-rt9467#1

.. _abi_sys_class_power_supply_rt9467_sysoff_enable:

+------------------------------------------------------------+
| **\/sys\/class\/power_supply\/rt9467\-\\*\/sysoff_enable** |
+------------------------------------------------------------+

Defined on file :ref:`sysfs-class-power-rt9467 <abi_file_testing_sysfs_class_pow
er_rt9467>`

This entry allows enabling the sysoff mode of rt9467 charger
devices.
If enabled and the input is removed, the internal battery FET
is turned off to reduce the leakage from the BAT pin. See
device datasheet for details. It's commonly used when the
product enter shipping stage. After entering shipping mode,
only 'VBUS' or 'Power key' pressed can make it leave this mode.
'Disable' also can help to leave it, but it's more like to
abort the action before the device really enter shipping mode.

Note: use /sys/class/power_supply/rt9467-*/load_switch instead.
---

Aha. It's the line above that now needs to have the '*' character
escaped. I have no warnings after that is done.


>>
>> $ docutils --version
>> docutils-3.13 (Docutils 0.23, Python 3.13.16, on linux)
> 
> I have
> 
>   docutils (Docutils 0.20.1, Python 3.12.3, on linux)
> 
>>
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202609110722.GAZVme6v-lkp@intel.com/
>>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>>> ---
>>>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
>>> index 0a390ee5ac21c..04a771cd23512 100644
>>> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
>>> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
>>> @@ -1,4 +1,4 @@
>>> -What:                /sys/class/power_supply/rt9471-*/sysoff_enable
>>> +What:                /sys/class/power_supply/rt9471-\*/sysoff_enable
>>>  Date:                Feb 2023
>>>  KernelVersion:       6.3
>>>  Contact:     ChiYuan Huang <cy_huang@richtek.com>
>>> @@ -16,7 +16,7 @@ Description:
>>>               - 1: enabled
>>>               - 0: disabled
>>>
>>> -What:                /sys/class/power_supply/rt9471-*/port_detect_enable
>>> +What:                /sys/class/power_supply/rt9471-\*/port_detect_enable
>>>  Date:                Feb 2023
>>>  KernelVersion:       6.3
>>>  Contact:     ChiYuan Huang <cy_huang@richtek.com>

-- 
~Randy

