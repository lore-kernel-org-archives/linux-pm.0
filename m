Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414308;
	b=5sA/iEkwdn5QZNctApSlHnEAHvOuXazsGpM3KwaIvyLv4aN9Y8Febx6P0eDhIII0FmOt
	 kR8a4qDzKhvBsf+IGpgc8fvxkeKjo9xBXeLEZV2JmeO+LTn4lwpEtHGVQ2ekgSz+OWgQV
	 XQiEOgjWnGl7xJN5qqWBmZGMFpdehayjATXz7gLMa4qsAyIesDZdIN7P2gnLAmZaWVtjh
	 PYiwJ7re8IWHOvoIY5u9UCxchrQ4if06WZk8VjjXrYO7pA5U3msgj7h/sPup4J423oFB5
	 fWG2xEQkAI+1CbrPjaFy+k9oCEBkVWJnD3qoaorHiFc+QHY5FTUs8UvT032jwlT3eUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:Received:To:Subject:Cc:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:Date;
	bh=ckB7UdInDhsEA/WaRGbQfVP2uEdgLishpFgnJaNPJ3I=;
	b=e27YyQDQBX/4m91K6HDrWxgaLyjcHlI28oqRS10h3o4z2OG17LaCvn14TeIB+nIHhbud
	 EoGI+QsJWI7tCnRyvnIChtnGPOUVdF2rpVTjbuvX9k8NDYpa63JAUUqIZipzwrEslPbDS
	 HWmFO9Q9CgnIrCNEIdCMcefllCiMEP7ogIAUbMA5FRYfLiwKJ9A3os/KKOVrnG4XawFkb
	 0P0nLLPKpZ1hKkWhWJn/df31AB1CpgdbvelR65XSl9ReC42dbj4u5UJorRj2/XtQuN5md
	 pRDycwDclULFL8KAj3Ik7tseV4UnYkyYbGZodKZoNjS0CJp3/XyxKaKqHDVXknvlxDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=boake.ca;
	spf=pass smtp.mailfrom=boake.ca;
	dkim=pass header.d=boake.ca header.i=@boake.ca header.a=rsa-sha256 header.s=google header.b=otEepPCi;
	arc=none smtp.remote-ip=74.125.231.136
