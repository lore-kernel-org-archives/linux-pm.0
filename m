Received: from tabos.org (krueger-it.net [145.239.1.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372403E0724;
	Wed,  7 Oct 2026 20:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=145.239.1.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791403918; cv=none; b=U6g9mGVJ5h/tcQJfQVap9ZXDwr3c4JQjPu+NDiEVgqAaryxG0zgQ998DhzduoHyEc9cAytKERlqaBlN/xGdRzRppujRDQuJrqZfEwXFQ/HouHTQ4M/dC+2ceSkyM2zQlbWriHG2ojuOuMz2+rhJa2+WOs/Ub3OLtjWDeIHpvxvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791403918; c=relaxed/simple;
	bh=CduJo08thxp5QM4qt+zcNcOtvM1VU1HT6gn3YLz2Q8s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DuQTjzBKYOhXe1qgZU++kZVEiUwT55K0vli4z5OjXkyWOO4aAqLWUCo0XVAMY9tGVGf24GS48sLJ3T6Sy6ZPctiAmZ5u4OvGxWFvvAuUJqynrCCczX5o/jIfWkm/PPjPyMIPlEdoGDHu+gV0u5cZPwnDf3+KiJJx86Qjn638az0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org; spf=pass smtp.mailfrom=tabos.org; dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b=TULYm6Q7; arc=none smtp.client-ip=145.239.1.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tabos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tabos.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tabos.org header.i=@tabos.org header.b="TULYm6Q7"
Received: from buzz-fedlet.fritz.box (unknown [IPv6:2a00:6020:4959:6d00:63f1:51d4:a6b1:3f19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by dserver.krueger-it.net (Postfix) with ESMTPSA id 506DD62E019D;
	Wed,  7 Oct 2026 22:06:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tabos.org;
	s=default; t=1791403569;
	bh=KL3AwC5Hsot6UNPptFXC70kmjxyuSzLbTRTjr3A9wlo=; h=Subject:From:To;
	b=TULYm6Q76bZmqdyAScz+zCC5Vbb5bQ3e7fSROnLqt3jIbZ8trGZRerJ2QjMVF1pue
	 0RJ1WY5ASfRv3SpQnIGDTpM+zGTzIJCHykuA+sPsQOv7JXIklwWGRvoERqbBhs5XTG
	 wk5cnWOIffj7qXCMWO//+hLRIjq+2m5Cc7Li2zHuttMfxRimP7fvrXK4xh2VMhhCBe
	 INW2Yue8VPTCyGF+a5Ue3ql5QOyRGON3NZq2nppZSh1VTpZvu4rnyAHll9sE60whYB
	 e7VLm+cLsQaukvQzvFKs8CcdVpoebmYsD/kufu3Yh3PntNWwbMRPKXb0CaYNhMYc7D
	 vcIlwGt62s6fA==
Authentication-Results: dserver.krueger-it.net;
        spf=pass (sender IP is 2a00:6020:4959:6d00:63f1:51d4:a6b1:3f19) smtp.mailfrom=jan.brummer@tabos.org smtp.helo=buzz-fedlet.fritz.box
Received-SPF: pass (dserver.krueger-it.net: connection is authenticated)
Message-ID: <128d3b1aa9aff8f1a2d1cd2173a9469110b0dc17.camel@tabos.org>
Subject: Re: [PATCH 2/2] power: supply: qcom_battmgr: expose CHARGE_NOW on
 SM8350-class firmware
From: Jan-Michael Brummer <jan.brummer@tabos.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, sre@kernel.org
Cc: andersson@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 07 Oct 2026 22:06:08 +0200
In-Reply-To: <73e4b46b-6a26-4124-920c-7638b449fc1c@oss.qualcomm.com>
References: <20260829054546.86210-1-jan.brummer@tabos.org>
	 <20260829054546.86210-3-jan.brummer@tabos.org>
	 <a2f3de2b-90f6-427d-9994-a8b1ec8cbed6@oss.qualcomm.com>
	 <73e4b46b-6a26-4124-920c-7638b449fc1c@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.0 (by Flathub.org)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Am Mittwoch, dem 02.09.2026 um 18:21 +0200 schrieb Konrad Dybcio:
> On 9/2/26 5:02 PM, Konrad Dybcio wrote:
> > On 8/29/26 7:45 AM, Jan-Michael Brummer wrote:
> > > The SM8350-class firmware does not implement a dedicated 'charge
> > > now'
> > > property. It does however report BATT_CHG_COUNTER, and on this
> > > class of
> > > firmware that value is the remaining charge in uAh rather than a
> > > monotonic counter. Measured on a Fairphone 5 with charge_full at
> > > 4116000 uAh:
> > >=20
> > > =C2=A0 BATT_CHG_COUNTER=C2=A0=C2=A0 reported capacity=C2=A0=C2=A0 cou=
nter / charge_full
> > > =C2=A0 2434614=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 59%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 59.1%
> > > =C2=A0 3525354=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 85%=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 85.6%
> > >=20
> > > Map POWER_SUPPLY_PROP_CHARGE_NOW onto the same firmware property
> > > and
> > > store the value in status.capacity, which the
> > > CHARGE_NOW/ENERGY_NOW case
> > > of qcom_battmgr_bat_get_property() already reads.
> > >=20
> > > Together with the preceding patch this gives userspace both the
> > > full
> > > charge and the current charge. UPower now derives an energy level
> > > and
> > > runtime estimates in both directions:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 discharging=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > charging
> > > =C2=A0=C2=A0=C2=A0 energy:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 14.4347 Wh=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 energy:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0
> > > 15.6003 Wh
> > > =C2=A0=C2=A0=C2=A0 energy-full:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 16.8807 Wh=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 energy-full:=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > 18.1505 Wh
> > > =C2=A0=C2=A0=C2=A0 energy-rate:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 3.39313 W=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 energy-rat=
e:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > 7.3492 W
> > > =C2=A0=C2=A0=C2=A0 time to empty:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 4.3 hours=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 time to full:=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > 20.8 minutes
> > >=20
> > > Signed-off-by: Jan-Michael Brummer <jan.brummer@tabos.org>
> > > ---
> >=20
> > Ok this makes more sense now. We should still gate the other
> > property though.

Hi Konrad,

so this one is fine and can be merged? Or am i'm missing something?

> >=20
> > [...]
> >=20
> > > @@ -1442,7 +1445,10 @@ static void
> > > qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
> > > =C2=A0			battmgr->info.technology =3D
> > > le32_to_cpu(resp->intval.value);
> > > =C2=A0			break;
> > > =C2=A0		case BATT_CHG_COUNTER:
> > > -			battmgr->info.charge_count =3D
> > > le32_to_cpu(resp->intval.value);
> > > +			val =3D le32_to_cpu(resp->intval.value);
> > > +			battmgr->info.charge_count =3D val;
> > > +			/* the firmware reports the remaining
> > > charge here */
> > > +			battmgr->status.capacity =3D val;
> >=20
> > Let me try and find whether we can rely on this - on newer targets
> > many properties are more or less just front-ends for vendor
> > plumbing (because there's a ton of different chargers etc.)
>=20
> There's a comment saying /* remaining capacity in uAh */, so it seems
> like this should be OK
>=20
> Konrad
