Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322052;
	b=E6ahrImH8e2OW4vEjNB9oS8OoUXKU28PwwWIBKUwHFzQ6d3kcLZpk80ZaH2B1+VQA52o
	 Bv+I0Pd8c2i9x2c59sxvj4XH2S75A8g2A1HGVmR3o+xRsrLoerDECFM+SEsZiKhbEVWoa
	 fOkmsqpvwLuhevmAK1ikn+OFJO45vzet+lZwytZhKmlmN9eAmf6lBXQ06ZTkoWWDnftOV
	 dmB5Gs0BgXhBjw2b8RKr3FNRXC59jL0s6OmXwYPvofyCdF/q0OESO60sdQ6dhrFu63Ss7
	 HMIJhlk8Q/BL0phF3i3ZBaaoBl56PTvIu3P8wuyW9qobLfaocq2YqZ3prceSZPnIdVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322052;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=zYrbKUrrhiWhuUIHfWppc5eatCVfJErJZhYrxtExoA0=;
	b=o9OOJwinLEtcpeCJOzqSidDJYAjNg9DmlvI03nuTQy2NYJvDoEFPliynNBTlZcLiKIir
	 LL6iPZp0nbGr4EuCB6GYFsCvolI54bAEkhSTu9ZlZj3nvHjeZ47iUU2MOktd0xBgBxjvZ
	 9WlRh5ZqwIcQlV+gCJN4q17kVVqwUxRwyhu1U1QjPtaDUI5Ycapp+c9S9UokR9wlm1wVH
	 CpzsJ3PHu2BJNA2WoIUkU9NvJn1AKYGl7p2UXntdBaSORJxTUkCiduzBM4Y2KrRDcYVW7
	 bMUHAg4VHicBEArdGT1kjqGIHr37NneF6mXFph9JXnkghBuLBaUkTTQjOoTefFa9o8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KesO+rgT;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B354E606A325;
	Tue, 10 Nov 2026 14:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B354E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=KesO+rgT
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0679C1477;
	Tue, 10 Nov 2026 06:47:28 -0800 (PST)