Received: from mail-oo2-f8.google.com (mail-oo2-f8.google.com [74.125.231.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85ED606A885
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 16:25:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B85ED606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=boake.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=boake.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=boake.ca header.i=@boake.ca header.a=rsa-sha256 header.s=google header.b=otEepPCi
Received: by mail-oo2-f8.google.com with SMTP id 46e09a7af769-860f0ac44a9so397617a34.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 08:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=boake.ca; s=google; t=1794414306; x=1795019106; darn=vger.kernel.org;
        h=date:message-id:content-transfer-encoding:content-type:mime-version
         :cc:subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ckB7UdInDhsEA/WaRGbQfVP2uEdgLishpFgnJaNPJ3I=;
        b=otEepPCijELHLR1esJBHXpY9g4Zh4OKnsR3BJJaQ6US+ToIEx70LaviiiiJR4pSulD
         PuYObrw8Kv2SO6n5mVDcZB9q+ybiIJuIZ5GnLMa/JAvTHQD/KK09pDKL9HB2ok0BDkPw
         7rrUeCEsLPdSp8Jmviw6GvbugtwM0krGvBZXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414306; x=1795019106;
        h=date:message-id:content-transfer-encoding:content-type:mime-version
         :cc:subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ckB7UdInDhsEA/WaRGbQfVP2uEdgLishpFgnJaNPJ3I=;
        b=MKGGsaMuAFNXBhDQYgoDpx0bmnYsAUSNZ+C5MgoqZBe/i20ZKQt5nfdMsRxcKjxbV8
         hNEnTMD0ijy+i3owOnTsr8AZyuBReTa2yWSy/qQTo6dwZTLWbAHMmVhFvONqpZtuDQHB
         2sBXgFumJkeM96Y2bwfdSsAsCG6JRI3AW/sklBaN1Pdh6zanjbIZlBeuZWbZsa0tSBk2
         Wz0JA8h4YBjisY2qPz9JZxq2rM5EVVJLXuWvNGkkMs0v12UZY2l31rPdNbbgrtXUe4hc
         hR8JKjpvTtz0cBvy8lFNBzCXHC7o5mihAkkF4lZ7xncHIMh1Dx/eTrC4p/VUZe5l7uqJ
         zRdA==
X-Gm-Message-State: APuU4Z9vvT1cnB9xtolFmBnmPz+4FkbkrjPHlPHhlY/qnXTxi8VBGz1F
	rbiROZWyW5WzI1WzeiahB8EKOSNYuaFz9IcuTF6yqceOs1dV9urDCVWRpX5MnmYzAXqqOmVhZJ1
	0VFsSfv6Qig2L
X-Gm-Gg: AYBFou1HLwa5s0DeZd57VGlBX1Wng1oHM0DhMsF6NwVWLx4nHRsCQ/2q1mirU5GBJ3J
	tTC/9dp81OCgiQzdpsTkj8Y/ySqrfcmrhGE4omui++17td8On7u/u7+Arsl8ZgK8Xi+BJT4OP8e
	3iHGgEVfsfR0jW+HUiNUqPsskfWaW4yys1UdqdqSlwCpNAIvo1FjsbBqvaCGJOGqZwhGGcK9tfz
	Xw+VnDu1SS3PmYPQkl2+B98gquLudic9L611km8X0b4+GEad5PWlZiggTfPCj91bQ1adQP2wXNM
	2t0t6nlRedjR+Ym6Kr+KD2c7PQlEt+hCKYKobFDGc851TXkUgmjzqJQzG8WiSMR2O8j4lbXE2AI
	DgHlvBJ5ViYsnA9UKlLtzy+yjIEvJLnP/oIsOEbnpHuxq7cpPJqvygEgE0drl0+S2mvAm0pRBHq
	x7msNiQpuNMMiMGB6K4r0c2NSi3WJJhCp07bG1FuFI/YXxZhLWYIBIC1ngBWuZEXzqIgTXA3ZZC
	jUQInJhJuwkerTjc5bOwpsiBha5FkYH/13Kx7KzqANuZ6OQBooJUjFAIbJlB6trF3hT/FN6VA4A
	jahq95vEqcLncvmmshu+F9SWdAzE66GqUXB7r5/5wbbEz003jydp8Xd3Y96Qrst/74fLqUmR8JY
	l1vn8Fb+AokILigQ/zi5WLzW04KjZC80=
X-Received: by 2002:a05:6830:2643:b0:81b:ac5b:ea17 with SMTP id 46e09a7af769-860f28697a9mr2748932a34.16.1794414306442;
        Wed, 11 Nov 2026 08:25:06 -0800 (PST)
Received: from Tobo ([2605:59c8:3823:2810:e6c7:b59a:50e2:b698])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcb62443sm4799328a34.6.2026.11.11.08.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:06 -0800 (PST)
From: Patrick Boake <patrick@boake.ca>
X-Google-Original-From: Patrick Boake <patrick@tobo.localhost>
Received: from patrick by Tobo with local (Exim 4.96)
	(envelope-from <patrick@tobo>)
	id 1xRB8C-000cy5-2N;
	Wed, 11 Nov 2026 11:25:04 -0500
To: linux-pm@vger.kernel.org
Subject: PM: hibernate freeze/image-creation stage has no watchdog-equivalent protection (real 6h12m stall)
Cc: Rafael J. Wysocki <rafael@kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Message-Id: <E1xRB8C-000cy5-2N@Tobo>
Date: Wed, 11 Nov 2026 11:25:04 -0500

Hi,

Real-world report, not a patch -- happy to help test if useful, but wanted
to raise this while it's fresh and while the related watchdog work is
active.

System: Debian 12.15, kernel 6.1.0-54-amd64 (Debian's packaged LTS --
predates the DPM watchdog extension below, noted explicitly so I'm not
overclaiming what I actually reproduced).

On 2026-11-10, an automated maintenance script called `systemctl
hibernate` after a normal, successful run. Kernel log:

  Nov 10 03:40:23 kernel: PM: hibernation: hibernation entry
  <complete silence for 6h12m -- no kernel messages of any kind, confirmed
   via journalctl -k across that whole span>
  Nov 11 09:52:27 kernel: PM: hibernation: Marking nosave pages: ...
  Nov 11 09:52:28 kernel: PM: hibernation: Creating image:
  Nov 11 09:52:28 kernel: PM: hibernation: Need to copy 1573875 pages
  Nov 11 09:52:28 kernel: PM: hibernation: Basic memory bitmaps freed
  Nov 11 09:52:28 kernel: PM: hibernation: hibernation exit

No second "hibernation entry" -- this is one continuous call that took
6h12m to get from entry to its own snapshot-prep steps, then aborted
without ever writing an image or powering off. Userspace was frozen for
the entire span (a 5-minute heartbeat process went completely silent for
the same window), so whatever it was stuck on, it wasn't something a
userspace watchdog could have caught -- the watchdog would freeze too.

Two things point at where the kernel's own protection stops:

1. Task-freezing has a real, enforced 20s timeout -- a failure there logs
   "Freezing of tasks failed after 20.0x seconds". That message never
   appears, which rules out that specific stage.

2. Device suspend/resume has the DPM watchdog. I checked its current
   scope directly against commit 3339234 ("PM: sleep: Add DPM watchdog to
   prepare/late/early/noirq/complete phases", landed 2026-09-25) -- it
   wraps device_prepare, device_suspend_late, device_suspend_noirq,
   device_resume_noirq, device_resume_early, device_complete. That's the
   suspend/resume path. It doesn't appear to touch the hibernate-specific
   freeze/image-creation callback path (the stage our real stall actually
   hung in, based on where the log picks back up).

So: a real stall landed in exactly the stage that (as far as I can tell
from the commit itself) still has no watchdog-equivalent coverage, even
after the recent extension. I don't have a fix to offer -- this isn't a
patch submission -- but given 3339234 is recent and the scope question is
fresh, wanted to flag the gap with real evidence rather than file it as
a cold, unsubstantiated report.

Happy to provide more logs, test a patch, or file this properly via
bugzilla.kernel.org instead if that's the better venue for something at
this stage (report vs. patch) -- let me know which you'd prefer.

Thanks,
Patrick Boake
patrick@boake.ca
