Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF67C28A72B
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804209; cv=none; b=qlTm3NxwDU4sWFyy9gxKetWevRvlQvDcV260JM03oThxwGvwp4NuZYATGO3nducZypfTLw/9CjDpsaWXdlLWCtG6t8fuznGNYQpY24+4nlak+RSPrpEO9E/5XBqWco1B0msP9XDmDSWKV3719rkw86er8+XaI2fAdobKgQEfi4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804209; c=relaxed/simple;
	bh=zySzlQIWDVEuXt4qW/2D5esfFoEkrRc5ro5t+wnod4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kbAgRECmXI7ayKVL0nHIRwwliJ36GukylVqbRoJ6JksXGdOgWAgW6Mdto0o2M/Zb01gzET/x2j9XGuNFlcKtkQRMbQdj3yyRzwUZvdUlU1jjyP/R9AH3X3AjtpP9V5hYUVb9EIZvBSZ6WQbhGRGK34qY7xyxD/G1dcCWzW6DogQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pj6zxKTZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj6zxKTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E46CC4CEF7
	for <linux-pm@vger.kernel.org>; Wed, 18 Mar 2026 03:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773804209;
	bh=zySzlQIWDVEuXt4qW/2D5esfFoEkrRc5ro5t+wnod4U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Pj6zxKTZHnvDqSBhkmboRA89jxo71oma1c7fgni7CHFuQ0xuPAMfrSSOm1SWMnwRe
	 OBablO86iyNGqwil4edZf5XQrZ9h9Qbr7h9j3FDpLLURuNyJZf2DY6Z7MUIaWH/MfL
	 TmDT6OkBIpW7fBk+YZQdgnVOvJa7EtE+uXhjRBWfxaacrwTdeIYdCEF8SSCG6rT/j0
	 +bwAK1Sceen0SIitGbB3lCy9FzLsf/BC2R9x1Xnmo92vnpFqLhJpcPtCHk0PcQ5KhG
	 2AGCKjTn0rEw0VnP4Ga8LCTQ4ejW1zVlw63MIcu5XfP/2SeJJkZncFIUOeJdIqKLk/
	 IwXZTiJN+/ijg==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-b97ba4c2be2so357772266b.1
        for <linux-pm@vger.kernel.org>; Tue, 17 Mar 2026 20:23:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwM4uo38TEcplrz3tFLwwTQFAS/m4NDJAO4rPJcO3+BElO4rXw0
	dk8UR/HsNP1t+i0AzCYcL9VzTyPWD4ugKiNg7OKLCPQkLCiFEU+1Gcs/nla9vilgHuDcWwgSdon
	4PPXYal61r1CjXG/qBmSCoD9Faywpe2Q=
X-Received: by 2002:a17:907:f497:b0:b97:e32f:7ee8 with SMTP id
 a640c23a62f3a-b97f4a7c84bmr96937566b.37.1773804208150; Tue, 17 Mar 2026
 20:23:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311090035.169539-1-dedekind1@gmail.com> <20260311090035.169539-5-dedekind1@gmail.com>
In-Reply-To: <20260311090035.169539-5-dedekind1@gmail.com>
From: Len Brown <lenb@kernel.org>
Date: Tue, 17 Mar 2026 23:23:17 -0400
X-Gmail-Original-Message-ID: <CAJvTdK=DDVXX6ZFVD5XkiqR7HDbwnYmSemq2qfRJ9YqhO4ujKA@mail.gmail.com>
X-Gm-Features: AaiRm523l349vVqLo9ELxtDtJvbZFIXKOorScqZtZdM5I2MWP6ptrrw0Ud_iuEE
Message-ID: <CAJvTdK=DDVXX6ZFVD5XkiqR7HDbwnYmSemq2qfRJ9YqhO4ujKA@mail.gmail.com>
Subject: Re: [PATCH 4/5] tools/power turbostat: fix delimiter bug in print functions
To: Artem Bityutskiy <dedekind1@gmail.com>
Cc: Linux PM Mailing List <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

typo:

-       return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value))=
;
+       return (sprintf(outp, "%s%0.2f", (*(printed)++ ? delim : ""), value=
));

I think you mean (*printed)++

On Wed, Mar 11, 2026 at 5:00=E2=80=AFAM Artem Bityutskiy <dedekind1@gmail.c=
om> wrote:
>
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
>
> Fix a bug in the following functions:
> 1. print_name()
> 2. print_hex_value()
> 3. print_decimal_value()
> 4. print_float_value()
>
> The problem is that the 'int *printed' argument, that is intended to be
> used as "has any column been printed yet" flag, never changes.
>
> Reason: incorrect assumption about operator precedence in the expression
> '(*printed++ ? delim : "")'. This expression increments the pointer,
> but not the value it points to.
>
> As a result, a command like 'turbostat --show C1,C1+' produces output
> with columns merged together without any delimiter.
>
> Fix this by using (*printed)++ instead.
>
> Fixes: 56dbb878507b ("tools/power turbostat: Refactor added column header=
 printing")
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turb=
ostat/turbostat.c
> index 3487548841e1d..f5cf12ab84e09 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -2837,29 +2837,29 @@ static inline int print_name(int width, int *prin=
ted, char *delim, char *name, e
>         UNUSED(type);
>
>         if (format =3D=3D FORMAT_RAW && width >=3D 64)
> -               return (sprintf(outp, "%s%-8s", (*printed++ ? delim : "")=
, name));
> +               return (sprintf(outp, "%s%-8s", ((*printed)++ ? delim : "=
"), name));
>         else
> -               return (sprintf(outp, "%s%s", (*printed++ ? delim : ""), =
name));
> +               return (sprintf(outp, "%s%s", ((*printed)++ ? delim : "")=
, name));
>  }
>
>  static inline int print_hex_value(int width, int *printed, char *delim, =
unsigned long long value)
>  {
>         if (width <=3D 32)
> -               return (sprintf(outp, "%s%08x", (*printed++ ? delim : "")=
, (unsigned int)value));
> +               return (sprintf(outp, "%s%08x", (*(printed)++ ? delim : "=
"), (unsigned int)value));
>         else
> -               return (sprintf(outp, "%s%016llx", (*printed++ ? delim : =
""), value));
> +               return (sprintf(outp, "%s%016llx", (*(printed)++ ? delim =
: ""), value));
>  }
>
>  static inline int print_decimal_value(int width, int *printed, char *del=
im, unsigned long long value)
>  {
>         UNUSED(width);
>
> -       return (sprintf(outp, "%s%lld", (*printed++ ? delim : ""), value)=
);
> +       return (sprintf(outp, "%s%lld", (*(printed)++ ? delim : ""), valu=
e));
>  }
>
>  static inline int print_float_value(int *printed, char *delim, double va=
lue)
>  {
> -       return (sprintf(outp, "%s%0.2f", (*printed++ ? delim : ""), value=
));
> +       return (sprintf(outp, "%s%0.2f", (*(printed)++ ? delim : ""), val=
ue));
>  }
>
>  void print_header(char *delim)
> --
> 2.53.0
>


--=20
Len Brown, Intel Open Source Technology Center
