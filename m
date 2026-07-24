Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3222F549F
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905491; cv=pass; b=aKYVmoBBnzor0+qNVfpgwifofMxo/QLmz04F0qe9RyC/8Dph1d02Ay5BtHM0AydMRbl58uQvgoZDNPTq7DNNk+TAlJ9opMvjYh2aRu8xZDoVdQOh4LQZXxXnbP2Ln/Sc4HJ5w3F/Z+9/GQUX1ITkcNkBtUvz7Rp2TUi57N3E9pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905491; c=relaxed/simple;
	bh=1yHOw4P4o3+O/DBp60Yv8U9QuZtvtdOsTb8sPScZobc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=klCBTFGBz4/j0Ef2LHN9aSJJw69avC2SjdDMmFnPkLX24TnVNURBIaTnw+R4M+NWLsED97oCkT5iTRJtu1bKMGsjhm91WBIoqjmML1gSopIsK4AyTPSom0AMpiwlNRlxG32JIhIcS7uSKr83r4bfJ4XQTOFLvKYZgl/OaH+aJ/w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRXtDmS3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QgpXI1/H; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRXtDmS3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QgpXI1/H"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbD5p3487364
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:04:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	HH4wO6nyRrZiBShi9lrjkrI2flnam11wcKl2gFHmy0g=; b=oRXtDmS3bz5bCRAA
	Xrtyft8XmVNUktvTsBKk6PH7dx2YwG9wHqGzfQhzzzHscbrpzGoTexLy+OaMwCcd
	Yo9lo+BHdJ/Ygy1NJrgLnqN5Vxu3P2RK4/sgS23aZAZcLn+pYMB7rMHqlSSTH2bq
	Ljo1qSBiDQH+tGcF7Qgrxstfuo55QOr3RRA0JFmJRxbOzVYvGTQeC070WaF4Vh5M
	F5LNzWhhWuG5/MbfTNpQhsoVXqhBQ+AcaP5s7oNx3vEjEsEbSjC6zTD53P0yrR57
	WYLwjpiHf4CjY/zdWIkd8B90i4/n7rlQ1uHC2BkHpW/9EHDQQbm2dgwTa/mcSMNH
	9sVGNg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fkqa0ca63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:04:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e56b2b350so107751785a.3
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:04:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905489; cv=none;
        d=google.com; s=arc-20260327;
        b=Mdw0QDqGLljRwPviZK8E200JekFdYqgE8emq7Q36T9vqRZ5KHwiAv4QkSTmW8DeZtg
         TLwXoXhdifct44du074xbZSlHYs84y7C6mqO2d54GrVxs+RYaIVdWvitrsLUZKrDBMYx
         otRAHjPvZ3gNvywNwIAR2MqSvlu0HX2BAUiTBdx3wmMzNYFN7DNtrVCsHenNDN4d6DMy
         pumrsSGA4sm/8zjCBC5oQwvQXjy/NL1ojNvgKJ9/bSzDEg1pnIQ+jHArX2fofxfvv26v
         bS2/Zm5yBN/mL/BM1nxcdYE3m7Gv1s1pXRUgVS+Ki2cSXZfhqDBf0kiAxkDkfo6kexpc
         toFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HH4wO6nyRrZiBShi9lrjkrI2flnam11wcKl2gFHmy0g=;
        fh=PzYEwNQC95d3jsHUgF3SPvtZvsqWbPR94Nr3FiDEF8E=;
        b=lXnAq0cfeU00050i2q5XUaC+nYkvF7FqMcpaJTmW5fgnOGcNRXK/qjdLiYA1C2uuEa
         cLXX5Wk8+E/2eKWbSDSbPGuWwKJoXmbTWmKRCNOCJYfjW3PbxGz3g6gJ91cBbUjlGSTY
         0fU0bSVxS6BsB52lvBQWj3H5dEps+NeNEjlrRqhPffP04EA2ai/3+1kPgULPF6067oG9
         /UT+cHYTX1Frtu8dRgyqnFg+WCftbG9NfBHe5sy+77BL6GkFg738UPuAOsRORRP7Ch0/
         cXnr6TIQrpK3IwcJATheXaliB9SZDVUfx2CovwwKEqLAQomWrwe1iS1szsf8HybTHtMr
         0blw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905489; x=1785510289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HH4wO6nyRrZiBShi9lrjkrI2flnam11wcKl2gFHmy0g=;
        b=QgpXI1/HnPJpMcvw/34D6EpKsh39EkvyhTY8qhHSNj2ZbE9PpOFYMcz7/tuUPFrhPR
         Pk0zJfiIdJ71bfmxfvHj4vceE/n1r7XKE6FTl4TGbvDhVsxT22P3+pMTCGQoZ0C4V8eJ
         p4QEW+C4ndkGaRhTCzrRaw1jQWRFX1KakN7LRtZCngEPb/na5HQGPdVJm22RZaSOJrkR
         joLDZ+V7G3MQq8mA1XPeR+T8w67RsJZQndaQUvL8Ar3GhQtLSzU4W/ApZ2RAAjPuBMXH
         RUmIOQtaqU2QGbaOiFxfYM2dMfRj3ctGND1gzt2IU8M9Bmu4QmUEexp8RGV86wRlguey
         fePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905489; x=1785510289;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HH4wO6nyRrZiBShi9lrjkrI2flnam11wcKl2gFHmy0g=;
        b=newg6GTCVGzFF1xcXj8mKPA2Rlj0ZTsG1O4Q0kt+6lbCiY/RI22IDA2AbFWoCUJVhq
         fpp17vrJv3Mo7RwLOaZMtnZXh6f5Wubo8NjP9az2E1Lt7NgfywBOawKpSN8t0JOug6uj
         ViSe1C+qvgivPFYMfBnFzdg/EYT8kt7vG4yszX4XZDgh6t+P4xyF/UVqjUkkFSY+eGkT
         KsOU5+7ygjoyD7TxCtYIf6WBxLVi6LhbGUNMkX90qW3GUAL03NTR1YJ/3IioK5n6sUnU
         /IV20nww8qiXtCOa72Gplhcl+5E3JNajFFG8NMAy8p+Ivwws0hsKUAiDg/IolIqS0yLI
         ZOsQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJfZSQotHUrp5ToIn2ogyN2ILlKZ/Y8uGj5HWv0bvFKYfFE7UJbJ4OtOgDUuRWoYJUzO8DPjJm3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFqzvMd08Z7yZ5yCQx0VS+0lvsHUoJgKaG7TTLDogfQ3C6X440
	9g/AuSXFaQUnVW8Fz4+nJRNFEi+bwsIYSQr6tvWxwWp1Df6dE+Ymp0oacPCVhnUaUSHlH89UP1K
	oa+QSE0SyziWQx06fnSKCCSqZTyNII2fvOePKT8xl09NYTR1F1deVBgi9iADlA9xJB/tuk0ekKN
	aojLnfE3ZaoKcfz26mlrdFY4eEuSZNBMV7y2QJ
