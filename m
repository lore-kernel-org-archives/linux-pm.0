Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D818331A48
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 01:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787882298; cv=pass; b=bNUNWzPgIiAtAR41UzYmWaT+cVccimLq71KBEjAINsQKWMPBaaQHY+m7IqF/cBSGjcaVhjWnWsf7AallDoR5B/6k/lMFRSk69J/e0FH8U3ANHrmsMTkETkwq301s8FTT+VmitXv1r4RxIeHcrfBL4Z7OgUdexkcmB4cnbeL+K/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787882298; c=relaxed/simple;
	bh=zZoGddlU3ausn34UCqH/PYiWSA8OFcFsdjUfBg+773I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MNPCmkVAuMg2eGfjNtymEHS4bUnIZ0Yqonh5VCwzk1pl+e7eXSeV9laClgm9dwgTNxUDJlHvpEwYv7/DZOOka/NgHTRZeAUejBLQxjvpia91uA2vF3O/49UOFFy6UXVxLaJDAHVL3zYeRFHzaH4gerTunTpAW9egZp100FhUIWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKBIoUmr; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKBIoUmr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a60f0dbeccso471265a12.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:58:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787882292; cv=none;
        d=google.com; s=arc-20260327;
        b=NXPzZ7m1GW7udCNYfpk2e/MzUNMrZqMjGGKhH/riDRiI9txRM5wX3dvB9ZNDqWmCE/
         Pv9T0pOwh2u7X6jkAs4kAhkOhDFero6vK1vwMOUV0zcby98MhIjB029lCeQ6Z5FiFzs/
         TRhyeMhWiGUwE8Fx92Ole/mfR8u7PyT3xfjpMuERAxZpOJS4OCE0BlvxxiC57BPb5lPd
         BR0BBxzbM6Bp9Pi7cpQXlSR1pRPuC1KhrJN1eHplPR5axMMPuyOQMtzp70lpEgxsOvhP
         vSpc14pDDS016IOTKLGd/sFFtFaddcE6CiX7D2vWOglNrhyIwKGytqTmuUqnDusfzFDX
         g/pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P+EK9lsGm/CJ4yMCW7O8AWTlGzaJhfvDAQErgueGwWc=;
        fh=6DSx0zgcwTAQueRqIz0ACEDfyaZZtCxDh0wPPRm/svM=;
        b=kLk+kfhZJLCTEL4nw/q/snyyyfYb/Y3dvtmn+ugWUyizl3+VIqhZfBijbdVYQ593XK
         rMlJ3Mh41mG+gYkyDuXOzopWVOmESZQ6wvqZmEChfL/gdvCbFpd8S34Uaco5Xi5VzIYk
         digENzi0qK81uSreUzorRg4q8Ij+o1ksTdtDJ9ca6Uxp66PRd6R183HjslX45Y3+Bfyv
         Fbj2IX4oA7aPzbSA63aNX8LO19Jtm3Ao2HAyCX3WQrSROYD6EnnI9c7lLKCSdQrhzd1f
         vmUYYdI17pEmDWJ6vboLjwcm+uk2w0FqfDemDmhYdwshWgOVSwDOjbWNPwabDu7cE/ti
         rdhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787882292; x=1788487092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=P+EK9lsGm/CJ4yMCW7O8AWTlGzaJhfvDAQErgueGwWc=;
        b=EKBIoUmrS0fphhxw+3zsasMPcLjuZI5LJWBfxEvgl3rhaIohH7E/iFok9Ae3+oBy4a
         FQKA0fqv6FsaHQ1YjNmF0rKzVgs6yYdGIaD2YgKseDiACmXHNiIiVRYXz2xgPzEWAF7V
         KFngX4aCswr9N0hyaI5SbU7tbG9bSTSNaT5Cu3awgNu2V8L1OA3DrwVunGUuT+jHBDla
         MWmCIs1h/gpZjaY26+jJYj+oZKwpbDEaxqx4bwYIGyyrG2E4A9hNjKLPPBrxxT2X6+94
         vcPHqkk7ADJWXcl+rLqwQVoPDfxB0mThmrCqOmq/348AhrZUrTB6u/bZtawUSPmmLHrg
         Xyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787882292; x=1788487092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=P+EK9lsGm/CJ4yMCW7O8AWTlGzaJhfvDAQErgueGwWc=;
        b=EJhTUyTjdX2LaJg0WWJguqWBUT5/GwYbOoulhytOwvtMDMS2gJ8jtWo+HRKMhpyXZe
         Btj90/SFhjsMUhmFCH8uq4uFahPsxFkAalOMps3I44SZe+YOtKFFajrlPSI1h1BaKVca
         TMg/5czDuLbrdqPCEzEaQsmvYqZm4NhhKaSEiESP65C/iNLC0Mj4JvTc/nypHszAMmDF
         xxb+fX1ksx2OE54zl6RlKA5+47CpQn+8ZsNC7mFJdMMP8IESld2PdgzdSTIWiFkWhfEc
         3H22t1tDX6m4qkmd6DjPP1h6gLUTB9Y8VMcBGHYbRDKL9EhdvutnWtlUJrXwxnHDy64a
         IuJA==
