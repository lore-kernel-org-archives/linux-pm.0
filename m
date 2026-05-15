Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260C53C81B4
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 06:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778828060; cv=pass; b=GCxXi68l4AfLE0nYSNjgsWQ0KYX50tL2JUocuTidcHjT71KROKccdzaihNS64Cu2fnB9yRDE6k3M6Oi4O9NaqcoDlqEBsuoSmAZhPwmjuBMjdOOcA8qSgVbF73dBRlb6D6/GRA7NifqA13w/Xx3PElyqzBj5cFqhN9S76L2boOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778828060; c=relaxed/simple;
	bh=+zDO4k/9Tgy4q0LSQYpj77MT3b6n3APYAMy8uyw53OI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F49w3WOsUpvKL17GqVx8GgZ9VODUXNw77zJSqsnuHOg94SEiSEQq9KQgEw4CdOScbs/ch3dawO98ZF+Vn6Qp2XGXxUD460aPv6R3D6PQ3RLyrUWKlE0PxiWFc4q/OtZl53lFvInIKZEMVo0u+dFayc8J07WUKcdJTgFSo5M6rXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com; spf=pass smtp.mailfrom=it-loops.com; dkim=fail (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b=kMDDxkIv reason="key not found in DNS"; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=it-loops.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=it-loops.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=it-loops.com header.i=@it-loops.com header.b="kMDDxkIv"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-67c2b4809baso17354973a12.3
        for <linux-pm@vger.kernel.org>; Thu, 14 May 2026 23:54:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778828057; cv=none;
        d=google.com; s=arc-20240605;
        b=K/dFe8FS3CRWhIlozI+JdywaJtTLJO6hPBGvV/xq7niZ7PrM/ivfX16TDYKWqkkQux
         QVlrDfxv8bZOfA44UtS5/xAjwoFPxjKCgVr1+5Z6clyYFamUkSNjWhzdGpdShZkkwN/G
         oPQEIVNrcLlGV+DvoIuNQ+bCfaron0MAGUGSX/oWXt+/+iX/tREm+2azTxKr+d/ygljk
         4A3qwDZMK/Y1Wa7GZgRMBKmIZWorvmUTPsOianZ7oN3XgzmSsb3J6L4nClGDeswF93l8
         xfLIT49A1g+OMvBsjGMU8966w7UCppWftHz2yuy5pjqB9vXtkq7+R7OeBCJRhUDuG53W
         Gh/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+zDO4k/9Tgy4q0LSQYpj77MT3b6n3APYAMy8uyw53OI=;
        fh=IsHRFwxe3aVEk3yfwQ7b2th0I/fRWtyPyWny3wTZtHc=;
        b=HoCaRk9Z/Z4FlsyFj8Hh61N9YroguIPp8Y7qSWFwMFGA/Obi+RoNLYYTfSVFpSMmyv
         Jk5mQDGM+YyhFnIgQm4B9DlsiqOGNZ/Vu6NMyqYL76oVJV5GHJCnrtt52ZmgoHPgphjE
         thUOiSxuTc8RG0Chkzif4UFcJFa0Qc6wtFq02tn3Hqfb5pbw/sbWiBesv1G8jMeum/jV
         jdxscyj6veD3l+IWOx2rBUlnm0daZQQHondeN2lw4Wf6JdtYe24EhJYy4zytrrg9LnD7
         sofW+/Z6JY6EA+L3/1qK65puNSKnp7tpc//uN+q+h8s8EGUQ1sF8BK4RszKOEebfv62d
         2kdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=it-loops.com; s=google; t=1778828057; x=1779432857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+zDO4k/9Tgy4q0LSQYpj77MT3b6n3APYAMy8uyw53OI=;
        b=kMDDxkIvj5Uw7X4ikmX2iNaMj9CKp96+/CmV44U/RnSJBQRCMeJ0X1e2IFedR0Gfk4
         WPZKpZStCRiBfQNDKmMq4yS+Vu6Il/+wp+yJRQvHBgadk95VBqlVTVvFSMovIwlX1c21
         aEr41kOC+0EUHw+6ojC3E3fl9l8IM7SCnYvhg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778828057; x=1779432857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+zDO4k/9Tgy4q0LSQYpj77MT3b6n3APYAMy8uyw53OI=;
        b=S3eqHApWyUZr1MOZZEDh/pyyrZjin8N6G3WoiGH6zHWN53NZgXGQoEEjUwfNQJ/0Gr
         ZQabdnKoL01aGZ84bDmtHeZZmnNQ86N2MD6bzaOxFXX3T2vR6xSd+ldOz9ciKnVmsGBM
         1Z5YivbbHE95+53RHEB0rsvuHGdlGmltSvqtVN+z/BOBmgVDOMH2OtCj8bSbgzdKLsxz
         5VbLfuD40nK6jHhlE4oipmJwwyzw/hNUJFCI1KLBZ/tRzt4jgjPrd8PmqC2j3ntuFRNm
         aAAKZQaSfT3WUP+IDI5g8z15o8s+ZqFLrKMBhYeFq95ORqBOX0PIgCXw6zHd4ggdiZ/b
         me/Q==
X-Forwarded-Encrypted: i=1; AFNElJ9jY7gFRGBZJhbM/dl61jEkdKunnaeWQkwGXNpJoMDX1JS3MM43fhtyzqLAwBIMWa+tunSAMDyN4A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyxFNLxuhrRzeXg7aywy4QDVccFsDCExz/vBVP+uFUGY0D52lK1
	kggJgO7or7fJjOHQHqGi0FYp2NNxZAjdvp5vJELJqhSxTfNZFKs5N7JV1etrjXBIsO5RYWKJrWS
	U7iQx19Bx5m33OTLy9eRshVyP4Jhx4goBdd9Uyoe4kg==
X-Gm-Gg: Acq92OFp3e53ht+zuI5zFoUzLdQHnEx9i72oQbbux+AMMoQnpCm+C23hUdqtKlOHWRr
	Od3K0+0maJDps7oaVJB4SdmhaS1kywQAKvYCchiodNM1Y6200dCa8DrCGpzUwNn73utGGsSTg61
	mFp4vzqbJQ7jdaJDCnHp7wDr2Yv7cIszIIv4EvTqigcnV7h+MrjPp2Qv3pjCpDMkZBAoFzpJ4ub
	vC1KvnFWTX/zh0LKMqI/kUk8z6ZfGrv/gX5Xmazh3MochdItAALZ7v0EyxTDZjlETKgjNFCz0L5
	msLQ3OO9
X-Received: by 2002:a17:907:9801:b0:bd0:8e74:85a3 with SMTP id
 a640c23a62f3a-bd5178f9146mr136045766b.26.1778828057421; Thu, 14 May 2026
 23:54:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALG0vJuaU_5REU55Hg170LipPLj7Tt0V3icn7XzxLY-8+jsx-A@mail.gmail.com>
 <20251120055748.GM2912318@black.igk.intel.com> <aSGTghJyX-u-leL6@wunner.de>
 <6e7aa10e-9938-4ab1-af14-b3d2906c211a@panix.com> <CALG0vJv7ZA8byAF25pKqh9fEBpfgbXk+cAE6s9K1N6ZvVRroUw@mail.gmail.com>
 <628342c2-15c5-4890-84ae-dc29df2c5f16@panix.com> <CALG0vJt9x5Oh3DvAvFJR88u2oD063aRyhcufOXHNwv6YKCU44g@mail.gmail.com>
In-Reply-To: <CALG0vJt9x5Oh3DvAvFJR88u2oD063aRyhcufOXHNwv6YKCU44g@mail.gmail.com>
From: Michael Guntsche <michael.guntsche@it-loops.com>
Date: Fri, 15 May 2026 08:54:04 +0200
X-Gm-Features: AVHnY4K5JlpDA8yXuZAkRPwOV4pj8GaTUwmlTBUE0m65VZymA16RPDRQKhluGxA
Message-ID: <CALG0vJuoF92whbgkzb-a01m4X+=3L2CZDvyVu4gpB7tAFFKACw@mail.gmail.com>
Subject: Re: Oops when returning from hibernation with changed thunderbolt status
To: Kenneth Crudup <kenny@panix.com>
Cc: Lukas Wunner <lukas@wunner.de>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, 
	linux-efi@vger.kernel.org, maarten.lankhorst@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 11, 2026 at 10:05=E2=80=AFPM Michael Guntsche
<michael.guntsche@it-loops.com> wrote:
> Since this was still happening to me with 7.0.6 I went back to 6.14 on
> a whim to see if I can see anything specific there. After coming back
> from hibernation (which worked) I noticed that there were no efi
> variables at all. The kernel log showed the following
<snip>

> So it looks like that I ALWAYS had this issue with my notebook but up
> to 6.14 this resulted in a warning and starting with 6.15 it became a
> panic and lock. What I do not understand at all though is why I am
> apparently the only one that can trigger it repeatedly and others are
> not seeing this issue.
>
So I looked at the dmesg output with a connected and unconnected dock
and the memory layout is different. What I am wondering now is how
this is working in the hibernate case.

* Machine goes into hibernation with the dock connected
* During hibernation the dock is unplugged
* On resume the firmware is doing a full init (sans the dock) and
hands-it-over to the boot kernel which continues with this new mapping
* The hibernation image is being loaded with a different memory layout
* Once this image resumes it tries to access efivars which are now
somewhere else apparently and panics.

Is the hibernation resume code accounting for this change in memory
layout in any way?

Kind regards,
Michael Guntsche
