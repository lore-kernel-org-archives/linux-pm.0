Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793592238;
	b=hJGx7T9Lxy82Da6xFLm2+N8TRnZ3/nnJTAbxkFsGWK2dACyPFi/M/4U3UBvKDf0hHTi5
	 FpyGjxxtlauIWJgFu44QdvBNM1Vs/v8bIVG/ydJfzIXEFZvQ8+568r6GR9bZVvnvQcyay
	 +ZQhEnpUfiPLnpAoZImEiwLnb5EdeWRK9x9ESY8NXGbXZ1P3JugrMr+/LgZpg3Snjc68O
	 ycybsdjyk8/3LJ/9MS8ACKZZTrO9tkI+YSJDzm0lQSmqmtXlrB9XFZDj/LsbZ/Cy4/3Th
	 jqtRA4875etY3Ic+qhDripzGkrM8YhkIral/Peczltu/gw/7dskeoqvSiOTl6lKaUlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793592238;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=qsWlwY+vxPmPFxRUYpkVys4GdRvLGTlYzdsiVqsoQl8=;
	b=bOg9GqL8JNq22Bq4vdCQ0EaDD+iuiEkD1Xc5XTCD7yzpHEyrxeQ/AKZOq3f9bGS61WpR
	 SLHiWBjXmekHHjjV+8eRqIAN9qhv3wf1Cp9vCy8yJuq45Sv5/fiVq2YLlamBbp2OfBsbA
	 DGN7f3e2zcJ1f67Vp21hfkmNE/A/IfzWIUu8rWD5YXOttcSwJFn+I9xF1zWryvZuqssT4
	 BYWnJIx6HaoePF5DPJXkKy5LAW85AaVn7hHp3uDFBmyp5uNKXlksWj4oO3ZJQiLULgiXS
	 SytasR3fy+joEL4TkEE8il5ZGDgUMkiy/+0jmBI8n64olzhabuL6oHFCFg9SfTN/2Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--chungkai.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d3gtpeug;
	arc=none smtp.remote-ip=209.85.210.200
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09142606A32F
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 04:03:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09142606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chungkai.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=d3gtpeug
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-8a0589ff620so1636741b3a.1
        for <linux-pm@vger.kernel.org>; Sun, 01 Nov 2026 20:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793592232; x=1794197032; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsWlwY+vxPmPFxRUYpkVys4GdRvLGTlYzdsiVqsoQl8=;
        b=d3gtpeug6FV4i5D1jzTp7hFlhrCBwd0+Tb9izX8A8ynvMeubaXVUNucYTsmknPsyxf
         jrCQnoJoKm1IR2PNT1SMkl1P+94fcQ3GUaJsX12aFL/+ThbsLJ5AgbBCep2CKVkPWU3/
         BOmEIyw1ewRwvtB6dNaTjiYk/1uIYR/Veu/3GOLRGqnV6GUtr9WY1vp/FPP5EP2z2heR
         Ky2j88n4pfWvh0Nr1XSaHY3zst9RkHSFIyyiTxKUtTE76J2ONhKx2GXHFd4G4oBchQEP
         MLzf2x4K7COKfE1z0Z240F7b/3P7LjtWxnKnMMLDJ+yu+hr1MUXjhPonefcAWQeZ+Lso
         P17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793592232; x=1794197032;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qsWlwY+vxPmPFxRUYpkVys4GdRvLGTlYzdsiVqsoQl8=;
        b=L8cg9muahxn88OWODEcV8iLjTwuDKrbPQTdoaXMceESF9BduhN5yGs+SvSncP3wWen
         BllnPnLez3WR73zK2utYZWrK44F55gqcaFKr8OC/4L0BjY3+XfDmH649Juve3EgNr0C2
         3TIadAqhhH4lc6ATdNlB12Qzk9pGsjR79r4A1tcftf+/L6pjqa6gtUOGb2yaEGMaMWAB
         4q637zFnzaO9S0cJPlmxDg0ycRLL4clacrgO98YzyhKjHqKqrFUIs4c3ckJKQQMpbiat
         RRG6fshnnYTchDqgewzTa5jJAkBKJi0ZdTSf1OahS8s7AgzmYiL7/ITJvpdWjsIUwIwL
         IOWw==
X-Forwarded-Encrypted: i=1; AKwUvBwbGyKj3K/Vcpx7dWEV98Oc3LveOAhWCVwAPplElbsUWWTAjTi9yNTfbQXL28P4NIYvI438ezp32g==@vger.kernel.org
X-Gm-Message-State: APuU4Z8yH4lF0IF0GrtjbEx2XlnplmSsH0voQLRI/Yq+7i2IRr114fFJ
	1jbqxafBoXKaZn7UtNgfhS9+T2sayA70363DSHttPk5CUyIDFgGj9pbtfVzV86KgRyRKV3Mqb0R
	X3j0ZuoHg/xfTqg==
