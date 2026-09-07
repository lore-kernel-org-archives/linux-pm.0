Received: from outbound.st.icloud.com (st-2002k-snip4-5.eps.apple.com [57.103.78.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D82E330D23
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788796847; cv=none; b=LdRQetPLrS6/y+D6oCNcdmU/TJx6o1pdUyVyyfr6cLkpP2u92GyDQtNzTYTWCxbVgfWxq/93gxlMGzDbUpapi16aJlDdF1PN+0MgUk6I6z/clJ1ldTHFUg1Rx2yDzoFkZFm5ad6+WO+v97E2hHg53ZZEvRb+PcCoy1KssD7D4aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788796847; c=relaxed/simple;
	bh=br2hmQZRkNwBbB2q7HS/COPZ3Snd9jCDeCk57A1JAGc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=kRz/3jQh+FzIZhLCerIJuuEQwGsUBoPSss74cjHJIGv2Cfn/VoznQaQUjVL0BJokK3v1vr0LphK9pbZo74wrJJyU9sTxf+j3GkrqoNTy20c9ODiIJdr86f52tYjrD7WlkO93X47hpxSDvTtU51WjHfF5pT/M0yRwHuWyoGcanVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Jf148OiD; arc=none smtp.client-ip=57.103.78.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Jf148OiD"
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPS id DB39B1800281;
	Mon, 07 Sep 2026 16:00:41 +0000 (UTC)
X-ICL-RepId: 01a07c99-af66-7f95-89cc-60047f7381e1
X-ICL-Out-Info: HUtFAUMEWwJACUgATUQeDx5WFlZNRAJCTQhIC0MCRQNDCVYBXxcOVk1KGV0DWQpVCXkRUAFYHlZeWhdeTVEPDxlaFFwYU0VRH1RYQQ4KWBIYXBRcUFgeRhJWDV0JGRhGXlAbXwJCDxwTVhUTHUMZDysISgRDB0UCXgslEwlTVlsTVRdGCRkIXR0ZFVoJCldRQF1OAV0ACR8WDhlSQAMJVkIUGVVdAEYKElpPBAgDDwNECEpzBFQHXQVdVlACWlUSBEAIVlBeCF4fTBw=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1788796844; x=1791388844; bh=l2EAFQ5baqL8h49z6YZjQbaX6bImsKCuVJ95ybo9FZs=; h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type:x-icloud-hme; b=Jf148OiDfOgo1Aw9HB8G49fgGMMBgkw/6BTfHLkHACWpdpZDm9bsNOJzAL/OaMtXK0uH9JJMGr5QV/JuhlKQFO790aRMavdTM8S6fB2vY8fJSMJ2wC+dG/WdFZOHm2ifzaEhfIk5j49CqTKT+gOpBDhU6s22t9Dfek1KS37d/2cM6ffbTXMVfnQI54r9BrlF4oxLmyXnzQFmTBZuoszMproF6ts2vCqZ/eBKAKH8+X64ZeiGM16rjrKun+a93m7j/wDNx8QnWipGjg33taYkgVnaljSf0F+4CPKC5Yg1AzQd6Fn7vPh7ZFWPvApe9CIhWDStrIruKMIP/PiIoH6rYQ==
Received: from [192.168.1.190] (unknown [17.156.216.30])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-2 (Postfix) with ESMTPSA id 5EC6F18002B9;
	Mon, 07 Sep 2026 16:00:38 +0000 (UTC)
Message-ID: <c0d6207b-f7aa-4bd2-af07-8bc77e4d1412@icloud.com>
Date: Mon, 7 Sep 2026 12:00:37 -0400
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-pm@vger.kernel.org
Cc: rafael@kernel.org, platform-driver-x86@vger.kernel.org
From: Sandor Nagy <sannnagy@icloud.com>
Subject: [BUG] Lunar Lake: 400 MHz after s2idle; PL1 Tau affects reproduction
 and recovery
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=TdWbdBQh c=1 sm=1 tr=0 ts=6a9edfaa
 cx=c_apl:c_pps:t_out a=oyWFxbOnq+dmhQrAPgaJYA==:117
 a=oyWFxbOnq+dmhQrAPgaJYA==:17 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=x7bEGLp0ZPQA:10 a=7VO5mNthaX4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=6Vj588pRnnhkDWG5z4wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Pl_-z2dvTONE12QsGOFs2kma8rKGVqf3
X-Proofpoint-ORIG-GUID: Pl_-z2dvTONE12QsGOFs2kma8rKGVqf3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDE3OCBTYWx0ZWRfX6dRlN81Wko+N
 JU1a4tL76WVOaXOm+insjOgTSoYnh922ha6CEKPGAZ7alFL18VEQCw8B441B1peWoY0AGS9HIx5
 zNXvw+oM/tHYvCvsp3j8iYiQDeBGk4SEwJw7rnKot3QGcWakOeCTi5nXwUO/dkhnJPJHSOon6H9
 ifGytnoLfgBbaWzTJ0Thb6izLvidiY2525qdofTPOVckhW7OZCWtS8ldz3QKmkWV0Nnawogt4fd
 HGCEqOoWGg3xp9squ7k1cwuA4ZrVohokzWBSxIc1tS9v3yKBKHm0YhC+NC/t0amfyeCko1lXp2m
 YoEfx0HHuxSbQF8HExKsRYtn7J6fsHkMsayhmQr0F4ceTzG9mdHaYllP3Imh3g=
X-JNJ: AAAAAAABI85zyNTr5QZjbG6nVihdvAMTJy/pGgg1GbPe/jgGcz5HtSEsQVHOrAyCLFoo2K9WWOELVFR9BeupzTmO04zjE4X/8Cm+vIRaGOMAFLi5chLnXI3uMLlkqboC9Jb4D7LOhLsX18KJ9OTy94KglBbtqneyanjwzWAYTYMEa/Hthll+Rsk3ya0YDTo9YskSFFL/t9aRO6+afxBImA3aPiWI3a8wkf1CVmY2wFpsHmvSj9AgFOO32oYv6Y8qeMg4zIfqkSYVoUeZm8egpFqj9BYVQfSfIJYoiewK28R4Tcml24iFVq9N0tfEEUdPU8+xVOkdLgEX2mJhMSjopTTemUxgf3YkBydbXtST9xQwaeyUHOTOFHh23ym/M3BucTGUX67LgRxBASr/Myg0gNniSQHukTMX5kVIowi9IQT/ePlO1wGL88NzP9oS1myREmlEfdTJmGNKQtiW8Mnsm1BaWSHV3S/WAxoVjJoYhqWp2NeYk2mTqcPaxFoE0b4egBv+Z4iwBs6c6YQwCOEkae9JLprrwJK2jRKIV0ZXyd+rFVyvgvJ9BS1CCsLQOG96i3yBDBwGCTlkRlYTMP1A9kJWUj2l4qJrGqXNUHE1/qeKCZlQcsnYV6apQiE/bwompHnqn5qEdzQF9Dq5l80HZ00aa14xsV8+4lkqdhP3HtWBZEZfXmFX03MuWZ8U+HF21oRoL3gdZRhzpipIjAPzyXzT23YezgG9ToFjj+UbA16BrtVdtgnTnOaV69acISVkUCBgR8cLN4hpW3I6YLv1QqvGBJtWp4HAM/cL/4B6EqDDnGBn972B0tu0jxvJuvNZLQ/XdqRVpKqh0jVBXmkm/EC20G5UfcLSAbCfdPBpSGvlTWLwbuyXe12DfQBjyy+7cSC3TfkQ4l0j2QefiGZjeiHs1lHm0ZILgaQ/w3xNh+61ocVb2BeZwzyXApKhRRE5K1L6tCqhiQpNJjsOWOdxnD3/2SV3OBo
 G9wvtjPmrGfEDPayCXoSUzXWjrTGWMBEXsi1K1xYQuk9FhcslBfovlwbgR3UDmC6KvErJN7FWq7sOz7Wf6nyqMv1Bp2rt3NVcJOuFolAwKZGz70J1SN6b6ePq2BqTw5zNVs4b7CERqDKmhaDeH9eiAfY1CWDIGOpAWBxuVt0YcLAuDwCOIlbg0kDQgxac5f6S59XeYLdG8XKne7VnB31ymWigP2kX3Q4lk27C5j2J0FyxP+DXr2K4+J7/82JuSO80K8EcobBOKvRZKjBcsTu12eBTE/eLMOOugzTyFHeqlu6O

Hello,

My ThinkPad X1 Carbon Gen 13 intermittently resumes from long s2idle 
suspends with all eight CPUs stuck around 400 MHz. The issue also occurs 
with
Fedora’s standard packaged kernel.

I have collected hardware telemetry, shortened reproduction of the 
power-limiting behavior by changing the MMIO PL1 averaging window (Tau), 
and observed
promising recovery with an early post-resume Tau pulse.

Could you help investigate this or direct the report to the appropriate 
Intel power-management engineers?

System:

- ThinkPad X1 Carbon Gen 13, model 21NSCTO1WW
- Intel Core Ultra 7 258V, family 6, model 189, stepping 1
- BIOS N4BET77W 1.47, EC 1.41, microcode 0x128
- Fedora 44 Workstation
- intel_pstate active, HWP enabled, s2idle
- Capture kernel: 7.1.13-200.btf.fc44.x86_64; recorded kernel taint: 0

The capture kernel is a local rebuild of Fedora’s kernel-7.1.13-200.fc44 
source RPM, with no additional kernel source patches, using 
dwarves/pahole 1.31
instead of 1.30 to correct BTF generation for sched_ext. The .btf suffix 
identifies this rebuild. The suspend issue occurs on standard Fedora 
kernels too
and predates the rebuild.

I have experienced it across multiple kernel versions but have no 
known-good version or bisected regression. I have not yet verified 
reproduction on
current vanilla mainline.

Normal reproduction and symptoms:

The issue occurs after long s2idle suspends. Short sleeps resume 
normally; longer sleeps produce the 400 MHz episode, and the lag 
generally lasts longer
after longer suspends. This matches my experience before instrumentation 
as well as the recorded experiments. Under the sleep-power conditions 
measured in
several captures, our energy-based model predicts onset at roughly three 
hours. The exact duration threshold can vary with energy consumption during
suspend. To reproduce at the normal Tau setting, leave the laptop 
suspended for several hours, preferably overnight, then resume.

During an episode, all eight CPUs can remain around 400 MHz despite 
active work. Package power is approximately 2–5 W and temperatures are low.
Performance recovers spontaneously after several seconds to tens of 
seconds. Shorter sleeps often resume normally.

Instrumentation:

I used custom diagnostic scripts to record a baseline before suspend and 
repeated snapshots after resume. They read CPU MSRs, powercap sysfs 
attributes,
and Intel PMT telemetry.

CPU frequency estimates use APERF/MPERF deltas over awake sampling 
intervals; they are not calculated across suspend. PMT fields are 
decoded using Intel’s
published Lunar Lake XML mappings, checking the product and 
crystal-frequency fields before converting residency counters. Residency 
figures below are
differences between counter readings.

The recorder is read-only. Separate intervention code performs and logs 
setting changes.

During captured 400 MHz episodes:

- PMT PL1_LIMITED_RESIDENCY advances at approximately one second per second.
- Power-limiting residency advances on the core groups, ring, and graphics.
- PROCHOT, VRHOT, thermal-limiting, and PSYS PL1 residency show no 
corresponding increases.
- MSR package PL1 remains 37 W; MMIO package PL1 remains 17 W.
- The normal MMIO PL1 time window remains 27,983,872 us.
- HWP requests remain unchanged.

A verified MSR PL1 write from 37 W to 36 W and back did not promptly 
release the fault. Cycling power profiles has also not helped.

Shortened reproduction:

The most informative experiments changed this setting before suspend:

/sys/class/powercap/intel-rapl-mmio:0/constraint_0_time_window_us

These trials used battery power, the balanced profile, and comparable 
wake procedures:

- Approximately 900 seconds suspended, Tau 27.984 seconds: no PL1 
residency increase.
- Approximately 900 seconds suspended, Tau 0.999 seconds: 1.316 seconds 
of PL1 residency, with corresponding core/ring/graphics power limiting.
- Approximately 60 seconds suspended, Tau 0.999 seconds: no PL1 
residency increase.

Shortening Tau therefore allowed reproduction of the limiter signature 
after 15 minutes. The short-Tau event ended before the first valid frequency
interval captured a 400 MHz lock, so this reproduced the power-limiting 
behavior rather than the complete user-visible symptom.

A separate experiment set Tau to approximately 2 seconds before a 
45-minute suspend, then restored approximately 28 seconds immediately 
after resume. It
captured all eight CPUs around 400 MHz for roughly 18 seconds and 20.118 
seconds of total PL1 residency. There is no matching untreated 
2-second-Tau/45-
minute control, so this does not establish how much the restore write 
prolonged the episode.

Automatic workaround experiment:

The workaround is launched asynchronously from a systemd post-resume 
hook. A small native helper saves the original MMIO Tau, writes 125,000 
us, and
verifies the readback, which is 124,928 us on this machine. It acts 
before starting the more expensive Python sampler, without waiting for fault
detection. The power-limit values themselves are unchanged.

The monitor restores the original Tau after two consecutive intervals 
with little PL1 limiting, or after an eight-second maximum hold. A 
recovery journal
and service cleanup path also attempt restoration after failure. 
Busy-clock recovery is assessed separately from PL1 residency.

In the latest natural suspend of 2 h 59 min:

- CPU0’s power-limit status was active before the write, and PL1 
residency had already advanced by 1.228 seconds since the pre-suspend 
baseline.
- The write landed approximately 0.254 seconds after the kernel’s 
journalled suspend-exit message.
- Total PL1 residency across the capture was 1.775 seconds.
- The first valid clock interval after the write measured 1.89–3.05 GHz; 
its sample completed 1.16 seconds after the write.
- Restoration of the original Tau was verified, with no additional PL1 
residency through approximately 12.8 seconds of subsequent recording.
- I noticed no resume lag.

Working hypothesis:

The observations suggest that package energy accumulated during sleep is 
mishandled in the PL1 averaging state or its timebase on resume. Historical
clean/fault captures are consistent with an energy threshold related to 
PL1 × Tau, and changing Tau changes the reproduction conditions.

However, the energy measurements span before-suspend and after-resume 
snapshots and include some awake activity. They do not expose the 
controller’s
internal state or establish whether the defect belongs to firmware, 
hardware, or Linux resume initialization.

A matching symptom has been reported on a ThinkPad X9-15 with the same 
processor:


https://github.com/intel/linux-intel-lts/issues/84

I can provide timestamped raw captures, kernel logs, diagnostic scripts, 
and intervention code with the corresponding revisions and command 
sequences.

LLM assistants helped develop the diagnostic and workaround code, 
analyze the captures, and draft this report. I ran the experiments on 
the affected
machine. The underlying code and raw data are available so the decoding 
and conclusions can be checked independently.

Is this a known Lunar Lake issue? What additional instrumentation would 
help distinguish incorrect energy-delta accounting from stale averaging 
state
across s2idle? Is there a supported way to resynchronize that state on 
resume?

Thanks,
Sandor



