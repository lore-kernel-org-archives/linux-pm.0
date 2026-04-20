Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B6533B975
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 16:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700987; cv=pass; b=XVI96H6wKxps1heV/AeEtOZA0UxEcTfN+c8lXsvTeSRqgepc3HLFEILeuWqg5Yl3rOI3P9qucMtoK5g7C+5giuQP9TwCEnaeP6VNU0TncVU471kytqkYXeoBRlk1e8RnPuXV8kt7kbrE/BU57ocU/6RLgsloi03XnimR3qPfVds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700987; c=relaxed/simple;
	bh=R9V9R4q8xvWULOX3gjvoRnt/IB++lyxSgzyFQ02/p8w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j6zgcJUw4/FnpavCjYNAT7J9mQJoo0CZXZUaKcaxZvhDqVqwfbbWZfpQUFKyVXseKZamMTToB+ovKoSEOGn0yr6iLAmUtuKThreuQo8XG/g8BEIY8UopPkrH9xwaf+bV382Dc302wxxhebWRnVb2FB6H+nw9LuCVSlte8bpkj58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmkkjOD5; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmkkjOD5"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-488b150559bso25059835e9.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 09:03:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776700984; cv=none;
        d=google.com; s=arc-20240605;
        b=LJ7zLSSeC8p8Yw+VHu6+o7Fzjyl+dO6ROoLq9N4lgAWUdmdU1MNEKJsfKo8TUffLom
         0eqHpKfA8er+Na+ptOJrTDP2P8UCs4uGx9u9EfQCZbZPc4lVVoz5ASwpIYZrlbp/GHz2
         GWsNlX8TTjm90yjpiOFhD6HekqUdTS/syhZR2MrRlmkBmVegSKG4/44GhDCcG9RPqgqc
         1ieXsY6ZFXKTyb41ZtyZ7TkJ5C9ZAh4vvJMxRgNTnUdmTWVdaxRU8Kbs+1ULFFhO61F1
         6TdE/WTkMQiriPUKXU8MSQZ6Vyn8/bWURbGP5t0p3688ch3sK94lLT/4AfXyIQRndySH
         w1OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        fh=/J2M7RndHc+KPjqdgulmp3oY1//2Qzzbn6f4eyfWwQs=;
        b=kk8atiSJo9sM9VhWcfELuUA4dL9iHtCifv4GcuzJtlPgMO+GU1PENqqI3KnQNrtM7L
         V87k6oFPo8L9kssrxOp/pAIJDo1cYxjJH3cWmYe3g/LvCzuRm5t2UvynuTFMM3skAL4/
         +NYPU6bI7ENw0t/bz6/3Uv3wQARk/OxY6tx497KOE5diAy10b0XRXCEmcdtojzdoPXRD
         aGKviXmaonE4lQECIUSsiprxrF//OPD2iXW5iQ0gTMEzPcRzYkDKPRupN821Uo9eH6kH
         y5LNp8teAHhxLQf0itxSKA3O7Q9cRFPtDC8Dbnx5ssjZXKoWcVSiZj+4jJupkvDg/hUa
         wBqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776700984; x=1777305784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        b=NmkkjOD5u/+xKdbPi3ue948LOpoVNlpcP93rwGZQRjN4eC2c4+BbPMvh/gJk+u0fNy
         nHkU5uJu7/oSzvXPTJ+9wr81WiYxhhVo7xQDskFeZO78P5xDddoSoYOfOQ77obBpmrCf
         rhKjqjus5yuPp3zE6YheSV7Fw4ZYnQ5lJh+phdHn6TZmtqDZZEIRTrTzPaiv3X7HDeyb
         ovt1juVx8YkxiJXIf2QtY1Q6nn/4Yf3rrkHmQNz1YhHf6ycWNjO/nqFQWZoAVVSvefJ4
         ZAOQ0LlxoILJa8/eTVekAXqxIhjV30BD0FdUwSUzcTyE/o1qKWQ9nXQWtb7Mb8g5v15v
         sVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776700984; x=1777305784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBF/huw+jCdmavak8Kfcjpi9kTHcjyw4uzaIxzF9jcE=;
        b=XeKOHchBAwHJXoJcv/VcPfT2uRmsZKUe07OkPBRMrm5oDCj3XtSI3eXyepDHbyBTYz
         2tn8MMgb1n7C8CSmMFVA3gA+GBq7a7uYw1uPs0eRl2ieGDpPHA7Od82T5zu8xeV8LfsO
         kHgVSq6KWh5dkn2nDP41bapynZCfM9grufnVzhth+9eyTeXBcXgYSPFvAAYf5Y7dwjvs
         nphP6Pqgk6PjUBK9lMCzEC/Am1vLnSC3edYpfBzGz8aAwssBOOPh2tVXEBDdUgSP2oi4
         hkMpNFhNDbxie88nkuZ2NC8o0UYkiBLAbieaBhKYegKuIBomNjiaoKK24FKQ3izOS8hV
         xtqQ==