X-Gm-Gg: AR+sD13kW76IkwDnJEiPFSVpPAn2mzJ4Uh7L2zundguO2mwYXqMTFVGnxWuO69oMJVK
	9zea9vtBuLgctKrbmMn+i/8vk6mUjyNRkEVRGz7xPkXWj9fZZ9f2+sGsAHx7VlHZfWPyFT9Sxjd
	TNQchHpISpdT0A2Z/dWyyu+uMehPEiK9+7gtKuwy7MQQXcMQF83k8106q/hg==
X-Received: by 2002:a05:620a:2a15:b0:92e:46cd:72a1 with SMTP id af79cd13be357-9310391f2b5mr828737085a.5.1784905488417;
        Fri, 24 Jul 2026 08:04:48 -0700 (PDT)
X-Received: by 2002:a05:620a:2a15:b0:92e:46cd:72a1 with SMTP id
 af79cd13be357-9310391f2b5mr828731585a.5.1784905487953; Fri, 24 Jul 2026
 08:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-rpi-pm-remove-v1-1-e4eed226e08a@linutronix.de>
 <CAPx+jO8EPX2br9vsuFXBDPoQTF+Ks09MFcFQzchZxZVaj7y=-w@mail.gmail.com> <ifzlb2b3rdoo3hckhga7ggmmd3j5ub4a2krb4g25sh6naoxeyj@64ownhquehue>
