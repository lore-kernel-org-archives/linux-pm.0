Received: from sender5-pp-g121.zoho.com (sender5-pp-g121.zoho.com [165.173.182.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8660D3A8753;
	Sat, 17 Oct 2026 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792260713; cv=pass; b=Rn8dbsuFKyjnAKZ64B3vBHPssa/jCgvxTNXuiDrvvZlmyoGD8RkMvrnw5cg4swg3HykHEYzVCr15gURHgYKEPZ8FfWqV7ZxdzQEKZCiG14KeeTfRpT+oMsnV+ojg36FFBrH+vkpAl0ADsWneo0wj381fn074CWheufulErI4UC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792260713; c=relaxed/simple;
	bh=5l5M7ldOOho0U6i23M9DnNdlicXGb3Nb1ghmEMt8/U4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=FaKFP2ttTRZNp53m67zps3tWxVIqFmaVvP6+KwTaZoBDRgtdCgnY/h9T7huUcPHyCH/nDYKwcFtIOPHs+zHOXzeooz5pg5nEK4xuaZ0A3rQhSJVAsEZX+jRtwWVWsTHxiJeVo7PSo6OZREtuRGIRtVk3XKtP7h4PHt7Ci/4xTHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=ZYXDcXFo; arc=pass smtp.client-ip=165.173.182.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="ZYXDcXFo"
ARC-Seal: i=1; a=rsa-sha256; t=1792260679; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Wf+3gtGnX2BD3aq5epxTIQG0hxG7Z8TSLxvVyOV81A2RIPnCG4qRFAahj29OQGuBng27ZDAYK+kIO6RzmKfFxdpLTDAAzOtPezcR4V2VB6BBvMAarDsy5KmTtBU029u8QJcjmnbtrrfujlhunvo3gjTTYWWwRZExDYAGrDcOLTQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792260679; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=iZK1SzhVJ5iudhiM9HkFHjn0doBDMU5UNoZ2IvM49WI=; 
	b=D6/ptZnSEnbCpm/KHOd20Uh6NesV0FrJIcs9oDvjG2kxS3jzz+iTclbsTfP4NKvs7sujyHsZiy8bHjZnyTMwUX56vqcz5uXpuGM+wkl5Y/kYxt/5qMEkxJtuzzRLcFNUbOp9I+6r6kDnZ6bNu+Swo9FMv7tQiVcrLPV+ew0NVKY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792260679;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=iZK1SzhVJ5iudhiM9HkFHjn0doBDMU5UNoZ2IvM49WI=;
	b=ZYXDcXFosSsyV0TToby0jFyjWHW63hXO80ZfalAodoQT/ef3Jr4co7o+yDN01q5r
	PbwmuyePR+pX6Td4NNrtUUcbdBEk0iFGyBrdm/duWWM8OxvnDBXH4he4atxoRLw05iA
	GHLkHcmVyKol2OT61uhFCwSqfXLUBV5+k0yaKA9GQ/hsPegr5pQvQ1g4VXXnHEUBm1L
	LN14mkYvAe/gwwKP51sXPj6ahbWcTRZywbO/f+082U0pOCbaiSSrm+Fls/BW4ssKJEN
	q6ejcCxoXxne7GSNQVYtNXnoQKQ796hHCDo5mK/xAE+TcaBGKhbiNLinVY5h4HeS5X8
	LCEoEsC1Ag==
Received: by smtp.zohomail.com with SMTPS id 17922606761881015.7789796070091;
	Sat, 17 Oct 2026 11:11:16 -0700 (PDT)
Message-ID: <d0da648567bc15ccac06d9429b46142e241df1a8.camel@rong.moe>
Subject: Re: [PATCH v2 0/4] ACPI: Serialize battery, INT3403 _TMP and
 ideapad methods
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Hans de Goede <johannes.goede@oss.qualcomm.com>, Len Brown
 <lenb@kernel.org>,  Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?=	 <ilpo.jarvinen@linux.intel.com>, Ike Panhc
 <ikepanhc@gmail.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>, Mark
 Pearson <mpearson-lenovo@squebb.ca>, Armin Wolf	 <W_Armin@gmx.de>, Charis
 Stratakis <c.stratakis@proton.me>, Avraham Hollander	
 <anhollander516@gmail.com>, Jeffrey =?ISO-8859-1?Q?W=E4lti?=	
 <jeffrey@waelti.dev>, Rick <rickk1166@gmail.com>,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261017130652.318778-1-aliamemis@disroot.org>
References: <20261017130652.318778-1-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 18 Oct 2026 02:06:08 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

On Sat, 2026-10-17 at 16:06 +0300, Ali Ahmet Memi=C5=9F wrote:
> On ThinkPad P1 Gen2 and P53, INT3403 _TMP switches the EC page selector
> without taking the mutex the battery methods use.  On some Lenovo
> IdeaPad and Yoga models, the battery _BIX and the ideapad GBMD take the
> EC mutex and a serialized method in opposite order and deadlock until
> an AML mutex times out.
>=20
> As discussed in [1], add exclusive variants of the AML evaluation
> helpers and use them for the battery, INT3403 _TMP=C2=A0
>=20

int3403_add() seems to be another call site of INT3403 _TMP, but PATCH 3
didn't touch it. Is it intended?

> and ideapad methods.
> Patches 2-4 depend on patch 1.
>=20
> Changes in v2:
> - Merge the follow-up series [2] and drop its EC query and UCSI patches
>   until they are shown to help
> - Add acpi_execute_simple_method_exclusive() for _BTP and ideapad
> - Make the helpers wrappers that take the lock around the existing ones

You dropped Hans' R-b from PATCH 1 due to the massive change. The next
time you do the similar, please add a note to the changelog.

> - Join lines up to 100 columns, add a Link: for Suggested-by:
>=20
> Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23bpz=
mX9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
> Link: https://lore.kernel.org/all/20261014190544.150093-1-aliamemis@disro=
ot.org/ [2]
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065
> v1: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.=
org/

The series is now neat to me.

With int3403_add() fixed (or explained), for the series:

   Reviewed-by: Rong Zhang <i@rong.moe>

Thanks,
Rong

>=20
> Ali Ahmet Memi=C5=9F (4):
>   ACPI: utils: Add exclusive AML evaluation helpers
>   ACPI: battery: Evaluate battery methods exclusively
>   thermal: intel: int340x: Evaluate _TMP exclusively
>   platform/x86: ideapad-laptop: Evaluate ACPI methods exclusively
>=20
>  drivers/acpi/battery.c                        | 12 +++---
>  drivers/acpi/utils.c                          | 41 +++++++++++++++++++
>  drivers/platform/x86/lenovo/ideapad-laptop.c  | 12 ++++--
>  .../int340x_thermal/int340x_thermal_zone.c    |  6 ++-
>  include/acpi/acpi_bus.h                       |  7 ++++
>  5 files changed, 66 insertions(+), 12 deletions(-)
>=20
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
