Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619130;
	b=nnlTr9qplh7Mn2IPDLh6K0tVSjmhj8yzyDVxnBPvPzhdTb2+D7M1ukxXpYwvl9t/nE/D
	 jsinSxZ69r5xC+rAnByLkOXuoLOsfWfKu3DNdrMdCelLYzRiS0zVJmL4roWSlpySfvRSg
	 FBuOOSD1sQIL0Y5TtlbIcY4eL/PCfd6P4X6qW+L2EnRJc1jL7fesRQp5L2aUoPzr2XOdb
	 ir6K/Xr1AcfFa/iE9n0J3ubwMNqXNNRStko47l8Y7DImQAQyxdW4E5Z3w16DaIk+tuvbp
	 ai+UcB4VzcEf4lxj4PigOw9IfIBibFTVEekZQw8h5OxYao7qSdUBpRWNHxkAwMcYFnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619130;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7wWR/kabT1aDgwyJI2mMDwpL+9XIqIMRnR+gF3/USXw=;
	b=k5uxX3hwWxDjmSQK8KHu4idHFnHzIGYUT68fGR9OKWatkJag6Af7RLmYF0HHI2tcnvfm
	 EVoi1BqYysqjTNYJsAVVrO2cGbootbzeVqULBxuDAQc+ioCtp36Mju3TRx5QTeNj+QJTi
	 3keVLZtmfe3VJGa7rBuLhJEZtBo3junFSetx7vKp2y/H/FuZ78maoCvkEfrRo09q/TLFU
	 Iwe7Q2F6LFZ2VVD7oJza7mjU3oFPntWOOR8Rg+nwsECEKVZe5tTlIswULLf5ogCiMWCzS
	 H7r+0faxuSVarwfQ8KVnYxKSYu9+2wvaxYfj+XThLZM8GJufGyNBkFmwxoQw2jMDvBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6CNi0ZQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DF6606A33E
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 11:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X6CNi0ZQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795B11F00A1C
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 11:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793619129;
	bh=7wWR/kabT1aDgwyJI2mMDwpL+9XIqIMRnR+gF3/USXw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=X6CNi0ZQTufe+wV+Zotl8HMHJ0fTIFI1iv3bs55PrjmsUmevXB45h2dv8sIVt6O8u
	 KNpy5K8eZHbAzR38RlZfF/S0KZup+6o3C1cXtBJuXg3QP775WTPiq1r5KYuSu2TyNJ
	 kAxXToV+yZXK51trVLF25Hr+gKbSrUgKs8jKHr4ihZYfW4kON0HkfYUvOZT9Xgdp18
	 jZf1uQIBNKFbKgV1oFuA1i03Ue/VjpaaS+pfZugYRAxulLY7oNoMrm0GHsvY3IVWo2
	 2hQj3ovJ9LP6qgYjK90P2uIILlndn2nEWlCZygez29v2M1Hl9E+/huIgK83cbUp02S
	 eKo/msv0egqBA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so2786700e87.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 03:32:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwjxIISz7GVpkHtDhUUMLZh/Y28Ixb8gS1ZeEi8Ds7tfEP7Ja5yH0fWWquArPRnKN6jbw8hOjVYAg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/7446XA1fv/Ui0TvZhtYRw7aH0sYxxT98tEW7oOSN3EABxAOKA
	8BU5qxgJSOfNHIOVFJaGqBDGblwcx2Tfg2rmzMPfoiZ662QC5/yxQngoXrDw5GWCQnZkMOqi9ak
	gBqo/eYdrSKuTrefWx3vmtn/TfG8iBZs=
X-Received: by 2002:a05:6512:6690:20b0:5bf:dc07:3c08 with SMTP id
 2adb3069b0e04-5bfdc073d90mr1916977e87.48.1793619127876; Mon, 02 Nov 2026
 03:32:07 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027090638.900747-1-chungkai@google.com> <CAJZ5v0hLYKeuSHpxxRkbK07DuqOat7AuUp4nwz-1V6bgfgzWAA@mail.gmail.com>
 <20261102040348.4154728-1-chungkai@google.com>
