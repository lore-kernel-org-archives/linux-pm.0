Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B502AE78
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2026 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838473; cv=pass; b=Z8VhTlYOwknrXh78czm7VQDBRQeqYjO6ex0hEVKrI2txLvlueQBtOBavQVK3ZBoD0HtnMVfdSXuicjlvzES/XbmulV5x9HM58HJTF18rOCrQonvJWeklHMpVt4HglsSNbFcAaUvRj0pzRRD0xIYD1PVaEk6QF9txXPz+U/Zo6Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838473; c=relaxed/simple;
	bh=jeF7sRuCE/tgNWpWkEp8CGIbKh6Ye/S47INTgDZFQCI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=EDMRqiBgfzHoRWbaX6KLHAmrAxaf3sTrwltV39N5QVNcEpq603+SEkYkM/VcZB3kD9SjAJd3ClSVOM0BpyUR+SdoIBC21Lqkg+bH+qPs6JSS7E9qyn4EXy+AOt1eWXFZr/2ljWFld65S2jnS3bYp9ZknrdvD0s/+UlMcfZJ5xE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqxSnExd; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqxSnExd"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-676d8a1835cso1580658a12.2
        for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 23:14:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776838470; cv=none;
        d=google.com; s=arc-20240605;
        b=D6x5d+SwXxP3NP+BoWC+HKfzjUA+R6z+tYhCnfhaWvklohQER2nqlnN719kEfj7V4F
         rQGFaK5vTldy+GiomSS1swzEvDC5Qdk+w1oQgLDfkkMum8ORcZoKqMCV9tXkdJbGlub7
         lf3Zzlljy+/wkYY56BBoJTHdng0o0gvh8dLxXfEMJr9YtNqLZ3PTZtUw50xE6vv86F+F
         NXwwd1ixNba5gFE1m5f9pP4YEMw3tSg8vRMrYep+9lF4m/gteDHneRpAFG5avjf2aIe3
         6XWfFbQIw12BFWobY5Nezr4CgRJWMFn7FYPfhVasoJ9sYv1rnHekP2l/F+oA5e1vA0Nd
         D4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P7E2q6exx7PW87rgGpHFPg1laXVtt9+bH8xKH5r59iw=;
        fh=5YbbbWJo0eyx0CQHep9ozvzKbwC5iOic4xdP2j0ItRM=;
        b=h/PtdGvPRJVmur6Ief8lFTgMCH6EYncajjlPgc3K+X/d4ufJ4quOl/jPQbNWYxN0Ty
         HGgHzTrXzQ4hY8AcZJ5qZzITTloy7N0bQ7iUdp+TtDF4mtwCO+4QgMdTr6qtu+KVeneh
         63Xx9ql70Rgf+t1l/BXXSoAjouQx7mFoOlFtRnCt+AlRRd2AnZDlVBRTT8TTlPvpKb1P
         3X2WlEDa+h2CSi7tQp2RmLcIJNlKWPF/Qf9PUqnaxzLb01cl7OeuFOZ1Gy2ZK+56ithP
         HAeTUYk55DTBYpn2HT0XHMxh0WdZBQxrjN0tkFQLjxIiPSCPJOOeuOM9pOpFrzwzAT0G
         gNTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776838470; x=1777443270; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P7E2q6exx7PW87rgGpHFPg1laXVtt9+bH8xKH5r59iw=;
        b=XqxSnExdnAhG+HOwVAn8PBPkH047wVCgRlSH6CslrPx/XHjn/6/m3P1QTvC4+A7WeN
         JGujtyGHQkgbRgbIq2BYhu29VJfOQQKXPCQW+p5rFU/dEY/SuHvlKdom6y6isZpJYQcB
         FDZqGHpnFP0e3FnOPBUk6PGtpkA/ifBWiWV8AG5r+vpT3HvPrE87TH9BQRCC2V4MI4Vz
         w8N2TeW28bRDkliOFmWwBo9shMrfkRvE+vVY1dKgMRtbtaJqrF6mqErJ2qatfPwLBehG
         sZJr5aPR+FrlZ+3EY4FSE1u2Azvpq0P7M40bXhB+LciqsNJDi9q3kHcOcQq8SnvByVOb
         2y8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776838470; x=1777443270;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P7E2q6exx7PW87rgGpHFPg1laXVtt9+bH8xKH5r59iw=;
        b=k38OAkHPYyIneJ5miTW/BEECID98ML0tWKeq5utnnwbGpekzzbQvnshcoYEvvJc3Eb
         2DwBBQgudkYB5dGWE+g5YX5KGa5IqWZ8zQCkoBrpxYxpBtmagMv+xTFhX4OAaUcGzZL/
         j7JtB8LgzthVWEoGRr0E+TItSIOh0xoYP5FAEQCZIgJwd+ADuVWiHORBPZXWcrKPCE7u
         jX+TaNDWqhrVt+6oYJnWXZ6oOmlCIQ6snJv+jrw0wNCBGdd7LslDxdHa5sHl0/YS+N5V
         5V0ax7TA/3Fuic95jSnEO4h+tUShkEk2oa34s/lDwBvHWEnexcZvMNXjVyNgxXxycK8J
         TztQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Acws8wXq31fOdltl71fenBwwLgVTWrZE1Q9VVKOiCd5Zsicf47cNVcBgG9xJIrZZ1pkyJtq/sKg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzcJPyMdCcSMaLfp1znkaN4NK1+/7kCwqrDD5MIThQxZaYyvjgK
	7caokxuQoEhuXYNhew2XqAd1HPzuYD6Jr076U4sxocytpFBnlXwqlDbCONYwEfU5JcPC7j6xH65
	Bq7YuPXeTRAtZTKyLRj/evw+O894Mmr4=