X-Received: from pfh28.prod.google.com ([2002:a05:6a00:12dc:b0:89e:ccf8:b3b4])
 (user=chungkai job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1814:b0:8a0:7024:6360 with SMTP id d2e1a72fcca58-8a9be589bcemr8234543b3a.19.1793592231862;
 Sun, 01 Nov 2026 20:03:51 -0800 (PST)
Date: Mon,  2 Nov 2026 04:03:48 +0000
In-Reply-To: <CAJZ5v0hLYKeuSHpxxRkbK07DuqOat7AuUp4nwz-1V6bgfgzWAA@mail.gmail.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261027090638.900747-1-chungkai@google.com> <CAJZ5v0hLYKeuSHpxxRkbK07DuqOat7AuUp4nwz-1V6bgfgzWAA@mail.gmail.com>
X-Mailer: git-send-email 2.56.0.317.g454f8302e1-goog
Message-ID: <20261102040348.4154728-1-chungkai@google.com>
Subject: Re: [PATCH] PM: runtime: Allocate pm_wq with WQ_HIGHPRI
From: "Chung-Kai (Michael) Mei" <chungkai@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ulf Hansson <ulfh@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chungkai@google.com
Content-Type: text/plain; charset="UTF-8"

On Tue, Oct 27, 2026 at 11:59 AM Rafael J. Wysocki wrote:
> Interesting.
>
> I suppose that there is a measurable performance benefit from this
> change, so it would be good to say what it is (say, an increased frame
> rate or similar).

Below is A/B data from two arm64 Android phones (6.12-based kernels)
comparing unbound pm_wq at nice 0 vs. WQ_HIGHPRI (nice -20), with this
patch as the only difference.

The workload is an automated UI test that repeatedly swipes open and
collapses the notification shade on a 120 Hz display, driving frequent
GPU and display runtime PM suspend/resume transitions alongside active
frame composition:

  Platform A: 8 CPUs, 245 vs. 245 runs (220,524 vs. 217,954 work items)
  ---------------------------------------------------------------------
  pm_runtime_work CPU wait mean    151.0 -> 107.5 us        (-28.8%)
  pm_runtime_work CPU wait P99     1,867 -> 1,102 us        (-41.0%)
  pm_runtime_work CPU wait max     15.08 -> 5.77 ms         (-61.7%)
  pm_runtime_work wait >= 2 ms/run  7.51 -> 0.94            (-87.5%)
  pm_runtime_work wait >= 5 ms/run 0.457 -> 0.008           (-98.2%)
  UI rpm_resume() waker wait P90   662.7 -> 156.7 us        (-76.4%)
  UI rpm_resume() D-state P90      717.4 -> 213.7 us        (-70.2%)
  FrameTimeline app missed/run     0.204 -> 0.171           (-16.0%)
  FrameTimeline SF missed/run      1.086 -> 1.074           (-1.1%)

  Platform B: 7 CPUs, 196 vs. 245 runs (85,957 vs. 104,452 work items)
  ---------------------------------------------------------------------
  pm_runtime_work CPU wait mean    134.5 -> 100.9 us        (-25.0%)
  pm_runtime_work CPU wait P99     1,809 -> 1,122 us        (-38.0%)
  pm_runtime_work CPU wait max     15.77 -> 3.71 ms         (-76.5%)
  pm_runtime_work wait >= 2 ms/run  3.40 -> 0.53            (-84.5%)
  pm_runtime_work wait >= 5 ms/run 0.189 -> 0.000          (-100.0%)
  UI rpm_resume() waker wait P90   207.5 -> 23.3 us         (-88.8%)
  UI rpm_resume() D-state P90      217.1 -> 73.3 us         (-66.2%)
  FrameTimeline SF missed/run      0.551 -> 0.531           (-3.7%)

> Essentially, we're talking about redistributing CPU time between
> tasks, so some tasks will get more latency as a result of this change,
> which means that it is not an obviously right thing to do.

Agreed, this is a scheduling trade-off: pm_wq runs arbitrary driver
callbacks and genpd work whose cost is driver- and platform-dependent,
so the impact on other tasks cannot be assumed negligible across all
systems.

If changing the global default is undesirable, would exposing pm_wq
with WQ_SYSFS (so platforms that need it can tune
/sys/devices/virtual/workqueue/pm/nice) be a cleaner alternative?

Best regards,
Chungkai
