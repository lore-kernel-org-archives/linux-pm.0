Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70C23B47EF
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2026 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486805; cv=none; b=P2hmALymiPgSxdPCmOi+M+E9SbKnyvt8LAmtQyjhhwwFnUAnV2z+lrr9fgrSW3oBmoaPexnP5SdAuUgj+g6aBQGEB5c19SjT2b4zRD1pTZI05m5WdJapV/OkLDNgdj6f9lltzwm/+JFXTj4F1NVEAwqnFvoI1kvbucV3jKwBz5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486805; c=relaxed/simple;
	bh=Gns521/EKZLdx7MAed51/yhfAPJrg46pDNraWUEqGY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLYsAHA8XYGuHZl7hd6I11dCzXABHfGOzGp4M4FUTeWt/z0aASP5K3bBMQgs0mFUTTjEglhm40Gf1daj1VPS2aiGeHnu16wGv65sf8XvC7Jvh4w9xTlq8AE8boYoXywFOiwt2754P7ZXwjDD/bumpUIXI3SC2+2JIef0zWvFHjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRIy6el4; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRIy6el4"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48c5b7d5865so153966f8f.2
        for <linux-pm@vger.kernel.org>; Thu, 08 Oct 2026 12:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791486802; x=1792091602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsKnBLI7Oap+/MtZR28XECViUHg4ECBk5FTj278RiYo=;
        b=HRIy6el4IpC9LCt71Kunj7c3EIR9OEG8R9pOQ6KFslG/klJUzr3FGgI1jgd87Dz40/
         aB0H42gGQwD6evC2BfjW+N5julgGKxkoU8IHFJMk5e8lHU77pfw0NXaYUo4hrqVPkAhi
         /XHxnRBF13FjQF72XnvfO7fhlejI0pajNy+x8WOBY7wPYqxYhfov36NG5xQBYoQjH/LK
         KfC3UXDCkJ+ziYK2QAXH5YoFbl70x9QSftnmHNZFK3hYl5qvyT3U7SPZZimBuOt6xUTQ
         C3CcbAIKroB/02+CDu9sBMYxLqNBgay5yn5iVN5yy5m2u6DSRTCdcsgP1bOmtC/DxNH0
         KBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486802; x=1792091602;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsKnBLI7Oap+/MtZR28XECViUHg4ECBk5FTj278RiYo=;
        b=v5ON1xc/5fHYgMn6eRAiOFS05qsXbmW5EtxtnsrXsk/I/T0kH7WycM7tn31smPSWTG
         5oIL1lWQU4hDADypKETVUax90reWMrYMg3l1mIQvf+Te3LZvy4IbXds6RHYwLFgJ9MkC
         poGl/Yp2CA39Seis3fGqmIFBppGO7yxfniDlSHaBqpD+n0VpiJ+KJONGgCWFiTy4VKtk
         oe5ACrEdmG97gl1zrDhJBnlSvnb4VT0+PuPxMU8Za+GHcTSZIlg7FVXtAIIHdlBOg2qR
         khvQ6MT8ATOgY4EUoS9LHzvW0CWA4pi6tnhB4j+DIJTZQefRxY8Bi/9K2TY8Or64Kp7k
         eu4g==
X-Forwarded-Encrypted: i=1; AKwUvBw3IxR3Qqf/NrH6VbBmM2ToR59Dj3DAFDvL/xbuPYsxVtJejnT/ULHhjSgOz+d28QfHy97XQiH+bw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJjhnmL4RWarPEKWbIrM4Eldc7Hyi3jznpVbZXsz95JzxC1PcPZ
	xspYukkExJjCG7a48OqSeLClRtCygaCuEt1R7YuLqTJNtHP/RiJaAWcG
X-Gm-Gg: AYBFou2t88lpFLejEtRvaiPvDuTPow9JY0vFTUy50AGyNjaHq1MMVr7/ozFNEkKlX+R
	ZfA+oQ376hYHRc75VTtJdr4gcY0g82BuDrpYGur1Vg8H+lX4MAXVuw+G71vtQEprPO+n+UohfnN
	wWyZ0kfhRj/6lBm+mpO6Yw1lOkABY8eVhz0GP9udjoLTt0gqtiqEQd+C24GtnjysBq1wQ/Pfcml
	96K13vr71iwlxpgO1BwgXYvACelWCZot0SXoK+/393gkk/a1JZuNGNAs3AmRbHfPZxGVCeySC8X
	qiYMcBLh6PXLqAgWYMA7w4tX8Gkl0xzSf6aVm3K772h8opzL08CONSLnCLSMA4ychOb+Q5Rpl3r
	LL6M308a9vDlPyTEjmLj9iMS/xnbnwafUQgSsnB8O5nmHsmwkfk2F6/TslgwIu5FD30NMRC5Cdu
	Zgk0W+nGxvXm9+VgsrkEIlCPM9cXIlCdBLlkz9JJR7d+NcIqKbQylkLsVwviYNSTtOG41SZso10
	M5UCqFsX/qrkR9K26BCDOpiLdKKeR8=