X-Forwarded-Encrypted: i=1; AHgh+Rqzqvs+O2tvj4lAoaG8vSne5pklBzGWWbZKzDsjKDW52G51VLvh33rblwaGHy858IpBVtq/mvhi8w==@vger.kernel.org
X-Gm-Message-State: AFuF++mpcZiDyeRfsRA5XDqW1YgCD+Q7Iajwwj9vVvw/5rM+CG7bz+4T
	OR3FuU6aB5LKbuxhO3OAlIQY4/ni+3DMNgwl7rWkzH/BCtVQvBajO44POaKiLzUgdwrF2+0C8jj
	SCH0isvdZEvQjqQ3Xc3q2Z3jVFX/P0ME=
X-Gm-Gg: AR+sD10ThwDR3pfMVEGnLEmLZY8Z4O+BjffnHGZHvdoURuB5ucOuevbVLthdZ+o+h7V
	ucYqTCYOVr2sMkgR1JNYsN4mm3Jx+RSsyTPT01GdbOD9Kst0ebxT0903tRunxS0sqQxHXGLALok
	e4+DygPeUZd7Zm3h/f5Ho9/yBjiifVf4jXCNg7hs31RqcUDPMGzaxDmf16Q4+iGh+7u3eXEvU3h
	8cksy+Wsx1bfpzNXxC7ME8WoA+gtjlC05PPTWBdHUIy2LWOcW4Vl0MvWbCc/0ktmeh6+WDZppXf
	HDlA9AU+8ZCAmHKGfWq2NpqFauA+Q5VU8vTPRiiVKeA=
X-Received: by 2002:a05:6402:3223:b0:698:6084:db7f with SMTP id
 4fb4d7f45d1cf-6a60d3b901emr1673005a12.10.1787882291311; Thu, 27 Aug 2026
 18:58:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a5789fed-14c7-4760-bd45-dbc26bfe8df3@amd.com> <CAJVKnz95hAzJJ86xNkHNctnQbb+BwHtNiTkzPL5NGYR4GsZyUg@mail.gmail.com>
 <9e49bb0a-d339-4120-9658-3c8e0c5f24c1@amd.com>
In-Reply-To: <9e49bb0a-d339-4120-9658-3c8e0c5f24c1@amd.com>
From: David Smith <smithd98@gmail.com>
Date: Thu, 27 Aug 2026 21:57:33 -0400
X-Gm-Features: AcwNN1X5iJhFRVhGhnLYfRipoXm9dX16xB_exV7iUZQC_qEANfW8LkyOPbIoS1U
Message-ID: <CAJVKnz-DxJdYUgc7Ea6KEK4JQihW6jeYWCyHH9afWa1W9Lo-Tw@mail.gmail.com>
Subject: Re: amd-pstate: Cezanne data fabric sync flood on DC gated by CPPC max_perf
To: kprateek.nayak@amd.com, linux-pm@vger.kernel.org
Cc: ray.huang@amd.com, mario.limonciello@amd.com, perry.yuan@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prateek,

Thank you for retaining the dropped reply on the thread - and
apologies for sending it as HTML, that was my mistake. Plain text from
here on.

Both of your questions first, then one new result that changes what I
told you about voltage.


1. THE CPPC / CPUFREQ DUMPS YOU ASKED FOR
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Kernel 7.1.8-arch1-3, BIOS T78 01.25.00, on battery, current boot.

One thing to flag before you read it: scaling_max_freq below reads 3800000
because my own mitigation applies that cap on DC. It is not a stock value.
Stock is cpuinfo_max_freq =3D 4508086. Everything else is untouched.

