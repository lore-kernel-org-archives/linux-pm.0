Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADB386C3D
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785940464; cv=pass; b=KhR8uQA5wd5360eri/MDq6DFDeDxmxNjzRfAk4CKbjKQNhk53GOHEi9MVqLBaQj8Kz8iz65qYFw6bc/yIf6N4ZxQBIgylaw1sXXAnTgK2adGEywoC2nX9l9pIZoGUL6S0su0v8aPCV7FmM01ljOEjnhx8oMm4nCWjNXatM7C7yQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785940464; c=relaxed/simple;
	bh=+3fgM4H5wGJnSjIEnUXYKjyM5QXZJWkJSacdHOvq9sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcoxEeqs6NmVWGOvPB4RLqVw5zxoPeoN1izWFcEJ1vDs/aqiTtoEz8YYIIRrVb3RCZYqp1Oed7QXWYKwA896Bjdbc/L2gxfm2ljJh6U+gK3VYNmDOdFiP26lSIX3ZgKSvijYkOSX+t1jspLBZyQOmWo7BfuruPNAK5Edt5JmNjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DbkyfWM1; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbkyfWM1"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-495437bb891so10562915e9.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 07:34:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785940455; cv=none;
        d=google.com; s=arc-20260327;
        b=XUHvnZ2KdtDfzJU8BFwLQOW2ADrjAWxKImGhISab8e31yzzE3mp0/KKOhZEe1vsPYc
         9acDeAh234PJ8PjzD2xBvc13p0J9Nyhlc1+vsZke43RJF7di0mkwFzTXLs3/OK//6x1h
         7AYB7qQN53h/ZfWS1O3qD+mqsSvpi08bCERlv3ZcINY+to0eYgU9In4dYyPLk+AE6i28
         lrD+r3DfJ8cBLDRDvJQaVk7AdwcCix3nGSA6m4iHrzl47lc10P3MJQ0PlIYALqXzoBUN
         /73NtGur2IEwtYAXIsqymI7iUp7SHtQR0R1zmFDmx+lc9mLe02KBZESTbhMXwrA4UVPV
         vJZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uBu+xHSTPZfrU1RA3h5cR6eT+QYPO2asmnbGxOoNzHk=;
        fh=Ykg4OeE9IzpkD8CF80LNs0Fs8TbfdAXzlRMIrYrq5NM=;
        b=GCsagNhlu/iI5Wgdp2EkHtm0tNYHTPEu+GUdWq1uHqX6ihPadUsjSeO9On8lQDA9Y1
         5GyJGELBglb1a/0gCtyNk1+nCByvWoTuDIFw+Viy+Cmx8oVEIebUj85YWRhidwHKn/e7
         +1pPulRVZPGSJcwlM1wWYrczdjy7D3cn2LpZtihryaKg4TrP7SSghUjiCnQ+r6nqKCT+
         pinx9khs4YkZyFjEvmfJjSFB4eW8Q2P70SHjfo9Dsg47AnfCPWmGnB25hNwx2Lw2VobJ
         n5RjfLJcNSeNtTwrF9oWkmIgU8G8sWxA9Q6PCa+fXsKUSU08FOkcQX0ByN68aFr2IAaI
         LcJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785940455; x=1786545255; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uBu+xHSTPZfrU1RA3h5cR6eT+QYPO2asmnbGxOoNzHk=;
        b=DbkyfWM11OWvFtN0TFcbHmJPN8+iKQeUbsDzj/OHaj4LgAL8+Yg6MeqBoiuL/Cclqv
         PBHaYH+5UHhJnrjNZZJx1d/yAmqCnzI3guIWYAN44S/SCMZXwySnFTVXbrhxynnfqzrs
         zlfJ1MstK2Nul6hjDflFDr49opuyx7UBko18vy8Fw3j5Xp7UpKC0HLxSVeEVu3CepZFO
         TXdmXmUKL82Drpq4dP1UqMgnHlnmBI3snR9Bg+6VsfQJWFn/7tOHoyYh8c+iUqRMinJO
         SBgc1SE1QvL708HbyH3CDyG2jTus/TPxyHPKWV1PPyBA5InWnmCrgLOVtLmRagzjE/VJ
         jQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785940455; x=1786545255;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uBu+xHSTPZfrU1RA3h5cR6eT+QYPO2asmnbGxOoNzHk=;
        b=OZltS/db4Louy8EcNbfbiuV0ABVw8Z2jl1EUxglzObUZyvXpWFtgL9g3GhMcVGrOkM
         TJSLSGetv+U/B25QgfsgZnjVBW7jZWFFvjhF+1zmMNN91SjJ5S21538IZOVhNVcAcM1E
         NBmfIPiJBvMNvlemZ1mSu9o+fqxiJent4oJ1P6e8ob06CUaemeQLjuxF2PfkhfslREHv
         j2x4qeYQqFD5pmBltDu8Z/vft5/CqpnoiHq+KUVpjWWWVdDwp2YdxoYKLURjQEloesyF
         JJ/iH4MWRb10y0lHnxdx5b1kn+PLH+m+G6ws43HO4IdCrZagczn7+A0OE9OmQ76H5+rJ
         +fOw==
