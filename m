Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83E3472071
	for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789213068; cv=none; b=c91XoTb6uR48Kk0D8Y1EcrgS33Nw0OLlRm/x9EX3P7nKpEeUnkhw077MgEgewd8nfF+iY+UPZbrPSHLPNQGspipLfg2Yi9jZTT4NHmW6T7o4HmvJzbEbroU5zs92fsULoeN7QvsbYcCOM7mT4pLoVPaO0M7R6IDehjl+k060cpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789213068; c=relaxed/simple;
	bh=RExdxvalmhuQ4igE15Cjkz69e9cJn4uuxFIjIpHu/zA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fds6Xy7Zhd6UVLG2FMIFQ6AifP4GVBTLs1g92S/V3Yv1fKN/k/AsKOZaeo4S0Yy9lUiDxiZbdCWpL66Y5iT+ZN+gQzk99FK1mwIkdyWBHLU03LqwlTzTR73h+NL6z2TnwHDjMeTEavR9O+ZH1kKVhXckFhcgbexvHAeqM0caVuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFXx33BS; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFXx33BS"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843971bdd0so89640f8f.1
        for <linux-pm@vger.kernel.org>; Sat, 12 Sep 2026 04:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789213065; x=1789817865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gJcRqsLZqK1lU4eYh1WG11ZDI4ruah74QgvrXeQigNU=;
        b=AFXx33BSI07yt1yTypeaqBwwsHdlxPig8VHmdhhU/YtY6hLvInQteLVgk6KSgnY292
         d19VmUeJLIA5gooScWUcDP+9wIah7z0fcfaBIm4shJT9hgSjIl++4qL7Cdf7+ytgErnX
         CKSOIrHuWOPhlqsya9FvQS6uIoJ9D0h4mF+Pk1uFRhUd0357CCYTm+3LofleYqT5o0EF
         XW7pKCf4lMBgVp70mvlLBRL9RXi2ROQ66AOSovErtek3VmbJbi1ubRYX5hf3ekHYxGFA
         YoMfZBpA0bZ/3VBhJeFw2FeoLWw+uJODhGeiuj0drddZxk3tzz3qfhhwdA6in1jmabBZ
         F1Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789213065; x=1789817865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gJcRqsLZqK1lU4eYh1WG11ZDI4ruah74QgvrXeQigNU=;
        b=pPwGa+u2q6tz1bnBISe5xbqHfUnu+nHFjjQJ9DU7i0ddoYVciAHM1xUfnPXLoJ7pN/
         3FhJWIYiRcvFYBvcz5rB5pLg09uxcfZVb1cSVarhr0sIxCIHiR8fPuSgPqeglsb/F1EW
         fvfCiO5HRtRJ9MIJGUKwgF1Slcm5N9mImridOAubq1wssKCv6kY8Wvmj3Cx2Ov+Fo3zR
         VZLz+407zYUg+TTEkqRbacJQHWgposNDQsm2MuF2JcR6tAcspVgJaLgeOZ/fm8OLlh5H
         qBgYbsvzLFWdBHa+LrRFqY69zyYaez80fnW6F10axXl+dJddyh2dJaLmr4P6TUl0yKdk
         c2fQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnNpAvs//Eot2+Pe3XFjd1jTW+KOUl4knprj+fIliaygujPUDGsNimoaCiKHq8k6xsOGYD5g+LYg==@vger.kernel.org
X-Gm-Message-State: AFuF++k5zF749pHyWRQHpXxywQ0CBOHBm1O1gM70/kB3IL4f3xLezSI5
	pVe/rBTjGOn6V0STCxBIrzoHVp9TzbtclvKKM42Dfx/ezeD763HWs7ns