# grep -r . /sys/devices/system/cpu/cpu0/acpi_cppc/
highest_perf:181
nominal_perf:70
lowest_nonlinear_perf:41
lowest_perf:15
reference_perf:70
nominal_freq:1901
lowest_freq:400
guaranteed_perf:0
feedback_ctrs:ref:727350219481 del:635505385681
wraparound_time:18446744073709551615

# grep -r . /sys/devices/system/cpu/cpu0/cpufreq
scaling_driver:amd-pstate-epp
scaling_governor:powersave
energy_performance_preference:balance_performance
energy_performance_available_preferences:default performance
balance_performance balance_power power custom
scaling_cur_freq:2315367
cpuinfo_avg_freq:2315367
scaling_min_freq:1113443
scaling_max_freq:3800000 <- my DC cap, not stock
cpuinfo_min_freq:407358
cpuinfo_max_freq:4508086
amd_pstate_max_freq:4508086
amd_pstate_lowest_nonlinear_freq:1113443
amd_pstate_highest_perf:166
amd_pstate_prefcore_ranking:181
amd_pstate_hw_prefcore:enabled
boost:1
scaling_available_governors:performance powersave
cpuinfo_transition_latency:0
affected_cpus:0
related_cpus:0

On your point about the v6.12 -> v6.17 derivation change, the
arithmetic here matches your description exactly:

lowest_perf * nominal_freq / nominal_perf =3D 15 * 1901 / 70 =3D 407.4 MHz
cpuinfo_min_freq =3D 407358

against lowest_freq =3D 400 MHz, which is what 6.12 would have used.

In my last mail I said the two kernels derive "cpuinfo_min_freq
1113443 -> 400000". That was sloppy: 1113443 is scaling_min_freq /
amd_pstate_lowest_nonlinear_freq, not cpuinfo_min_freq. The actual
cpuinfo_min_freq on 7.1.8 is 407358 as above. Please use these numbers
rather than the ones in that paragraph.


2. amd_pstate=3Ddisable: YES, IT STILL REPRODUCES - AND IT GETS WORSE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I ran this twice, on a full reboot with amd_pstate=3Ddisable on the
cmdline (not kexec), same kernel, acpi-cpufreq active, on battery.

arm 1: died 98 s in, near idle
arm 2: died 25 s in, during model load
both: 0x08000800, same signature

So the CPPC / amd-pstate path is NOT necessary for the failure.

I want to be careful about how much that is worth, because neither arm
reached my measured ladder - both died before it - so I have no graded
hazard number under acpi-cpufreq, only "it died, fast, twice". I am
not claiming a ladder result.

And there is a confound you should have, because it cuts against
reading this as "acpi-cpufreq is worse":

- under acpi-cpufreq, scaling_max_freq clamps to the top _PST entry
(1900000), so my 3.8 GHz DC mitigation becomes a NO-OP and boost is
entirely SMU-autonomous - I measured 4478 MHz on battery in that state
- the P-state floor also rises, to 1600000, versus amd-pstate's 407358

So that boot is simultaneously uncapped and higher-floored. The
reading I would stand behind is therefore not "acpi-cpufreq is
dangerous" but: whenever the effective frequency ceiling is
uncontrolled on DC, the machine dies - under either cpufreq driver.
Whenever it is capped at 3.8 GHz on DC, it does not.

If it would help your SMU discussion to have a properly ladder-scored
acpi-cpufreq arm, tell me how you would like the ceiling controlled in
that state and I will run it.


3. NEW: A SINGLE-VARIABLE PAIR - AND IT KILLS MY OWN VOLTAGE THEORY
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
This is the only experiment I have where exactly one variable moves,
and it falsifies the mechanism I was building toward in my last mail.

Both arms: same boot, same machine, same battery, same workload
(llama.cpp 128-token prefill, ~6.7 GB model, verified resident, CPU
only), 27 minutes apart. Both with amdgpu
power_dpm_force_performance_level=3Dhigh, which pins FCLK at its top DPM
state. CPU VDD plane sampled at 492 Hz.

