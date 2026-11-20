Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795208045;
	b=P2HXMfofDFvR0bORNvi1fxCOtUbhq6JziVMj39/ez1UCvIpGQzcPpcuYEehr1OoBooV9
	 vcYeErr2ct/1riiUZDqz6PVGGGuXgwY0lrs9502BWX2XfOQD7PSkC0Ev8W+seYcReD5Hx
	 osSa3pnVmVYzXSdCquhUAOqec748C8yzDk0ChF7e05z9FgLF2gEp0vcylPNB6bq0RtpCP
	 1vjze+4Ur6LhqFZZQwJHm5V8cQklR8vQNe3JbDV2OmB1s40Wtd9HwWk/qixdicokRWVqO
	 ReM2Cz+XZVY5kbfkksG9pV+MTlyY2uSfjbDG5+iYGPO8xD6H7wwe4+a7lEza5uQ7Aww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795208045;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Provags-ID:X-Spam-Flag:
	 UI-OutboundReport;
	bh=riB3AhuJ6M7lS415LO5WZ4ozxVdHjoWfDeSjlRWa3WU=;
	b=xoTrDQgOmJEjI5nscK/XB60n9i83Tph84OI/4K+0OhQRwFDfzZk6n6ZT8Ih/VUfw+f5g
	 wN1e14Xn/Zl9oQRkVUYel6g1bHcqaGoNmVZQVbIWwbxnWfHMIuBGSR4hql5Bdawm7/PrU
	 aT5MUEX419UQN+G77iQksnVqHKUa5uexrFEDkj7uwbTqaE09nnJGMVnhMS8FF6FJMMwPQ
	 euh5gXrt7P4YhSPfzJbbE0QbgVBlUdxTHpxqar5ivurveSjRuKTCYiyOiRkVQSWNmMpTT
	 FjMUq26KyFTUYnYBd6MJ9+DQcFK89AY1RD+QlrKSu5Fm/8V9qnKI7KeXIB/iiVVw4NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=p3PxSiiJ;
	arc=none smtp.remote-ip=212.227.17.22
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97714606A689
	for <linux-pm@vger.kernel.org>; Fri, 20 Nov 2026 20:54:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97714606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=p3PxSiiJ
DKIM2-Signature:  i=1; m=1; t=1795208041;
 mf=PFdfQXJtaW5AZ214LmRlPg==;
 rt=PGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZz4=;
 d=gmx.de;
 s=s31663417:rsa-sha256:er5aywVsNiXmMCVqhHMmlr+Vm8sT
   GXMDI1Yhctmvx0ShaZ8avRDLfsRkFLdWW+GILgyIRkjo2h3p3MxibL8Bi/+nnm1q6hvQ4szZJGc
   Ngm2goJryGYVy8/9safteeGzCGd3MRwfVjKHV4RJCO0skajDZZY43YSnlaRq1COY362fkmIza23
   GZbrRhRDQ13xGg9FZe7dQJr4NQtJJfXvr1wHun4T+XAIPfy3ZqaeRPDpkqouBscyv030cl8hJ0e
   Dib3T9eBmnB5ZBcTRP/B52ARWXPce5FGzzjh06bHzq6LAka0xBeIU+oDRIxrCir7uDKoaRi3wfL
   YD1sflbAWEOjcg==;
Message-Instance:  m=1;
 h=sha256:
   03MsQUnEZbvY9LiiIS+4Sf8OPACZexPgNXUlw7WV2HY=:
   3FryA2sXea0DJiwq5SQanWdaCcVTqLF29oOanVSEkWo=,
  sha512:
   Q+w47saHFI0dXucHTi3QUv8yuSbkkvQpMF9CYsjRRelSW0csdEwQjGfT34xP2xpUePZZHI8Y2QMyAQ25MnDWcA==:
   6QvJTE9+RDQST74NtcoN6qz4dBmUm8YxV5p/36x4ky3Ot4FJLk6jK4yjq5p+1sM3BpvUHqDYPaRHpMYJ4jnFVw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795208035; x=1795812835; i=w_armin@gmx.de;
	bh=riB3AhuJ6M7lS415LO5WZ4ozxVdHjoWfDeSjlRWa3WU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p3PxSiiJLJqjCJC8Bp2J5BYzbI0CpMVOwMCHuFFEAoe1zq7+Txw9FgweRLUlimpo
	 50AoAvGXw06MHxA8rpDLQiefAmqoP1OyThlycSHuK1IzPLuvy6ViM/VfnBejmIxkP
	 Z2eVKNj2+wAKBxORP2Ul71+hZHGOLCf0uXy06jBPGoOo7IXwtbbSJ1lnDZBxrGtui
	 rOYKQ7dtXSfIO3bqdG/GbGsdud5/uyd1oRdi6cWXoXImcWJ3q5sFksBiW/bN2hV1j
	 5Ojc2Sc9Ihn078yn8nYlS7Rqo+uIYI0l/j6KS40//+xT1VndINVLcF6UDc7ikq5bv
	 CqctJKpEQfa3rJLaAQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6Daq-1xb6GQ2e2C-0087N3; Fri, 20
 Nov 2026 21:53:54 +0100
