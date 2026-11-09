Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=81.169.146.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794234614;
	b=V4wbUuy5KZFJ/K9/9T9fKchZUgMqhixGFQj06aLQPywDbjwvgBCXLIT9zSK61jHfnXTc
	 Qo5t3cuvKlzngEUuM35YVTPn6Hi31yoQW8o2Wp4GOra23UTiUqRHT34vPONcwHT8hqV1i
	 UdlYYn+GG3X9HLTR4ocrC7hnSRy1u/M3JAGQkfxk5oe2a7K37LzsCmLYa4j+FgS1MDdKs
	 YlSFeI4qXi1Hag8MAzUefbAWL/xRbFHetIyxpdLXamcyfkgsD9PTWEX9uTGYfAzBxN/UT
	 z4ros71yoVUn1bdIFOJ+WkxmvznTUtqFfECTWIk/RAx487SObcAdjReAlqqpNxXvqRg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794234614;
	h=DMARC-Filter:X-RZG-CLASS-ID:DKIM-Signature:DKIM-Signature:X-RZG-AUTH:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8KiPHgaI34vv0/q5DZBdlVQ5Ql56ikXsCwH4QLHKU2g=;
	b=P0Cx5lvjRpk0U6BDAWawqJfhe7VbdSEbLf+WDfsGGfxVEQdu8nWOhRVS85sjAolOwNx6
	 F0cWfy2oKCLZJxlpyHnkwOwGqmqZMbh3wEUCIRYyiRVMlg/HUbBrmCGbBp5Za+HPyv3sv
	 IQOkRNsw8yKUdkVt63DTf3O8WcIGo5neqpo0oo9Mv2r/nFS6Xb1tbpzNNcwY1xOSZZyBJ
	 WmkGkmzfaXFxkf9p+IkTKisZ4UnzDqFFkSaHOV2OzSLoA2mMdekj/PyZ4JGzcQGmH9XN+
	 AlmvH97HWR6hMFquGf1pTQFNWuYfXLis82POW+VcaBLusgiW/ramjn50RuGF+VtspQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outer-limits.org;
	spf=pass smtp.mailfrom=outer-limits.org;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lk0NjN7H;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iCZOqIGw;
	arc=fail smtp.remote-ip=81.169.146.171
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A32606A322;
	Mon,  9 Nov 2026 14:30:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49A32606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outer-limits.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outer-limits.org header.i=@outer-limits.org header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=lk0NjN7H;
	dkim=pass header.d=outer-limits.org header.i=@outer-limits.org header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=iCZOqIGw
