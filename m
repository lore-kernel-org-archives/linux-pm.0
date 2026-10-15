Received: from sender5-pp-e109.zoho.com (sender5-pp-e109.zoho.com [165.173.182.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0874EC66E;
	Thu, 15 Oct 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072421; cv=pass; b=RmYYkLeRSd+0Oy5z3SvBlOlpc4mzpZ5SHbeoqKhVcr0yC+FiQAwQH/ycdKDaFFzT9Cj7KyXIplzxgDqqBKiI96tsvln+5qBLItsIYv3owwC0sdAdEfcO6cETKg6T5CqH7e6EYOeQaD6hIF9skQNjeOLMD7NnAKyPfNrfc2WeWNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072421; c=relaxed/simple;
	bh=zE4YjEh8QdPFxQ8eU7lNWqwB+b6PsSS01RvbHBDYggE=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=b6WTl/3IQ7pSdjnIGKlFAqYubFOsGcO2w4nkqJPxeXWHbYgrMJru6pVCMAyJhNQgc/K1r+vfrOEdSp6f1mBNPyvEcFmC8o66Uerq3ehhSekfGCRVD4+qpo9X+jcong2YsmM7UTCtFQqy4k/7C89P5foX5b5KPXJPsY+y9Tzk8Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b=iOzVcVmo; arc=pass smtp.client-ip=165.173.182.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rong.moe header.i=i@rong.moe header.b="iOzVcVmo"
ARC-Seal: i=1; a=rsa-sha256; t=1792072407; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=L6MZoV8wPfRvlFCHOlpgbrtcOUa7C8NKrZBTXfaUfSlTFHCDAqCELv2ziHorUvL4V/uYgjyugM8Y/k8UZfQNfYaRE3K3MwlneOB0gz8ePO8MiBMnCA0t14FOmnweXgZUIetaZr/4XbuFJvAOKJojb/P9O32AchblXCrcvykaW2Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792072407; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=c6Mv732sGbNbJsbq5B//QerhX6BlAafCTrC6wqDiTrk=; 
	b=JlgZ8VCGFh51MVLWeq9aSRg/b9FNO9tSkwRYXM00xM8eyZg2Q1QZbG53YXG1nLnA1+XwYqzDZQ27Ho9O4zGYgz6pavN3lwf5yF0WEVB8urYISJK/pvHshW2B5DrA/qPpKaT8oFvP8at9vROUAjTgJiG4k7YQSe6dzXjmEK0XWCg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792072407;
	s=zmail2048; d=rong.moe; i=i@rong.moe;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:Date:Date:MIME-Version:Message-Id:Reply-To;
	bh=c6Mv732sGbNbJsbq5B//QerhX6BlAafCTrC6wqDiTrk=;
	b=iOzVcVmop1ZDRYHMs7zrhy9RboHR2oXvps/W/02Va8v1v5pEENsRGv66iLM8+B5v
	TnnE5aN4SvI0jykHry+s7W1B448oyTV47MDPSVT3qmcQzf06GMvb3KAzoQZfazZ0Vxv
	QiBkNg+hhbYg4U9zlb2O2vUPIuREMrAQcWCSfXmpkobdlNPrMpdxpWJQYbeQcnrPWUc
	7227t6Hw+n2wFWAOpZqsv/sheICup5FGPQ7OJ3JUACA6YREYvqTqxw9yg8WMlaaX/K6
	+rhNwRLA9yD23HjK21KM38qHJMIsMaLCxQ7giu9zejCV5NGDGOcAB8Ktt1e2uzBvfH2
	WFIsurUEAA==
Received: by smtp.zohomail.com with SMTPS id 1792072403278583.9180743363034;
	Thu, 15 Oct 2026 06:53:23 -0700 (PDT)
Message-ID: <db52af80e3d52f16a609071db79a29e012f4fcd9.camel@rong.moe>
Subject: Re: [PATCH 0/3] ACPI: Serialize battery methods and INT3403 _TMP
From: Rong Zhang <i@rong.moe>
To: Hans de Goede <johannes.goede@oss.qualcomm.com>, Ali Ahmet
 =?gb2312?Q?Memi=810=946?=
	 <aliamemis@disroot.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, Daniel Lezcano
 <daniel.lezcano@kernel.org>,  Zhang Rui <rui.zhang@intel.com>, Lukasz Luba
 <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>,  Charis Stratakis
 <c.stratakis@proton.me>, linux-acpi@vger.kernel.org,
 linux-pm@vger.kernel.org, 	acpica-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
In-Reply-To: <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
References: <20261014132703.93355-1-aliamemis@disroot.org>
	 <58586fa666f09c209f9d7fe8c692a8bdda6d4410.camel@rong.moe>
	 <7ecfd94c-7083-4d76-a5f7-490ba1e650d7@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 21:48:13 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.56.2-10+b1 
X-ZohoMailClient: External

Hi Hans,

On Thu, 2026-10-15 at 15:13 +0200, Hans de Goede wrote:
> Hi,
>=20
> On 15-Oct-26 13:45, Rong Zhang wrote:
> > Hi Ali,
> >=20
> > Thanks for working on this!
> >=20
> > The series is generally in a good shape. I just have a few minor
> > comments.
> >=20
> > On Wed, 2026-10-14 at 16:26 +0300, Ali Ahmet Memi=C5=9F wrote:
> > > As discussed in [1], add exclusive variants of acpi_evaluate_object()
> > > and acpi_evaluate_integer() and use them for the battery methods and
> > > INT3403 _TMP, which interleave badly on ThinkPad P1 Gen2 and P53.
> > >=20
> > > UCSI (bko221065) is not converted. =C2=A0
> > >=20
> >=20
> > Please leave a link to the bko bug, so that readers don't need to
> > assemble the link themselves.
> >=20
> > > There the contention is on a
> >=20
> > After carefully auditing the ASL code again, I've just found the root
> > cause of the mutex acquisition timeout.
> >=20
> > It's hard to notice, but \_SB.PCI0.LPC0.EC0.RDER being declared as
> > "Serialized" causes an ABBA deadlock:
> >=20
> > Thread 1 (battery)                         Thread 2 (ideapad-laptop)
> > -----------------------------------------  ----------------------------=
-----------
> > serialize \_SB.BAT0._BIX                   serialize \_SB.PCI0.LPC0.EC0=
.VPC0.GBMD
> > evaluate \_SB.BAT0._BIX                    evaluate \_SB.PCI0.LPC0.EC0.=
VPC0.GBMD
> >   acquire ECMT [A]
> >   serialize \_SB.PCI0.LPC0.EC0.RDIF          serialize \_SB.PCI0.LPC0.E=
C0.RDER [B]
> >   evaluate \_SB.PCI0.LPC0.EC0.RDIF           evaluate \_SB.PCI0.LPC0.EC=
0.RDER
> >     serialize \_SB.PCI0.LPC0.EC0.RDER [B]      acquire ECMT [A]
> >=20
> > That's why merging battery notifications significantly reduced the
> > frequency of mutex acquisition timeout.
> >=20
> > > firmware AML mutex that _Qxx EC queries also take, which a wrapper
> > > around acpi_evaluate_object() cannot cover, and Rong's notification
> > > merging in 7.3 already reduces it on the battery side.
> >=20
> > Lock contention is not the root cause, and EC queries and UCSI _DSM are
> > just innocent victims of the ABBA deadlock.
>=20
> Hmm, ok so since \_SB.BAT0._BIX takes ECMT itself instead of relying
> on \_SB.PCI0.LPC0.EC0.RDER taking it (1),=C2=A0
>=20

I guess the intent of holding ECMT in _BIX was to prevent race conditions
in multi-threaded interpreters. IOW, the firmware authors probably took
multi-threaded interpreter into their consideration.

        If ((Acquire (^^PCI0.LPC0.EC0.ECMT, 0x2000) =3D=3D 0x00))
        {
            If (((^^PCI0.LPC0.EC0.BTDV && ^^PCI0.LPC0.EC0.BTFC) && ^^PCI0.L=
PC0.EC0.BTDC))
            {
                BPK1 [0x01] =3D 0x00
                Local0 =3D ^^PCI0.LPC0.EC0.BTDC /* \_SB_.PCI0.LPC0.EC0_.BTD=
C */
                Local0 *=3D 0x0A
                BPK1 [0x02] =3D Local0
                Local0 =3D ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTF=
C */
                Local0 *=3D 0x0A
                BPK1 [0x03] =3D Local0
                BPK1 [0x05] =3D ^^PCI0.LPC0.EC0.BTDV /* \_SB_.PCI0.LPC0.EC0=
_.BTDV */
                Local0 =3D ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTF=
C */
                Local0 *=3D 0x0A
                Local0 *=3D 0x0A
                Divide (Local0, 0x64, Local1, Local2)
                BPK1 [0x06] =3D Local2
                Local0 =3D ^^PCI0.LPC0.EC0.BTFC /* \_SB_.PCI0.LPC0.EC0_.BTF=
C */
                Local0 *=3D 0x0A
                Local0 *=3D 0x02
                Divide (Local0, 0x64, Local1, Local2)
                BPK1 [0x07] =3D Local2
                BPK1 [0x08] =3D ^^PCI0.LPC0.EC0.BTCC /* \_SB_.PCI0.LPC0.EC0=
_.BTCC */
                BPK1 [0x09] =3D 0x251C
            }

            BPK1 [0x10] =3D ToString (^^PCI0.LPC0.EC0.RDIF (0x01), Ones)
            ToDecimalString (^^PCI0.LPC0.EC0.BTSN, Local0)
            BPK1 [0x11] =3D ToBuffer (Local0)
            BPK1 [0x12] =3D ToString (^^PCI0.LPC0.EC0.RDIF (0x02), Ones)
            BPK1 [0x13] =3D ToString (^^PCI0.LPC0.EC0.RDIF (0x03), Ones)
            Release (^^PCI0.LPC0.EC0.ECMT)
        }

> this means that not just
> the ideapad-laptop GBMD method call but anything calling
> \_SB.PCI0.LPC0.EC0.RDER may cause this abba dead-lock, right?
> Are we sure nothing else is calling  \_SB.PCI0.LPC0.EC0.RDER ?

I checked all code paths with ECMT involved, and concluded a call graph
with all faulty methods:

                      ideapad-laptop
                            |
                            v
   battery                 GBMD
     |                      |
     v                      v
   _BIX -> ECMT -> RDIF -> RDER -> ECMT
                    ^       ^
                    |       |
    +---------------+-------+
    |
   GSBI -> ECMT -> SMTE/SMTF -> ECMT

GSBI: \_SB.PCI0.LPC0.EC0.VPC0.GSBI
SMTE: \_SB.PCI0.LPC0.EC0.VPC0.SMTE
SMTF: \_SB.PCI0.LPC0.EC0.VPC0.SMTF

All methods in the graph are never called by any method or driver that is
not in the graph.

So battery and ideapad-laptop are the only drivers that could potentially
trigger the ABBA deadlock.

>=20
> Regards,
>=20
> Hans
>=20
>=20
> 1) I guess ACPI mutexes may be taken nested from the same thread

Right. ACPI mutexes are re-entrant. IMO it's a broken design by
encouraging firmware authors to write broken ASL code.

Thanks,
Rong

>=20
>=20