X-Forwarded-Encrypted: i=1; AFNElJ9sC9sYMUAhfXKKtHQDHnZfDuyjFI68w1xIY+AEsUwJC5HKOyBfrqQTW/n523t9aBDmVBIVWwc1Bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxgKCkwpYQs013f4Ip2gCvKrkp4NJMCX1vvjx9oe9wWN7/W06EE
	SY94UwQFQPDYRZOkp7t/52GItpCUUHMGCXDH1Ixtx5cmRPec1EvtyqboFCIzb3Yf2VtF1SgGUsM
	YacsY1NvS7SNvLTQPBMExDvrUX+qq60U=
X-Gm-Gg: AeBDietUBp1HK4BEKRwsgP1ucnZphcwg/iZFvwxfJ/zaFwSWvBDeMo9hbuT1LnMzD4h
	WVH4a1pDsN/4EVFRKXbjb3JLep/Ak3H7eBTfvjVuv59WGLy1s7ZSlwxwAxILXgGW7p7EUkL1rti
	Dlzc+BmOLkIejIISk9EIgHLndipAhhMpo0AlBlbTxcZ4Ex5LLhlhLrYbekhANYRGI2DSJl077LD
	0Elw6ZYzbmmYAPYsE+Z7NILqW0lTY4vE/uULsbomhAD92/BXzItIx2dZEZz961vftIz47SS+ux/
	YQCDAhqmXR4JUbrZZ9lrI9609tpcIQNAGP+a9LNoKrzTLbz2weO3oGthx21J1vkEIQ==
X-Received: by 2002:a05:600d:8449:b0:488:a894:b27a with SMTP id
 5b1f17b1804b1-488fb74a8c2mr175647735e9.8.1776700983794; Mon, 20 Apr 2026
 09:03:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260320192735.748051-1-nphamcs@gmail.com> <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