X-Gm-Gg: AYBFou1gOv0WNzy64OV1uJCK+c9pHXSx/hCo97ulEJ4I1XFCyB6STCsfj+kXQe2nClV
	3d9IO5jiiujgsuGeYxPt8Rwmgqf8vavU/qJtqM3TklSsXUKruOTl9VXNLvUU0iCWmAlmyiieDah
	1/3hkKTBN4TX0dj5qc29Up2ffkBVgyj25le98fv4gtfEpcd3/kW52QI8j2jBxYpxfqfHpX2k/9n
	qapywN6Zsv1klZdr7k7QmIvaWxOVvB8uTXX6GkUOQuGMkFmZYQxUqB/f+Ghnp5rHcwvc6st8IKQ
	7STJsCcfTXL63igkUcb8nMPqT1bNzTjIjNJ6UxPorBnJCM0cZZSs0bAkJtLwmNOabTig52BLd32
	xVk1QbOyJPH91nKd+1IMF+/FC5vMqqhGMcNRZrywFkChJ36FOFCS4jk3HEwS3G4gkGiUihmSdCH
	PbRbgZDrAb958P9N9M8BNPSAwskiEOEj27F00z7TpN2NhGcC2lteqmXFNY3aWmbzV/kLZF01c+y
	Lng7Z7oig2lAqLMsqQ6lk6h7Xr8BrcYnyzu8uJuYYXwhu66YXxkc14DmK+HiCUVc0k+2/8kdypk
	tw==
X-Received: by 2002:a05:600c:46d1:b0:49d:798:67a4 with SMTP id 5b1f17b1804b1-49e61640f73mr84164245e9.0.1789213064708;
        Sat, 12 Sep 2026 04:37:44 -0700 (PDT)
Received: from OrangePi5-Plus.BB-HOME (20014C4E1B8209007423DB663D3B2FEC.dsl.pool.telekom.hu. [2001:4c4e:1b82:900:7423:db66:3d3b:2fec])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a81943sm99068345e9.1.2026.09.12.04.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 04:37:44 -0700 (PDT)
From: Igor Paunovic <royalnet026@gmail.com>
To: Jiaxing Hu <gahing@gahingwoo.com>
Cc: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Heiko Stuebner <heiko@sntech.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Ulf Hansson <ulfh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Oded Gabbay <ogabbay@kernel.org>,
	Elaine Zhang <zhangqing@rock-chips.com>,
	Abel Vesa <abel.vesa@oss.qualcomm.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Alexey Charkov <alchark@flipper.net>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Igor Paunovic <royalnet026@gmail.com>
Subject: Re: [PATCH v12 03/14] accel/rocket: wait for a running IRQ handler before resetting a core
Date: Sat, 12 Sep 2026 13:37:17 +0200
Message-ID: <20260912113717.6819-1-royalnet026@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912065053.1519165-4-gahing@gahingwoo.com>
References: <20260912065053.1519165-1-gahing@gahingwoo.com> <20260912065053.1519165-4-gahing@gahingwoo.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Jiaxing,

While re-running the 19 August protocol on v12 as posted today, I
found an error in my own reports that this commit message now
carries. It is mine to correct, and it also corrects yesterday's mail
[1]. What falls from that mail: the 53-versus-49 bound, the sentence
that 19 August showed no manifestation on either arm, and the closing
suggestion that both statements can stand in the commit message. What
stands: the provenance, 45 resets on 19 August on v8 1-2/12 and 102
on 25 August on v9, and the caveat that this protocol bounds and does
not prove.

My script kept the scorer output of every inference per round and
never aggregated it; my summaries scored only the one inference after
the forced autosuspend. Aggregating the per-round files now, the
constant-0x80 result is in the rounds of nearly every run, on every
arm, on all three dates (resets per run, then rounds at 0x80):

  19 Aug  v8 1+2        12 + 8            2 + 1
  19 Aug  base only     12 + 13           2 + 3
  25 Aug  v9 1+2        12 + 11           6 + 1
  25 Aug  base only     8/10/12/8/15      2/0/1/1/2  (+ the one after
                                                     suspend)
  25 Aug  v9 1+2+3      13 + 13           2 + 2
  12 Sep  v12 2+3       10 + 11           2 + 0
  12 Sep  v12 2+3+4     9/5/12/13/14      2/0/2/1/1  (+ the one after
                                                     suspend, twice)

