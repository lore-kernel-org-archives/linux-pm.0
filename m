Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C811B496D59
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790171997; cv=none; b=FnaF+n/vHD3ECbhySfUB2O3P5yN6WtNxOnjScpU016tfVOE4YkBEKlnGkCy+Uf4Go0XtZcEbXZdegWx8TGSwgK26AFBoT9rLkc0J0rzYkwm62TyPcRuAUUNEziOWlbx7jfh+bfAcuLLcsJgDZxfumjwOR5IoFdy+E9zjToi1HKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790171997; c=relaxed/simple;
	bh=ORDYVlR/Qy0ZfFGqomuhjW+hYsFx4wMHVsrhfN3U3Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXKNZ+gRylnp4XxYXilYs/krrPs+pnrtAYPDXVr1FWDRaPqE2faRToVo2GexkGLKjngQBzEX5O6P1ZkkbgehDZIB1LUx+utNSPBKy4qIsUyBZlcJp/QQGENoWtc3SlDcWsFOczw+9qzDcSkHKxjceXku4c4DsFXdbXTfBAN9Y1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+h9Kt43; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+h9Kt43"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648351F0089A
	for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 13:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790171995;
	bh=ORDYVlR/Qy0ZfFGqomuhjW+hYsFx4wMHVsrhfN3U3Ww=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d+h9Kt43alQacQrtz9+Jmcssg+K5LpT7mnXfQMF1Y6Lw0VUJdYHwFvly1Lo52NUnk
	 BZODSApNH/E5k2d4QkN+QY5Cg/E38UGVyAVX+oYkGjl6v2bBr4pLNnVHFkJQ2wbB1D
	 +vZqEsi3tMnOnm+IYBh8Gs5eQqH0cTlTH3E9eYbzY1UTAKq65AU8N8EcfLDnPr9ix8
	 ZMivvWP7ryi7Ij0Ct3XCEHKsvWo1nGr1VHOaguo1ivuymDZ4MUn9MGHmB6aW+EFjLk
	 8wvpeterBxJ1E//VYKSRobgOl+IhgUOVjDduZk7W9G0XRZaEAb2tfH7+yOZC++Ws/1
	 SuW5lg3oYZGpg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b899413537so1284409e87.1
        for <linux-pm@vger.kernel.org>; Wed, 23 Sep 2026 06:59:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDUJI6A5902EkbQHLD3LghbGf4bBGBbBS5nIDSoHHCPXA4glXTJVa6Oc2zMCzMexL/L1FDL+rniA==@vger.kernel.org
X-Gm-Message-State: AFuF++lkg7tej7ZPvWyULfJKupKgLHFiOvL5PjOAdt2sWhoUrdbc/Oqb
	t1Z94vs7MsiFuV18peu/Bkcss8LMpjO3952kSaFeKdSTJV8XgUdoD1kGm+pHZN7jjNLRwWKvPoJ
	7vXMztzxZbsNN15/BZnFezVtPaRNOsHY=
X-Received: by 2002:a05:6512:3186:b0:5b8:babd:dc2c with SMTP id
 2adb3069b0e04-5b8d89b7fa1mr1143692e87.37.1790171993702; Wed, 23 Sep 2026
 06:59:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806110159.69690-1-daniel.lezcano@oss.qualcomm.com>
 <ef124b64-e7d2-4c9c-9890-00685e34f314@oss.qualcomm.com> <350caba2-4a95-4945-91dd-0be89b2d3e22@arm.com>
 <71932f61-5721-4363-b163-427432fedab4@oss.qualcomm.com> <f1019e70-f3f7-429d-90e5-c74234dc5cde@oss.qualcomm.com>
In-Reply-To: <f1019e70-f3f7-429d-90e5-c74234dc5cde@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 15:58:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hcqkeGzuhar7e1zdcAEKO6Q3btuSjF9tM=rXv5f5xZZg@mail.gmail.com>
X-Gm-Features: AclHuK9IMbjDBZL9qhHmGxHNCZcvnVAMA9EgXW1lDHAWKL-Tx9uwcfEswnbNHWw
Message-ID: <CAJZ5v0hcqkeGzuhar7e1zdcAEKO6Q3btuSjF9tM=rXv5f5xZZg@mail.gmail.com>
Subject: Re: [PATCH 0/2] powercap: Introduce generic hierarchy helpers and selftests
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, linux-pm@vger.kernel.org, shuah@kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	manaf.pallikunhi@oss.qualcomm.com, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Wed, Sep 23, 2026 at 3:47=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
>
>
> Hi,
>
> On 9/15/26 12:54, Daniel Lezcano wrote:
>
> [ ... ]
>
> >> I can see some potential improvements there.
> > This patch is a blocker for more changes: DTPM, powercap cooling device
> > and SPEL drivers from Manaf.
> >
> > It has been tested and there is a selftest with. Is it possible to
> > consider these two patches for merging.
> >
> > Given it is not a fast path, improvements can be proposed later.
>
>
> Given that there has been no feedback so far, would it be possible to
> consider merging these two patches? They are currently blocking further
> work.
>
> There is also a selftest covering this functionality, so future changes
> can be made with regression testing in place.

I'd prefer to handle this along with

https://lore.kernel.org/linux-pm/20260819165605.1398880-1-daniel.lezcano@os=
s.qualcomm.com/

which appears to be the only user of it.

I thought that Lukasz would send comments on those, but in the absence
of his comments, it would help if you combined those two patch series
into one and resend.

Thanks!