X-Gm-Message-State: AOJu0YwdthUgUlBMGdQVx4YQxK0pj6HC/k0eZllGnwqO3FyT8SzHiVZ5
	VLxGe2ehQe1F75S9E4CkhYoUYJ+myI/LyGbivX4MY3qrlSjqxgg+0RHq3SWLezrucHvpnq4P6OD
	dy1+cVuNY77NZa1Vt0cJNKDaKpr/f6bU=
X-Gm-Gg: AR+sD13jvePMXNlqoS7aLyDOEKa2q+3gb49fS6q2J2NI3ObqqAwEAd82IPzcEFHWJRY
	T9gXtAlvBKtPIGqBnMeM6A6fg2htjJYCSivZvdBiC3P59PtKlgLe+/0q1yQUQ3WLg8/PbH//wfl
	ogk+NWxhBdFk3elSW2VA+/EtazCCb34oU5pWmPvuX4QVaeZoQygUzuKNUf4RxMdHalL5WdaS0pn
	AB9/cy9fkxMgFijZ00W+7Nc4iVK8c25ra5uAJIEdJp6SL7s9bSysiEIamE3q+L/V5WkMYDc2wLT
	ybZlKVrnpP5vrGPy00akcvnnvBem5uUK3AIAoKKfJikjXgKpUzHIia+C707qrG/ydC+J1QG4sk/
	B7XonBy82IHEN
X-Received: by 2002:a05:600c:1d1f:b0:497:ff5a:38b9 with SMTP id
 5b1f17b1804b1-4994e39509emr93143745e9.9.1785940454402; Wed, 05 Aug 2026
 07:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABoscT+MDv1=LRnogCanDfF33KLmMs3ah5n4A8OA=F8E7nprCQ@mail.gmail.com>
 <194df922f197e738bf19e86be4e4ecd25c141f74.camel@linux.intel.com>
In-Reply-To: <194df922f197e738bf19e86be4e4ecd25c141f74.camel@linux.intel.com>
From: Karan Shukla <karzshukla@gmail.com>
Date: Wed, 5 Aug 2026 10:34:02 -0400
X-Gm-Features: AUfX_mzNmhaIZID88-BE_6t_1q6swfZ-xzuudYjob8sD613MxEFC9OzcoCW2PuM
Message-ID: <CABoscTJgNio4fR60EBOONzxDrq5Ve+8NhqUVa5Z=Nh-DJ=JOxA@mail.gmail.com>
Subject: Re: Bug Report: intel_idle: no model entry for Wildcat Lake, falls
 back to ACPI _CST
To: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Cc: linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Artem,

On Wed, 2026-08-05 at 16:53 +0300, Artem Bityutskiy wrote:
> I did not measure Wildcat Lake (WCL), only Panther Lake (PTL).

No problem, thanks for the context.

> Yes, we internally discussed to just use Pather Lake (PTL) values, but
> we figured there may be differences in firmware, and I was not
> comfortable using PTL values for WCL without measuring them.

That makes sense, I originally thought about using the PTL values as well.

I'm happy to help with any latency measurements that would be useful for
a potential patch. I have the WCL hardware in daily use, so I can run
whatever is needed on it. I see wult is the tool for this, so I'm glad
to set it up and run whichever configuration you'd want, and to send the
results in whatever format is most useful to you.

Karan

