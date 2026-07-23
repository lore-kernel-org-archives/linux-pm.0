Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBD32C0268;
	Thu, 23 Jul 2026 14:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.190.126.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784817970; cv=none; b=qWTm+K9RClR7IOQnyQurGRPZJhFqH1KoDvmdR/YnbcHZ/farJ0ZVmIZFm126LtATzT2P1w5AJJLcFE/BVou/Zt+4VELU39C1wterUT9yzZBJBsPb1I1LnvV7z8qtG8JzZqEK7FK/64wBjzr32q3K3YOvO3nMH/WylvHQKFC4QJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784817970; c=relaxed/simple;
	bh=yJ9roKmsUrsxfA6NIeNKiOR+jNPE8ZIkwuF1SIP1Qa0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=sP1TjDDqeqZ1gz0L5kyPnOgLEey4m56QhKGLenVjz/UucNuLKelxVjSCMzxhD4qFpsPtFO71DYQ6pJpfrSLbMM57Aimiww6AdixS/FkSBNufvijmCY0/0HypKoeYIHRftZHX1McOfOFOe7NoNNW1+HYsX/OwPdPN9DXNu3I/yTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=JxO19SMK; arc=none smtp.client-ip=93.190.126.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=grrlz.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b="JxO19SMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1784817964;
	bh=2I4+emJ6jZ81A5mqeezPydeNIgRNkfR0mwgux8PqAGw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=JxO19SMKdzvOSNZJSSmFlIKHU5ZOMgTt6Oo0eQTl034MQQfoS1pAgnMn5gch5sR4E
	 +fbFZNXmvPZJx5Vl87xtg5JkWB6xFGrEPRZnsnWeZGkX5QX+EOnevbtnIwsY5i9Pmg
	 kyeJackXOn7bOou15uYNy2yNJ2AyoAWODm5IBrRs=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4h5YpN5qSzz12vW;
	Thu, 23 Jul 2026 14:46:04 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4h5YpL23RWz12Rh;
	Thu, 23 Jul 2026 14:46:02 +0000 (UTC)
Date: Thu, 23 Jul 2026 15:46:00 +0100
From: Bradley Morgan <include@grrlz.net>
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
CC: akpm@linux-foundation.org, baoquan.he@linux.dev, rppt@kernel.org,
 pasha.tatashin@soleen.com, pratyush@kernel.org, rafael@kernel.org,
 lenb@kernel.org, pavel@kernel.org, kees@kernel.org, tony.luck@intel.com,
 gpiccoli@igalia.com, linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
 linux-pm@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_3/3=5D_PM=3A_hibernate=3A_log_?=
 =?US-ASCII?Q?the_task_that_initiated_the_power_down?=
In-Reply-To: <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
References: <20260721151358.4185467-1-include@grrlz.net> <20260721151358.4185467-4-include@grrlz.net> <CAJZ5v0jN0QQordGJ+7EyO42Zwidok0j+TKZLCmRhU8CFeRHMuQ@mail.gmail.com>
Message-ID: <22B60EFE-21BC-4E2F-9542-93D9FC2AAAB1@grrlz.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On July 23, 2026 2:55:41 PM GMT+01:00, "Rafael J. Wysocki (Intel)"
<rafael@kernel.org> wrote:
>On Tue, Jul 21, 2026 at 5:14 PM Bradley Morgan <include@grrlz.net> wrote:
>>
>> Give the hibernation power down the same treatment as the reboot
>> syscall commands.
>
>Why?

1: Andrew suggested it [1]
2: because going down for hibernation is the same as "Wait, who the hell took the box down?!"


>
>> hibernate() runs in the context of the task that
>> asked for it, whether through the reboot syscall or a write to
>
>It doesn't use the reboot syscall.

Hmmm.... I may embarrass myself here, but it *could* (wink)

See kernel/reboot.c:

#ifdef CONFIG_HIBERNATION
	case LINUX_REBOOT_CMD_SW_SUSPEND:
		ret = hibernate();
		break;
#endif


>> /sys/power/disk,

I'm wrong: /sys/power/state

 so when power_down() runs current is still the
>> initiating task.
>>
>> Log it once the image has been written and the machine is committed
>> to going down:
>>
>>   reboot: initiated by systemd-sleep[812]
>>   reboot: Power down
>>
>> The line comes from kernel/reboot.c so it keeps the "reboot:" prefix
>> and sits right next to the final "Restarting system", "Power down"
>> or "System halted" line, same as a plain reboot.
>>
>> The one exception is platform mode rolling back on a pending wakeup
>> event after the line has been printed. The existing "Wakeup event
>> detected during hibernation, rolling back." line follows immediately
>> in that case, so the log stays real about what happened.
>
>(a) Why is this information in the log useful?

when the box just randomly goes down, some people prefer to know 
"And what process did this? Or what did this?", say

"Was it systemd-sleep? Or some random power daemon?? Or some stray
reboot(SW_SUSPEND)??"

Userspace logging can't really do this... 

There is software out there which can do this, but it's not the greatest.
[2]

Hence, this series!

>(b) Do you realize that it only appears in the log when hibernation
>fails or it may appear on a serial console or similar?

yeah. The image is written when the line prints, so after a successful
hibernate and resume dmesg won't have it.

Thats exactly the
same visibility as the final "Power down" / "Restarting system"  line it
sits next to

Well, if you want it, please say.


[1]:
https://lore.kernel.org/all/20260719231540.455bd5c3eac842686c05bd7f@linux-foundation.org/

[2]: https://docs.memfault.com/docs/linux/reboot-reason-tracking


(oh and btw, if you don't buy in, it's ok, just say.. any questions, ask)
:)

>
>> Signed-off-by: Bradley Morgan <include@grrlz.net>
>> ---
>>  kernel/power/hibernate.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
>> index d2479c69d71a..bec91bf6a63c 100644
>> --- a/kernel/power/hibernate.c
>> +++ b/kernel/power/hibernate.c
>> @@ -687,6 +687,8 @@ static void power_down(void)
>>         }
>>  #endif
>>
>> +       reboot_log_initiator();
>> +
>>         switch (hibernation_mode) {
>>         case HIBERNATION_REBOOT:
>>                 kernel_restart(NULL);
>> --
>

Thanks!