Today's seven runs were two arms only, no unpatched arm, so nothing
today re-tests the differential. Same board and base as before,
PROVE_LOCKING and DEBUG_ATOMIC_SLEEP on, serial console captured on a
second machine for the whole session.

So "no manifestation on either arm, oracle 48/48 throughout" on 19
August and "every inference matched" on 25 August were both wrong
for the in-round inferences, and the 0x80 buffer is not a
differential signal. It is what a job cancelled by the reset looks
like from userspace in this protocol, whatever made the job miss its
deadline, so it cannot tell the races 2/14 and 3/14 close from an
ordinary induced timeout.

The mechanism, from the code: rocket_reset() calls drm_sched_stop(),
which detaches the hardware fence of every pending job that has not
completed; rocket_core_reset() kills the block; drm_sched_start(sched,
0) then completes those jobs through drm_sched_job_done(job,
-ECANCELED). That finished fence is the one on the output BO's
reservation. The only wait the rocket uAPI offers is
DRM_IOCTL_ROCKET_PREP_BO, and rocket_gem.c maps any positive return
of dma_resv_wait_timeout() to 0, error or not, so teflon reads an
output buffer that was never written, which its output conversion
turns into 0x80 (mesa rkt_ml.c, output + 0x80), exactly as you
described for RK3576. With JOB_TIMEOUT_MS=2 the timeout fires on
about half the inferences (74 timeouts over the 147 inferences run
today, seven runs of twenty-one; 14 of the 21 in the traced run
below); whether the reset or the completion wins that race decides
the outcome, on every arm alike.

A direct witness, one run on v12 2+3+4 today with a kprobe on
drm_sched_fence_finished(): exactly two completions in the whole run
carried result -125 (-ECANCELED), and exactly two inferences came
back all-0x80, round 11 and the post-suspend one. The two
cancellations are 5.3062 s apart and the two scorer files 5.3057 s
apart, and across all twenty-one inferences of the run the gap
between a traced completion and the scorer file it produced is
constant to within 2 ms, against a round period of 280 ms, so each
cancellation falls unambiguously in the round that came back at
0x80. In the other runs I have only the scorer output, which took
exactly two values today (all 48 channels within 1 of the CPU
reference, or all-0x80, nothing in between), so there the
identification of the 0x80 results as cancelled jobs is inference,
not observation.

For this commit message I would drop the two paragraphs that cite my
runs as evidence for the race: the one beginning "Igor also ran a
differential on RK3588" and the one beginning "His own bound on it is
the right one", and put this in their place: 45 induced resets on 19
August, 102 on 25 August and 74 today, every reset recovered, no MMU
faults, no lockdep report from rocket or the scheduler in the runs
where lockdep was still armed, and of the 420 inferences scored, 384
matched the CPU reference within 1 on all 48 output channels while 36
returned the all-0x80 buffer of a job the reset had cancelled. Please
keep both Link: lines and add this message as a third, so anyone
following the 19 and 25 August reports lands on the correction too.

Two things I should have said before: all of those resets landed on
core 0 (fdab0000), the other two cores being bound but idle in this
single-client protocol; and two of today's five 2+3+4 runs come from
a boot that had an unrelated lockdep splat in the DP driver at probe
time, before the test, so they carry no PROVE_LOCKING cover. The
Tested-by lines on 2/14, 3/14 and 4/14 stand for that and only that.
On 3/14 please drop "differential base" from my tag comment, which
then reads exactly like the one on 4/14; and on 2/14, where the
comment is only "# RK3588, three cores", please give it the same
comment as 4/14, since the lowered timeout belongs on every tag that
came out of this protocol.

One question this leaves, mostly for Tomeu: there is no out-fence or
status field in the rocket uAPI, and PREP_BO drops the fence error,
so a job cancelled by a reset is indistinguishable from one that ran
(rocket_job_run() reads the error, but only to return NULL instead of
executing the job). Is that intended?

The artifacts of all twenty runs (scorer output per round, runtime
and genpd state, journal, serial log, today's kprobe trace) are
preserved if you or Tomeu want them.

[1] https://lore.kernel.org/all/20260911192833.105634-1-royalnet026@gmail.com/

Regards,
Igor
