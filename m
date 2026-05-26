Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A443388E5A
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779793976; cv=none; b=T84o/8LY2WGJgMunGbJ55/2hg4v7+OUXvJeW2h9RRopTNOiSVSIQ+KzonLh8oeQ59IUm/MIKQD3LOBXpEZFLRNilNOXQFMSALAJxWssm1t/Fn9IyLhPpzd15+9STHVZypx5rELODGxZGXEBTHruvaUn6Z1FFEa5z4tu1NZuJcKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779793976; c=relaxed/simple;
	bh=6DHcLqW2hF6arW2oI1mYZlWVbcgF/kCF3yAdubQuJC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=It0F5nzFfNCKo9Zpwc6hu4Qy2yp8MnvWiVenCBdbV5cJ7v800W6lY/hgR14widaPWncOw/fR2F9OW8NExtdBVkixL0qBA2no6MTdO4bFntVmRmKFIRX84fksnt1m3AM607FcmbgeKV2qTvdqEWYWbgJZPtU6p95bQLa+nHZb6Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjIJHwin; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjIJHwin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E09C1F000E9
	for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779793975;
	bh=HuXE1RIeo32t9S/mLJp4qTohd6ZFYKZYOeaolLQzZRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MjIJHwinbMRdAs+ZdMRjOMkyZyg654kXJ7g/krCs2Aa0cWdMoGsWk9slWwfyiK0jT
	 v9UbAigt8trfKslhajALhY+BhOfIVmmb86dQVTDE/IUo9Ma9ZQJv372M3X6ebOL30O
	 tResSCiRCRMPfiFIU9eguGaqMao37OjCn+KlNDWR2Efj8aM2Cfi+YWzahf9y7vpcAl
	 YrPSmhq3BIhL9zeLIOeOCq5Xo9kFjsbelaLOF83QY2OYYhJtAvmFCBOjABU5f+H/38
	 XfU9P53jepoDtesvgsgrVzh37aTwXpuSV2/DUjGZzuthKt2OstYnzKtsdqIqsOHe3/
	 h16Gh77yBLQ8A==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a8738c178dso9156569e87.1
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 04:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8n1zkSKnoouufiagKlc5f1u/QCda4V+hdzzELypE3V+wIYFjfo+Oou8SnTRwXC+DhVoKCtAGF/Tg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyAoHjUN6LKO6EWP3S0mYshZBPYuIjyU/ulSbytfObRhigY1xbV
	ucY0bejDqXxnhDJX+TbwH6PzhCTYAzJAF9oQMie35szyJc3eHdW+qc2LHL7EGibfYc6UqpRbVUw
	TecLgVfYKYRLZcMfgtZpZqMb2mSCIJ54=
X-Received: by 2002:a05:6512:39d0:b0:5a8:f243:eea6 with SMTP id
 2adb3069b0e04-5aa323d4962mr5880150e87.24.1779793973568; Tue, 26 May 2026
 04:12:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520081254.13493-1-l1rox3.developer@gmail.com>
In-Reply-To: <20260520081254.13493-1-l1rox3.developer@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 26 May 2026 13:12:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i6_c8ScWB02GW6ryrwbM0ZHYpgn-pmop+U3WCTBwdraA@mail.gmail.com>
X-Gm-Features: AVHnY4JZXPag6083P7d753YAvjazRtqVbNeYvP-0z9_VQh4NRy22tivnIG7vx5o
Message-ID: <CAJZ5v0i6_c8ScWB02GW6ryrwbM0ZHYpgn-pmop+U3WCTBwdraA@mail.gmail.com>
Subject: Re: [PATCH] PM: hibernate: make LZ4 available for hibernation compression
To: l1rox3 <l1rox3.developer@gmail.com>
Cc: rafael@kernel.org, lenb@kernel.org, pavel@kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 10:16=E2=80=AFAM l1rox3 <l1rox3.developer@gmail.com=
> wrote:
>
> Without this, CRYPTO_LZ4 had to be manually enabled in the config
> to use LZ4 for hibernation compression. Add the select so it gets
> pulled in automatically when hibernation is enabled, just like
> CRYPTO_LZO already does.
>
> Tested-by: l1rox3 <l1rox3.developer@gmail.com>
> Signed-off-by: l1rox3 <l1rox3.developer@gmail.com>
> ---
>  kernel/power/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/power/Kconfig b/kernel/power/Kconfig
> index 05337f437cca..530c897311d4 100644
> --- a/kernel/power/Kconfig
> +++ b/kernel/power/Kconfig
> @@ -42,6 +42,7 @@ config HIBERNATION
>         select CRC32
>         select CRYPTO
>         select CRYPTO_LZO
> +       select CRYPTO_LZ4
>         help
>           Enable the suspend to disk (STD) functionality, which is usuall=
y
>           called "hibernation" in user interfaces.  STD checkpoints the
> --

Please check the sashiko.dev feedback on this change:

https://sashiko.dev/#/patchset/20260520081254.13493-1-l1rox3.developer%40gm=
ail.com

and either address it, or let me know why you don't think that it
needs to be addressed.

Thanks!