LETHAL SURVIVOR
scaling_max_freq 4508086 3800000
FCLK 1333 MHz, 100% 1333 MHz, 100%
FCLK transitions 0 in 23864 samples 0 in 66913 samples
VDDNB (SoC rail) 818 mV 84.5% 818 mV 94.0%
CPU VDD plane, peak 1250 mV 1281 mV
CPU VDD plane, % >=3D1300 mV 0.00% 0.00%
CPU VDD plane, % 1100-1300 25.6% 33.0%
exposure died at 20.9 s survived 318 s, 9/9 steps
outcome 0x08000800 clean

scaling_max_freq is the only thing that differs.

Two things follow.

(a) CPU-plane voltage is NOT the mechanism. I had built a story where
the cap protects by removing a sustained 1.37-1.39 V operating point,
and I was about to send you that. The pair kills it in the awkward
direction: the run that SURVIVED sat at a HIGHER peak plane voltage
and spent MORE time in the 1100-1300 mV band, for 15x longer exposure,
and lived.

Related provenance correction: I have been quoting a "vddgfx" column
as though it were a GPU rail. It is not - on this part it is the
shared VDDCR_VDD plane and it tracks the CPU V/F point (1 thread:
cores 4574 MHz, plane 1393 mV; 16 threads: cores 2761 MHz, plane 931
mV). I also sampled it at 4 Hz for most of this investigation while it
updates about every 2.7 ms, so roughly 1 value in 92. Any voltage
claim I sent you before this mail was drawn from aliased data.

(b) Fabric DPM transitions are not necessary either. FCLK pinned at
1333 MHz, 100% residency, ZERO transitions across 23864 samples at 492
Hz - and it sync-flooded anyway. I had previously seen FCLK thrash at
50 Hz and wondered if it was causal; in this death it is entirely
absent.

Note also how harsh the survivor's configuration is: FCLK pinned at
1333 MHz is the modifier that kills this machine FASTEST at stock
max_perf - 11.6 s in one arm, 21 s in another. Under the cap it ran
318 s clean.

That leaves, on my side:

excluded: fabric DPM transitions, SoC-rail level, CPU-plane voltage
remaining: peak core frequency itself, or core current / di-dt at the
top P-states

i.e. the fault lives in the top ~700 MHz, between 3.8 and 4.5 GHz, and
is not reachable through the plane voltage, the fabric clock or the
SoC rail. That is the tightest statement I have.


4. WHAT I CANNOT DO FROM HERE, AND ONE OFFER
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
I cannot separate frequency from power budget: there is no writable
PPT interface on this part, amdgpu exposes only power1_input
read-only. If there is a debug path to set a PPT limit on Cezanne, I
will use it.

I also cannot witness a droop even in principle. Every voltage and
power number available to me from hwmon is an SMU self-report, and the
one independent instrument - the battery EC - refreshes about every 9
s against an event that lasts under a second. So if your SMU
colleagues can read what this part actually commanded in the final
~900 ms, that would settle a question I have no way to reach.

The offer: the band 3.83-4.45 GHz is entirely untested. My coverage is
<=3D3.80 GHz (0 deaths, 52 ladder steps), 4.48 GHz (1 death / 1 arm),
4.51 GHz stock (dies reliably). A cap at ~4.1 GHz bisects it and would
give you the threshold. Say the word and I will run it.

Where it stands:

at stock max_perf on DC: 14 deaths in 15 valid arms at smax <=3D 3800000
on DC: 52 ladder steps + a 35-min mixed soak + a 20-min integrity
soak, 0 deaths

Nothing else has moved that gate - BIOS 01.22 and 01.25, EPP,
governor, min_perf pinning, CC6 off, fabric pinning, and three
kernels.

All of the above is now also on bugzilla 221909 as comment #5, so the
public record carries the corrections too.

Thanks again - happy to run anything your SMU folks want. It
reproduces in 10-50 s on demand.

--dave


