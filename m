Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEC1364EA0
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 15:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933371; cv=none; b=iFNT14O4f5Lc70pD9dqyWNkdhz2O+3gb7JgR8G5LQ/SFujgYMeQ+Yg1TUSuuGMIiOUYDLG24Qo4ILXcdYx3R7rX0uj9f/LevNfqh7pm5Vf2oJJYo9WNJzPqNaVj6cBXoNQqLdbKM8PNpQHy2AG6z7s6pzfgl7Azp5+Kc/p94DNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933371; c=relaxed/simple;
	bh=rXrA+pF4Oh+RRqzT6nplO+woFz6rjNZB27Fpyk153f4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apxj3cIe1XN59V9xgWqIBg+lf7cLpqk9RSEOqoMrCc2XOAWBPo7JvkiV9ZS820Dy5wEZb1fgE9diQIH2wOYwl0SM3H00Dnt/A1173Y4hBNvzyAbUALd2WxzkcmlioJLV/92OdlGEki2kVJRhEMPlN1JVk9wB0hGLn+lWvRveI3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWkB00SQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWkB00SQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37678C2BCB0
	for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 15:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773933371;
	bh=rXrA+pF4Oh+RRqzT6nplO+woFz6rjNZB27Fpyk153f4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LWkB00SQJIjdrLElMA5kUAzU3mpdvM1vgLZBC3Doj2enLYg8MkHUMnN+aB1TmaN5W
	 apbFcsMN4WnTr4EShlWflWABvF7XzUwWCMoykTIZ0EgpEr4nxjl6fLjGk2Ka5BtTLd
	 pD9U+wnQyWydIcILzwzZlU2pik+Y17NLrg24yy2YGrc8gG9ZsYW7b9T1uDLBT4Dnt9
	 FktILdCVvJp5Spfc47y95TgL2Gg7ryg/6oIR3GGV7ASmM3z7G2JpXE+mL0YSkZ8p82
	 8TYnMLuuPptLYJTGW+pGsdQNLnWagYouHcGvCXSlm2wsYXSW0WkVI75htf97laDqQy
	 ET7fO4et0xIAg==
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-67bb5c2e0fdso406246eaf.0
        for <linux-pm@vger.kernel.org>; Thu, 19 Mar 2026 08:16:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWZivhzTZkVcB5gAmJWg7LUcoam8IT4wLby6XgLvUwjj/o0Y3NzxkAWXx6JtIQ+5VHYC+8190epyQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzdA/9ptOf84BPNIztdlD9clxtBi2Fs+rL5neeetFi2i5WvamFc
	/ppxAsZc9xc5anqXvrnQYS4lS7dbE4k/4s9xpWg8faGEyRuPor+JB+tIl9BazAQXq0VcdJRYD7S
	w6kGmKo07b5GPIhY0sIvjZgf7nfgCPr4=
X-Received: by 2002:a05:6820:8107:b0:67b:b96c:271f with SMTP id
 006d021491bc7-67c0db09c45mr4908560eaf.55.1773933370332; Thu, 19 Mar 2026
 08:16:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314201225.38822-1-ebiggers@kernel.org>
In-Reply-To: <20260314201225.38822-1-ebiggers@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 19 Mar 2026 16:15:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gN+LUqh8eeW8LkDYrnn3KTWoOcLF8azjD4WXZCbMRskQ@mail.gmail.com>
X-Gm-Features: AaiRm507kB1rE1qtij5eEBSl9kK8lLNMYnEBZ9NZKCIqM1hwWCO7yU8nnEaP8ik
Message-ID: <CAJZ5v0gN+LUqh8eeW8LkDYrnn3KTWoOcLF8azjD4WXZCbMRskQ@mail.gmail.com>
Subject: Re: [PATCH] x86, hibernate: Remove inclusion of crypto/hash.h
To: Eric Biggers <ebiggers@kernel.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Pavel Machek <pavel@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 14, 2026 at 9:15=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> hibernate_64.c does not do any cryptographic hashing, so the header
> crypto/hash.h is not needed at all.
>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  arch/x86/power/hibernate_64.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/power/hibernate_64.c b/arch/x86/power/hibernate_64.=
c
> index a595953f1d6d8..e72d26acae797 100644
> --- a/arch/x86/power/hibernate_64.c
> +++ b/arch/x86/power/hibernate_64.c
> @@ -12,12 +12,10 @@
>  #include <linux/suspend.h>
>  #include <linux/scatterlist.h>
>  #include <linux/kdebug.h>
>  #include <linux/pgtable.h>
>
> -#include <crypto/hash.h>
> -
>  #include <asm/e820/api.h>
>  #include <asm/init.h>
>  #include <asm/proto.h>
>  #include <asm/page.h>
>  #include <asm/mtrr.h>
>
> base-commit: 1c9982b4961334c1edb0745a04cabd34bc2de675
> --

Applied as 7.1 material, thanks!