ARC-Seal: i=1; a=rsa-sha256; t=1794234590; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Z9INr75GkDeSq3HwFpO/yirX6fuxNLHAqiRuj05jGCO9YSrd1CasgUAXGLHI59CW7D
    ghln5jXkT/V6uMeNVzqvrlj+MJr2MhTdVmskwpxsuUlfNFa0UMoRJem5dR0X2ZWAbc2u
    r7CwyTsZPbWEj4za8cT4Gv490WY+Lc2IBwsVzq4MQFCluB9QXNM6dO0vQXgts773F6UT
    sDukfgxj0o6iM8T+BzDlupIZWr2q4UNF6Y4QKrBqgIQbd8ob4rXJjtJCpHxboeVVnnEy
    vNVwuB9YXqWOIe5NtQmoRZXOmY9+nOsivALNnH3AtaEmuIxKgWZhA+/muCje2ZeE9i9M
    iAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1794234590;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8KiPHgaI34vv0/q5DZBdlVQ5Ql56ikXsCwH4QLHKU2g=;
    b=O22EbDoxqG9yX7AurB1FwUDJKOuw1LocmMfTgvP28Uj0qGAEPPWto0n8of12Q0MVla
    1sRXclyzmGGU1gYeDWSUUedwsfJb6xJMsLmvxFnnW+Tk4HFaVuyOwKjBAGgHAj2jbT9m
    tt5VmxvA7JkxizBFkUKPpHDOQQJLIHBIwMHzRE2FTyfI2FFF5Hz9G4A+BFKGrtYPAwh3
    D+rnM9x5eay/iFKURxrDn2TVw0UP4WTRrpOzIsIexJROG/xfQ375Ie9rNQ1rZFVXMhzw
    3Sh0HUsShGDXpex/eI8+WGaOrIZEM5D5/Xtug6TuCs048NAJ0CjZs2htiNUyvZRaRYhI
    55XQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1794234590;
    s=strato-dkim-0002; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8KiPHgaI34vv0/q5DZBdlVQ5Ql56ikXsCwH4QLHKU2g=;
    b=lk0NjN7HDjSoWExkDonAsB75kBu/iJvoZJ+4z5YvKXGUg1uQ0Vr3f0fCDWenrYD61X
    ceRq5BsPMi685YXVdMYi0zQgvy8KCf7jyLzgRDkgHu2lJNc44uLhmdUGcLr8SvsHhP9G
    cjckct2LmgkyTYLJjn8VauDwSo1UvpQ2306a2xpbY+7lXghqtbxvp+CMVH/2dq5tzp1r
    WJenrW4d2H6rwPGp/fSZY3LiYcaXcaDjBpJn8r5svAcbSzkM8cNLIHNb9cmX5OFYiLJT
    nrW2kF4CU/13IEHIO4mmvwNFhg9n/8QJobNQN8vmbTIXQ/2yYup4KT6BV7es5zGOVt7T
    pWMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1794234590;
    s=strato-dkim-0003; d=outer-limits.org;
    h=In-Reply-To:From:References:Cc:To:Subject:Date:Message-ID:Cc:Date:
    From:Subject:Sender;
    bh=8KiPHgaI34vv0/q5DZBdlVQ5Ql56ikXsCwH4QLHKU2g=;
    b=iCZOqIGw9SLc/UbmFWdWVNDa5Xu7IOH+2paJz4mFxFjDnCODFcOuAzaQR4dzHQ0GHn
    hec2m2ds27X4F7L/fRBA==
X-RZG-AUTH: ":JnkIfEGmW/AMJS6HttH4FbRVwc4dHlPLCp4e/IoHo8zEMMHAgwTfqBFXdk1Z5IDmIqDY7xpnOs6mGD64frXxHtrE3e66udIGwZnWwLgga9o="
Received: from [IPV6:2a01:cb15:80c6:e800:a9dd:2b53:f1aa:d3fa]
    by smtp.strato.de (RZmta 55.6.3 AUTH)
    with ESMTPSA id J82cde2A9ETn2f5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 9 Nov 2026 15:29:49 +0100 (CET)
Message-ID: <c479d14a-aedf-4815-b191-a5ebf41c1844@outer-limits.org>
Date: Mon, 9 Nov 2026 15:29:48 +0100
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
Subject: Re: [PATCH 1/6] irq_work: Re-raise pending irq_work after system
 resume
To: Adrian Hunter <adrian.hunter@intel.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jiayuan Chen <jiayuan.chen@linux.dev>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Frederic Weisbecker <frederic@kernel.org>, Andi Kleen <ak@linux.intel.com>,
 linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, driver-core@lists.linux.dev
References: <20261102074039.26983-1-adrian.hunter@intel.com>
 <20261102074039.26983-2-adrian.hunter@intel.com>
 <20261102090604.GR1779021@noisy.programming.kicks-ass.net>
 <74511f6b-f5ff-498f-bf97-ebdc86c43d24@intel.com>
 <20261102163937.KwllF-Pg@linutronix.de>
 <2d6105b4-bd75-41b5-a7b2-da91bda31350@intel.com>
 <20261104073220.Hgq4chT1@linutronix.de>
 <56198a93-670e-4187-86a3-99ae54295998@intel.com>