In-Reply-To: <CAMgjq7AiUr_Ntj51qoqvV+=XbEATjr7S4MH+rgD32T5pHfF7mg@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Mon, 20 Apr 2026 09:02:52 -0700
X-Gm-Features: AQROBzDxid6PXLYOtsvRL4lA7x1zRB3nMTMN0giu6Su7fE6kLvWGH4GcqL7x9i4
Message-ID: <CAKEwX=M4nWeAw1-geCwABuv-0okz3-x9SwNswL-1Ks9KEAS6Mw@mail.gmail.com>
Subject: Re: [PATCH v5 00/21] Virtual Swap Space
To: Kairui Song <ryncsn@gmail.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, apopple@nvidia.com, 
	axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com, 
	bhe@redhat.com, byungchul@sk.com, cgroups@vger.kernel.org, 
	chengming.zhou@linux.dev, chrisl@kernel.org, corbet@lwn.net, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jannh@google.com, joshua.hahnjy@gmail.com, lance.yang@linux.dev, 
	lenb@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-pm@vger.kernel.org, lorenzo.stoakes@oracle.com, 
	matthew.brost@intel.com, mhocko@suse.com, muchun.song@linux.dev, 
	npache@redhat.com, pavel@kernel.org, peterx@redhat.com, peterz@infradead.org, 
	pfalcato@suse.de, rafael@kernel.org, rakie.kim@sk.com, 
	roman.gushchin@linux.dev, rppt@kernel.org, ryan.roberts@arm.com, 
	shakeel.butt@linux.dev, shikemeng@huaweicloud.com, surenb@google.com, 
	tglx@kernel.org, vbabka@suse.cz, weixugc@google.com, 
	ying.huang@linux.alibaba.com, yosry.ahmed@linux.dev, yuanchu@google.com, 
	zhengqi.arch@bytedance.com, ziy@nvidia.com, kernel-team@meta.com, 
	riel@surriel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 23, 2026 at 3:09=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Sat, Mar 21, 2026 at 3:29=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wro=
