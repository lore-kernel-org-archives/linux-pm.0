Received: from sender6-pp-e105.zoho.com (sender6-pp-e105.zoho.com [165.173.180.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B4C26D4CA;
	Thu, 15 Oct 2026 11:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065420; cv=pass; b=JdEchkBczBrH0T5RHIjxE++IMKTWdAfcKI1H3bVf2lZ3ceLbaH3WDYtjwZDBmorLQq0WD6UDPZiBs9rQQRQ4U/x0pLafjy4T8MrkXkfIAVCFH4Fpto3Vrmur6BEwynTGX9528FuBfPt7DCVH0ryYx6Ez8tMSuQzdciFUYreDAh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065420; c=relaxed/simple;
	bh=nH1zuQYv0sdFhBLZ5TSfcr6XbMKn5plJMTMStrVWRck=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=hym4K6+TtgvJsKdrKiz3mpUZstIcZLKTaL8Omaw62f6CygSz+wysmE33raiT4mi+u4xS6tERztpzQvGL+DrrKyAEs8lSAS6Uc2NZntigKzkW+EIN68kXPz2VmmP5fz9/UvlfeJ+NWeYKppo9ez0Umgrd7lFDUDZBgRayPOhFxAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=TeISHmWX; arc=pass smtp.client-ip=165.173.180.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="TeISHmWX"
ARC-Seal: i=1; a=rsa-sha256; t=1792065406; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ClRzXoMDmA9rDFLoxjtvi97wGM/sZJCJF5somzzUM7vX39f1BRUbQW8Gb+fRvaFTIBQ8cVaQ2nUxdRPyT6MTVo2ASbfcYm1Mm5rj4XeJesSAq9M4+0RPDYUlELAQJg6J0LEhuwLxEms3CrgsoXBTaJD+VkQShwVGuKDTEBPj6KE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065406; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=KneaYbwkKEGo5OfTF6SYMTOYdOAjlXr9BJxUu8zh+1I=; 
	b=hF6UF+hk6f4FkIHLomVRIyJBl2hsfkv+Mb6QrqQHnwCfqpmZbXfWkffXKSlM8DogG3SifsQTgiX1Kf7ZolIcDkNMacYY9Bj9Ycmyc5sjKENR+ik5fEPfonPio2/Bzust/Aeq/kc/9mcgmbRp8SAG7bNfR8QB21uPeRDnR7X9hPs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065405;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=KneaYbwkKEGo5OfTF6SYMTOYdOAjlXr9BJxUu8zh+1I=;
	b=TeISHmWXocqvLrZi0P9+81J7Z2Ztujxb6IPHJ9PcJvYLT/BqQ+2acT4s2MpMp2q5
	CoONWuALlbVWiqFaMOm/nuCM1GwLZKqCToxIf9jDgZFB0Yl81ZGP94BaJXq4brKSnx2
	9TbFHCeL2YzK7PG2GEgojr+57Wsqa6q37i1sKCbhIf2rKnViiFzIVs0N9knEbNfvsh0
	E+ASRyrXBVbgJ67sDgczX+CsnGmyiBqmJn0qtL1PfIDnAA1HjpgpIQao7WmGZCwsN2q
	CTLlXg9nQaHNsicYuXwRJoYGNLMm2WPGXL49iMcjU1iPDqfvvuXevOPk2sZksqLxdnm
	MU/ALGrwwA==
Received: by smtp.zohomail.com with SMTPS id 1792065403261929.124589646763;
	Thu, 15 Oct 2026 04:56:43 -0700 (PDT)
Message-ID: <08b6196a955faef9968224d7946ea5b1150f2ae3.camel@rong.moe>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, Hans de
 Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,  Armin Wolf
 <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
 linux-acpi@vger.kernel.org, 	linux-pm@vger.kernel.org,
 acpica-devel@lists.linux.dev, 	linux-kernel@vger.kernel.org
In-Reply-To: <20261014150537.121547-1-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
	 <24b2e368-f0bb-484c-bf88-b9ce3125180f@oss.qualcomm.com>
	 <20261014150537.121547-1-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:51:22 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

On Wed, 2026-10-14 at 18:05 +0300, Ali Ahmet Memi=C5=9F wrote:
> On Wed, Oct 14, 2026 at 03:45:10PM +0200, Hans de Goede wrote:
> > Hmm, I wonder if we should export the lock added in patch 1/3 and
> > then also take that in the ACPI EC interrupt handler ?
> >=20
> > The ACPI code already uses a threaded IRQ handler for both EC GPIO
> > IRQs and GPEs so sleeping in the handler should be ok.
>=20
> Sleeping is fine, but the interrupt handler completes the EC
> transactions, so taking the lock there would deadlock an exclusive
> _BST.  Doing it in acpi_ec_event_processor() where the _Qxx methods
> are evaluated, works though.  With the brightness key queries also
> running the \GTST copy, 283 of 891 _BST reads were broken without it
> and 0 of 804 with it.
>=20
> > I'm just thinking that if we're going to do this it would be nice to
> > cover the bko221065 UCSI case too.
>=20
> UCSI and _Qxx alone aren't enough there.  I emulated the ECMT users
> from the 83DR tables and the EC helpers kept waiting up to ~680 ms of
> their 1 s timeout behind GBMD/SBMC until the ideapad methods were
> exclusive too.

Nah. Emulation doesn't count at all.

Without a real EC, any call to ECCC or RDER (called by GBMD and SBMC)
times out because CMDB is never reset to 0:

        CMDB =3D Arg0
        Local0 =3D 0x0100
        While ((Local0 && CMDB))
        {
            Sleep (0x02)
            Local0--
        }

Thus, any call to ECCC or RDER consumes at least 200ms in emulation, but
in reality it doesn't.

If the EC is really stuck for such a long time in reality, the platform
will shut down or reset itself.

Thanks,
Rong

>=20
> > Note this is something which can be done on top of this set.
>=20
> I can send a series on top of this one for the EC queries, UCSI and
> ideapad if that sounds good.