Content-Language: en-US
From: Julian Vetter <julian@outer-limits.org>
In-Reply-To: <56198a93-670e-4187-86a3-99ae54295998@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/4/26 8:48 AM, Adrian Hunter wrote:
> On 04/11/2026 09:32, Sebastian Andrzej Siewior wrote:
>> On 2026-11-03 17:46:32 [+0200], Adrian Hunter wrote:
>>> On 02/11/2026 18:39, Sebastian Andrzej Siewior wrote:
>>>> On 2026-11-02 12:54:22 [+0200], Adrian Hunter wrote:
>>>>>
>>>>> Yes CPUs remain online for suspend2idle, but currently the choice between
>>>>> suspend2idle and "deep" (S3) suspend is a user space choice,
>>>>> refer /sys/power/mem_sleep.  Many modern systems do not support S3
>>>>> anymore, but it has not gone away.
>>>>>
>>>>>>
>>>>>> Anyway, I'm torn; I would much rather make this trigger a WARN and have
>>>>>
>>>>> AI now also identifies ftrace, BPF, GHES NMI, and #MC as possible causes,
>>>>> not just perf.  I haven't tried to confirm any of those.
>>>>>
>>>>> And, belatedly, AI is now saying an irq_work raised before lapic_resume()
>>>>> might result in #GP if the APIC is left in xAPIC mode at resume.  Also
>>>>> not confirmed.
>>>>
>>>> Could we flush this before similarly to what happens during CPU-hotplug.
>>>> The question is if this event can stay enqueued during suspend (and
>>>> handled on resume) or should be taken care before entering suspend.
>>>
>>> WRT "might result in #GP if the APIC is left in xAPIC mode at resume",
>>> the systems I have checked restore the APIC in x2APIC mode, so the
>>> issue is theoretical at this point, although I can get "unchecked MSR
>>> access error: WRMSR to 0x83f" if I deliberately add code to change
>>> x2APIC to xAPIC early in S3 wake (in x86_acpi_suspend_lowlevel()),
>>> and then do:
>>>
>>>    perf record -e power:suspend_resume --filter 'action == "machine_suspend" && start == 0' --no-buffering -C 0 -o /tmp/x.data &
>>>    rtcwake -m mem -s 10
>>>
>>> The error can be avoided with:
>>
>> I meant flush it via irq_work_run_cpu() like in smpcfd_dead_cpu() (the
>> CPU-hotplug path) and not go via APIC. You should do it late once the
>> interrupts are disabled so no new irq-work can be enqueued.
> Disabling IRQs doesn't stop NMI or syscore enqueues, and the resume-side
> raise still goes through the APIC

Hello Adrian,
I ran into the same lost irq_work self-IPI independently, in a different
context. I triggered that same issue with a live migration of Xen HVM 
guests. I sent a fix for it, but the posting only reached xen-devel and 
the maintainers, and not the Linux mailinglist (because my company email 
has some issues), so here is a short summary for everyone on this thread:

My Setup: XCP-ng 8.3 (Xen 4.17), Ubuntu 26.04 cloud image (kernel 
7.0.0-38), 4 vCPUs, "console=tty1 console=ttyS0". After a live migration 
the guest hangs, e.g. "systemctl restart systemd-resolved" never 
returns, and fsnotify/SRCU users block.

Mechanism: On Xen, live migration suspends the guest through 
xen_suspend() (drivers/xen/manage.c), which runs inside stop_machine():

syscore_suspend()        -> lapic_suspend() disables the local APIC
HYPERVISOR_suspend()
gnttab_resume(), xen_irq_resume(), ...   -> printk()
syscore_resume()

With the 8250 console being nbcon, the printk() in that window queues
nbcon_irq_work to the raised_list on CPU0 and then sends the self-IPI. 
But, the APIC is disabled at that point, so it's dropped. Afterwards, 
the raised_list stays non-empty, so irq_work_queue() never raises the 
IPI again and we are in that same situation.

In mainline the nbcon trigger is hidden by 560f4deda327 ("printk/nbcon: 
Change nbcon_irq_work to IRQ_WORK_LAZY"), but the underlying problem is 
still there for any non-lazy irq_work queued in that window. To 
reproduce it on mainline I reverted 560f4deda327 on top of v7.4-rc1:

v7.4-rc1 + revert of 560f4deda327 -> hangs after the first migration

v7.4-rc1 + revert of 560f4deda327 + this patch (1/6 only) -> 6 live 
migrations between two hosts, no hang, no SRCU or hung-task warnings, 
systemctl returns immediately

Since xen_suspend() calls syscore_resume() after the window above, this 
fix with the new irq_work_resend() functions covers the Xen case as 
well, without any Xen-specific changes.

Regarding the flush-before-suspend: In the Xen case that would not help. 
The lost irq_work is queued by printk() after syscore_suspend() has 
already disabled the local APIC, with interrupts off, so there is 
nothing to flush yet when suspend starts.

Tested-by: Julian Vetter <julian.vetter@vates.tech>

Thank you,
Julian
