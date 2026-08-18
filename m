Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0430244999F
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 09:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787046953; cv=none; b=S7+I5UUjf6nqyOdGa+8vldpch+GOBJKFrpVD12lcbA3lyoIpg1j1uMfJkr2OCfgL+SBLAvaTfu4y6BQoYu3zerYzhSpiLNO8MF7cpJrwcvjz4oFVG3aDE0IwjHCU7Iz+LqdX2Glynpxoz8iQLCNveYLTVMwlDqy3d5/kWE8ixHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787046953; c=relaxed/simple;
	bh=uSjLGwM8f8rLIyQ8IaLP4sQuqoay2liq4KxW5tYEfKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NCpNKJ0hoqzkVOP4dVIu8O1NyWEEUvwBNDZu4wpfbFHYEmwcmYggjXtV/WfqY/OiItWCkGNUIHQ1qzDVGb0Oa+sMDsTCoohhfDNALmDtjh4/1kTbZvYFJ1/gAdLa0qAh3Zdm1DwpOFwqmRgu7Qf9i9yNxua9IUxECmk24/kZab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cil1Wf2A; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cil1Wf2A"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ced3386430so43189575ad.1
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 02:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787046951; x=1787651751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvZfYYEAxhzIIn9xadj0EwR+EuQol+UjVFty09Z5sHc=;
        b=Cil1Wf2A+RxG79R7+4Ot2jXo9HDGeCUuDKz2U76yqhtGxnY0pNqLQynw9EYf9OuB2m
         l+zhmoBeEH27R3/jSVUrr3iouup10ua6agcezrjssq95OIEIJJlPFJLlHGFpkkcxfUAP
         Xucqs+/0zrHSdpUGEr6WopAJD1ahBEHIxQ2guL73iN5d10Ug4Aa69DulTRT/Ar/bBZRG
         IMfOeqe9mH9aeKH8ML8HofWYqWa9MiidFaLpp+P3SOFv6lu+myieWgYehM3GJ6jjXSJN
         vXNNN2E1EXSAaivASFMdtZZwMG/j3At/GWhAcuTjyi7mYDXj9/D2FAK/x17QjA519cv3
         GB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787046951; x=1787651751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvZfYYEAxhzIIn9xadj0EwR+EuQol+UjVFty09Z5sHc=;
        b=eHgWNQdyyPwlctpa0KUknCBmVfc8TcrdcDtVTeaf6m40+TWQfvSJe2RW+XRxBXF3SP
         Uhiu+SGH/awn3xY5WJs4Tldt6f26nxnM4DRDfK8ot7+kHtNuosK5xFApPCKjC2d0fKNf
         7mtpSxIq3FfkJiF12+dDGW7gqKB4hMddxwGtODNNeinGsXInom5vDgGvRW1QOGKLrgoM
         OZdA6QIdfofVxeG5us/rB/gdae63H1qQYcApFursBdBeZvahkjUBOLB1uWiZsvX0dETa
         5Hl86o1/WpF/UYWpaMBw/TzIuQziATdV5K5ZIXhRQEANIdjxxej7YwkUJGfsWxcDP0ig
         Dpaw==
X-Gm-Message-State: AOJu0YxXLePVeH/gyBhAsffLXEdXRnjTX9od/FvCtEWSU7Ry+j7EZGxq
	XMQuNjLTr2nNB8X48b3Vc9IP8p7KTJuheuKGOAZm3H81vp5qO+lp2k9r
