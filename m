Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F5A348C4C;
	Tue, 13 Oct 2026 01:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791855629; cv=none; b=hH4ysJ3JpvZcRbZK417C0b2YW4QShIrv65VNtdYEBe0iHnv9D864q6h6O/OUmalo7UlaJWHNA4dAyD27fhbYo0iNyn72i4c48W11uuEqJujNbeCM6ASC8+IR3EECAWdHcZeONR4VkMDmehYfcKEWEFzCBG6GYqEsno6S4ToNAq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791855629; c=relaxed/simple;
	bh=qj0/+cMxaIjvgJPXNv2KdAcvS7E+bqvRcs7uhBsEU8M=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkuC9Zfr/lpay8CFF9eC1UJsyLxxPhyZVPzKuUMfOsYu4RHnGCxcBgEDyQ0NFQ28kdHwjQ+Bt4WE72XiGJxqnq05JnQuOu9B+s6ivI7arkU4AIqmkasznIG3zASQMJPhNLGbwlT4p8M3likchqgY9ZuSMPUMoP72DHhGaoTjYpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=jXDAt/ZK; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="jXDAt/ZK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791855620; x=1792114820;
	bh=HoWCXQr+g599YdKydg+WnwnnXEKIjUbnMEfi/3N88JE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=jXDAt/ZK6RWS6OOn5eA1IsPVyzbWfw6ulFmcImX46OBCKHeyYFWjhncw9MjY1Fhd2
	 j+5SGF4NHlgLI9vAR9xnhzgmS/FGvB779L33WHZ5/F5TAUwnAjJaXP98v/btdTyLIW
	 +e90zW+/dODvVxa75BgqR09UgcEJ4aWktXIuzLTldV9cF9z6IxmnOtwIHOvxxpsxjL
	 vH5aAIod83mrAKu1JzHqAF9LVCfe++27SA7olhR6Z9DCgrryEQC0CCZrb5x5cY5nPH
	 DqoGM5VTYaEW3pt3waiw7PvhuqVIKHJ9CshLJLdLE/X323kDrYak3FmYHk/xPiTHzZ
	 QKBfS+G9fw/IA==
Date: Tue, 13 Oct 2026 01:40:17 +0000
To: =?utf-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
From: Charis Stratakis <c.stratakis@proton.me>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Armin Wolf <W_Armin@gmx.de>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, regressions@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the complete callback
Message-ID: <RzdkKLBwqo3DyCK02-SY8TzjXuAuqzmM5cuV7LddeKdLyZhPu_av9VmcP8a7ZE5Uzt1sJo4AoMaN9reZpMo6jSQ2P1G3ooDL1rn2atKO2O8=@proton.me>
In-Reply-To: <20261012225841.15260-1-aliamemis@disroot.org>
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me> <20261012225141.13683-1-aliamemis@disroot.org> <20261012225841.15260-1-aliamemis@disroot.org>
Feedback-ID: 224044180:user:proton
X-Pm-Message-ID: 73d09911cc629e8dc5db4d7b2310de8aeb35d0a7
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, October 13th, 2026 at 12:58 AM, Ali Ahmet Memi=C5=9F <aliamemis=
@disroot.org> wrote:

> Hi Charis, could you test this on the P1 Gen2?
>=20

I've rebuilt the Fedora 7.2.10 kernel with the patch for F44 to test it, th=
e hunks are identical to 7.3-rc7. As before, no vanilla
kernel was installed, all testing on my laptop, with Claude's help.

The test is cycles of "rtcwake -m no -s 25; systemctl suspend", checking en=
ergy_full, voltage_min_design and serial_number
after each resume, with int3403_thermal loaded throughout. I ran it as ABA =
so that nothing else could drift:

  7.2.8-200.fc44, stock          10 of 10 resumes corrupted
  7.2.10 + this patch             0 of 20 resumes corrupted
  7.2.8-200.fc44, stock again     8 of 10 resumes corrupted

18 of 20 on stock against 0 of 20 patched.

Tested-by: Charalampos Stratakis <c.stratakis@proton.me>

Here is what Claude reports, hope it makes sense as I don't have much knowl=
edge of the kernel's workings:


Both flavours from my report show up: energy_full =3D 328.1x Wh, which make=
s
capacity read ~20%, together with voltage_min_design =3D 32.81x V, and one
cycle with energy_now =3D 328960000, i.e. 424%, with energy_full intact. On=
e
bad cycle is worth singling out because it supports the \GTST explanation,
it returned voltage_min_design correctly as 15360000 while energy_full was
328160000. So the page selector flips in the middle of _BIX and which
fields come back wrong depends on where in the read the _TMP burst lands,
rather than the whole structure being read from page 0x60.

I also traced the EC (ec.c dyndbg) on the patched kernel for one resume,
which shows the ordering the patch relies on:

  .223100  WR 81=3D01, 00, 02, 06, 04, 05 with the 0xA0-0xAF reads, i.e.
           _BIX and _BST from the complete callback
  .236664  last battery page selection
  .239670  WR 81=3D60, first \GTST
  .270916  last of 13 consecutive \GTST bursts

Nothing from the battery is interleaved among those bursts, and the next
battery access is 5.7s later from userspace polling. Worth noting that
"Restarting tasks: Done" (.240802) and "PM: suspend exit" (.251365) both
fall inside the \GTST burst, so PM_POST_SUSPEND, where the refresh used to
happen, is right in the middle of it.

The firmware bug itself is of course untouched, so a _BST that races a _TMP
at runtime can still return garbage. Those were the transient 424% readings
and they self-heal on the next read because of the 1s cache. Would a
plausibility check in acpi_battery_get_state() be welcome for that, re-
evaluating _BST once and warning FW_BUG when capacity_now exceeds
design_capacity by a wide margin? It would sit next to the existing
workarounds there. I realise it only catches the obviously absurd values
and not wrong ones that look plausible, so I am not sure it is worth it.

Regards,
Charalampos Stratakis
