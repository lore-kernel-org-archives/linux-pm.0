Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8377524676D
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784724523; cv=none; b=rwNfrjocVz9dHAqrZGugKT0nOODh+DirroqwFhCGTgkR75xTIaRpNENvUk7J36SkJQlMgHLcQLCSvfjpwVLQrsKJVhm9QrYJmKhkTRzXACjRL6YxhZJLXUz3QJyKWaI94jxPJWM47DJ1HgkM5nyPu7NnKqRvTRkAxN7pxXtzKJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784724523; c=relaxed/simple;
	bh=Mng/jzjXvYqUEl1a2WmIoP5Zy6eFqqC0U6qdxp5sywQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtTbKzC12LvdAnRkCHvjdT1lI9wPENRbzHJAQUdIrq7xQMakOd0KpYxgrCzIxfaXLQsA+zNOLB1PD8J/2RC/7cna5d0oXv+Lx0VO9Dzik41qAwGe5dP9XacklCx3FwXkhRYHLOa8IlZnhfReIdvT9X02E7PfIXByknp3M5rNkbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrYs6w8B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrYs6w8B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 248A81F000E9
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784724522;
	bh=R2ciK6Snd5bQhLKCNmRtjZ4ASCTtMYt4gvJ2WT5JiCs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SrYs6w8B2aTEZrW4ug51jfM5t3chTR6cYynDbMFSrPomlooCAk7Eag99uARLU3M8o
	 pPH4UySAy3nZ7Df7c5PZQ5rA1RODpVSHIvrBLuoAR1kANRcbxPS0+5Ik5/O3eT7bZB
	 rg8sFhdPlEusvAKa7wTeAwU5w1izzCRxlN3ZF1S2d972qA0ewExNHihHgNKDFWN4UH
	 SbTHDG3lLtHnfc5QvVVlccO+U4iltvL0r2pZm9DCWkQNjsPUOv0XHL+xytq87P5wfa
	 iqokH4RJFqxtHzdxeFt0LLZzbC9M1JuJ0ncKrc9IAx2UuPv2me02A2fIygwo+Czpxq
	 IWmVVgaovUeQA==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5b021916bd3so11521028e87.3
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 05:48:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp2NAaB0jwh1Hdrx1jpSbq9+tEKTe4gG40Jo58n1afaJKu2Tone8EVTgGF7Csbt7qfoMrAx8lNNig==@vger.kernel.org
X-Gm-Message-State: AOJu0YzAx1il2w1SIIb1Vvjsln8kbNwdM4Edb0gEwvXmAbAVmYJV01Wi
	WEidHVlmlnC5auD3HEKvcfyBFScjMQtRxZNMnn1+YMFdHllR9eIBXlSbYHJsqlRb+myuHQ67Aqc
	QTznUNYcGYf6WQwRstgBGgQYTj5NBoWA=
X-Received: by 2002:a05:6512:3f08:b0:5b0:f9d:f7b9 with SMTP id
 2adb3069b0e04-5b28f85feffmr5340595e87.2.1784724520592; Wed, 22 Jul 2026
 05:48:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624123135.7193-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260624123135.7193-1-alhouseenyousef@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 14:48:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
X-Gm-Features: AUfX_myrLWQPhR-yZoGA7Llcpq3D_n84vnSnLZJyg3heKkSOON3MrG9M02rN04w
Message-ID: <CAJZ5v0hE8RyBwi6imwgzADMaRzL8FrD95KeH+Eo54rfXboyggg@mail.gmail.com>
Subject: Re: [PATCH] tools/power: amd_pstate_trace: fix help path dependencies
To: Yousef Alhouseen <alhouseenyousef@gmail.com>, mario.limonciello@amd.com, 
	kprateek.nayak@amd.com
Cc: ray.huang@amd.com, perry.yuan@amd.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 2:31=E2=80=AFPM Yousef Alhouseen
<alhouseenyousef@gmail.com> wrote:
>
> amd_pstate_trace imports Gnuplot and numpy before parsing command-line
> options. As a result, even "-h" fails if those optional runtime modules a=
re
> not installed.
>
> It also handles "-h" by printing a blank line and exiting. Use the existi=
ng
> help printer for "-h", and move the numpy import to the path that needs i=
t.
> The direct Gnuplot import is unused, so remove it.
>
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

AMD folks, if this change is fine with you, I can take it into
pm-tools, but an ACK (or equivalent) is needed.

Thanks!

> ---
>  tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py b/tool=
s/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> index 875b08655..b1b201b2e 100755
> --- a/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> +++ b/tools/power/x86/amd_pstate_tracer/amd_pstate_trace.py
> @@ -27,8 +27,6 @@ import re
>  import signal
>  import sys
>  import getopt
> -import Gnuplot
> -from numpy import *
>  from decimal import *
>  sys.path.append(os.path.join(os.path.dirname(__file__), "..", "intel_pst=
ate_tracer"))
>  import intel_pstate_tracer as ipt
> @@ -260,9 +258,6 @@ graph_data_present =3D False;
>  valid1 =3D False
>  valid2 =3D False
>
> -cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> -
> -
>  try:
>      opts, args =3D getopt.getopt(sys.argv[1:],"ht:i:c:n:m:",["help","tra=
ce_file=3D","interval=3D","cpu=3D","name=3D","memory=3D"])
>  except getopt.GetoptError:
> @@ -270,7 +265,7 @@ except getopt.GetoptError:
>      sys.exit(2)
>  for opt, arg in opts:
>      if opt =3D=3D '-h':
> -        print()
> +        ipt.print_help('amd_pstate')
>          sys.exit()
>      elif opt in ("-t", "--trace_file"):
>          valid1 =3D True
> @@ -291,6 +286,10 @@ if not (valid1 and valid2):
>      ipt.print_help('amd_pstate')
>      sys.exit()
>
> +from numpy import zeros
> +
> +cpu_mask =3D zeros((MAX_CPUS,), dtype=3Dint)
> +
>  if cpu_list:
>      for p in re.split("[,]", cpu_list):
>          if int(p) < MAX_CPUS :
> --
> 2.54.0
>
>