Message-ID: <fad724e8-72f2-4ce2-9a40-26aeb11c5a08@gmx.de>
Date: Fri, 20 Nov 2026 21:53:52 +0100
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
Subject: Re: [PATCH v2 0/9] platform/x86: uniwill-laptop: Complete battery
 support
From: Armin Wolf <W_Armin@gmx.de>
To: hansg@kernel.org, ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 bifangknt@qq.com, nicokessler@icloud.com, sre@kernel.org,
 linux-pm@vger.kernel.org, wse@tuxedocomputers.com
References: <20261110165318.631010-1-W_Armin@gmx.de>
Content-Language: en-US
In-Reply-To: <20261110165318.631010-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:n1ufyaB7rqGeo9YKMpHIZa15UTmsAOtHF9pq6PZZ/eGUZCZtu7w
 zCUK1UhDiO/Ff+fOIrK0XfRKhdKva6OHV/RPNtXCET0a31WbaUR6vJlI9KPL3DhKmMRMttF
 K5+II8kN/jzmR5B4cJcGX3DCcNx8PrJ3fsNdND1pGh4wHl+naYQMK3m5E6UvyEHqqPWtE8K
 R01VlLHqqP1isQmR98Lxg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:40MXictyNPA=;pZjF0tB3kuFHFG6ONTqvMG+olCt
 +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

Am 10.11.26 um 17:50 schrieb Armin Wolf:

> According to the work item for upstreaming the out-of-tree
> tuxedo-drivers package, the mainline uniwill-laptop driver still does
> not allow userspace to read the cycle count and raw capacity of the
> battery, preventing Tuxedo Computers from switching over to the
> mainline driver (among other things).
>
> This patch series aims to add the missing battery-related bits. The
> first two patches extend the power supply subsystem, while the third
> patch uses the new API to expose the battery cycle count on devices
> where this not already being done by the ACPI firmware itself. The
> fourth patch also exposes the raw battery capacity using a custom
> sysfs attribute below the battery power supply device. The fifth
> patch only does some generic sysfs-related cleanup, while the last
> three patches add support for new devices based on user reports.
>
> All patches have been tested on a TUXEDO InfinityBook Pro 14 Gen10 AMD
> and appear to work without issues.

Hi,

what is the status of this?

Thanks,
Armin Wolf

> Link: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/work_items/253
>
> Changes since v2:
> - fix error handling inside patch 5
>
> Armin Wolf (9):
>    power: supply: core: Add power_supply_has_property_direct()
>    power: supply: Enable struct power_supply_ext to be construct
>      dynamically
>    platform/x86: uniwill-laptop: Report battery cycle count
>    platform/x86: uniwill-laptop: Expose battery health and cycle count on
>      all devices
>    platform/x86: uniwill-laptop: Expose raw battery capacity to userspace
>    platform/x86: uniwill-laptop: Mark sysfs attributes as const
>    platform/x86: uniwill-laptop: Add support for MECHREVO Yilong15Pro
>    platform/x86: uniwill-laptop: Add MECHREVO JIAOLONG Series-X6xR55xK
>    platform/x86: uniwill-laptop: Add support for XMG EVO 14 (E25)
>
>   .../ABI/testing/sysfs-driver-uniwill-laptop   |  11 +
>   drivers/platform/x86/uniwill/uniwill-acpi.c   | 269 ++++++++++++------
>   drivers/power/supply/power_supply_core.c      |  26 +-
>   include/linux/power_supply.h                  |   3 +-
>   4 files changed, 220 insertions(+), 89 deletions(-)
>