On Wed, Aug 26, 2026 at 11:18=E2=80=AFPM K Prateek Nayak <kprateek.nayak@am=
d.com> wrote:
>
> Hello David,
>
> On 8/27/2026 7:27 AM, David Smith wrote:
> > Hi Prateek,
> >
> > Thank you for the quick reply, and apologies for the delay - I wanted t=
o come back with the BIOS result you asked for rather than a partial answer=
.
>
> No worries and thank you for the detailed report. Since the
> mailing list dropped your reply, I'll retain it in wholly for
> record on the thread.
>
> >
> > Short version: I tested 01.25.00 as you asked and it did not fix it. I =
also owe you a correction: two rows of the table I sent are invalid and I h=
ave withdrawn them. One of them is the row your hypothesis rests on, so ple=
ase read that part first. I have posted the same corrections to bugzilla 22=
1909
> > (comment #4) so the public record is not misleading.
> >
> > (Dropping gautham.shenoy@amd.com <mailto:gautham.shenoy@amd.com> - it b=
ounced, "Recipient not found".)
> >
> > 1. THE BIOS UPDATE YOU ASKED FOR: 01.25.00 DIES
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Flashed and verified three ways (DMI, HP's own tool, and the DEVFW imag=
e on the stick). Confirmed before the run that the operating point was unch=
anged across the flash, so the ladder is comparable.
> >
> > BIOS T78 Ver. 01.25.00, kernel 7.1.8, battery 96%, uncapped
> > 06:46:42 warm: RSS=3D6692 MiB, MemAvailable=3D5892 MiB, 26.8 tok/s <- a=
rm VALID
> > 06:46:58 STEP 1 (short) survived 1.92 s
> > 06:47:08 STEP 2 (128-token prefill) opened
> > 06:47:53 next boot, reset reason 0x08000800
> >
> > 23 seconds. So this rules out AGESA CezannePI FP6 1.0.1.1c and PSP 0.11=
.0.85 -> 0.11.0.88, and everything else in HP's 01.23/01.24/01.25 deltas.
> >
> > But it does not touch your hypothesis, and I want to be explicit about =
why: across 01.22 -> 01.25 the SMU firmware is unchanged at 64.74.0 and the=
 microcode is unchanged at 0xa500014. The flash did not move the component =
you accused. I wrote that down before the run so it could not be read eithe=
r way afterwards.
> >
> > 01.25 is the latest HP ships, so the BIOS avenue is now closed from my =
side.
> >
> > 2. THE CORRECTION: ROWS 3 AND 5 ARE WITHDRAWN
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > Re-deriving my arm ledger from raw logs, the surviving runs at stock ma=
x_perf shared a defect: the 6.7 GB model was not actually resident, so they=
 were I/O-bound on page-ins instead of running sustained all-core AVX2. The=
y were not doing the same work as the runs that died.
> >
> > Row 5, performance/performance 4508086, "8 steps 0 deaths": entered the=
 window with 10 MiB MemAvailable, holding 5004 MiB of a
> > ~6.7 GiB model, at 17.3-24.2 tok/s. My 3.8 GHz-capped run manages 30.7-=
31.2 tok/s. A run pinned to max_perf 166 that is 30% slower than a capped r=
un was not stressing the part. Its quoted fmax 4374 MHz was a transient pea=
k in a starved run; mean fmax was 2953 MHz.
> >
> > Row 3, balance_performance/powersave 4100000: same defect, worse - RSS =
38 MiB.
> >
> > So the row-1-vs-row-5 pair, "pinning perf high is safe", and my claim t=
o have excluded the battery all have no valid arm behind them. I am sorry f=
or sending
> > that as the headline result.
> >
> > Row 5's configuration has since been re-run properly (RSS 6692 MiB, Mem=
Available 12.6 GiB, 27.9 tok/s warm). It DIED.
> >
> > This matters for your hunch specifically. You suggested "DC + Performan=
ce EPP, the SMU is probably misjudging the power distribution". On this mac=
hine epp=3Dperformance is not protective - it is one of the configurations =
that kills it. That exact experiment had in fact already run on 2026-08-24 =
07:46, before your mail arrived (gov=3Dpowersave, epp=3Dperformance, smax=
=3D4508086, battery 91%):
> > it hard-reset with 0x08000800 during model warm-up, ~3 s in.
> >
> > I have now seen deaths at balance_power, balance_performance and perfor=
mance alike, and with min_perf pinned equal to max_perf. EPP is not the gat=
e.
>
> Thank you for confirming!
>
> >
> >
> > 3. THREE MORE NEGATIVE RESULTS SINCE WE LAST SPOKE
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > All on battery, stock max_perf, with guards on RSS >=3D 6000 MiB, MemAv=
ailable >=3D 1500 MiB and warm throughput >=3D 25 tok/s.
> >
> > (a) CC6 disabled: died in 10 seconds. Verified at 0 CC6 entries/s (norm=
al arms measure 3420-4403/s), so this is not "C6 reduced" - the machine exe=
cuted zero C6 entries and still flooded. This also refutes
> > processor.max_cstate=3D2, which is the most-recommended workaround in t=
he community gist now linked from the bugzilla.
> >
> > (b) Kernel 6.12.75 died in 20 seconds. The bugzilla now has reports nam=
ing 6.12.x as last-known-good against 6.18.x/7.1.x failing - exactly my con=
firmed pair. I gated the test in advance so a survival could not be
> > dismissed: 6.12.75 reaches a harsher operating point than 7.1.8 (3.67% =
vs 2.94% of core-samples above 3.8 GHz). It died anyway, at the same step a=
s every other death. Incidentally the two kernels derive different limits f=
rom the same hardware - cpuinfo_min_freq 1113443 -> 400000 - though
> > the per-core highest_perf ladder is identical. Is the boost-numerator /=
 _CPC derivation change between those kernels worth pursuing, or does this
