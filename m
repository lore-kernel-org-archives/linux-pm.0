Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617515;
	b=uclEExIriPtDTQC7TfK5OR3zzQ4ylRVJA9WAy0IMUz9xUw7TI4cmFlX5m7pS2YP+0Jg6
	 KpafkniBNeU5KB4Qt46EMq/V1INDc2PovsIEAaxI8DLaDhNvz8F3cBDQZbYBoYohaNSG5
	 50pepI5zlRHEWk/bpvXuw+9fVz1tbQHWiqEVjQUdpJ4B7UqD7wymaYn2qpBlNvXLCHJgl
	 BvPOcCQQsiCoIAr4EyID/TS9Ph8/SQZsAgX+wgtYPsj9+Lqpefbl/NGR5aoLVlCU1X3Pq
	 um3rjBc5/9Q/Q21OCtiL1Xvcerwu6CAWtH9D7or7TrkebHzNYtnW0PESFClm+NlZkWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617515;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=0Gc9tYtRb19MW0h+QBmLaneRf2CSlYjfdbqau2neOto=;
	b=FFLh5sYB/o8p0RKHgSRTrvupRxxmDV7iwDspdokVtVG7jRed8GvSLjV9c+4kebbSiWDU
	 rr2kmquXxeQOOhpVpTMnC4xfAVV9AmWvu0quGpLo2ENtIRCvoSTDqYlf576Paa3xe5GSz
	 j4K5Ezg7vZ53KuvKEWh1/qHv0On16qxJ4HKasZhF09quvJ/Ng3F1j1Z/cpx/8Fi3tp8Zz
	 uqXomBSYKxq4XiYop97Kn3R72vNy+Fb4UMcAAiSofUa5vWzhcPCwOvPQsW9SajwRN73+k
	 HLY4AQj3WFkLhLOaRTdyjuwpNaL34F4C/cpP19Y5dXJ8H15S21f3h8yPYBi+sSXFmYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ho2gnp0X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E6606A330;
	Wed, 25 Nov 2026 14:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ho2gnp0X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E641F000EF;
	Wed, 25 Nov 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617514;
	bh=0Gc9tYtRb19MW0h+QBmLaneRf2CSlYjfdbqau2neOto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Ho2gnp0XzfNdjWNXAJI/Axure0NT2HpjLyaJjBNjOip3PlqKh+gXsp7of7DnVaO0p
	 GOCi8+D1NytiFBxi27DxpjC7f4cwkMslXpl8XUY45OzXh5u4s8lqNaYHeAKfZI2nOj
	 WaM7Df1ddsZa3MAbU9KVGatNjlldVIGokNkhYsNKNkzCOwT2a1ARQEq6Ui0+FRPFsU
	 NQmktrraq8ErCoiF0ewL5Z1S4bd+x0dm9cwLycMZnNLw5nVVA3NiLhTdwBNXfTYKgT
	 QwukmWm3KAr0EwvuyQbk+qfNWTUR3a9SWkIMy+sDhDRknuZQtFEfUkPqAZk3Zkf4RV
	 mXqdHam9FB1dw==
Message-ID: <5387130c-df43-41d7-9ff8-8ee549e6e97f@kernel.org>
Date: Wed, 25 Nov 2026 15:38:30 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/2] PM: runtime: add additional suspend/resume metrics
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Samuel Wu <wusamuel@google.com>, linux-pm@vger.kernel.org,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20261123-pm-runtime-summary-v3-0-81a966953a81@kernel.org>
 <20261123-pm-runtime-summary-v3-1-81a966953a81@kernel.org>
 <CAJZ5v0hpnoGw89WHyofLr3SxnrJNs99LnhndeOv245y_LgGWXQ@mail.gmail.com>
