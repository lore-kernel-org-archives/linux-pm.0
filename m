Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7429546EC7A
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346145; cv=none; b=aZ9WfWwaGWDpEL1szmaEeuEQCPBI29rvj2VW7zo38wqnHCYeFu3j2ZWk9H7ivIPSTLfs0+cV6PvlQWHESWHJGqDPwoKCxH7OwzwurJpvNQLoElT/QBmSWDOe/r2NHqiURDDehd1WmeNpzjQXySiDtkYEQ2MNUsNbiqdlbw5Mgeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346145; c=relaxed/simple;
	bh=5EzZXQ8V6NL9RxhHhxukzNsAZVvijkybCPLoUlAjCho=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=akYAm2ADAuBCV5nwu5ggx4DQ8ngl2ndepXj1CMeKOZAi7W7VG9sIMN9il1eXuaGEeIhQlJ6HzGRbWeBwWM7Xt7Fk81fTfEHate0qn06Ll03kI5LISZrpLRKQYFH4O7rDDJFPuKL0nAO0QVDjnbM4tCwRGM+dSoe7QYSvwI4f3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dzt+Favm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dzt+Favm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96C921F00ACA
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788346141;
	bh=5EzZXQ8V6NL9RxhHhxukzNsAZVvijkybCPLoUlAjCho=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=dzt+FavmypQFbF3qJ6JG4U6E/zBRcrrTLQ61YXbv5f2vnYH4c9yr1Smk68WJuY2j8
	 f7UwQqcQm2o4ToSbrbyHBDe5THvP2/W8D7Ii91G/SCCAystq+Xc6EVq9X0jgFv9k8U
	 h7Z5l73rBoRUfMm7VRYPXowmjoxkG45LjDCCTNYnmPVAzvnaZavSvosIf3JfX0u6If
	 hE7eTQ3YOadPWPNs0Z7WeuUghwRRFrZT9oeGBglqjr9KXxaylnCw+8sfHZWysB/HTb
	 xVQk2CdyZy9yTsRzQG9hlnWvKECb0Ii6MPmrZCLoNhhAFhW0ZHMhfmpgVsp6zy/E63
	 C+yubQc8KLOTw==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5b0115b9e17so761103e87.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 03:49:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByDe4IrkdcXjaRNlswyzJE1UK6YO3L4Wvdbf4ftSKvqpFLr3sBktn0D/I7UatTbIdDdSDSYSTFAkg==@vger.kernel.org
X-Gm-Message-State: AFuF++mn+QlE3wz5rZgcsf6wM3yIs5mbRGKitxHSI3w8sayIwUjhf2zQ
	EGiqvOlq/BmM5uITqn/jp9HxGNRPwFx45zOeaXI+p0THXyuAfaee5tv4y7V+bxrQH9kKr2lSYZc
	lqbck5CTOHqa5Ll+L2KhJXOSL1+1F9gOsHyToEElutQ==
X-Received: by 2002:a05:6512:131f:b0:5b6:4b2:45b4 with SMTP id
 2adb3069b0e04-5b6087ed44dmr1265412e87.32.1788346140221; Wed, 02 Sep 2026
 03:49:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 03:48:59 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 03:48:59 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <CAMuHMdXmn7B_UOb8f2j0_BOx3d55nA0-0Auay-HLFYWtziS+6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
 <20260826122742.153643-4-biju.das.jz@bp.renesas.com> <CAMRc=MfAdTMb_4ii=up-ESwc322YYjzseyvAxshM6vUcEGfxcQ@mail.gmail.com>
 <CAMuHMdXmn7B_UOb8f2j0_BOx3d55nA0-0Auay-HLFYWtziS+6Q@mail.gmail.com>
Date: Wed, 2 Sep 2026 03:48:59 -0700
X-Gmail-Original-Message-ID: <CAMRc=MewW5aLqY66i-uUor3ke6k25rjZh3z7Cn76e_KhHQWoJA@mail.gmail.com>
X-Gm-Features: AcwNN1W3bxjr6MHNEaKG776nM62LP78_XqASMYOXKt17cNFJcTa4ryypmgpnWGo
Message-ID: <CAMRc=MewW5aLqY66i-uUor3ke6k25rjZh3z7Cn76e_KhHQWoJA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Biju <biju.das.au@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Magnus Damm <magnus.damm@gmail.com>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Sep 2026 09:10:45 +0200, Geert Uytterhoeven
<geert@linux-m68k.org> said:
> Hi Bartosz,
>
> On Tue, 1 Sept 2026 at 18:15, Bartosz Golaszewski <brgl@kernel.org> wrote:
>> On Wed, 26 Aug 2026 14:27:25 +0200, Biju <biju.das.au@gmail.com> said:
>> > From: Biju Das <biju.das.jz@bp.renesas.com>
>> >
>> > Add a power sequencing driver for the Renesas RZ/G3L PWRRDY module,
>> > which signals power readiness for various IPs (USB, DSI, CSI etc.) on the
>> > SoC. The driver binds as an auxiliary device to the parent SYSC driver,
>> > using its regmap to toggle the SYS_PWRRDY_N register bits, and exposes
>> > {usb,dsi,csi}-pwrrdy pwrseq targets.
>> >
>> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
>
>> What is the merge strategy here? Are patches 2 and 3 independent from 1 and 4
>> at build time?
>
> I think so: one can safely select a non-existing symbol in Kconfig.
>
> So once you're happy with this patch, I can take patches 1 and 4
> through renesas-devel.
>

I picked up 2 and 3.

Bart