> > result close it?
>
> Between v6.12 and v6.17 we began deriving the cpuinfo_min_freq from the
> CPPC Min Perf and Nominal Frequency in the _CPC object instead of just
> setting it to Lowest Frequency advertised in _CPC.
>
> I've requested for some more data below on this point.
>
> >
> > (c) I also have to withdraw my "range, not ceiling" interpretation. I t=
old you the cap works by narrowing the CPPC range and that the workload nev=
er
> > exceeds ~2.9 GHz uncapped. That came from an unreliable fmax field. Re-=
measured with per-core CPPC delivered/reference counters:
> >
> > STOCK (4508086) CAPPED (3800000)
> > p99 3981 MHz 3752 MHz
> > p99.9 4171 MHz 3963 MHz
> > max 4473 MHz 4493 MHz
> > core-samples > 3.8 GHz 1271 (2.94%) 93 (0.21%)
> >
> > The workload does reach 4.2-4.5 GHz. The cap cuts the above-3.8 GHz pop=
ulation 13.8x while leaving the median untouched (2336 -> 2331 MHz) - it ac=
ts entirely on the tail. The excursions concentrate in low-thread phases (c=
old load, page faults, memcpy, NVMe completion), not the all-core vector ph=
ase, and per-core counts track the CPPC preferred-core ranking
> > exactly (the four highest_perf=3D196 cores carry the most). Note the ca=
p is statistical, not absolute - 0.21% still exceed it, peaking at 4493 MHz=
.
> >
> >
> > 4. THE MOST USEFUL THING I HAVE: IT CORRUPTS DATA BEFORE IT RESETS
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > The last kernel line before one reset was a userspace fault in the comp=
ute workload, which the kernel resolved to a specific instruction:
> >
> > traps: llama-server[34143] general protection fault ip:74fd9014dbd7 err=
or:0 in libggml-cpu-haswell.so[e0bd7,74fd9007f000+d8000]
> >
> > File offset 0xe0bd7 is inside ggml_gemm_q4_K_8x8_q8_K, the hottest loop=
 of
> > the workload:
> >
> > e0bc4: mov 0x1b8(%rsp),%rax ; base pointer from stack e0bcc: add (%rsi)=
,%rax ; +=3D an 8-byte word from memory e0bd3: add $0x8,%rsi e0bd7: vmovdqu=
 0x10(%rax,%r12,1),%ymm0 ; <-- FAULTS HERE
> >
> > The same instruction faulted at the earlier crash that produced the MCE=
 (identical ip low-20 bits) - but that time as a SIGSEGV (error 4, page-not=
-present) on a canonical-but-unmapped address, rather than a #GP on a non-c=
anonical one.
> >
> > vmovdqu is the unaligned load and does not raise #GP on misalignment, s=
o both faults are bad *addresses*, and %rax is built from two memory loads =
two instructions earlier. Same instruction, two fault types, two different =
bad addresses - that is a corrupted pointer operand, not a software bug.
> >
> > Which is precisely what the MCE said: IPID 0x001000b0_00000000 -> SMCA_=
LS_V2,
> > XEC 1, "An ECC error or L2 poison was detected on a data cache read by =
a load", Poison set, OVER set, PCC=3D0, on two cores at two addresses in th=
e same instant. The LS unit is the consumer of an already-poisoned line. Wh=
ich upstream unit sets poison on this part? That would let me trace from co=
nsumer to
> > originator, and it is my question 2 on the bugzilla.
> >
> > Control: the workload has faulted exactly twice, both within seconds of=
 a sync flood, across ~14 valid stock-max_perf arms - and zero times across=
 43 capped ladder steps and two capped soaks.
