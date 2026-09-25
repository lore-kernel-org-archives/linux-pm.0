Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3918A4D37BD
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364694; cv=none; b=sh10hLYESPm+PGGUtsB8F+x3Kj4je4Bau0oomqjwCn1Y26O1RAjZ7LPrrmk1BN51DmFRwuLktLCKflZLV4kUvWeTCLcN4PmSo8vXgLWTKKTLah8DXwG09Kpe9R+7QSNZrsGznu4rzjOs+QOllUfaMDvEHj9eRoWmr7s+eHwZbcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364694; c=relaxed/simple;
	bh=bQpiDAkN8PFpxGCZhmyWfwZ5uGOq8rQmBqjhIP8KmzY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RsYAivCNE7RrADX0V0WjpAXtFH2yIy18Q1HZYYmCLGlsuGqaETCIZlBhXhO7H7ka23DShILLPRknT0ULMKL2bPQb04MBNJxPCm5EFDsd6onJ0gzRTSCqg/yvsMKdJfhvCDdiq0VaTUDPzlBjQMpif+yXMDT/6OlVBsrocWdGNtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SpEtQ5D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SpEtQ5D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E668F1F0089B
	for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 19:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364692;
	bh=wdWQ30emSDP4qcVrkdnvjNPbDT0awLP6/Wq6pXd/aiA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SpEtQ5D+cpSAeGghBbByC9WkZOOimQ4lLNYvc2IES/XraDZ0i5dEFdgeEIi4E5eRG
	 z0+ZVqaMv68sesDwFQROZyeUAiDzDwutjMbYqeJut6mgM5zu5zh64PuKkiGUFjfoLi
	 xRYkHU8tXimQGPknGgl/5137/NG91OrjVJSqQYDf3jcVmzUnWy6A+KyE4GsJINGM0D
	 wgR9+4PQwnuk8l2jEI+ASBekc+oYqFEEyRC1AbQiN7oMPgbW79YG9ohxo0smchi234
	 HOpB6K+0F368zkYfn+9fIRv2wUyh3W+6Z1CDfOEPGfeKCIxKm++wFHr6Wacjcz8GVd
	 Jg3Zbx6a9N1vw==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a59fa3112cso10414561fa.3
        for <linux-pm@vger.kernel.org>; Fri, 25 Sep 2026 12:31:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwY8H1t56yGmSPu+hiBq7OzAUwgDokBHWviw2avJFrCyazezlcvAJ7tMUBGwmF9TgkvRJ8kZIyWUw==@vger.kernel.org
X-Gm-Message-State: AFuF++n/4ulHS3UeNe3JsIya17SmIloS0ctjcb5hJiNxQ6dQHKQCd8tb
	fUTtuTRSVvIGQ1szQ2dEL/RLx2JqqI08V8Ckd+oZOwosrJvH+4uQ4cQ+wg3qM+zoUC+848mWMAy
	pI4KCj2xO3GdGuZR6Uhzlmis6XBwsM1E=
X-Received: by 2002:a2e:bc16:0:b0:3a4:9b64:9811 with SMTP id
 38308e7fff4ca-3a63c0de06amr17290141fa.15.1790364691303; Fri, 25 Sep 2026
 12:31:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916211317.433349-1-superm1@kernel.org>
In-Reply-To: <20260916211317.433349-1-superm1@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 21:29:53 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hhnrwBuZK=enaAc3XYAchveAYjsqykfuYfT2qotRMtng@mail.gmail.com>
X-Gm-Features: AclHuK-cyn3LGeOhIcKp7elU2kLQVMA3nE8eF9NLLpbDIO69bKhlbmZz-TbeD8Y
Message-ID: <CAJZ5v0hhnrwBuZK=enaAc3XYAchveAYjsqykfuYfT2qotRMtng@mail.gmail.com>
Subject: Re: [PATCH] PM: Add resume event mapping for PMSG_POWEROFF
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: mario.limonciello@amd.com, rafael@kernel.org, lenb@kernel.org, 
	pavel@kernel.org, gregkh@linuxfoundation.org, dakr@kernel.org, 
	Eric Naim <dnaim@cachyos.org>, linux-pm@vger.kernel.org, driver-core@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 11:13=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> PM_EVENT_POWEROFF (0x0800) and PMSG_POWEROFF were already defined in
> include/linux/pm.h. Add the resume_event() which is used when a shutdown
> sequence needs to be aborted and the system should return to normal
> operation.
>
> This completes the PMSG_POWEROFF infrastructure needed to support
> differentiating between hibernation and shutdown sequences when
> re-using callbacks for common code.
>
> Hibernation is started by writing a hibernation method (such as 'platform=
'
> 'shutdown', or 'reboot') to use into /sys/power/disk and writing 'disk' t=
o
> /sys/power/state.
>
> Later shutdown will be initiated with the reboot() syscall with arguments
> on whether to halt the system or power it off.
>
> Tested-by: Eric Naim <dnaim@cachyos.org>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
>  drivers/base/power/main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
> index e130da4281410..7265553ba24ca 100644
> --- a/drivers/base/power/main.c
> +++ b/drivers/base/power/main.c
> @@ -1472,6 +1472,8 @@ static pm_message_t resume_event(pm_message_t sleep=
_state)
>                 return PMSG_RECOVER;
>         case PM_EVENT_HIBERNATE:
>                 return PMSG_RESTORE;
> +       case PM_EVENT_POWEROFF:
> +               return PMSG_ON;

Why should it be PMSG_ON?

pm_op() doesn't actually take PM_EVENT_ON into account, so I'm not
sure how the change helps.

>         }
>         return PMSG_ON;
>  }
> --
> 2.53.0
>
