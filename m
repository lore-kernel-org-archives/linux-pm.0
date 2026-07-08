Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EFA1274FDC;
	Wed,  8 Jul 2026 23:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783554902; cv=none; b=secWdbOMPWcP9KNGg1KZJjaZB45VFJtnuOIySZvB1t9vAz/97XvNrVoEAcTgyjScIf7wJ9J1qkmeDYs3Qc7tXIMfOXRrfYuN11W2uaJk26VGjMtM5Gf7L1DEeyj63Kr0gdrg5H/zVWjzWcZSfpg95QqWrAGRow4DJkU55HkCzX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783554902; c=relaxed/simple;
	bh=8wjdG35HLF3JHZvM426K0SmE1AxAF4MJlT+wFvjkhQ4=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=idoMtHjBNGiSFCEiROpgX6h22sJu8A7btvT7Yb/mXyFBTN8Qy3Oi+2H+E2ZNwZKkyv2HnhwsjY3twaYm+P/iEiTpetBi5eav3sWDdaY4kmtoYLqN/Ip2FaRlMXaUqS4B3Rlq3lcWXXFi21FamUv27QUMHSfYXIgz/GAKXcvC79I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=sSv99W6h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sb2Sxu/C; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="sSv99W6h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sb2Sxu/C"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 910BDEC00CA;
	Wed,  8 Jul 2026 19:54:59 -0400 (EDT)
Received: from phl-imap-08 ([10.202.2.84])
  by phl-compute-02.internal (MEProxy); Wed, 08 Jul 2026 19:54:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1783554899;
	 x=1783641299; bh=0fj0OfRKRN+V6v00303K9fBGX5o1MLHhUVcYImRPAOM=; b=
	sSv99W6h++OIkYrEH+58ybsw6u2lcYv5XAX1YeeESJALRA2bUMWnYnXUI1zlkvUg
	S8RrOnyQawetGjoD55TSSFd1WvTXUZUGA9Zye/I+t6LL7O+Fo+QQ60VVFMiet8GC
	NWTn2RiPWM9h8GoDDcAOYdkMlH2lIOoo+SSdMbJXlc36/eOwH5kw41GoLA8TYxnZ
	+UxLZsGLFXWf+lX+31pJQu5SidPnNz/QmNXnVDVhLdgCJ7ARquIS0MOVYe6bzJ0m
	RFwY14xYR5DGTHFtUqw33X+R+SANBdtelQZdg8Wvf8WWL69h/GWkOFf3Bh4yFEJj
	3ntqHuXLIFS2fa57fYxjMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783554899; x=
	1783641299; bh=0fj0OfRKRN+V6v00303K9fBGX5o1MLHhUVcYImRPAOM=; b=S
	b2Sxu/Ch5qca8HRHUT4H2fDqk4gipYZOALFSz2aOcTGSHYxuaMqy+Q/CEXwc8LsI
	/+CGQTpZahB9cuKe/Ykkfy0y8xlhxTP4bnvTOrSOffC9Ir/gfE/HK9oEP/JfX7GP
	pe3YMGhS+e1VhJiKQn2J2E7pawFNtucnQc8PDmnO3GUJLvREnTYS2gZFFsvZ4rS+
	ZEYMPrye0f3F8oVA2gMurXI4IZ2ByG1s0a3fr+ClJJiEtVspg2Zug/yBblGKGHUw
	fO8j8zN+mWZpQeGUbbUGhiNgnhN80oWFVH+qdyC9uciCNhEBaGAuskhauFhkg985
	jNEWj071jJDq/ygSUVLLA==
X-ME-Sender: <xms:UuNOauDm9r0tJcq_TmXgfYkXhevs1icWVSexvNUJvm6dx40WXRObmg>
    <xme:UuNOajVhnKePTzl4gEvO3zB-m6pcAh3HKK951aZ8Gsh2nXhLDdLLQQTubR1Vxui5_
    qECcVrDzZJW9pvnjtx0ulqhil3wjrsnhzf7El6yiu8-OWwo5B0euYA>
