Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712F3368B2
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772819988; cv=none; b=caGUgjcSqwdKi1pEnW7TzGWQ2zKPWpJqMuGQKcW8Tny0/uIhTkoTBamJR/CatsmSFf7CKTBNuZcWoCghgGXa9HV0d+Xs8cMAm332Zd//G2MzLe1sqWPJZM2XHQx+fXBPJpZj23HaCBPHMYxhZiHEz0KOe0ZOOe6g75hA6Yh74A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772819988; c=relaxed/simple;
	bh=jV7x6sL5WQmUwuqvDhw0eUFuWfTy70fhCBouF8DxREA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jL4OOmTmdPt5Zx+M/532FZ10uV/lFjWjd6U2dK5iUp77S1Iv1tkAnxru8j2FFiUYHnsTouJScveaYG5IUzL6xMQwJP/ebPWeXI7mh3V9w9E3pbWgFc4AU/ZO1Ly55f7egP2sG/3ixFq0jK4fbuXaqwKVx5yuIjonET3U3O+ak/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uu7I5Rn4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uu7I5Rn4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF209C2BCB3
	for <linux-pm@vger.kernel.org>; Fri,  6 Mar 2026 17:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772819987;
	bh=jV7x6sL5WQmUwuqvDhw0eUFuWfTy70fhCBouF8DxREA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=uu7I5Rn4kv8BzkOb2MgrTm8cUCD+dK6dxz36OZ4ewJDOmNxtGdQeMmAyiqRJ83cWt
	 6G8dljma+hNDpWCS1V537AWEtz7v7t84ZPgvgPvZCmnIFSB+aWfZPOA/oX9Abq4WiY
	 ep14Ey1HSG9n1TAjO8L+QulxbazFXmOdoEwxHvaw289YkcYWSJQ/69VpxCL4fFfVLq
	 KlyOiqgEXycDq4zEs2d4yT2PZt/wXCMybrr+aqpnVFdskY0p3CcP8kj0a+PN3++UDX
	 OafqqFvwH3UX/Sdym0e0pC7ROoePx0Hjxj9QrOM4Cgaz7bs3k2oTMP/WC5JcGE1Vnk
	 jiz3aK6qZ9n3A==
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-463a94f8475so6847281b6e.0
        for <linux-pm@vger.kernel.org>; Fri, 06 Mar 2026 09:59:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU3HgETiH52lwCh+GPWM8jJ9+vsfo23TWj0w2MsqLh42MHMI8MUWxLHPgpI5pi6lmozNaJVGBeMHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YywsoLSYUbyVNmOPxSbbRKkP+Z1SchxQYOwG5h8qrkrDVaQxa+a
	ZOsI7ySxP4ce+lfvIXpFHqgcrsLbKTedEuzti0E4AwzczBht2wUSylvIvSZMkhBKJ5MZzSjiN7U
	HUGwp3oJiAbjJNPFiu3JiZs5uHQoFPJM=
X-Received: by 2002:a05:6808:14c8:b0:464:5a7:7cd6 with SMTP id
 5614622812f47-466cd0cfb86mr3880686b6e.15.1772819986884; Fri, 06 Mar 2026
 09:59:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
In-Reply-To: <20260306-cpufreq_lgm-v1-0-47f104aed7c2@dev.tdt.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 6 Mar 2026 18:59:36 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
X-Gm-Features: AaiRm53Uvt7coDURFCxvpq6wNBeZOvwaJHR4-gEgKBgsuOcrN_DpwPDNZxpCJBA
Message-ID: <CAJZ5v0jR0eVu2oCD+c0x9MERfYvdPfNi2T9YZrO9RLQf-+iH3A@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86/cpu: P-state support for Lightning Mountain
To: Martin Schiller <ms@dev.tdt.de>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Florian Eckert <fe@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 9:27=E2=80=AFAM Martin Schiller <ms@dev.tdt.de> wrot=
e:
>
> This patch set contains 2 commits to get P-state support for Intel /
> MaxLinear Lightning Mountain. The first adds the needed code to the
> intel_pstate driver. The second adds a workaround to the x86/cpu
> subsystem to enable EIST on all cpus.

Can you please combine the patches?

Or does the first one work just fine without the second one?

> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> Martin Schiller (2):
>       cpufreq: intel_pstate: Add Lightning Mountain support
>       x86/cpu/intel: Add EIST workaround for Lightning Mountain.
>
>  arch/x86/kernel/cpu/intel.c    | 23 ++++++++++++++++
>  drivers/cpufreq/intel_pstate.c | 62 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 85 insertions(+)
> ---
> base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
> change-id: 20260306-cpufreq_lgm-c0280ef989c3
>
> Best regards,
> --
> Martin Schiller <ms@dev.tdt.de>
>