Received: from [10.57.15.53] (unknown [10.57.15.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 442823F632;
	Tue, 10 Nov 2026 06:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794322051; bh=XYUpXMXpunbRvsnV8H46R4geCfYL9eeevnHVAJ65qbQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KesO+rgTQUiN+M15PMxPKVf7Sqs7H9386kSssQ0Manrf1HK4S3tTpIBb3LGzvOgji
	 q9xo+aPeDwk0/LauDKLJAMawnwEwiy6ryzrVikTFfwfQ0VLDuiwIEuwoQIcfLCE7Nu
	 dUjcxw4hu8vKq09o9g7foqpJozr2MUwduLUhB38s=
Message-ID: <5a593b56-2f16-4b86-bcc4-e0f632b47577@arm.com>
Date: Tue, 10 Nov 2026 14:47:21 +0000
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
Subject: Re: ACPI: CPPC: shared PCC subspace data can be freed while another
 CPU probes, reads, or tears it down
To: =?UTF-8?B?5b6Q5pmX57+U?= <xuhx@hust.edu.cn>, rafael@kernel.org,
 sudeep.holla@kernel.org, jassisinghbrar@gmail.com
Cc: linux-acpi@vger.kernel.org, viresh.kumar@linaro.org,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lenb@kernel.org
References: <4c7f9772.192e1.1a17d5c2ed5.Coremail.xuhx@hust.edu.cn>
 <2026102727-data-sequel-ce41@gregkh>
 <7e7371c7.22ae1.1a1c591c7ae.Coremail.xuhx@hust.edu.cn>
Content-Language: en-US
From: Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <7e7371c7.22ae1.1a1c591c7ae.Coremail.xuhx@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/10/26 13:07, 徐晗翔 wrote:
> pcc_data[] is a global array of shared PCC-subspace objects.  The
> reference count is an ordinary int updated without a lock, and
> acpi_cppc_processor_exit() can kfree() the object and set the slot to
> NULL while another CPU's accessor is using it, while another CPU's
> first-online probe is allocating/registering it, or while another
> remove is decrementing the same count.  The result is a UAF, a NULL
> dereference, a lost refcount update/leak, and a PCC channel/shmem
> lifetime problem.  This report is source-level: the test environment
> does not have a PCC/PCCT controller, so no dynamic reproducer is
> attached.  I am not claiming the double-free variant.
> 
> The detailed description:
> 
> * Test environment / affected version
> 
>   Linux 7.3.0 source (verification/linux-7.3), line numbers from 7.3.
>   The available QEMU/KASAN guest used for the sibling CPPC report has
>   no PCCT table and no PCC mailbox controller, so it cannot create a
>   real pcc_data object.  I did not fake a pcc_data object or call the
>   teardown path with a synthetic pointer; that would not be a valid
>   dynamic reproduction.  The affected code is the normal
>   CONFIG_ACPI_CPPC_LIB path in drivers/acpi/cppc_acpi.c plus the PCC
>   mailbox release in drivers/mailbox/pcc.c.
> 
> * Mechanism
> 
>   A PCC subspace can be shared by multiple CPUs.  pcc_data[pcc_ss_id]
>   is the global slot, and its refcount is the number of participating
>   CPUs (cppc_acpi.c:48-83).
> 
>   Allocation (cppc_acpi.c:714-729) is:
> 
>     if (pcc_data[pcc_ss_id])
>             pcc_data[pcc_ss_id]->refcount++;
>     else {
>             pcc_data[pcc_ss_id] = kzalloc(...);
>             ...
>             pcc_data[pcc_ss_id]->refcount++;
>     }
> 
>   There is no lock, and the slot check, allocation, publication and
>   increment are not atomic.
> 
>   Teardown (cppc_acpi.c:1037-1051) is:
> 
>     if (pcc_ss_id >= 0 && pcc_data[pcc_ss_id]) {
>             if (pcc_data[pcc_ss_id]->pcc_channel_acquired) {
>                     pcc_data[pcc_ss_id]->refcount--;
>                     if (!pcc_data[pcc_ss_id]->refcount) {
>                             pcc_mbox_free_channel(...);
>                             kfree(pcc_data[pcc_ss_id]);
>                             pcc_data[pcc_ss_id] = NULL;
>                     }
>             }
>     }
> 
>   This is a plain read-modify-write, followed by a separate read for
>   the zero test, with no pcc_lock and no teardown mutex.  The release
>   happens before kobject_put(&cpc_ptr->kobj), so the kernfs drain that
>   protects the cpc_desc sysfs object does not protect pcc_data at all.
> 
>   Accessors take the global slot and immediately use it:
> 
>     cppc_get_reg_val_in_pcc(): pcc_ss_data = pcc_data[pcc_ss_id];
>                                down_write(&pcc_ss_data->pcc_lock);
>     cppc_set_reg_val_in_pcc(): cpc_write(...); then the same lookup
>     cppc_get_perf_caps():     same pattern (cppc_acpi.c:1488 onwards)
>     cppc_get_perf_ctrs():     same pattern (cppc_acpi.c:1678 onwards)
>     GET_PCC_VADDR():          pcc_data[id]->pcc_channel->shmem directly
> 
>   None of these check for NULL, and none hold a reference that would
>   keep pcc_data alive across the use.
> 
>   Four independent interleavings follow:
> 
>     A. exit vs accessor.  The last CPU is unbound while its tick,
>        cpuinfo_cur_freq, or an already-running acpi_cppc sysfs show is
>        in a PCC accessor.  exit frees pcc_data and iounmap()s the
>        channel shmem; the accessor then calls down_write() on freed
>        memory or dereferences NULL.  This is the simplest UAF and does
>        not require two CPUs to be removed at once.
> 
>     B. remove vs remove.  Two CPUs sharing the subspace both read
>        refcount == 2, both write 1, and neither frees: the object and
>        channel leak.  If one remove has already freed and cleared the
>        slot while the other has a stale non-NULL value, the second
>        remove can dereference NULL or freed memory.  The exact
>        double-free requires both removals to observe zero, which needs
>        an under-count or another remove path; I am not claiming it.
> 
>     C. first-online probe vs remove.  CPU B is doing its first
>        physical online and runs acpi_cppc_processor_probe(); CPU A is
>        being unbound and runs acpi_cppc_processor_exit().  They share
>        the subspace but hold different CPU device locks.  The probe's
>        pcc_data_alloc() can read the slot just before exit frees it,
>        then increment freed memory; or it can enter register_pcc_channel(),
>        sleep in pcc_mbox_request_channel(), and then write the channel
>        pointer into a slot that exit has already freed and cleared.
>        acpi_cppc_processor_probe() also dereferences
>        pcc_data[pcc_subspace_id]->pcc_channel_acquired at
>        cppc_acpi.c:981 without a NULL check.
> 
>     D. channel release vs in-flight send.  pcc_mbox_free_channel()
>        (drivers/mailbox/pcc.c:431-448) only iounmap()s the shmem and
>        calls mbox_free_channel(); it does not wait for an in-flight
>        mbox_send_message()/txdone or for send_pcc_cmd() to finish.
>        An accessor already in send_pcc_cmd() can therefore use the
>        revoked mapping or the freed channel.
> 
>   The probe failure path is a separate, non-race lifetime defect:
>   acpi_cppc_processor_probe()'s out_free path iounmap()s and
>   kfree()s cpc_ptr but does not decrement the pcc_data refcount that
>   pcc_data_alloc() just took (cppc_acpi.c:1015-1023).  It can leak the
>   channel/object, but it is not the concurrent UAF above.
> 
> 
> * Reproducer and results
> 
>   No dynamic reproducer is attached.  The current QEMU test
>   environment has no PCCT/PCC mailbox controller, so a real pcc_data
>   cannot be created; I did not substitute a fake object.  The evidence
>   for this report is the source-level lifetime above, with the exact
>   line references in the mechanism section.
> 
>   Static evidence summary:
> 
>     - cppc_acpi.c:714-729: plain refcount++ in pcc_data_alloc()
>     - cppc_acpi.c:1037-1051: plain refcount--, zero test, free, NULL,
>       all without pcc_lock
>     - cppc_acpi.c:981-989: probe reads pcc_data[...] without a NULL
>       check and calls register_pcc_channel()
>     - cppc_acpi.c:644-675: register_pcc_channel() writes the channel
>       after a sleeping pcc_mbox_request_channel()
>     - cppc_acpi.c:1313-1336, 1366-1389, 1488+, 1678+: accessors use
>       pcc_data[] without a reference or NULL check
>     - cppc_acpi.c:97-98: GET_PCC_VADDR() dereferences the slot directly
>     - drivers/mailbox/pcc.c:431-448: free does not wait for in-flight
>       sends
> 
> 
> * Suggested direction
> 
>   Make pcc_data refcounted with refcount_t and update it under a
>   dedicated teardown mutex (or pcc_lock), with the slot lookup and
>   increment done atomically.  Accessors should acquire a reference (or
>   use RCU) before dropping the lock, and the free path should clear the
>   slot first, then wait for readers/in-flight sends before
>   pcc_mbox_free_channel().  Free pcc_data after the kernfs drain, or
>   make the sysfs show hold a pcc_data reference for its whole call.
>   The probe error path should roll back the pcc_data_alloc() increment.
>   Report-first, no patch attached; I can test a proposal on PCC
>   hardware or a suitable QEMU model if one is available.
> 
> 
> 
>   Please keep me in Cc; I am not subscribed to the lists.
> 
> 
> 
> Regards,
> Hanxiang Xu
> xuhx@hust.edu.cn

Thanks, both ACPI CPPC reports were already on the list:
https://lore.kernel.org/all/c1190e23-2043-46d9-ae7e-f95103363b0b@arm.com/
https://lore.kernel.org/all/20260830115644.2056983-1-christian.loehle@arm.com/
https://lore.kernel.org/all/20260916162805.1039247-1-christian.loehle@arm.com/

I will fix them.