X-ME-Proxy-Cause: dmFkZTEh28FWsb4YZngwi97wFmwz2xbVaURvOKOkCavWKWgl0GS/PEf9zC5Q2ElL8tR/Wy
    4TID+ycUASgHoy+Q+zrdjpm8qy54z7sET7e8DNwO9SSPq2fWVU1tu25tZg0EfRoPLazROv
    m3izOyxe2HbgcNZWV8HJbBBxlypYmOH+cGHhZida1lLUSDeGSIlXU4jkA+XZVQs6ZSFZcn
    YMfVfvFMwpCj40cVLAzgAHS9GbUJDuXDQ1kLL7UsPoCxdA4FgDvkqbOLzMh6okTk4TtqNz
    nMmXtX8Ro5MdpKb1WnG0yqysQqMFnVwGeAY/cF4V20hxqm+iyyH1AuxTKGTL1D0iyK6Wje
    AnBSxcWw+ww53PzA9ON9zzbmJYtOpcqLF3/fnib5X8PgNBWzzpjiocfdyVSoCn9lkLvBPL
    +rMEsUqSCZ+CpKneNtWG/CQvqNrnteespJPvOqcKEokMkGZM8VksOtmHHF6/dsdkHiG3rf
    JjnYg71inYCbDnLqRvQubMT7CLq6IV8fcu2r5H3QlfBgbNFmUVPDc+vz/6nS/AITce9FkW
    vGhPBqrnCDlk5cCNgHwObBEsyVQFsXnW/61JVLGCQmQESUkpFQU/Ub6cwi47eVakgwgbLS
    YeP8Vm6M8A0LLbPe0d1gLj+cxb7lQgBvBF92eS1XQDDS9hLlppz24ymhU96Q
X-ME-Proxy: <xmx:UuNOamnxZFVm8qOzn2nEZBiwr6pbB1DW0fhJzMFhQhEYG8S_qC3otQ>
    <xmx:UuNOagEkeaYPJfuP0LrLRFen3A64zvibijIUig1fxxIN9lAz4IKFZQ>
    <xmx:UuNOam4WHbIiGbe655ara7ZSByxuIliqWymYke-_rSN7HVvRYa2ZAQ>
    <xmx:UuNOagnPoJip2jjIKjMBwcqs3GifS_yIrM_g4k1i0OepumvmgnnQxA>
    <xmx:U-NOamLs8uVOeNI0IQOorKMpbKomLdbTwRrlic1e2oABNVEVLDLcDmDh>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8CCFA2CE0078; Wed,  8 Jul 2026 19:54:58 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_tw3h5u72vV
Date: Wed, 08 Jul 2026 19:54:38 -0400
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "Polina Vishneva" <poli@0iq.dev>, "Len Brown" <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 "Artem Bityutskiy" <artem.bityutskiy@linux.intel.com>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Message-Id: <4390834c-8bcf-4d3a-8e95-1d8508fd4c05@app.fastmail.com>
In-Reply-To: 
 <YQYPR01MB11542163CE28DD33BDC70AC73BDFF2@YQYPR01MB11542.CANPRD01.PROD.OUTLOOK.COM>
References: <6O1QHT.QP6URTCEWLSV1@0iq.dev>
 <CAJvTdK=XuhxrZ+ULuXyV=cMsSS9caqDBACXUnj+R6UYesMXABA@mail.gmail.com>
 <YQYPR01MB11542163CE28DD33BDC70AC73BDFF2@YQYPR01MB11542.CANPRD01.PROD.OUTLOOK.COM>
Subject: Re: Fw: [External] Re: Lunar Lake: silent fatal platform resets caused by
 idle-exit core hang
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Note - switched to my open-source friendly email account. Lenovo email s=
ucks.

>
> I think the chances of this being related to the Linux kernel are very=
 small.