In-Reply-To: <20261102040348.4154728-1-chungkai@google.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 2 Nov 2026 12:31:55 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfbUk8ickkCxojHevJ2zrmbCECxJfUySGwp-0W8D3cww@mail.gmail.com>
X-Gm-Features: AclHuK9ncUO_Qs_j0WFYocdd5wYCsH6AIN3-nn7HRtOBIc8G4tXtRUPLZ82zG3k
Message-ID: <CAJZ5v0jfbUk8ickkCxojHevJ2zrmbCECxJfUySGwp-0W8D3cww@mail.gmail.com>
Subject: Re: [PATCH] PM: runtime: Allocate pm_wq with WQ_HIGHPRI
To: "Chung-Kai (Michael) Mei" <chungkai@google.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulfh@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 5:03=E2=80=AFAM Chung-Kai (Michael) Mei
<chungkai@google.com> wrote:
>
> On Tue, Oct 27, 2026 at 11:59 AM Rafael J. Wysocki wrote:
> > Interesting.
> >
> > I suppose that there is a measurable performance benefit from this
> > change, so it would be good to say what it is (say, an increased frame
> > rate or similar).
>
> Below is A/B data from two arm64 Android phones (6.12-based kernels)
> comparing unbound pm_wq at nice 0 vs. WQ_HIGHPRI (nice -20), with this
> patch as the only difference.
>
> The workload is an automated UI test that repeatedly swipes open and
> collapses the notification shade on a 120 Hz display, driving frequent
> GPU and display runtime PM suspend/resume transitions alongside active
> frame composition:
>
>   Platform A: 8 CPUs, 245 vs. 245 runs (220,524 vs. 217,954 work items)
>   ---------------------------------------------------------------------
>   pm_runtime_work CPU wait mean    151.0 -> 107.5 us        (-28.8%)
>   pm_runtime_work CPU wait P99     1,867 -> 1,102 us        (-41.0%)
>   pm_runtime_work CPU wait max     15.08 -> 5.77 ms         (-61.7%)
>   pm_runtime_work wait >=3D 2 ms/run  7.51 -> 0.94            (-87.5%)
>   pm_runtime_work wait >=3D 5 ms/run 0.457 -> 0.008           (-98.2%)
>   UI rpm_resume() waker wait P90   662.7 -> 156.7 us        (-76.4%)
>   UI rpm_resume() D-state P90      717.4 -> 213.7 us        (-70.2%)
>   FrameTimeline app missed/run     0.204 -> 0.171           (-16.0%)
>   FrameTimeline SF missed/run      1.086 -> 1.074           (-1.1%)
>
>   Platform B: 7 CPUs, 196 vs. 245 runs (85,957 vs. 104,452 work items)
>   ---------------------------------------------------------------------
>   pm_runtime_work CPU wait mean    134.5 -> 100.9 us        (-25.0%)
>   pm_runtime_work CPU wait P99     1,809 -> 1,122 us        (-38.0%)
>   pm_runtime_work CPU wait max     15.77 -> 3.71 ms         (-76.5%)
>   pm_runtime_work wait >=3D 2 ms/run  3.40 -> 0.53            (-84.5%)
>   pm_runtime_work wait >=3D 5 ms/run 0.189 -> 0.000          (-100.0%)
>   UI rpm_resume() waker wait P90   207.5 -> 23.3 us         (-88.8%)
>   UI rpm_resume() D-state P90      217.1 -> 73.3 us         (-66.2%)
>   FrameTimeline SF missed/run      0.551 -> 0.531           (-3.7%)
>
> > Essentially, we're talking about redistributing CPU time between
> > tasks, so some tasks will get more latency as a result of this change,
> > which means that it is not an obviously right thing to do.
>
> Agreed, this is a scheduling trade-off: pm_wq runs arbitrary driver
> callbacks and genpd work whose cost is driver- and platform-dependent,
> so the impact on other tasks cannot be assumed negligible across all
> systems.
>
> If changing the global default is undesirable,

I'm not saying it's undesirable, I'm just saying that there could be
more analysis of its impact IMV.

The FrameTimeline numbers don't seem to be changing significantly
although there is measurable improvement.

What about other workloads?  Are they affected in any way and if so then ho=
w?

> would exposing pm_wq
> with WQ_SYSFS (so platforms that need it can tune
> /sys/devices/virtual/workqueue/pm/nice) be a cleaner alternative?

I'm not a big fan of this TBH.