(For posterity, I'm including my original email as plain text below so
it isn't lost from the thread. The first send went out as HTML and
didn't make it to the list archive.)

--

Hi,

This is a bug report, not a patch. I've been debugging a Dell XPS 13 on
Fedora 44 (kernel 7.1.6) and working through a few processor state
issues. In this case I was able to determine that intel_idle has no
entry for Wildcat Lake, though Panther Lake was added earlier this year.
I can't verify what the correct C-state values for this silicon are, so
I wanted to send a report rather than guess at them.

On a Dell XPS 13 (DX13260) with an Intel Core 5 320 (family 6, model 213
/ 0xD5, stepping 1), intel_idle loads but finds no model match and falls
back to enumerating states from ACPI _CST.

  $ cat /sys/devices/system/cpu/cpuidle/current_driver
  intel_idle

  $ for s in /sys/devices/system/cpu/cpu0/cpuidle/state*/; do \
      echo "$(cat $s/name) $(cat $s/desc)"; done

  POLL     -> "CPUIDLE CORE POLL IDLE"
  C1_ACPI  -> "ACPI FFH MWAIT 0x0"
  C2_ACPI  -> "ACPI FFH MWAIT 0x21"
  C3_ACPI  -> "ACPI FFH MWAIT 0x60"

The _ACPI suffixes and "ACPI FFH MWAIT" descriptions are the fallback
path. No intel_idle module parameters are set (no_acpi=N, use_acpi=N,
no_native=N, states_off=0, max_cstate=9).

arch/x86/include/asm/intel-family.h has the model:

  #define INTEL_WILDCATLAKE_L    IFM(6, 0xD5)

drivers/idle/intel_idle.c's match table does not. As of the current
mainline, it ends at INTEL_PANTHERLAKE_L.

INTEL_PANTHERLAKE_R (0xE5) is also present in intel-family.h and also
absent from intel_idle.

Comparing what ACPI _CST gives us here against ptl_cstates, the nearest
existing table: C1 matches exactly, and C6S carries the same MWAIT 0x21
hint with somewhat different timings (127us exit latency and 381us
target residency here, against 300us and 300us). Two differences do look
like they matter:

1. C1E (MWAIT 0x01, 10us/10us in ptl_cstates) is not exposed at all.

2. C10 is present with the correct MWAIT 0x60 hint, but is advertised
   with an exit latency of 1048us against ptl_cstates' 370us, and a
   target residency of 3144us against 2500us. So the governor reaches
   for it later, and PM QoS constraints exclude it more readily.

The MWAIT hints themselves are correct, and C10 is being entered heavily
already, so this is not a case of a state being unreachable. Over ~2h of
uptime on cpu0:

  C1_ACPI:  usage 4093039, time 455056615 us
  C2_ACPI:  usage 1739573, time 867104684 us
  C3_ACPI:  usage 701765, time 1022082936 us

C2_ACPI averages ~498us per entry, well under either C10 target
residency, so relaxing 3144 -> 2500 would promote very little of it. The

C1E gap is probably the larger of the two.

Request

Could Wildcat Lake (0xD5) get an entry with the correct table for the
silicon? If it is a Panther Lake derivative that can reuse ptl_cstates,
that would be a one-liner, but I have no way to confirm that from here
and didn't want to guess at exit latencies.

I'm happy to test a patch on this hardware and report residency numbers
back.

Context: this is the fourth piece of Intel tooling I've hit that doesn't
know model 0xD5. intel_lpmd rejects it outright ("Platform not supported
yet", filed as intel/intel-lpmd#123 with a fix proposed in #124),
thermald reports an unsupported CPU model, and turbostat cannot read
package C state residency on it, which makes PC10 unmeasurable and in
turn makes S0ix debugging on this platform harder than it needs to be.
On the intel_lpmd side I opened the PR mainly for visibility, and I'm
running the updated daemon on the device with no issues.

System details

  Dell XPS 13 DX13260, BIOS 1.3.0 (2026-06-25)
  Intel Core 5 320, family 6 model 213 (0xD5) stepping 1
  Fedora Linux 44, kernel 7.1.6-201.fc44.x86_64
  CONFIG_INTEL_IDLE=y, CONFIG_ACPI_PROCESSOR_CSTATE=y

Investigation was assisted by an AI coding assistant (Claude,
claude-opus-5) per Documentation/process/coding-assistants.rst. All
measurements above were taken on the machine and are reproducible with
the commands shown. No patch is proposed and no code is included.

Thanks,
Karan Shukla

On Wed, 5 Aug 2026 at 09:53, Artem Bityutskiy
<artem.bityutskiy@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, 2026-08-05 at 09:31 -0400, Karan Shukla wrote:
> > Hi,
> >
> > In this case I was able to determine that intel_idle has no entry for Wildcat Lake, though Panther Lake was added earlier this year.
>
> Just historical context:
>
> I submitted Panther Lake patches.
>
> I did not measure Wildcat Lake (WCL), only Panther Lake (PTL). Yes,
> we internally discussed to just use Pather Lake (PTL) values, but we
> figured there may be differences in firmware, and I was not
> comfortable using PTL values for WCL without measuring them.
>
>
> Artem.