> (We've run Linux on this model and it has been fine.)
>
> It would be interesting if booting with "idle=3Dhalt" makes the issue =
go away.
>
> My guess is that you've got a flakey DIMM.
> Does it pass an overnight memory test?
>
> Unfortunately, I believe the DIMMs on this one are soldered onto the
> motherboard...
>
> cc: Mark, who may have some insight....
> cheers,
> -Len
>
> On Sun, Jul 5, 2026 at 5:43=E2=80=AFPM Polina Vishneva <poli@0iq.dev> =
wrote:
>>
>> Hello.
>>
>> So, I've got frustrated enough with my system cold-resetting every few
>> days to try to debug the issue, with some success.
>>
>> TL;DR: cold reset on the cpuidle exit path.
>>
>> It's *probably* not actually a kernel bug, but I don't know any better
>> place to submit it (hoping that the Intel folks will take a look).
>>
>> System:
>> - Lenovo ThinkPad X1 Carbon Gen 13 (21NS001ACD), BIOS N4BET75W (1.45).
>> - Intel Core Ultra 7 258V (Lunar Lake), microcode 0x126.
>> - Kernel 7.1.1, intel_idle in ACPI _CST mode.
>> - Reproduces even with intel_idle.max_cstate=3D2, so the enabled
>>   states are only POLL, C1_ACPI and C2_ACPI.
>>
>> On boot after each crash, the kernel logs:
>>
>>   BERT: [Hardware Error]: Skipped 1 error records
>>
>> I pulled /sys/firmware/acpi/tables/data/BERT by hand and decoded it w=
ith
>> https://apc01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fg=
ithub.com%2Fintel%2Fcrashlog&data=3D05%7C02%7Cmpearson%40lenovo.com%7Cf3=
802edcfdf349bfdd3c08dedd3a20a6%7C5c7d0b28bdf8410caa934df372b16203%7C0%7C=
0%7C639191438937666379%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsI=
lYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%=
7C%7C%7C&sdata=3Dt09jXVwO9ptn39ez5fPlWlnPF7YtqtyuUwxvs484PUU%3D&reserved=
=3D0<https://github.com/intel/crashlog>.
>>
>> The region contains a full PMC crashlog (MCA, Punit, UNCORE, PCORE,
>> PMC, PMC_RST, PMC_TRACE records). iclg summarizes the failure as:
>>
>>   CORE_TIMEOUT.SINGLE_STUCK_TRANSACTION.C898FH
>>   MCA.BANK3.INTERNAL_TIMER_ERROR.MSCOD_E184H
>>   CRASHLOG_REASON.PMC.10H
>>   CRASHLOG_REASON.PUNIT.20004H
>>   RESET_CAUSE.FIRMWARE_GLOBAL_RESET.FW_GBLRST_SCRATCH16
>>   RESET_CAUSE.GLOBAL_RESET.PMC_FW
>>
>> The important registers (one P-core has captured state):
>>
>>   mca.bank3.status =3D 0xbe000000e1840400
>>       VAL|UC|EN|MISCV|ADDRV|PCC, MCACOD 0x0400 (internal timer /
>>       retirement watchdog, "three-strike"), MSCOD 0xE184
>>   mca.bank3.addr =3D mca.bank3.misc =3D arch_state.lip
>>                  =3D 0xffffffff9471bb3c        (kernel text)
>>   super queue: exactly one stuck transaction (cacheline 0xC898F)
>>   pmc_rst: gblrst_cause_0.pmc_fw=3D1, fw_gblrst_cause_0.scratch16=3D1,
>>       gblrst_req_0 =3D pmc_fw|syspwr_flr|pchpwr_flr
>>
>> The LIP: given that KASLR slide is 2MB-aligned, (lip mod 2M) is an
>> invariant. Solving over System.map text symbols gives 14 candidates, =
of
>> which only one can be related:
>>
>>   cpuidle_enter_state+0xbc
>>
>> Disassembly:
>>
>>   +0x73  call __x86_indirect_thunk_rax   ; target_state->enter()
>>    ...   sched_clock_idle_wakeup_event / local_clock_noinstr /
>>          sched_idle_set_state
>>   +0xb6  call *pv_ops...irq_enable       ; patched to STI at boot
>>   +0xbc  test %r14d,%r14d                ; <- LIP
>>
>> So (my best guess) the core had already returned from MWAIT, executed
>> STI on the idle-exit path, and then stopped retiring instructions. The
>> retirement watchdog then fires, Punit reports CORE_TIMEOUT, and PMC
>> firmware pulls a global platform reset.
>>
>> The question is whether it is something known or rather something
>> platform-specific that should be reported to Lenovo instead.
>>
>> I can provide the raw BERT dump, and also I'd be happy to debug/test =
if
>> requested.
>>

With the BERT error this looks like a HW issue. X1 Carbon is one of our =
more popular platforms and should run Linux really well (I used it mysel=
f quite a bit for 6 months).
You probably need to call Lenovo support to organise an RMA.

If you want you can send me the kernel log and the EC and ME details (yo=
ur BIOS version looks recent) and I'll have a look through and confirm t=
here's nothing else funky going on.

I can share the certified Ubuntu or Fedora images if interested. I doubt=
 it's worth burning the time on doing the whole reinstall dance but it c=
an help when dealing with Lenovo support - they like to know the certifi=
ed image fails too.

Mark