> >
> > So this machine computes wrong answers before it resets. Both observed =
cases corrupted a pointer and were therefore loud; corruption of a value wo=
uld
> > be silent.
> >
> > One timing caveat, because it cuts against a simple di/dt story: in mos=
t recent deaths the compute load collapses to idle 0.3-2.8 s before the res=
et - in
> > one case the machine sat at ~9 W for nearly three seconds after the wor=
kload had already died. It is not universal (one arm died under full load),=
 but
> > time-of-death is evidently not time-of-injection.
> >
> > Correction to my earlier mail while I am here: I quoted that MCE with "=
... in libggml-cpu-haswell.so <http://libggml-cpu-haswell.so/>" appended. T=
he raw journal line carries no library attribution - the kernel did not res=
olve the vma that time. The library identification for that crash rests on =
the ip-bit match above, not on the log text.
> >
> >
> > 5. THE BATTERY, HONESTLY
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > You confirmed the SMU runs materially different assumptions on DC. That=
 removed the argument I was leaning on: I had treated "survives on AC" as e=
vidence the power source is not the issue. If the DC policy is genuinely di=
fferent, AC survival is equally consistent with a firmware policy problem a=
nd a DC power-path problem, and does not separate them.
> >
> > The pack is measurably bad. Measured under load at 82% charge:
> >
> > voltage_min_design 11.400 V voltage_now 10.981 V <- 419 mV below its ow=
n design floor
> > current_now 2.234 A at only 2.2 A average
> > charge_full/design 76.1% 263 cycles, 5 yr 4 mo
> >
> > I previously claimed to have excluded it; with row 5 withdrawn that cla=
im was not sound and I withdraw it too.
> >
> > I am not going to be able to test a replacement pack. I would rather te=
ll you that than leave you waiting on a result that is not coming. So the D=
C power
> > path stays open on my side, and I would not want AMD to spend time on a=
 pure firmware theory on the strength of an exclusion I have retracted.
>
> Thank you for the transparency. I'll talk to the SMU folks internally to =
see
> if these symptoms ring a bell.
>
>
> > 6. WHERE IT STANDS
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > At stock max_perf on DC: 13 deaths in 14 valid arms
> > At smax <=3D 3800000 on DC: 43 ladder steps + a 35-min mixed soak + a 2=
0-min integrity soak, 0 deaths
> >
> > Nothing has moved that gate: BIOS 01.22, BIOS 01.25, EPP, governor, min=
_perf pinning, CC6 off, and three kernels. Only the frequency cap does.
> >
> > I also built a self-verifying canary (bit-exact AVX2 checksum, single-b=
it-flip selftest 60/60) and ran four instances on the CPPC preferred cores =
alongside
> > the real workload, on battery under the cap, for 20 minutes: ~557,000 v=
erified passes, ~17 TiB checked bit-exactly, zero compute errors, zero memo=
ry
> > corruption, zero faults, zero MCEs, no reset. Caveat: those canaries he=
ld their cores at sustained 100%, which does not produce the idle->boost tr=
ansition
> > where section 3 puts the excursions, so that result does not yet cover =
the excursion case.
> >
> > Still happy to run anything you want on this machine - it reproduces in=
 10-50 s on demand, and I have per-crash triage, CPPC-counter frequency dis=
tributions and 5 ms RAPL/hwmon sample sets for every arm.
>
> Thanks a ton for all the data. After a boot, could you share the data
> from running:
>
>   grep -r . /sys/devices/system/cpu/cpu0/acpi_cppc/
>   grep -r . /sys/devices/system/cpu/cpu0/cpufreq
>
> Also, does this issue reproduce if you add "amd_pstate=3Ddisable" in your
> kernel cmdline, reboot into same kernel, and run the benchmark?
>
> You'll have the acpi-cpufreq driver running which does _PST P-states
> based scaling but the boost frequencies are completely controlled by
> SMU firmware still.
>
> It will help narrow down if a specific CPPC path triggers it for out
> SMU folks.
>
> Note: You'll need to do a full reboot and not a kexec since some bits
> of CPPC based scaling cannot be disabled without a full reset.
>
> Thanks a ton again for all the data.
>
> --
> Thanks and Regards,
> Prateek
>
