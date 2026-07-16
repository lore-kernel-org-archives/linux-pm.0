Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69CC39F191
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 15:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784216769; cv=pass; b=X69uJqkWtDuJwbhqgdGpdF+AI8l/vjsCBLP3oReqjwwssPI5CulpvWK6qeGwFaz3jZ0JjtHZ+qYXD1UTw0JUjmn3MO6AL3yszgl3k7Sy5dPYUi4NP9ODCssn2zAr3I5UYMeUDJ/RWe5ZBLsApZlq4LrUjLKcCrUX5Pg8Uy9/3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784216769; c=relaxed/simple;
	bh=OZGEF2emtiuHK15ItQmuCRN8wNze8eKQC2CdaVRwh64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fyg0erA0DxsmEw7sp6+YI0wnqTp9Flhm44b6xFQ/fhUDMUyfb+oAJ+QLfhBLsGsHykBQIRkU/tHzXVNU9jqGCc6oxjWtlQ/WgsI9vGjUbvtFGFfMyjmvAyhVqLuaJ9GIB6JIDztr+poNkPhcLUOapYpXsKCSEKTIYO/BmzbVZY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FUIZhSGN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dEmhFQQ3; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FUIZhSGN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dEmhFQQ3"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJvT52838020
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 15:46:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=; b=FUIZhSGNkDxiCWaM
	EJ4RUB+hfB3tOgb+1kGgQVAJciKke+hEDM0FAnLlSi604B7ccKMnjFzupW5BCQab
	kstEbZHlMgNve9ly7m0kJnB4BpvgGOM4/sy12A/WqD0p10vinVPTIKFpY0vIOTC2
	NNdR+61+OvOMn3+QBoT+H9BINQVb0XamqAC34pdHE3AFahRMBiFirPNEkorHQTV5
	gxev50CWP3yN6TgIe9P7K8TSx/UQJtxxmRNsTnsUN2LDvbAwck4pMrCVQ39uouUs
	HdKktWI4LE4c//gRH1ZfLunyhw5hJoIsfomNKXLpqjXRddb4OgTOjnMxMdiRCv2s
	CnENJw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feefqmqrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 15:46:06 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c1852a86fso76932231cf.0
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:46:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784216766; cv=none;
        d=google.com; s=arc-20260327;
        b=l/qeVIHHNMQRNNSs/Oetw1DM+vGEgjD190smh1Qi2W/7sqcKZ20Otk2DVh/hyZt3mg
         sF7CWROpIVy1V/2y+XX/F5MY/m7B9euqNjmiRZUPulxj3z+a0Jpls6mhh45pjyON9E7N
         TDr4iomJnJ1C/CqB1n0y4nScUYknj8OFqdRf9mq6aIK+wX9PqDXkAJnEd+AUnB1bn+dz
         83pMX/x3H47veVtwMTNiec011/DmNAaXiLNYnuv+WK7rvebmSBEPKeLgx/OOnnuXd/5X
         6vssPjppNIjsyy2Whb8wSr4CyFfZ68X/BjvF6eir9/OLsbX6cmbhNoFYFDrXf7QSA5aP
         6IwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        fh=WZRSf1ccacPdSHdQyBxkiS5yQ6WveBWBwUEsRJF4kGM=;
        b=G4x0M6P4iTXIfVCtTGIoigfftfB6WtR4/kpPvfhS+nDAv9mf5ZMWpP2rSNEMuVEFDW
         WuikbOCNC537S1HGjO6qD4QHs0sTsICvX/tpNHuqRGUG7LmSiZBKAqLEeFaDwQrXEoBd
         ik8c/X87DxcyBuup1fA1b3EQWqqJula+DA1jlDYGgBTiS1BqcLXfnPT+iD/lOMBH/6Zh
         nAFUQbdUao68sbTxO6wtw/2iXLS2F1vRPlUIoVCg2rNKxIHalNVDpJ+PnSLg6xzNpfHn
         zqeE4MrLRblJyvF8XU93FMRkj1fxb2JF6OYJDeEC9JfMSmlN9px+QbPPGGsAvmrSp25m
         LbjA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784216766; x=1784821566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        b=dEmhFQQ31ITGKWGljChZM1krIKv8FKBr66NaH1wq3ZJXEm+Sjh4HOAfCnBEMOWu6Pq
         t1LntwAh+U7khtGdydjHJI2FXdq+4Fr/ac3DahXSfnbxmhTGRiu+jolQtLSepUYg0Iew
         qQjb6r5LEfm6mtXC03c5kcXU3iRZtikifmGZE76p1WrEf84ufOz6mD70ZvcQd1z16W5K
         j0KhUQNX5olXBjpMIwmtbeMbkJt2F6ZQjhvcqjvahEuNc9yA8fVZMV1h+Itl9kWzAA5i
         jSxtCAQJg+CgR8Td6kWJcBk+lm/ra/c0aEVarMwPveFew1hZn7+stKo2ckhG2fuueR6G
         MtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784216766; x=1784821566;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaKMG7bPmKzijn8fMJPZ5Vh5EOk51mz9rGu26Crb5wY=;
        b=HDPuTPSdqMH/srl8q6zlx78FDwqKwlBYCkZ3cvhKqgVS58aT16SVij/S0Uhdbk5ODU
         qUjUEolklzSfefzihb4QOLsmRX79SSz9CrnQ/pTdGC1FaXPzNqW69c4g6MgzrWc33qg3
         WE6kgM+B5q3+avkHHDi23UtRtMU5zjptEy1DfGMEdy+hCb5rHvP0sb3T2pDLI36atIgU
         AbdT9pKn9bWqMGqyP6exgE0jnvKO5AiAJrk0HKm1SYvxc1MZMJXrfqscI1dymWVShbdD
         ZhQ0fM/3WN9/2lrlL1XDilsmNzaWvIk8IzKfaOR3CenB+n4njHiisNpPOy5NEH/cZzry
         ZSkw==
