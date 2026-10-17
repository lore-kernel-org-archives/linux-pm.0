Received: from sender6-op-o12.zoho.com (sender6-op-o12.zoho.com [165.173.180.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FAE187346;
	Sat, 17 Oct 2026 23:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.180.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792279406; cv=pass; b=DQ+s503ahk9q0FWO9vk4oM8z5ENbN8HziPjsZ4dD7zKO95prZylDgsR2CXffemDJeJgQmOl1EgTxjnjLAYh1+3FTmDtjYcx0hJ1xqBDibBIs+iaBdraoyji7srWzBTm4eOD1LqyGWHqjMuCXtUYi5JVeUyqgr5f1Gk/MaKMOFCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792279406; c=relaxed/simple;
	bh=7JiNBl//YpX+VSQcWyn+xXcvAvFIuTNuBJtyOnuAHOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BOSktKz6AkLZz16RrUj/2u+XwjMFOqTqUjwr2N4Fq2ppEgwAW0yAEbkWm+KRsw/LG0ynQKIg18LbjyNyKJJ3RKkM+AU3ghYgzJKBKnSxgHDCaWAY8KDKOzu8HaTrnivgaZrffwK4sQJ5/TT5xxgB//rYFrrrQGoxlZjSTCA1fac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b=XHjHh0eV; arc=pass smtp.client-ip=165.173.180.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sebastian.reichel@collabora.com header.b="XHjHh0eV"
ARC-Seal: i=1; a=rsa-sha256; t=1792279398; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=b7zpmcq3unhKOPSv1s3p4DvxCWLosR9KWh0HcY2eEEO93YTubC4qzpnEzZXMNmlOPDWzPAspzMnFeds0W8UM2ziYMT0FgmFmW1gL47mVbgUTlOnHCEOwwJQ+516AKmxTlGK77FzTiDOEeAXwbrp6T4tCH++riLVNSI8HUhpQ4BE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1792279398; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VQNyQOOeUCbxSE63mAZ9HBkM0mucvVeEtMqOuADXiGM=; 
	b=GWCKMr1+xRHbCn9SAxrCtzuR3AsZoNJVeQmI1uZXRgBYxQ3q2SYT273enxE9cKO+2LDxCOfWURJfve0P4aGwK0amiqhVa5TcPyJa7RO46y3K/zOKsSU/T8E2odW+6GixO6pSjXySUArAg29PQrp/kB48cMgs74Vh+X/lPCmmWSc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sebastian.reichel@collabora.com;
	dmarc=pass header.from=<sebastian.reichel@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1792279398;
	s=zohomail; d=collabora.com; i=sebastian.reichel@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=VQNyQOOeUCbxSE63mAZ9HBkM0mucvVeEtMqOuADXiGM=;
	b=XHjHh0eVgu8QyNoV5RhLf3lsEkRMk92G6MsmOPmqC5EoCJzKkJs0jg8m7t9QCBtf
	U7E37Q7lvK7/Fsi75vhkUlRCcrUKM6hsvE3vnJpsZezc1OCRdWiprOTWEbCGf6DTFhw
	ohyN5sFFtLHeS98bI1yUI0bmXkCXo6Olnna22anU=
Received: by smtp.zohomail.com with SMTPS id 1792279395451303.9284849372026;
	Sat, 17 Oct 2026 16:23:15 -0700 (PDT)
Received: by venus (Postfix, from userid 1000)
	id 672A618233B; Sun, 18 Oct 2026 01:23:12 +0200 (CEST)
Date: Sun, 18 Oct 2026 01:23:12 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Bjorn Andersson <andersson@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: supply: qcom_battmgr: report full batteries
Message-ID: <atQCEUI62OYTDUcO@venus>
References: <20261008-battmgr-full-v1-1-4f5485a9c421@oss.qualcomm.com>
 <32681ae8-3356-4570-8631-650fcd88c803@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xqfpaeqjdfww2pkq"
Content-Disposition: inline
In-Reply-To: <32681ae8-3356-4570-8631-650fcd88c803@oss.qualcomm.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/292.264.81
X-ZohoMailClient: External


--xqfpaeqjdfww2pkq
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] power: supply: qcom_battmgr: report full batteries
MIME-Version: 1.0

Hi,

On Tue, Oct 13, 2026 at 01:21:53PM +0200, Konrad Dybcio wrote:
> On 10/8/26 11:14 AM, Bjorn Andersson wrote:
> > The SC8280XP battery-status response has no explicit full state. When a
> > battery reaches its full capacity on external power, neither the chargi=
ng
> > nor discharging bit is set. The driver consequently reports "Not
> > charging", which can make userspace show the system as battery powered.
> >=20
> > Use the response's power-online bit and the reported capacity to identi=
fy
> > a battery that is full while externally powered. Preserve "Not charging"
> > for a battery whose charging is inhibited below its full capacity.
>=20
> Let's define that bit, as it's not obvious what it corresponds to.
>=20
> >=20
> > Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK powe=
r supply")
> > Assisted-by: LLM
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
> > ---
> >  drivers/power/supply/qcom_battmgr.c | 16 +++++++++++-----
> >  1 file changed, 11 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply=
/qcom_battmgr.c
> > index 7716eb9e1aff..97cbe966ea84 100644
> > --- a/drivers/power/supply/qcom_battmgr.c
> > +++ b/drivers/power/supply/qcom_battmgr.c
> > @@ -1261,6 +1261,7 @@ static void qcom_battmgr_sc8280xp_callback(struct=
 qcom_battmgr *battmgr,
> >  	unsigned int opcode =3D le32_to_cpu(resp->hdr.opcode);
> >  	unsigned int source;
> >  	unsigned int state;
> > +	unsigned int power_state;
>=20
> Reverse-Christmas-tree, please

I fixed this while applying.

> Claude also has concerns regarding how this interacts with charge
> limit (although perhaps "not charging" should be good there?)

Not Charging generally means the system is powered externally and
the battery is neither charged not discharged. The Full state is
effectively a substate of Not Charging. So the main issue from Bjorn
is a userspace bug.

> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>=20
> Konrad

Greetings,

-- Sebastian



--xqfpaeqjdfww2pkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmrUA1kACgkQ2O7X88g7
+pqEpw/+JQujOen77k8Z3BTdBzov1WlfGE3hlmTZNFhdRzuwyYIGLf++OkLRzz1P
2ssPjNHCB9EYYXbrbqBhEXRY0j0EREXVwjmc4Hh6bNAHZNTPUqWPvN/d6/3ArYGx
iZR9FqD9+V/S5+1Ao15Ddo0AlSIoefmlRmaKEbc9KtE3oGpVMGCFtcs1WlvYNMp5
7UTaxtLvllItfD9odTnkz2td48r3gu8nJPXRsWZ2o+KL1NuZItsCug1FvKeM1H3B
0v8/oEmFUPeAgRQxyYVr/O4RQnaFiJsZkoxwNSXohUGuub0bZtpdgPXFrpPupC69
MPP4JrEcSxDrVHwO6MHcqtw7trcsPUIP83YWTFonHCJtl9ijKkq2/l9Ym+kSohPK
he25VAFVQxOuKnyMETUJ7n1tco31hgD1lZrF42SVRaSzoR4PNqXMAatUJphDZsNi
xyF9dZe9WKxvp6DN4AYwQKhMdNSbV9O0IrIv9BlilYLxLki2sWBA4N28q6ysGRQG
7CGaSwIteXdtD0iLzDMHx47bojKCbMs40A2bg2NlVAszuQX4g2LKmZm0n0bYHou4
2Zlc4cgiztNr9YrG4HnlH/iTwZn7U6DMACVs9hWQBfR7HJ0qrIKMrY3hewRwJyG2
MhMh1Z7wkq5Bhf/EGlVfi6kr7bsB/RPtSoHaoLaIg1rQBlRZD24=
=q3Zt
-----END PGP SIGNATURE-----

--xqfpaeqjdfww2pkq--