In-Reply-To: <ifzlb2b3rdoo3hckhga7ggmmd3j5ub4a2krb4g25sh6naoxeyj@64ownhquehue>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:04:36 +0200
X-Gm-Features: AUfX_myV3Jm-ftEp1guJqTHh984-A-3KKl2vVDttM8ic7zL9cWO2QF5T5wk0EMc
Message-ID: <CAPx+jO_eG7Eu5C_PxykYwDpQOqGzD+3Kf7OgYC_4pE68rT1D2A@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: raspberrypi-power: add remove function
To: Gregor Herburger <gregor.herburger@linutronix.de>
Cc: Ulf Hansson <ulfh@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: PFfmQsxg-IkSel6UHjTrRvppBYmNoIfB
X-Proofpoint-GUID: PFfmQsxg-IkSel6UHjTrRvppBYmNoIfB
X-Authority-Analysis: v=2.4 cv=e/k2j6p/ c=1 sm=1 tr=0 ts=6a637f11 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=UovKDt9gyfZwSysGnsYA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNSBTYWx0ZWRfX1WiASaTZ2Xjz
 uOaCLYICt8T+xUzxOnx9v89yurUPWwTw+xgiXnWZUu2OZLCcQ8No6kxMwGBvfEuCVNtnqjn601S
 E0VlCVhU0BFYKLdjRqOvr2YYpJvIGV7x7Qo1Uzhn6m8x9W0n3VzXB3aA/yJMvcy/Ue/saNexdpc
 XBimUsFV5TAYAM9wqe8XMNK1XTB5ker3fbHYe4RU0Qn86pq3KJ+/nuSfmsetzhiESTTulcyWwbK
 99zU99aOcNqdu9+LwMIHulLBrUOuE4n+bNhhXzlCf/UccSgw8xUTx7VhvC1iDPHd6RnXPpGWjDj
 n6tCzgkKjMZjOHCQv19DmVDlDNzFQ+qzhKB0djTGFbFq2s3ZA3pPGoXKEyWUkLSKlE3GjqlHPtd
 EUmTpH06szyE468Q71qqIX9wMXiYoEwx3nPpgG4DP2HucLTw6vXYRMFwSVonottA8prW5W3F91Q
 usPQ2oCniyAujIVOCXA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNSBTYWx0ZWRfX6qK7Z1sMdDvQ
 n+7cCjnVU1m1t1FSiYquFVOePH7nEpVy03DElBldfkt0K7zADaaD05DAEs6TRDwXW2S5LKH4y3K
 X+6IK1i5W14nEyKsOXc8lI65akG7Qrs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240135

On Mon, Jul 20, 2026 at 7:07=E2=80=AFPM Gregor Herburger
<gregor.herburger@linutronix.de> wrote:
>
> On Thu, Jul 16, 2026 at 02:28:15PM +0200, Ulf Hansson wrote:
> > On Wed, Jul 15, 2026 at 10:16=E2=80=AFAM Gregor Herburger
> > <gregor.herburger@linutronix.de> wrote:
> > >
> > > The raspberrypi-power driver registers resources with
> > > of_genpd_add_provider_onecell and pm_genpd_init but never removes the=
m.
> > > When the driver gets unbound and bound again this causes error. Add a
> > > remove function to cleanup all registered resources.
> > >
> > > Signed-off-by: Gregor Herburger <gregor.herburger@linutronix.de>
> > > ---
> > >  drivers/pmdomain/bcm/raspberrypi-power.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/pmdomain/bcm/raspberrypi-power.c b/drivers/pmdom=
ain/bcm/raspberrypi-power.c
> > > index b87ea7adb7bea..2c2135c17afb0 100644
> > > --- a/drivers/pmdomain/bcm/raspberrypi-power.c
> > > +++ b/drivers/pmdomain/bcm/raspberrypi-power.c
> > > @@ -232,6 +232,17 @@ static int rpi_power_probe(struct platform_devic=
e *pdev)
> > >         return 0;
> > >  }
> > >
> > > +static void rpi_power_remove(struct platform_device *pdev)
> > > +{
> > > +       struct rpi_power_domains *rpi_domains =3D platform_get_drvdat=
a(pdev);
> > > +       int nr_domains =3D RPI_POWER_DOMAIN_COUNT - 1;
> > > +
> > > +       of_genpd_del_provider(pdev->dev.of_node);
> > > +
> > > +       for (int i =3D nr_domains; i >=3D 0; i--)
> > > +               pm_genpd_remove(&rpi_domains->domains[i].base);
> > > +}
> > > +
> > >  static const struct of_device_id rpi_power_of_match[] =3D {
> > >         { .compatible =3D "raspberrypi,bcm2835-power", },
> > >         {},
> > > @@ -244,6 +255,7 @@ static struct platform_driver rpi_power_driver =
=3D {
> > >                 .of_match_table =3D rpi_power_of_match,
> > >         },
> > >         .probe          =3D rpi_power_probe,
> > > +       .remove         =3D rpi_power_remove,
> >
> > In general it's not a good idea to allow unbinding power domain
> > drivers, as it will probably break consumers and their drivers.
> > Although, I don't know whether it makes sense in this particular case.
> >
> Ok. I stumbled on this when I was trying to fix an error in the remove pa=
th of
> the raspberrypi-firmware driver. I have not checked if all the drivers st=
ill
> work so you are probably right.
>
> > Another option is to prevent user-space from unbinding by adding the be=
low here:
> > ".suppress_bind_attrs =3D true,"
>
> That would be the simpler solution. If I add this for this driver, it sho=
uld
> also be added to raspberrypi-firmware and to bcm2835-mbox. Because withou=
t those
> drivers this driver wouldn't work anyways. Should I add this to those dri=
vers?
> And remove the remove callbacks?

Yes, that seems reasonable to me.

[...]

Kind regards
Uffe