X-Forwarded-Encrypted: i=1; AHgh+RrO9in/gaThQFTKiL6CFE813NotdNM+kMXCB9UOfzFr3Huho4ontlKGrOdFm+heMSSqmxFYSEq8cg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbxAoP5JDtRSPC5jxshDqmxmFriPpoubbBrCpsJMS8XlDlBK6N
	MsUwKX6C1N88o1PwBXs9HuejtpnEYeI6GyE/pVSEqPiPVXO1v7mCCXkY5K5+Lwqlc1CJyLHYr0z
	14453mpmCBzNREmXmL+Vk+8b1Qsorbq/b6t3OGGTb4hZdLWzYLaQHh9iS5JWnX35Kmc+E9EWxmD
	31+IFT9iDS2b10wloUPqMqzES/ETKdw9hLWanh/jWvUmy+kKU=
X-Gm-Gg: AfdE7cmTx3wI2UxE7DMr0FZ2+eSzHw1fVrcCP9ld7VVr494BZTjo6WljifH5EENDwY5
	uMPnwXFnXlIrsAF0qTPL4TxshpJGQgcsB1msNUDTV0SrA7JdrVitrNxeviPWrjYybIcjft/TwjG
	TMf9qkE/+d0QM/BcC5NudzbhbFwwZLWwPuvx9/hZjmsO+u3tX4oJO7vehO6p1AWobVJoEFM7mGP
	l6V+tpf/zRFltsswSY+s/jELlJMGnmo7+PEzShJfr3CzXlvf1W+Tqq9dLvrCj8CYVCmOrZmGsSr
X-Received: by 2002:ac8:574c:0:b0:51b:f549:c706 with SMTP id d75a77b69052e-51e423528d7mr115572601cf.16.1784216766030;
        Thu, 16 Jul 2026 08:46:06 -0700 (PDT)
X-Received: by 2002:ac8:574c:0:b0:51b:f549:c706 with SMTP id
 d75a77b69052e-51e423528d7mr115570511cf.16.1784216763565; Thu, 16 Jul 2026
 08:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-4-46253587af64@oss.qualcomm.com> <txl2wo47ftsaqwh32x63kmhqwqjx5xpszoazccyeqdqmjzh2rv@ocev6u7vzdiq>
In-Reply-To: <txl2wo47ftsaqwh32x63kmhqwqjx5xpszoazccyeqdqmjzh2rv@ocev6u7vzdiq>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 17:45:51 +0200
X-Gm-Features: AUfX_mz-fKvzynmtc1c_-d4E51SyY4cnAP-WK134FPMEMzbs42O_5YCHtKpJhKI
Message-ID: <CAFEp6-02kqoDvvGSYy+2uM-gzvhrH3OTUGaxu32pEfj=kOVHPg@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] power: sequencing: pcie-m2: Report power controllability
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=APNfGQ4N c=1 sm=1 tr=0 ts=6a58fcbe cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=4upAz5BH4U1jwP5PTYsA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX3ytguli3Spnu
 /pvAsNF674BXfO9wSozSsjL2zDSxWP3RpuYrW7y3CQ6T0wi/fxm53EBpDpDQq2tIE5yI2pMWftE
 Z7dqfe4OHEvhVXcrfSPgEkNT7URXJw4=
X-Proofpoint-ORIG-GUID: wOKSzATDJGZVfk7YMdnQlMcJDkVjMl7F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX9DQOd8uTHr1H
 imqCzDT4r93fEZPGmlYsA2ZvtJ8ck4u7ZM11RNxMe+jir+aQMpRauFyGJd2GCU9p+r8u6P6i3I1
 zQ1/huVVRKS6CriozeLyRiz8GRRdW7Ck1S3L8hPNdxJxIp+nBZxX5s35P07pXPz0f+HcE9HpZCK
 b8419ccJE6IWILk7sv59iTbDnstTpUFnFnBYXqkBFy+hBHio/DtWU/1VD5SpDj9qT4BZ+A6iBJP
 Z3IZpfcWpOkWvm8jifLymbboMA4nTfUIvr72ayVdV/pMp203kHKh7dhCCfl2Uea01A7TEE+Nu5r
 vKrtkUhGE+tTmK7tLAL9VL1eYpo8mR0jPNNQjk73SHeF4C6wgxfJPggrcUDS5RZaIedfGrWQQ4n
 18wVBK3bPKInZJ6Np9OpC3f8pAMYwwGxbFyMc2tbw+3djuRKi2UJDDTzH4/T1Vtepyu64mZ9sAO
 d+Zvuh4LaXr95d8Z5Dg==