X-Received: by 2002:a05:6000:38c:b0:48a:f4c1:4301 with SMTP id ffacd0b85a97d-48c7edcd161mr6378457f8f.6.1791486801862;
        Thu, 08 Oct 2026 12:13:21 -0700 (PDT)
Received: from lima-kdev.local ([85.100.66.184])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db652e52asm1158763f8f.36.2026.10.08.12.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:13:21 -0700 (PDT)
From: Kayra Cizmeci <kayracizmeci@gmail.com>
To: vincent.guittot@linaro.org
Cc: arighi@nvidia.com,
	bsegall@google.com,
	changwoo@igalia.com,
	christian.loehle@arm.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	lukasz.luba@arm.com,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	pierre.gondois@arm.com,
	qyousef@layalina.io,
	rafael@kernel.org,
	rostedt@goodmis.org,
	sched-ext@lists.linux.dev,
	sshegde@linux.ibm.com,
	tj@kernel.org,
	void@manifault.com,
	vschneid@redhat.com,
	Kayra Cizmeci <kayracizmeci@gmail.com>
Subject: Re: [PATCH 00/18 v2] Improving latency of short slice tasks
Date: Thu,  8 Oct 2026 22:12:36 +0300
Message-ID: <20261008191236.152916-1-kayracizmeci@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261002154415.2270586-1-vincent.guittot@linaro.org>
References: <20261002154415.2270586-1-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi All,

I wanted to ran some tests for this patch series. I couldn't really
apply it without some issues, but I think I managed to apply
it cleanly this time... Tho I may have been doing something wrong.
Please let me know if so.

base: 4a3b51aab6e25244d97936aa65e6d5425adf98e1 (on tip/sched/core)

Command Used Each Run:

hackbench -g 4 -l 100000 > /dev/null & sudo chrt -o -T 300000 0 ~/rt-tests/cyclictest --policy=other -t 1 -i 1000 -D 20 -q -m; wait

Environment:

Zen 3 with 8 Cores and 16 Threads. And Fedora.

THE RESULTS (COOKED):

On Base in 5 runs, average values are: Min: 3.8, Act: 5.8, Avg: 8.8 and
Max: 2511.6 (I need tea.)

On Base + Patches in 5 runs, average values bla bla you get it:
Min 4, Act: 5.8, Avg: 7.2 and Max: 1781.6

Or, in the shape of art made with love and passion:

 +------BASE-----+--PATCHED--+
 | MIN   3.8     |    4      |
 | ACT   5.8     |   5.8     |
 | AVG   8.8     |   7.2     |
 | MAX  2511.6   |  1781.6   |
 +--------------+------------+ 

Hmhp... Hope I'm not missing something. I need water. Bah.

Tested-by: Kayra Cizmeci <kayracizmeci@gmail.com>

Dancing donkey chases a car while shouting "Linux is the best, my dancing is the coolest. Cry."

Thanks,
Kayra



I'll add other not too important things below, these are pretty raw.
But if you wanna have a look you can.


THE RESULTS (RAW):

BASE 7.3.0-rc1+ #2:

RUN 1:
[1] 1950
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2115) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    8 Max:    1885
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 2:
[1] 2132
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2297) P: 0 I:1000 C:  19990 Min:      4 Act:    6 Avg:    9 Max:    2695
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

linuxfucks@micro-softly:~$ (Opsies. Who's hostname is this? It's so cool. Wow. 'linuxfucks')

RUN 3: 
[1] 2307
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2472) P: 0 I:1000 C:  19988 Min:      4 Act:    5 Avg:    8 Max:    3246
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 4:
[1] 2493
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2658) P: 0 I:1000 C:  19995 Min:      3 Act:    6 Avg:    9 Max:    1991
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 5:
[1] 2671
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2836) P: 0 I:1000 C:  19992 Min:      4 Act:    6 Avg:   10 Max:    2741
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

BASE + PATCHES 7.3.0-rc1+ #3:

RUN 1:
[1] 1490
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1657) P: 0 I:1000 C:  19993 Min:      4 Act:    5 Avg:    7 Max:    3091
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 2:
[1] 1671
# /dev/cpu_dma_latency set to 0us
T: 0 ( 1836) P: 0 I:1000 C:  19999 Min:      4 Act:    6 Avg:    7 Max:    1529
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 3:
[1] 1848
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2013) P: 0 I:1000 C:  19998 Min:      4 Act:    6 Avg:    7 Max:    1455
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 4:
[1] 2023
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2188) P: 0 I:1000 C:  19995 Min:      4 Act:    6 Avg:    7 Max:    1524
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null

RUN 5:
[1] 2200
# /dev/cpu_dma_latency set to 0us
T: 0 ( 2365) P: 0 I:1000 C:  19989 Min:      4 Act:    6 Avg:    8 Max:    1309
[1]+  Done                       hackbench -g 4 -l 100000 > /dev/null