Content-Language: en-US
From: Joshua Crofts <crofts@kernel.org>
In-Reply-To: <CAJZ5v0hpnoGw89WHyofLr3SxnrJNs99LnhndeOv245y_LgGWXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25-Nov-26 13:54, Rafael J. Wysocki (Intel) wrote:
> On Mon, Nov 23, 2026 at 10:07 AM Joshua Crofts <crofts@kernel.org> wrote:
>>
>> The current implementation only logs the total accumulated time a device
>> spends in suspended or active states.
>>
>> Add tracking for:
>> - resume_count : number of successful transitions to active
>> - suspend_count: number of successful transitions to suspended
>> - last_suspended_time: duration of the most recent sleep cycle (ns)
>> - min_suspended_time / max_suspended_time: shortest and longest sleep
>>   cycle durations to help detect power thrashing (ns)
> 
> I would mention that they would be only reachable through a debugfs interface.
> 
>> Signed-off-by: Joshua Crofts <crofts@kernel.org>
>> ---
>>  drivers/base/power/runtime.c | 93 +++++++++++++++++++++++++++++++++++++++++---
>>  include/linux/pm.h           | 16 +++++++-
>>  2 files changed, 103 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
>> index 4e9c23059a40..17aee68366cf 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -5,6 +5,8 @@
>>   * Copyright (c) 2009 Rafael J. Wysocki <rjw@sisk.pl>, Novell Inc.
>>   * Copyright (C) 2010 Alan Stern <stern@rowland.harvard.edu>
>>   */
>> +#include <linux/pm.h>
>> +#include <linux/timekeeping.h>
>>  #include <linux/sched/mm.h>
>>  #include <linux/ktime.h>
>>  #include <linux/hrtimer.h>
>> @@ -103,11 +105,70 @@ static void update_pm_runtime_accounting(struct device *dev)
>>                 dev->power.active_time += delta;
>>  }
>>
>> +#ifdef CONFIG_DEBUG_FS
>> +static void rpm_account_suspend(struct device *dev)
>> +{
>> +       dev->power.suspend_time = dev->power.accounting_timestamp;
>> +       dev->power.suspend_count++;
>> +}
>> +
>> +static void rpm_account_sleep_end(struct device *dev)
>> +{
>> +       u64 duration;
>> +
>> +       if (!dev->power.suspend_time)
>> +               return;
>> +
>> +       if (dev->power.accounting_timestamp <= dev->power.suspend_time)
>> +               return;
>> +
>> +       duration = dev->power.accounting_timestamp - dev->power.suspend_time;
>> +       dev->power.last_suspended_time = duration;
>> +
>> +       /* Update min/max extrema at the exact same moment as last_suspended_time */
>> +       if (!dev->power.min_suspended_time || duration < dev->power.min_suspended_time)
>> +               dev->power.min_suspended_time = duration;
>> +
>> +       if (duration > dev->power.max_suspended_time)
>> +               dev->power.max_suspended_time = duration;
>> +}
>> +
>> +static void rpm_account_resume_complete(struct device *dev)
>> +{
>> +       dev->power.resume_count++;
>> +       dev->power.suspend_time = 0;
>> +}
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>>  static void __update_runtime_status(struct device *dev, enum rpm_status status)
>>  {
>> +#ifdef CONFIG_DEBUG_FS
>> +       enum rpm_status old_status = dev->power.runtime_status;
>> +#endif /* CONFIG_DEBUG_FS */
>> +
>>         update_pm_runtime_accounting(dev);
>>         trace_rpm_status(dev, status);
>>         dev->power.runtime_status = status;
>> +
>> +#ifdef CONFIG_DEBUG_FS
>> +       if (dev->power.disable_depth > 0) {
>> +               if (status == RPM_ACTIVE)
>> +                       dev->power.suspend_time = 0;
>> +               return;
>> +       }
>> +
>> +       if ((old_status == RPM_SUSPENDING || old_status == RPM_ACTIVE) &&
>> +           status == RPM_SUSPENDED)
>> +               rpm_account_suspend(dev);
>> +       else if (old_status == RPM_RESUMING && status == RPM_SUSPENDED)
>> +               dev->power.suspend_time = dev->power.accounting_timestamp;
>> +       else if (old_status == RPM_SUSPENDED && status != RPM_SUSPENDED)
>> +               rpm_account_sleep_end(dev);
>> +
>> +       if ((old_status == RPM_RESUMING || old_status == RPM_SUSPENDED) &&
>> +           status == RPM_ACTIVE)
>> +               rpm_account_resume_complete(dev);
>> +#endif /* CONFIG_DEBUG_FS */
> 
> Please move the code under CONFIG_DEBUG_FS in this function to a
> separate function called by it and defined as an empty stub if
> CONFIG_DEBUG_FS is unset.

Ack, this patch is messy...

Also Sashiko still isn't happy with the way I calculate these metrics.

-- 
Kind regards,
Joshua Crofts
