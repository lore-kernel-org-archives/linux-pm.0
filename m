Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F6310779
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336864; cv=none; b=VybFEm9JGmT7dcJ+CKCUjUhEfoylxQUvdApBbmTxdqbD2s8fUWbBS0k1RLoVTI/nyPHsbTWCZvhk6qxYAmOATf4WrHpXFjtepR0vFO1CnmN+340QHAih7Sly3qqN0XxLrFxwuzx523ZHLER588VqnPCbXCbs3rIdg5QllUpKAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336864; c=relaxed/simple;
	bh=pm4U8vljrqThoQzokjpEtzQeCoCnEWcenZP8ww/4k9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lt++Wwne+VT6lLBncyndrMfjp57ldyAMkNZEPtojyMTHekqKO01W5sFDEdR7BXwg8z2AbWwOOgUny+eoDAOrL+w0ep8WjRX6fEYbXonL5cjTOEhWRP7h3iqM76ea86mhUhTUqPZwozFU7w86rhrOJdA0OpkVKM8e7rF5qLjaybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVkHwiLJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVkHwiLJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC1A31F00A03
	for <linux-pm@vger.kernel.org>; Mon,  1 Jun 2026 18:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780336862;
	bh=FJai4EZrxNteMzYYq8qhvFkyeHuhupF0VyqZ/uPCRk0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OVkHwiLJbNtRQR1daEbLMYYJbeH71xzB2myG6ijTJtDs+nzh7cy716sT7CPteSb4i
	 9zBNU1nIHTfGSeTmSBp8hmIcfjkYTh6v0YnPOCRn09FQ5BMpGjMx0mFLMlfKXsr2Us
	 64VZT94Psx6DCHlj40P8bCGLnWFWN46OpMUYIa0eMNMxhk5MbFcNFLFzHxoJu11J42
	 ugmTbRxzpAsykc7thcDHxmTS6o+LXFTfTKlcQFO0r8l6EwoVRnStvyquf9U8tvsE+e
	 1FyWbjqpD3LxQ4ufxVfslaxoBtX9RHWcS43d8bCfV0AGl2clRdQP6NN9mecArcrpCV
	 /4v1Sp760+rDQ==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so1623386e87.2
        for <linux-pm@vger.kernel.org>; Mon, 01 Jun 2026 11:01:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9rvrAaXi3x+cir9q9dvNl3o7eqXHWHthvt59glhC6aKjQz1QeP6SYItYjT5AEAd0HJoat7gbw66A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyjuUn3GPBvPGCKoN1XF8Hx4kF+yVEiCvdXHar2MJ4iyhpzMfXg
	ov/qpnw2ZxeJjuS+RCE+LZGjjfCTlNZvszar6pkH0Xy0CRXj2pMJ2ljtRtg8mWEy9mdI8qV564f
	BRujT/meuAD66SuD8kX6UWEBZilaAkcc=
X-Received: by 2002:a05:6512:3044:b0:5a8:b92f:5471 with SMTP id
 2adb3069b0e04-5aa608f1fb7mr3302663e87.23.1780336860524; Mon, 01 Jun 2026
 11:01:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528183625.870813-1-ynorov@nvidia.com> <20260528183625.870813-16-ynorov@nvidia.com>
In-Reply-To: <20260528183625.870813-16-ynorov@nvidia.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 1 Jun 2026 20:00:49 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jqMcRM6sks5P7Ai5p2wLxVmy34PsByierGLvO6tnuhdA@mail.gmail.com>
X-Gm-Features: AVHnY4KfVk9OmH3E9_srGOfCDI7trpo8PRnK2g6u7Vl3uXG0PCY9qxi1Bkna5gc
Message-ID: <CAJZ5v0jqMcRM6sks5P7Ai5p2wLxVmy34PsByierGLvO6tnuhdA@mail.gmail.com>
Subject: Re: [PATCH 15/16] thermal: intel: Use sysfs_emit() for powerclamp cpumask
To: Yury Norov <ynorov@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>, 
	Kyungmin Park <kyungmin.park@samsung.com>, Heiko Stuebner <heiko@sntech.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>, 
	Moritz Fischer <mdf@kernel.org>, Yicong Yang <yangyicong@hisilicon.com>, 
	Jonathan Cameron <jic23@kernel.org>, 
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Dan Williams <djbw@kernel.org>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Shuai Xue <xueshuai@linux.alibaba.com>, Will Deacon <will@kernel.org>, 
	Jiucheng Xu <jiucheng.xu@amlogic.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, 
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>, Robin Murphy <robin.murphy@arm.com>, 
	Jing Zhang <renyu.zj@linux.alibaba.com>, Xu Yang <xu.yang_2@nxp.com>, 
	Linu Cherian <lcherian@marvell.com>, Gowthami Thiagarajan <gthiagarajan@marvell.com>, 
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>, Khuong Dinh <khuong@os.amperecomputing.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Yury Norov <yury.norov@gmail.com>, Kees Cook <kees@kernel.org>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	Aboorva Devarajan <aboorvad@linux.ibm.com>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Ilkka Koskinen <ilkka@os.amperecomputing.com>, Besar Wicaksono <bwicaksono@nvidia.com>, 
	Ma Ke <make24@iscas.ac.cn>, Chengwen Feng <fengchengwen@huawei.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 8:37=E2=80=AFPM Yury Norov <ynorov@nvidia.com> wrot=
e:
>
> cpumask_get() is used as a sysfs getter for the cpumask module
> parameter. Use sysfs_emit() and cpumask_pr_args() to emit the mask.
>
> This prepares for removing cpumap_print_to_pagebuf().
>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>
> ---
>  drivers/thermal/intel/intel_powerclamp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/i=
ntel/intel_powerclamp.c
> index ccf380da12f2..bd7fd98dc310 100644
> --- a/drivers/thermal/intel/intel_powerclamp.c
> +++ b/drivers/thermal/intel/intel_powerclamp.c
> @@ -200,7 +200,7 @@ static int cpumask_get(char *buf, const struct kernel=
_param *kp)
>         if (!cpumask_available(idle_injection_cpu_mask))
>                 return -ENODEV;
>
> -       return cpumap_print_to_pagebuf(false, buf, idle_injection_cpu_mas=
k);
> +       return sysfs_emit(buf, "%*pb\n", cpumask_pr_args(idle_injection_c=
pu_mask));
>  }
>
>  static const struct kernel_param_ops cpumask_ops =3D {
> --

Applied as 7.2 material, thanks!
