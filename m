Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC95A429801
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 13:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777557476; cv=none; b=OLLkQIqggrvCKD3k42CLY9HO3apodMt1N87isjCzkNAriB/Bw6KkowmnhZBu4viHD5i5pcCSd1uT3s3JZSVEfN4ZfLoceuaha8ph0f+If1xRMjFNo3QP3kXsHFWfgTFP2SC+UTQni5pfbQAjhJx8uj5IfBvOasEByjzTK5pOFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777557476; c=relaxed/simple;
	bh=ge29YIxBH3iQ1LnhDffsAcTCGa9EhJtWr2KykorkGaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E/M/j48au/MyS4bQgTImPdt3dQCWdNEmlV17YixHgYgb+KzxMIC2Q9iI3zycsCf45dKYC9hboORyojEq+1gi/k1V6wJ2eqV/+vjJKaKKiVYr63fRj+glwDhXsM+iOlZgRfPO96vU60WwX2T4r8x0Eq/i9ktpvQSsRI6hePVWgWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SvwduuuL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SvwduuuL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA1EC2BCF6
	for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777557475;
	bh=ge29YIxBH3iQ1LnhDffsAcTCGa9EhJtWr2KykorkGaU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SvwduuuLwA6Pelg/9PMBb76YUtL7/7SdeoA/KJ5em6fzeMHQ1wLlTkY42C4AA/R8H
	 dUosG0iHrrEnOHzRuWt5pVxNSf+F0gDq77MgUzorDP/1cuNVOxa0MMaTBKzgonp5LK
	 8hHP9y5zbAFArDYo/XyhjjAg5h8KnXfvHxbtk2jZ/+c6Nv+eJESSp9OH2qQ5UMrHjs
	 ZVd1KuWCpEhDtbSVm54W81PS4lEEfeud1CG7g+tST3P9G0+TdKmFarmN7M+a0P3nBP
	 bNM0Ei8WVsGWLw+MCQDqk0MeLew/Omnmrmfrfpuk2UH9b1557Jxcs9h9japc4JjWrh
	 VleZH2GC+DrAA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38e8292423fso7976811fa.0
        for <linux-pm@vger.kernel.org>; Thu, 30 Apr 2026 06:57:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9EwEOomjBTxrve6qt5elaGqChAtWNtuqgcyaGETHXdY/xi0zSBgvQZbm9mUzFikBjy439ZAp5Clg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzebN+/bQopoIPt5POa3v8UuhqTsNutTTIiBE5zoJhAP3PhBZ+U
	RsVujLFF/YGHkL+zGc5SXJXVFMLUAX/Z9+LtMQZ8sqY6MEIn3SF7MrHkLltLwdCjSzxTBLDv5V+
	x+ACTT4OncKMWxjG818NY5TeIuB5HXFM=
X-Received: by 2002:a05:6512:1394:b0:5a4:176c:99ab with SMTP id
 2adb3069b0e04-5a8522c5bdcmr905626e87.4.1777557473917; Thu, 30 Apr 2026
 06:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12879883.O9o76ZdvQC@rafael.j.wysocki> <CAGAxtY2SEkx7OgMgM5ypA8qsBN0h6pcs111VjnhD-5ZGq7Je6Q@mail.gmail.com>
 <CAJZ5v0ikAeu7cW9K6sfKYbbsVK51GOsFrX-qv3KJ7cVr-gRHew@mail.gmail.com>
 <6010375.DvuYhMxLoT@rafael.j.wysocki> <CAGAxtY2N-=3taOBCTFZzEmm4NqJ-KhtsWq0fNts_tn3nAxpkTA@mail.gmail.com>
 <CAJZ5v0j2MKGRFRRVT4rFuzr2OwJg7ufAfDKUS0rgAsg-EBH6Kg@mail.gmail.com>
 <CAJZ5v0jhjXap6gSZ5unR7cE+CQQPk1tDnAXLm9rkGsC2AnZTew@mail.gmail.com> <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
In-Reply-To: <CAGAxtY3h4sEphqKL-jiSn4p0NT9mdZtOFrVxW7CDo22XdL56iw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 30 Apr 2026 15:57:41 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com>
X-Gm-Features: AVHnY4JIu9d3USeTjQ79Co-kPsveECHPlQxCbNA31ZDe-AMFp5TVwBjxdrR76IQ
Message-ID: <CAJZ5v0ixuF=AQf0_VcPH=4jo5X-HbEB3WvJAnk8_fZes+bjyLg@mail.gmail.com>
Subject: Re: Pressing the power button causes the device to freeze completely
 (schedutil involved)
To: Evgeny Sagatov <evgeny.sagatov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thorsten Leemhuis <regressions@leemhuis.info>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Wysocki Rafael J <rafael.j.wysocki@intel.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 30, 2026 at 1:41=E2=80=AFPM Evgeny Sagatov <evgeny.sagatov@gmai=
l.com> wrote:
>
> I noticed that for powersave mode, I'm getting the following values:

I guess you mean with the powersave governor.

> cat /proc/cpuinfo | grep MHz
> cpu MHz         : 2798.689
> cpu MHz         : 1999.659
> cpu MHz         : 1999.797
> cpu MHz         : 2741.103
> Also, there's now no difference in the single-core benchmark between
> schedutil, ondemand, powersave and performance modes. The benchmark
> always gives a very high result.
> This wasn't the case before; the modes had different performance levels.

I would expect schedutil, ondemand and performance to give similar
scores, but for powersave I would expect the score to be lower.

With the same patch applied, can you please switch over to powersave,
reset the stats and then capture the output of

grep -r . /sys/devices/system/cpu/cpufreq/

Also, I'd still like to see the output of

grep . /sys/firmware/acpi/interrupts/sci*