X-Proofpoint-GUID: wOKSzATDJGZVfk7YMdnQlMcJDkVjMl7F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160161

On Thu, Jul 16, 2026 at 4:27=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 11:57:30AM +0200, Loic Poulain wrote:
> > The M.2 Key E connector gates its functions through the W_DISABLE1#
> > (PCIe/WiFi) and W_DISABLE2# (Bluetooth) signals. When a signal is not
> > routed to a host GPIO, the corresponding enable/disable callbacks are
> > no-ops, so the host cannot gate that function's power on its own.
> >
>
> I think it is misleading to say that if W_DISABLE{1/2}# signals are not
> available then we cannot control the function's power. Power to the funct=
ion
> only comes from the core 3.3v regulator, and these signals only enable/di=
sable
> the radio (WLAN/BT) as per the spec.

Yes, though in reality vendors often use it as a reset/power-enable
for the functions, not only for their RF part, effectively powering
off the Bluetooth or WiFi subsystem (and the spec says that when the
Bluetooth radio is disabled it may reset the Bluetooth feature). I
guess that is why it's part of pwrseq in the first place. But right,
here the control isn't fine-grained enough to gate the Bluetooth and
WiFi functions independently, but power/3v3 can still be powered-off
as a whole when controllable.

Also, in pwrseq the targets are named 'pcie' and 'uart', but per spec
I think they should really be 'wifi' and 'bluetooth', especially as
Bluetooth can also be connected over USB while still controlled via
the same W_DISABLE2# pin, though we don't handle that case yet. But
that's another story.

Regards,
Loic



>
> - Mani
>
> > Implement the per-unit .is_controllable() callback on the "uart-enable"
> > and "pcie-enable" units so that consumers can query this per instance
> > (based on the runtime presence of the W_DISABLE2#/W_DISABLE1# GPIOs) vi=
a
> > pwrseq_power_is_controllable().
> >
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/power/sequencing/pwrseq-pcie-m2.c | 26 +++++++++++++++++++++++=
+++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/=
sequencing/pwrseq-pcie-m2.c
> > index e3ba9169144dabbf0c553c0a4302c3b511fcaaa1..4bcd5078609da1be966ab30=
c73cffae5e578934f 100644
> > --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> > +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> > @@ -84,11 +84,24 @@ static int pwrseq_pci_m2_e_uart_disable(struct pwrs=
eq_device *pwrseq)
> >       return gpiod_set_value_cansleep(ctx->w_disable2_gpio, 1);
> >  }
> >
> > +static bool pwrseq_pci_m2_e_uart_is_controllable(struct pwrseq_device =
*pwrseq)
> > +{
> > +     struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> > +
> > +     /*
> > +      * The UART enable is driven through the W_DISABLE2# line. When i=
t is not
> > +      * wired up on this connector the enable/disable callbacks are no=
-ops, so
> > +      * the host cannot gate the Bluetooth function on its own.
> > +      */
> > +     return !!ctx->w_disable2_gpio;
> > +}
> > +
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_uart_unit_data =
=3D {
> >       .name =3D "uart-enable",
> >       .deps =3D pwrseq_pcie_m2_unit_deps,
> >       .enable =3D pwrseq_pci_m2_e_uart_enable,
> >       .disable =3D pwrseq_pci_m2_e_uart_disable,
> > +     .is_controllable =3D pwrseq_pci_m2_e_uart_is_controllable,
> >  };
> >
> >  static int pwrseq_pci_m2_e_pcie_enable(struct pwrseq_device *pwrseq)
> > @@ -105,11 +118,24 @@ static int pwrseq_pci_m2_e_pcie_disable(struct pw=
rseq_device *pwrseq)
> >       return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 1);
> >  }
> >
> > +static bool pwrseq_pci_m2_e_pcie_is_controllable(struct pwrseq_device =
*pwrseq)
> > +{
> > +     struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> > +
> > +     /*
> > +      * The PCIe/WiFi enable is driven through the W_DISABLE1# line. W=
hen it
> > +      * is not wired up on this connector the enable/disable callbacks=
 are
> > +      * no-ops, so the host cannot gate the PCIe/WiFi function on its =
own.
> > +      */
> > +     return !!ctx->w_disable1_gpio;
> > +}
> > +
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_e_pcie_unit_data =
=3D {
> >       .name =3D "pcie-enable",
> >       .deps =3D pwrseq_pcie_m2_unit_deps,
> >       .enable =3D pwrseq_pci_m2_e_pcie_enable,
> >       .disable =3D pwrseq_pci_m2_e_pcie_disable,
> > +     .is_controllable =3D pwrseq_pci_m2_e_pcie_is_controllable,
> >  };
> >
> >  static const struct pwrseq_unit_data pwrseq_pcie_m2_m_pcie_unit_data =
=3D {
> >
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
