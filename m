Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616968;
	b=ohIeAdXlm6uhnKw6pn5+nwZjEbpCrO7PcGpu5gdElRvcwv2CPsZZ+gtiGQwPHxjMyJvf
	 R4fveoNeeiiV9uNVjZDZNrapR/qa9UJoivTw/gDSL3Mdgwul39n5/kxD5LXKd2Ec2oLjb
	 1ckh8YVt+SI2G1AkLsYy0QreSIDqWUCGWzcbzR7LdEtA1lmMjTKGN2FZ0h5yuoX28G6n3
	 7GbduPYtaViDKsmgCymuL/wEhNV7QLcbWJfmf7jy7go3+ccWBYztDfFkCSYvxHi1mONGQ
	 CZjxf1C10jO9CRDjb4X+jClXJuHwDoB3tnk3gWxjj6EUzA59hKKzwYmJnJsOYiPqvsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616968;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=dxbpM9JSGjvDSYs8AoC3NrW/TfSCm7pfRfifX8N/xPQ=;
	b=z91x9uamlYtKq8dIQocCQxUNULnEVghw/9qdg1rEf3M1V0QKiiJJ5tzyGYdGc2vdgVi9
	 mQAUMeoq+JwVWmF7na+c24UkVT7aChli+5OxAVmCF3Mp43tFH/VKkGUwlAw7g+ANpfTPU
	 Nnh+VkRTzU6B9b/ajJ6L8/5sEfU/u3myrCOgAZXY/UnJ9sX+GzuyfZgBGX5kmh9fXYdzr
	 ijG1lOCRN6cubkw8B0PhnLIIX9BN+0oo3feDcFfF5askezIHdA0S5MHwg+a0w69EPlcyE
	 Tfo2XfZijbH3Vjl9L1nclgINWEiFBQgcvaYh4hxf5iOMgX8u2+wDBz+MiE90VrVyxHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMBGzdvu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410F3606A321;
	Wed, 25 Nov 2026 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PMBGzdvu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC7471F000D1;
	Wed, 25 Nov 2026 14:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616967;
	bh=dxbpM9JSGjvDSYs8AoC3NrW/TfSCm7pfRfifX8N/xPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=PMBGzdvuLmBv6GbhOoRe2PB1yDkwM7NHeaPt6d3MP6UFQZyNtnsDjpjc1Vehb2h+Y
	 +vnBDhkSRLl8PEABfp0rQhl8EZQbmSROOL7KbUmaHL7J6HwCg2XZi2Vv6WhSeVlRm8
	 bjXTQAdLQrVLyrIx/FCITPaXrQwyV+99rzpMY1/NfxBiZ1ed45WL993hELJexrM3CS
	 G/0DAo8x8MI066oXTdaqBP6SmgPN9CvpfK0ZxVZ/W3XympMJ8Xakhoc59nHbp5xD2W
	 vQlvqddiEnYaG7673eQtzGd3nskDOUoPD1Y6oC5pHb74mbtwnDks5j4KZmEVKjVy6j
	 xT2e99ReAoSNQ==
Message-ID: <2c578ef0-b241-46ff-bc92-158fac966f0a@kernel.org>
Date: Wed, 25 Nov 2026 15:29:23 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] PM: runtime: add debugfs entry for
 pm_runtime_summary
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Samuel Wu <wusamuel@google.com>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
 <20261123-pm-runtime-summary-v3-2-81a966953a81@kernel.org>
 <CAJZ5v0iJ2ytkT2-JJTONCvYx3s-kOOtxopFkdbtGzHNQWOwJgg@mail.gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <CAJZ5v0iJ2ytkT2-JJTONCvYx3s-kOOtxopFkdbtGzHNQWOwJgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Nov-26 14:01, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 23, 2026 at 10:07 AM Joshua Crofts <crofts@kernel.org> wrote:
>>
>> Add a debugfs entry for showing the runtime statistics for devices with
>> PM runtime enabled.
>>
>> Signed-off-by: Joshua Crofts <crofts@kernel.org>
>> ---
>>  drivers/base/power/runtime.c | 86 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 86 insertions(+)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 17aee68366cf..cf657251633e 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -14,6 +14,8 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/pm_wakeirq.h>
>>  #include <linux/rculist.h>
>> +#include <linux/debugfs.h>
>> +#include <linux/seq_file.h>
>>  #include <trace/events/rpm.h>
>>
>>  #include "../base.h"
>> @@ -2223,3 +2225,87 @@ bool pm_runtime_need_not_resume(struct device *dev)
>>  }
>>
>>  #endif /* CONFIG_PM_SLEEP */
>> +
>> +#if defined(CONFIG_DEBUG_FS) && defined(CONFIG_PM_SLEEP)
> 
> Why do you want to make it depend on CONFIG_PM_SLEEP?
> 
> There's nothing related to system sleep in it AFAICS.

dpm_for_each_dev() is guarded by #ifdef CONFIG_PM_SLEEP.

-- 
Kind regards,
Joshua Crofts
