Received: from sender5-pp-e108.zoho.com (sender5-pp-e108.zoho.com [165.173.182.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD4231A07F;
	Thu, 15 Oct 2026 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792065085; cv=pass; b=ZSLtA4/3cXWINIdrZCzlxKUSBIZTM6RYS+HDiIWLbdsPQH3G6IsLeRoOimRjnLSMi0hVwiNGzJu3oSrwqRGIPm8D0s1xe+mvBlUqhR5PdR1udX5Dh/XaOu2MvIpbwAMnbaaj98D+TPD6MT1oW16QXA7Hp6Y5thY8HeuFlQXh7ic=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792065085; c=relaxed/simple;
	bh=fhohS3lGuoWITFeS9t/S4V2FLSotjO0Kcny/fDfQFO8=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=c+kEWZIx9hpEjvU+yuSdyGZv6nR7aEOtPI/2JOWLSRb8qoMCtCW2XAWz0GO/ySk04Rzbi6hbtSU2jEpXPqogSTHqTadTGcFwKriLl16vWglCR7J06J24/K5m9avxtbLw123kJ8W5awxlvKkz1BxQWiusEzhcxDKy/6+eX2AkdXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=qmvMmUJo; arc=pass smtp.client-ip=165.173.182.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="qmvMmUJo"
ARC-Seal: i=1; a=rsa-sha256; t=1792065060; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bM0KUqPAqwMuqGiF6gbZrNSyw8nCUyHtV1lqrPdUwoAfdUjH5bXCUjbbCwcgn5FSTr1FoKaUC9JW+eroyjKLXtKzSLtLbTlsxwQ0O1o3HclGAaqumUSlhqeNx7BdRQTYlP6zqnNyz2jGFdmwxEYglxNvDudXO0X0/1LGL2R5gcc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792065060; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Sy70hYmBViSJhx1QgvBdjnOR2dPydIgQOX2U1TRTaeQ=; 
	b=PleXrnwYVU5MP/1hRsKjfFP+eK/hKR7A3pmHO6mDISPDKrlY1QZxnK0dNTkopRR67BbVXIyTrP8keZw7NTp6UMLunE9NusEdfJNR1PH0sYQAmoZCty61tWlwJ1VG5MIdH9Agwqy50s4dMB80EZ3Klw/t7tE/YIdBNO4BFGpjeDY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792065060;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=Sy70hYmBViSJhx1QgvBdjnOR2dPydIgQOX2U1TRTaeQ=;
	b=qmvMmUJoeDmnrVHHKOC7IrFoAUC4uv9ljEAekxkxh6tHpYTDebeycNsnxVb7Fqs8
	4b6/NtgIz5q9RSwxXPLD8IIjhH07+hAelhIgdneJFC6RYnQDCn/X/EddiBjeY6ZIPnS
	wFwqKp9c1Rma0w+uJ9cZ1ijQkXRsL3bGK8TufZOtuLyqBUgK+WUkFyBz7fffKLy/+A9
	NWXWXgrLeSr/c5pUxGZSx2aCSE8gHYZebb94jOqrImlvDBS3nUDZAH8WkbeSvIKrPPN
	S1yYB5xqd98CKJSTb1ZX0oxbrdq1SNNTbtG/VBgVLqifsO15Lq7sjNHweIQepezWbah
	AGyEuPMFYQ==
Received: by smtp.zohomail.com with SMTPS id 1792065057319972.0408465652614;
	Thu, 15 Oct 2026 04:50:57 -0700 (PDT)
Message-ID: <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
From: Rong Zhang <i@rong.moe>
To: Ali Ahmet =?gb2312?Q?Memi=810=946?= <aliamemis@disroot.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,  Hans de Goede
 <johannes.goede@oss.qualcomm.com>, Charis Stratakis
 <c.stratakis@proton.me>, 	linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261014132703.93355-1-aliamemis@disroot.org>
References: <20261014132703.93355-1-aliamemis@disroot.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 19:45:47 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Ali,

Thanks for working on this!

The series is generally in a good shape. I just have a few minor
comments.

On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memi=C5=9F wrote:
> As discussed in [1], add exclusive variants of acpi_evaluate_object()
> and acpi_evaluate_integer() and use them for the battery methods and
> INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
>=20
> UCSI (bko221065) is not converted. =C2=A0
>=20

Please leave a link to the bko bug, so that readers don't need to
assemble the link themselves.

> There the contention is on a

After carefully auditing the ASL code again, I've just found the root
cause of the mutex acquisition timeout.

It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
"Serialized" causes an ABBA deadlock:

Thread 1 (battery)                         Thread 2 (ideapad-laptop)
-----------------------------------------  --------------------------------=
-------
serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0.VPC=
0.GBMD
evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.VPC0=
.GBMD
  acquire ECMT [A]
  serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.EC0.R=
DER [B]
  evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC0.RD=
ER
    serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]

That's why merging battery notifications significantly reduced the
frequency of mutex acquisition timeout.

> firmware AML mutex that _Qxx EC queries also take, which a wrapper
> around acpi_evaluate_object() cannot cover, and Rong's notification
> merging in 7.3 already reduces it on the battery side.

Lock contention is not the root cause, and EC queries and UCSI _DSM are
just innocent victims of the ABBA deadlock.

Please rephrase the cover letter accordingly.

>=20
> [1] https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23bpzmX=
9aAZ0Rsv4z9Q@mail.gmail.com/

You can use Link: tags in the cover letter, e.g.:

Link: https://lore.kernel.org/all/CAJZ5v0gS4agVUkCO6M=3DVW4Wi2y1-s+k23bpzmX=
9aAZ0Rsv4z9Q@mail.gmail.com/ [1]
Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221065

Thanks,
Rong

>=20
> Ali Ahmet Memi=C5=9F (3):
>   ACPI: utils: Add exclusive AML evaluation helpers
>   ACPI: battery: Evaluate battery methods exclusively
>   thermal: intel: int340x: Evaluate _TMP exclusively
>=20
>  drivers/acpi/battery.c                        | 17 +++---
>  drivers/acpi/utils.c                          | 56 +++++++++++++++++--
>  .../int340x_thermal/int340x_thermal_zone.c    |  3 +-
>  include/acpi/acpi_bus.h                       |  8 +++
>  4 files changed, 71 insertions(+), 13 deletions(-)
>=20
>=20
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
