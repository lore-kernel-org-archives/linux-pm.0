Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB420335BB4
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727065; cv=none; b=s7odRDtHvuUHpgVkQ5p5DcpSy74ZvpkhH8TnObfl8JkUhcubLDpRgZnXNl+UMssQfsWaOXcKfJ5BIVArmizaQiiwtfh3XIU/eJxkv2O1vmKzsMekgwdPSNv045qtLA3JG56BYZ5fXYBkePnANvW0/JgKsTNf1uWIxZCUz+AmQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727065; c=relaxed/simple;
	bh=31d5IuqC1wUQ3t04MMXovT6AAvbZncgvCgLiIn8iJfM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fr7zSCQRukeaivvJhlnhUrBLmqYt63vyq/merAzW54OJFQr4AkrM0UDJWgocudzeKhbhVXgJuzxLGVz+0HtHkDLx5jGQMMZ4OMqkf/0DQ0PKBp/mDt/2XdXcQXfRWmsyBrdEDK2SmZ/6r6rSZyav3+TOjoK9Wl7oLiEADg/wI80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BS9meq3J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BS9meq3J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CADD1F00A3A
	for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 13:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784727064;
	bh=rDPXtrURAOR3loMTBgMcjS6utOdp6bmi2HxcjdGau7Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BS9meq3Jw7CqNt93I606QN0L/os3RKlbg/ryHyS2WcS0FQBmYuBHpJINdD/jUs4Vs
	 4aH1O5vNW93qnMj3oaTxw9vli0FwhK8o1kmlO55pGjoMnWRWQicxQX8qvWToiS7ylv
	 ajbAgAxnlKc54zJaQ5Y1L/EU5zoTSuS1mjCkAf9Z0g+mzbflmGuMwhT88EkJVnliRy
	 4NYBZfHSC/Gm+0HPpW1Ip9NIYSoQhZAiMzTF+I5jEZGVXzS+b7G3li+bJzKkUJ9YVC
	 T0EbxbHmOxh/sEd+sbVhvoiG56Pxj8sXYVY/TbfJ+jedIHY8INOCwUkbZ6KTYZIMA3
	 eDgp6XNeZNLRg==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c7ac9b8c3so85067161fa.0
        for <linux-pm@vger.kernel.org>; Wed, 22 Jul 2026 06:31:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpJMhqNOpRPsU0WksfRZ/rpyqVt6mqTXIpOD1RG4vS6i5s13M2jyiRQRQ49ya7cDOK+5mCH5/9Asg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9amrYlttFSDlyr1X5hCLk9slIgjBs+Bbpi2eYK5yq2r/11NlZ
	70yqYrB4MVx2fDhfyEjm6GaX+e/dHCg2X2O6AV5WIRNofKJOdIJXxnLlg/b4gmonxKpqypY5Go4
	XTqLnewdQgwwP1FcaGal5yqGMRL+epo4=
X-Received: by 2002:a05:651c:881:b0:39c:650c:454e with SMTP id
 38308e7fff4ca-39eb2768f76mr42061291fa.13.1784727062890; Wed, 22 Jul 2026
 06:31:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611033213.11252-1-ankun@uniontech.com>
In-Reply-To: <20260611033213.11252-1-ankun@uniontech.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 22 Jul 2026 15:30:50 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jEFLQC=-p=Ybxi_JMcLZk-=Vc1MxngTEGZS=obr8WuPQ@mail.gmail.com>
X-Gm-Features: AUfX_myNQOcj4BeOp0OmJ48mdCquGlM4AjBedVSnZ1rqhLYQNKMbMP4DQRhNX5Y
Message-ID: <CAJZ5v0jEFLQC=-p=Ybxi_JMcLZk-=Vc1MxngTEGZS=obr8WuPQ@mail.gmail.com>
Subject: Re: [PATCH] PM: Avoid TOCTOU race in pm_wakeup_irq_show()
To: ankun <ankun@uniontech.com>
Cc: rafael@kernel.org, pavel@kernel.org, lenb@kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:34=E2=80=AFAM ankun <ankun@uniontech.com> wrote:
>
> pm_wakeup_irq_show() reads the global pm_wakeup_irq variable twice:
> first to check if it is zero (returning -ENODATA if so), and then again
> to format the value for sysfs output. Between these two calls, the
> wakeup IRQ could be cleared (e.g. by writing 0 to the same sysfs file),
> leading to a time-of-check-to-time-of-use race. The result may be a
> printed value of 0 despite the check having passed, or other
> inconsistencies.
>
> Cache the value in a local variable after a single read, and use that
> for both the check and the output. This closes the race window and
> makes the operation atomic from the caller's perspective.
>
> Signed-off-by: ankun <ankun@uniontech.com>
> ---
>  kernel/power/main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/power/main.c b/kernel/power/main.c
> index 5429e9f19b65..08a25117e38c 100644
> --- a/kernel/power/main.c
> +++ b/kernel/power/main.c
> @@ -683,10 +683,12 @@ static ssize_t pm_wakeup_irq_show(struct kobject *k=
obj,
>                                         struct kobj_attribute *attr,
>                                         char *buf)
>  {
> -       if (!pm_wakeup_irq())
> +       unsigned int irq =3D pm_wakeup_irq();
> +
> +       if (!irq)
>                 return -ENODATA;
>
> -       return sysfs_emit(buf, "%u\n", pm_wakeup_irq());
> +       return sysfs_emit(buf, "%u\n", irq);
>  }
>
>  power_attr_ro(pm_wakeup_irq);
> --

After the change though a stale pm_wakeup_irq() value may be printed
(if it is updated in the meantime), so why bother?