X-Gm-Gg: AeBDieuXVy60UQapho9WwCTBv6Z3J4/dWDWXGHRWz/ui2BAjwLK1nf7GiKnQIRhTgu7
	tZsPCibQpkH0VVEcBbhrcqb1dMGDcHvtCWnsFssWTIAGdGzAQGhnTi8yyfjwqGgVs/agiqedgBZ
	98HU8GWi41ao02kjrcAlb0h8ccM8RrvHJSH7RWUwI1xV+v5brqGnbVNU0h4s0qSKZdrUhb24eJp
	xhBlYA6KthFqFY3Usnz18L7eHxVh8+UPfpmN5LRzUeqqmj0ORBSFQo3OFBFrSZPlPvWcx9zNXtv
	ZOR5SYEw0mHepHc=
X-Received: by 2002:a17:907:1588:b0:ba9:3162:182 with SMTP id
 a640c23a62f3a-ba9316201a6mr261303166b.19.1776838469610; Tue, 21 Apr 2026
 23:14:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org> <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org> <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net> <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org> <aeevr6Zj3Pwm9wux@aurel32.net>
In-Reply-To: <aeevr6Zj3Pwm9wux@aurel32.net>
From: Anand Moon <linux.amoon@gmail.com>
Date: Wed, 22 Apr 2026 11:44:14 +0530
X-Gm-Features: AQROBzCenitl4Odlgd_JfKGymltQZPnNxQ-FB_fBcOyLvkgF7DPs6UdEgDyDJDo
Message-ID: <CANAwSgSCo-mESo6=KSc08oUzTWAgzpYu0JaW5KqmnCNiPYHjxQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>, Anand Moon <linux.amoon@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuwei,

On Tue, 21 Apr 2026 at 22:41, Aurelien Jarno <aurelien@aurel32.net> wrote:
>
> Hi,
>
> On 2026-04-21 16:10, Shuwei Wu wrote:
> > Hi Aurelien,
> >
> > Thanks for your addition.
> >
> > On Tue Apr 21, 2026 at 5:16 AM CST, Aurelien Jarno wrote:
> > > Hi Anand,
> > >
> > > On 2026-04-16 17:07, Anand Moon wrote:
> > >> After reviewing the Banana Pi F3 schematics, I confirmed that Buck1 =
and Buck2
> > >> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the rest=
riction errors,
> > >> I expanded the voltage range in the DTS to 500,000=E2=80=93950,000 =
=C2=B5V.
> > >>
sorry I was wrong from the doc below 1.2.1 CORE Power Design

The typical core voltage is 0.9 V to 1.05 V. Actual voltage is
dynamically regulated by
the **remote-sense dynamic voltage** adjustment circuit inside P1.
P1 BUCK1 and BUCK2 must be combined to supply the core rail.

[1] https://www.spacemit.com/community/document/info?nodepath=3Dhardware/ke=
y_stone/k1/k1_hw/k1_hw_design_guide.md&lang=3Den

> > >> Additionally, I updated the DTS to map the second CPU cluster (cores=
 4=E2=80=937)
> > >> to Buck2 to better align with the hardware's power distribution.
> > >
> > > Actually the output of Buck1 and Buck2 are connected together, so the=
y
> > > should always be configured with the same output voltage. And both
> > > clusters should be mapped to both outputs.
> >
> > You are right, I received the same response from the official developer=
s.
> >
> > Therefore, I'm wondering if an additional regulator-coupled-with: prope=
rty
> > definition is also needed here?
>
correct.
> Yes, I think this is the way to go. I even wonder if this shouldn't be a
> fix with Cc: stable. This also has to be done for the Milk-V Jupiter
> board, I haven't checked the other boards yet, but I guess they all use
> the same schematics at that the PMIC level.
>
> Regards
> Aurelien
>
> --
> Aurelien Jarno                          GPG: 4096R/1DDD8C9B
> aurelien@aurel32.net                     http://aurel32.net

Thanks
-Anand
