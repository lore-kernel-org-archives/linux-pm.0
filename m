Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E172D8370
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 13:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615857; cv=none; b=n2Um599hXKxe42gYFSIylwO9r3M/4oBSbAKZVd6gkMVlUZVp5T9UZ09en2q4/SucxJz7O5FByOWsDNeRHdeeTGfHOEtPHkFkVvuDJ2FH1JmVXR6LCE5r0hQCqDpmbt1nszOzxfRXMSYuOx53qIxPu/0AUPaQgtWss3g5DzLoDaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615857; c=relaxed/simple;
	bh=EM4/3d2ND1Vqe0ECw+jS0Rvh0VL7yVDqyMiSuG9ky/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JbTXRH9yXGzaOMiMwnPy/CvmYfVX7YpE33V7hUxd/LAX1KfBjg5z+4nJFp64PWWd5GbjR8gynh7obPS+ZeTYuuH/jMBQz9ZA/vEChFmZP0W05McxIBBzp6h2LPwv9UG0a0qo7m7Rwa0nLaOr3ydhARTnNTP7ILAGhFBWIDMav8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW71+EDm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW71+EDm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9C71F00A3D
	for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781615854;
	bh=CN657zUEBuZTy0QAI2PyjBlS7abDzoX5DB3vaiofMYU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aW71+EDm/vR05HkpCK4bFnRkQ0+DgXWz4Fga0CsyC9oGma0204yQAnOxYeDtUxHkw
	 j/BN5ubAZFQvkbCYAXEGNBHadHft6dXrLKMXRDs+sgw8fse94g1rbjm4SguBXocRKq
	 8295JAtj8mbMmbxkFad0B545ARRzzqKrOUCDmAQQFe02V/isQYF2aj1WFXrDt2x/tP
	 wzbK2g8oUaNlyqUuJq5vJhI2zxvsHSH7b+ke5+h7wpmWY6+2QjAe3xEs9uQhXvOomj
	 T1WWBE+5SZ07IxQSOdyXdn96Q/H4GYOVWeLx32laC6SR++pYzVvKVs5ASRJrWCur87
	 XWa/WBhpsEeNQ==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aa612bf6efso4225105e87.3
        for <linux-pm@vger.kernel.org>; Tue, 16 Jun 2026 06:17:34 -0700 (PDT)
X-Gm-Message-State: AOJu0YxQSgWiEa9KRQ7OBMUYZD9P8YI3BXUPULVqWbh4fJDaUn1GwHhK
	OX56DPIuPl/gnCZvpVeUnDPfyfJEZUbvr4hsNZArt7I+4m2rHMazQPV+m7YBmV0vms7swt+14mw
	8FJ+J6QOsxIIejNHhh0Ps3w+5rVRozsg23RZ+Zrf5yQ==
X-Received: by 2002:ac2:5ed0:0:b0:5a8:fbe1:15a3 with SMTP id
 2adb3069b0e04-5ad30dd6babmr2978224e87.39.1781615852832; Tue, 16 Jun 2026
 06:17:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616131514.1677558-1-vulab@iscas.ac.cn>
In-Reply-To: <20260616131514.1677558-1-vulab@iscas.ac.cn>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Tue, 16 Jun 2026 15:17:18 +0200
X-Gmail-Original-Message-ID: <CAMRc=MchoNo0eu4hf7jMXXiM-RTiM5AzheUNXU6vRdrw19vfSA@mail.gmail.com>
X-Gm-Features: AVVi8CeEb27hnDocnhrZjAFLoAL7S5Tlx8hr40F2SvR4FmHI3gBPfUipGGqGnD8
Message-ID: <CAMRc=MchoNo0eu4hf7jMXXiM-RTiM5AzheUNXU6vRdrw19vfSA@mail.gmail.com>
Subject: Re: [PATCH v2] pwrseq: core: fix use-after-free in pwrseq_debugfs_seq_next()
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 16, 2026 at 3:15=E2=80=AFPM Wentao Liang <vulab@iscas.ac.cn> wr=
ote:
>
> pwrseq_debugfs_seq_next() declares the 'next' device pointer with
> __free(put_device), which causes put_device() to drop the reference
> as soon as the variable goes out of scope. Returning 'next' directly
> thus gives the caller a pointer whose reference has already been
> decremented, resulting in a use-after-free.
>
> Fix this by removing the automatic cleanup and returning the pointer
> directly. The reference is now properly released in the stop() callback
> of the seq_file operations.
>
> Cc: stable@vger.kernel.org
> Fixes: 249ebf3f65f8 ("power: sequencing: implement the pwrseq core")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
>
> ---
> v2: Drop __free() and no_free_ptr().
> ---
>  drivers/power/sequencing/core.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/power/sequencing/core.c b/drivers/power/sequencing/c=
ore.c
> index 4dff71be11b6..e8721368f08a 100644
> --- a/drivers/power/sequencing/core.c
> +++ b/drivers/power/sequencing/core.c
> @@ -1008,9 +1008,7 @@ static void *pwrseq_debugfs_seq_next(struct seq_fil=
e *seq, void *data,
>
>         ++*pos;
>
> -       struct device *next __free(put_device) =3D
> -                       bus_find_next_device(&pwrseq_bus, curr);
> -       return next;
> +       return bus_find_next_device(&pwrseq_bus, curr);
>  }
>
>  static void pwrseq_debugfs_seq_show_target(struct seq_file *seq,
> --
> 2.34.1
>

Where will the new reference be dropped now?

Bart