X-Gm-Gg: AR+sD12vLxi6pSz+oWZPetZSQfqx9abjvpT6wbqSSinTxru5LacKT1l4VD5JkRYtRJv
	tc9lHYHvoyGQa/RWeqwM6b+CE9zb0sahBPn0X++Ga4nJeTrNuu/IMM4px/CzbmIQCX8aprQWxd5
	WwN2XBwCOqETSVxCvTfFLMc9weREqilGjrphEIwdcHNhoFjLiYZXQ2jBqR1f1Ru0gJGNCNXAcE9
	xapcJiSpThscYR/s+tECv1WXJL2vthfa7upk0FVbvyabl/hP58qVp6XDM2HUvdnghIs/ef5zGwX
	zQglQvHjtferCW0nLrtv+53p+/FUywupoXSyqa0//0wv5PkBRSzt9xDlHDdo6mKlW0CIcW8mG4V
	FOfj3ThtX41MTPXEFOGMYydg0pCqEhv/gsrVPxSEJ4/cu4NItxnz9U4FTQkaXg7rYtPgtZzW1g5
	+jA9fuOoNoqeHO56EYapLwCw1xdMrwMvxdGRmu0VMU++/N4TxVYBB0umSVnlXaCJ/iQimosf5e0
	q9/hVhCLAc=
X-Received: by 2002:a17:903:32cb:b0:2ce:93a3:c168 with SMTP id d9443c01a7336-2d3b085db2fmr370693375ad.7.1787046951357;
        Tue, 18 Aug 2026 02:55:51 -0700 (PDT)
Received: from volcano9f8e-host.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-326794c0c94sm29532295eec.9.2026.08.18.02.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 02:55:50 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Thomas Renninger <trenn@suse.com>,
	Shuah Khan <shuah@kernel.org>,
	"John B . Wyatt IV" <jwyatt@redhat.com>,
	John Kacur <jkacur@redhat.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hemanth Selam <hemanth.selam@gmail.com>
Subject: [PATCH 0/1] cpupower: monitor: Show how a counter value is exported
Date: Tue, 18 Aug 2026 15:25:37 +0530
Message-ID: <20260818095538.1196953-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this picks up the ToDo in list_monitors() which asks to show more of the
capabilities of a counter.

"cpupower monitor -l" tells the name of a counter, the processor
hierarchy level it covers and its description, but it does not tell how
the value of the counter is exported. That is not obvious from the
description either: most counters are a percentage of the time spent in
a state, while for example the Mperf "Freq" counter reports MHz and the
RAPL zones report micro Joule. Without that information the numbers of
a measurement run are hard to interpret.

The value type is now printed behind the hierarchy level, using the
square bracket notation the hierarchy level already uses:

  [%]   The counter is a percentage of the time spent in the state.
  [abs] The counter is an absolute value, its unit depends on the
        counter, MHz for "Freq" or micro Joule for a RAPL zone.

The man page is updated in the same patch, right below the description
of the [T], [C], [P] and [M] hierarchy levels.

Note that "%" and "abs" are deliberately not single letters: [C] and
[P] are already taken by the Core and Package hierarchy levels, so
reusing them would render counters as "[P] [C]" or "[C] [P]", which
cannot be read unambiguously.

The second half of the ToDo, showing the time granularity of a counter,
is not implemented. There is no per state granularity information
today, only the per monitor overflow time which is already printed. It
would need a new cstate_t member every monitor has to fill in, so the
ToDo is kept, narrowed down to what is left to do.

Tested with the Mperf and Idle_Stats monitors:

  $ cpupower monitor -l
  Monitor "Mperf" (3 states) - Might overflow after 922000000 s
  C0	[T] [%] -> Processor Core not idle
  Cx	[T] [%] -> Processor Core in an idle state
  Freq	[T] [abs] -> Average Frequency (including boost) in MHz
  Monitor "Idle_Stats" (3 states) - Might overflow after 4294967295 s
  POLL	[T] [%] -> CPUIDLE CORE POLL IDLE
  C1	[T] [%] -> ACPI FFH MWAIT 0x0
  C2	[T] [%] -> ACPI IOPORT 0x814

Measurement runs, "cpupower monitor -i 1" and "cpupower monitor -m
Mperf -i 1", print the same output as before, only the listing changed.

Thanks,
Hemanth

Hemanth Selam (1):
  cpupower: monitor: Show how a counter value is exported

 tools/power/cpupower/man/cpupower-monitor.1   |  8 +++++++
 .../utils/idle_monitor/cpupower-monitor.c     | 22 ++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.43.7