te:
> > This patch series is based on 6.19. There are a couple more
> > swap-related changes in mainline that I would need to coordinate
> > with, but I still want to send this out as an update for the
> > regressions reported by Kairui Song in [15]. It's probably easier
> > to just build this thing rather than dig through that series of
> > emails to get the fix patch :)
> >
> > Changelog:
> > * v4 -> v5:
> >     * Fix a deadlock in memcg1_swapout (reported by syzbot [16]).
> >     * Replace VM_WARN_ON(!spin_is_locked()) with lockdep_assert_held(),
> >       and use guard(rcu) in vswap_cpu_dead
> >       (reported by Peter Zijlstra [17]).
> > * v3 -> v4:
> >     * Fix poor swap free batching behavior to alleviate a regression
> >       (reported by Kairui Song).
>
> I tested the v5 (including the batched-free hotfix) and am still
> seeing significant regressions in both sequential and concurrent swap
> workloads
>
> Thanks for the update as I can see It's a lot of thoughtful work.
> Actually I did run some tests already with your previously posted
> hotfix based on v3. I didn't update the result because very
> unfortunately, I still see a major performance regression even with a
> very simple setup.
>
> BTW there seems a simpler way to reproduce that, just use memhog:
> sudo mkswap /dev/pmem0; sudo swapon /dev/pmem0; time memhog 48G; sudo swa=
poff -a
>
> Before:
> (I'm using fish shell on that test machine so this is fish time format):
> ________________________________________________________
> Executed in   20.80 secs    fish           external
>    usr time    5.14 secs    0.00 millis    5.14 secs
>    sys time   15.65 secs    1.17 millis   15.65 secs
> ________________________________________________________
> Executed in   21.69 secs    fish           external
>    usr time    5.31 secs  725.00 micros    5.31 secs
>    sys time   16.36 secs  579.00 micros   16.36 secs
> ________________________________________________________
> Executed in   21.86 secs    fish           external
>    usr time    5.39 secs    1.02 millis    5.39 secs
>    sys time   16.46 secs    0.27 millis   16.46 secs
>
> After:
> ________________________________________________________
> Executed in   30.77 secs    fish           external
>    usr time    5.16 secs  767.00 micros    5.16 secs
>    sys time   25.59 secs  580.00 micros   25.59 secs
> ________________________________________________________
> Executed in   37.47 secs    fish           external
>    usr time    5.48 secs    0.00 micros    5.48 secs
>    sys time   31.98 secs  674.00 micros   31.98 secs
> ________________________________________________________
> Executed in   31.34 secs    fish           external
>    usr time    5.22 secs    0.00 millis    5.22 secs
>    sys time   26.09 secs    1.30 millis   26.09 secs
>
> It's obviously a lot slower.
>
> pmem may seem rare but SSDs are good at sequential, and memhog uses
> the same filled page and backend like ZRAM has extremely low overhead
> for same filled pages. Results with ZRAM are very similar, and many
> production workloads have massive amounts of samefill memory.
>
> For example on the Android phone I'm using right now at this moment:
> # cat /sys/block/zram0/mm_stat
> 4283899904 1317373036 1370259456        0 1475977216   116457  1991851
>    87273  1793760
> ~450M of samefill page in ZRAM, we may see more on some server
> workload. And I'm seeing similar memhog results with ZRAM, pmem is
> just easier to setup and less noisy. also simulates high speed
> storage.
>
> I also ran the previous usemem matrix, which seems better than V3 but
> still pretty bad:
> Test: usemem --init-time -O -n 1 56G, 16G mem, 48G swap, avgs of 8 run.
> Before:
> Throughput (Sum): 528.98 MB/s Throughput (Mean): 526.113333 MB/s Free
> Latency: 3037932.888889
> After:
> Throughput (Sum): 453.74 MB/s Throughput (Mean): 454.875000 MB/s Free
> Latency: 5001144.500000 (~10%, 64% slower)
>
> I'm not sure why our results differ so much =E2=80=94 perhaps different L=
RU
> settings, memory pressure ratios, or THP/mTHP configs? Here's my exact
> config in the attachment. Also includes the full log and info, with
> all debug options disabled for close to production. I ran it 8 times
> and just attached the first result log, it's all similar anyway, my
> test framework reboot the machine after each test run to reduce any
> potential noise.
>
> And the above tests are only about sequential performance, concurrent
> ones seem worse:
> Test: usemem --init-time -O -R -n 32 622M, 16G mem, 48G swap, avgs of 8 r=
un.
> Before:
> Throughput (Sum): 5467.51 MB/s Throughput (Mean): 170.04 MB/s Free
> Latency: 28648.65
> After:
> Throughput (Sum): 4914.86 MB/s Throughput (Mean): 152.74 MB/s Free
> Latency: 67789.81 (~10%, 230% slower)

For this test case, I took my 16G (a bit less than that technically)
52 cores host, using zram as the backend and MGLRU, for a spin.

Keeping the same parameters as your usemem command, unfortunately, led
to massive thrashing (even with baseline kernel) - unfortunately zram
still used physical memory so the overcommit level is too large
(especially with random access pattern, i.e the -R flag).

I then tried reducing the 622M part to 480M, but the problem with that
is VSS5 did not show any regression - probably because the
overcommitting is too low, or not enough concurrency. I had to push
the concurrency up to 52 workers, allocating 300M each (which is
slightly more memory allocated overall than the 480 x 32 case), to
finally show the regression you reported. Variance was very big with 8
runs though (what I normally use for usemem these days), so I had to
do 20 runs per kernel - fortunately these runs are fast:


Metric      baseline       vss_v5         new_opt_v2     cc_v2
real (s)    15.0 +/- 0.8   18.3 +/- 1.8   15.1 +/- 1.0   14.7 +/- 1.0
sys (s)     396.4 +/- 31.1 511.9 +/- 60.3 404.1 +/- 34.5 392.4 +/- 39.9
tput (KB/s) 28188 +/- 6996 23287 +/- 6629 27999 +/- 6623 28744 +/- 7015
free (ms)   101.1 +/- 52.4 91.4 +/- 41.5  93.1 +/- 43.8  97.6 +/- 49.5
% real      n/a            +22.4%         +0.7%          -1.7%
% sys       n/a            +29.1%         +1.9%          -1.0%
% tput      n/a            -17.4%         -0.7%          +2.0%
% free      n/a            -9.6%          -7.9%          -3.5%


(I realized I mangled the output last time of the "memory reclaim
metrics table" table due to auto line break. Let's hope this is
better).

Strangely, no free regression. Hmmm.

But real, sys, and throughput regression are real. The optimizations
do close the gap to within noise level here too.
