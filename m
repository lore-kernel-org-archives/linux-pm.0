Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A69D3E0C60
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774030235; cv=none; b=HihWEaeuiHHRCbzS3O3MgDmn1YKXrD+TxDPf2CchyF3QR3FVBkXnRGkqqe95HmyT6s8D4jyg8ut7SeEbz3wWep2R9C3diNfR0YyeaLI/B8vi7hrEKn+xMFnH8gyU0kYDU06+EEIjeSh02klNaeLVK49/m6lCCg5Io6UOtaS0UM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774030235; c=relaxed/simple;
	bh=Jpss/77VJuvh2ZeXsO2jjwNuD4CAxEZi6FGKYUBlSww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tN371TJ9+2rJ9/47BE20W97cVDfgxfnAma/xfaUolImM6U2UXgvayHuclvaqsK/vGgNs0N1vQoqqJY1IC/47U14C7SZB/m1pMMtgNGGMoST8TQMbV384J/0q+qLIoaFijofCUGdCHy9QUsK8zNWM73Rr0Y1dCPIJws6SfPbjnMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8lsQ/sV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8lsQ/sV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF91C2BC87
	for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 18:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774030235;
	bh=Jpss/77VJuvh2ZeXsO2jjwNuD4CAxEZi6FGKYUBlSww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=H8lsQ/sVFQMBQ+pFsF/VV23y0fNr+qSnh6DY+8jqzmyseoJT2bJY8nw7IuM+i/Rpa
	 EXXCWEbCGywkPsbsHa3cbxS8BiXBD+SMl9sEOsbGmI7CM710eOR6jbAYtC/dCprr9m
	 D85GYQE/YaPEvfE7ActUG5bLvbxfD9EezM61qNmHU9WZhz8Hk1dhVkGS9jsaVJklYQ
	 hsfZvoie4/MKYvpt9/jCzIX1NfilSLxtEW0JdEtKMgraOBpfPQFaKImQR0W8qaGPzh
	 9gAih6K98EYn1UQB85uXKkaWmFxeyptlbKc/iJucJpFlFau3f24UWMEjpP5cly0MK9
	 FtcYUWD+6dBtg==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d7eb85fb81so1177195a34.0
        for <linux-pm@vger.kernel.org>; Fri, 20 Mar 2026 11:10:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU0zXyxUELdqe7AFLz9oYIHfTJtOP2uWl295Ai61kYAKGjeNRD5ZCPomnW/AEqvMGXwylgrZm1JZw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzffkWOPpjMgsPC0CUZvthgeCLV1j56iOK83Yeq0Uc8oEnnWnvq
	YyxzLiCmA+Kjm43xGSZwWVn+gZEWh7EtNrr6Hs9cXGgha5GENBPB1Kdjw/sFba1slLeM+U8DXid
	2AhAqtx0qNHcQ8f1HTHNMCWO2koPvppk=
X-Received: by 2002:a05:6820:4805:b0:67c:250c:ac4c with SMTP id
 006d021491bc7-67c250cad51mr1731395eaf.31.1774030234300; Fri, 20 Mar 2026
 11:10:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260313185333.2370733-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <43d464a89afdf955282ffe3ce0c5acd50e047500.camel@linux.intel.com>
In-Reply-To: <43d464a89afdf955282ffe3ce0c5acd50e047500.camel@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 20 Mar 2026 19:10:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hY2BWVqHQK6i_1rRCOrrtaeJq7Pe_OLz6d5Efy6t_cMw@mail.gmail.com>
X-Gm-Features: AaiRm531sFyfwtcJUJ4G-PgsAXBL0DxRUBLdbV3usF1z8wPkX4KnOzI3GvrLNZM
Message-ID: <CAJZ5v0hY2BWVqHQK6i_1rRCOrrtaeJq7Pe_OLz6d5Efy6t_cMw@mail.gmail.com>
Subject: Re: [PATCH v1 0/6] powercap: intel_rapl: Move primitives to interface drivers
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 20, 2026 at 6:02=E2=80=AFPM srinivas pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Fri, 2026-03-13 at 11:53 -0700, Kuppuswamy Sathyanarayanan wrote:
> > RAPL supports multiple interfaces (MSR, MMIO, and TPMI), each with
> > their
> > own register layouts and bitmask definitions. Currently, the
> > primitive
> > tables and bitmasks for all three interfaces live in the common
> > driver,
> > which requires interface-specific handling logic in shared code and
> > makes
> > the common layer unnecessarily complex.
> >
> > This series cleans this up by moving each interface's primitive
> > definitions into its own driver, so the common driver no longer needs
> > to
> > know anything about per-interface register layouts.
> >
> > All patches are no-functional-change refactoring.
> >
> > This series is based on top of the earlier RAPL cleanup series:
> >
> >
> > https://lore.kernel.org/linux-pm/20260212233044.329790-1-sathyanarayana=
n.kuppuswamy@linux.intel.com/T/#t
> >
>
> For whole series:
>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Whole series applied as 7.1 material, thanks!
