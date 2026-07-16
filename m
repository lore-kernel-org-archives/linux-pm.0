Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DAD3DDB04
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784193216; cv=pass; b=UU40Q/mO+JlZS8d2DBnOFwT3zbzm1NYdEe55WkCQSIz/V1Gr/O8RU1CD1Tho7aJpzB6rDN0GOtcLI95lr8bTWFn8zeFyDvdWRMzp0bunOmxPjX5dVC6uXRYJz1YMGf4mgwHQyzWmZuJKFzZ5Xw2x7UaOZ/yNnTYeamsg7ML8iQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784193216; c=relaxed/simple;
	bh=uCqDdKgSE05wWFAXOn24NCojvJkTjvFV4xaFhIaDAx4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gv0Ivw3FyK3tU6/Zbr8Vp7+mUI/oVZ9127zTHyTFC6z/8+j6gyK95Q9Z40mEaA8rbivYg/9sXX9wpiO/NYxYugNFkte2GAR9dHSene5gMlUHhesKywnNI0YqsZ0OOImmzVZYMWwKvZvQU6vhpNE4Mzwta4cXemWMIxBDfKGLvqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7+5EgcK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TwLzV0hW; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7+5EgcK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TwLzV0hW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66G7XaAl2176584
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=; b=d7+5EgcKohigk/Rr
	f50a0z/LZV72FFBzPnB6iROcFhInecWl+0+L0nY99Z41rukIuVSOycIuzUr8v6u1
	YzjXctSOPfKgBVAOxptCXH+HqIPNSsAgSdenpQm/tzJXy3Z1mQiyoNsvWNe8nHQY
	qy5rsaM3RL1ctlWQLte+ZhcU4mIkDF3clW0nMB+E8GgpBhPQbyffYyS9Od0w88w4
	4x91VBZjg2haPe8dxW5CjnJ29A/PJoExvtdKA9LKvcFb3XmtFjoioxot6lUajnLk
	r4i+E2BmY425n4WZEI6Zyx1MEPY/a+j7WCdKMeMa9TqBRbj8+KnLAAcMWUDu85Rv
	0PMEeg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feu108bpm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 09:13:30 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8ef18406878so113888726d6.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 02:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784193209; cv=none;
        d=google.com; s=arc-20260327;
        b=PTX3RwcDRYL6Vk131bsa+rrpW94ScAByI1TPhxI6FpcdouhXa4ZpY+zPdUy/NY4ghA
         lpBr4szDgTQUgkAOur1UlUZua7pXloeB01tdQwUdmk+pxR1zYg84eXE9XKsZF0YZO//x
         Rra578cq5KLEgdV0lDY+FcikP3KDsFwAwXZWaO+p+hZ5X/el+0qRD7r9oDRTvfoyBRuw
         0QbxY2Vk9rX5fCG4lRbSB6GgJ2lkOUooclJX3+L5XtqOjs4fV7CeP+EMS1sOaGaUU8dC
         f33SzTE/3590kx5TuffpSG+QVCXurLn9W03En80iARwy+LlDa7CZ8f6XuNAPcB1n2BSY
         YHWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        fh=C7ZAGh/SXXSITaD/mKczMqCJEjcFUgMgvNYZ3svfexs=;
        b=kH8sEMFK5dFXs4pSTotNVlrLkwYX+IW8fsOzZIKJvtMt4/0hOfqxdM8Uu32EQ/ENGD
         lp3emZd7al8Jz/zPxTfpe81N3n7psLYy7jKWXKeGXAB8zxzsy2+OTzzuxLkLJm2BCrUD
         9254IeGOA15wFIkZX1L9latbNBTdIjZFeKFQMToSZX+6EQqpct9GLPYhfO41LLltlkD6
         0x4EQg6dnbnTpdErybTbZC2TFkix0k+DCjmv7qMFq52fZxcKLXGwWEkLm/QKlanjyvMv
         8w7ie36U0iEjcWLaCu/CAMhURkYfeXlvQQ1BbfJ5LRHXPibz0SBKqz8vWgJ2sIrNhOQr
         o4eg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784193209; x=1784798009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=TwLzV0hW33RYt8nI0/zpwTi7ztoge/roka6KcZ0Jcdz9gRd2W0DHuaLsVUVXZdz4fm
         LOZ0smBTI+KUX5b5koWhpGqvy5jO14cE+INR+8QkJUYK5ujgKWhnulvLTp9IhdcXdj4V
         +a0h2sg33nJu1QJuQDW/bT9U1uej3ZaTLCjbV9runbis7DrI6v7WSmXs15Cc0vtupRbt
         PAaTzIlB0Q0RFJ4l+rnZcOb59NkdFkXe8p0VAjhH+AbtEdRsKkERuFRvcZxt4mVpk8Q2
         XapZGn3a3bgZ9+xnIlzdHyk2uTmuY4LmQiAHPGj3z93FRJDT8pHnvpD3iAtWfIEH+WG3
         Qgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784193209; x=1784798009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xFVa49Pt2B8c2YYrLGC9UiUElbNn58UHEJ43nuRf8mM=;
        b=rlxO+2/vvUofaLTK2WM1eY/BoL/Dq/GVZBX8ZkW0h2vP2GPskG6onODsHhvzVhqMEo
         ib09YkmMZghjqP/WEXkbDU15OE3tLfOty2f7pnCv9ioQmqlgFLHMWWnkyB5Yz27e8z9r
         yKmf6eYGO9hPbZUrIhxnEx1fXMO32Z37rxl8OzknHfyW6pH92WBiRltDSg1UzHkf81e8
         qxjWQnuQKDHuW8UilsuIBdocdMX8uZefVq14zpAG2MqHSZTrK+qOKW1MXHokSHpP1t/U
         hFY053yGFPIpk8r8Ff1BNGo3qedaraN8gU+D3fN6BdXPCnVFBSUANEUQzXemHluru/3t
         BcYw==
X-Forwarded-Encrypted: i=1; AHgh+Rr5rsSi4CEZ8JF3F0TCOhGz2FmkMN9VkeIKrmwOdZ2iu6r+ns9OFTnz//A8JDBkqvbC4BwiT3HStw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8j2aFYwsOlclwKj+Wg/LjFjZmn0Baf011da3e0DYQEhOuTE/t
	BC0bEKYOkicm2tW4jbMy3drKL7by04dL8x6P3N1TLbG/LLc+1ZBKDZU5gzoUr46ZrIAMrJBOp+K
	0xR3EQdXVsy9qA22DXPLj+Xjx+ZFgRJcp2Bub0tDGqHbK5GBBASiI+WuxQe9LezVALcc055hRHD
	5QN4w3LH8qLIFvQzid+dMUw/Houts+hLvZPuomn/ibP9vN2cZuJw==
X-Gm-Gg: AfdE7clSgB/SNXWMec/+gxXF/44cmNaW0udDcCuAZzfDoklc0x8TZRJE6Mshzrg7tA2
	IF3lWsUSkUy69n9rn8dDd56IJ+NvZTgHcrPX0rsT4bP/Ad6Fso4M4eU5Dzt2xqHHlbJSL9CVGNC
	a9pBrmuv6W6Zf1OnMNs4lfgMVJI6TKb5zA636+sI9NaNSgk4f2yhEGRXLZxvd8KG6NnscOjqk1L
	jvcwyOWbqKhKLnNbYklNLXjhQIeDeOrwskDH12qN38ZBjUoTEeLPCzgLUqVOz8LYPYvYGILtTQr
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id 6a1803df08f44-9074c766c6cmr114860316d6.28.1784193209402;
        Thu, 16 Jul 2026 02:13:29 -0700 (PDT)
X-Received: by 2002:a05:6214:428d:b0:8ea:fb8c:2e0a with SMTP id
 6a1803df08f44-9074c766c6cmr114859886d6.28.1784193208701; Thu, 16 Jul 2026
 02:13:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com> <20260716083141.GA4101439@google.com>
In-Reply-To: <20260716083141.GA4101439@google.com>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 11:13:15 +0200
X-Gm-Features: AUfX_mz2l-ruyrBEqJdkcXUQ_DW7F-Cm1EuP-VtmhPBeabFSDhnP6vsS9Wv2wFM
Message-ID: <CAFEp6-0UJyekA7zE74=CgneqvxDbea0Xw+u8O14bpcHX8Yb57w@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
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
X-Proofpoint-ORIG-GUID: 4s1VygpH2sA_OCsoVLQV_uJhe3vzQTeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfX9hGYrCA/TcAI
 yqrL3XX4R1aIp/4m0kCPnzAd1WPEkQW8w4njqQnbQHCnZFZcV+sNVTg6AosJ3AD9AQLg6RxTW81
 y9PoCRFqSdJOtlf8zCLSqnYwriItKH7NVwVM/1VqE0N55PeSm6KwWAjqe9WREOasy04nFlGaVti
 619UUoxXxdU68iW0MwTVdkSmlvRfybcR+K/EfXl0pxvrLwKAR3968WPFGuf9H3MfIQFXlTBuA3o
 JItMwDqv8EvUZRrKhkYTJtmxI8IUJM9yTa39sCDKpO80XFUUgO5SY2SFhavtvRKvyL2NcbVxMb2
 WiJ6LgtXV4L9galADsWlxUDeiUExLpRQQQgTKBJ2wIOMRxg4Hr3Nm7JGyFqit9iuxgGxqypb9AG
 hS+AuVXtpWdwozUoa4KTK8NqEfCHVK3MEmhVGov1i83u98R1i+wPDsZaKKb4yfQFhylUvIGQDOj
 71KvY9vbvhNWT98ihEA==
X-Proofpoint-GUID: 4s1VygpH2sA_OCsoVLQV_uJhe3vzQTeC
X-Authority-Analysis: v=2.4 cv=BPODalQG c=1 sm=1 tr=0 ts=6a58a0ba cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=UD6jFWV5_MqAamJTNaQA:9 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDA5NCBTYWx0ZWRfXwCOxEzE0wgX9
 CCmFO50ikg7uJxA5ScczuAd/kx0X4cp8qLWQBlC+7e+Z68UlQjR6BLLor64w8VVjuLZndjdJy8X
 ygb5n3hp0/BIAn66G2hdzYCTSu5VMJQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 phishscore=0 bulkscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160094

Hi ChenYu,

On Thu, Jul 16, 2026 at 10:31=E2=80=AFAM Chen-Yu Tsai <wenst@chromium.org> =
wrote:
>
> On Fri, Jul 10, 2026 at 11:57:34AM +0200, Loic Poulain wrote:
> > For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> > controlled by the W_DISABLE2# signal managed by the pcie-m2 power seque=
ncer
> > rather than a dedicated BT enable GPIO.
> >
> > When the serdev controller has an OF graph (indicating it is connected =
to
> > an M.2 connector), acquire the 'uart' pwrseq target from the connector'=
s
> > power sequencer and use it to control BT power instead of the bt-enable
> > GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  drivers/bluetooth/hci_qca.c | 35 ++++++++++++++++++++++++-----------
> >  1 file changed, 24 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7..f6529d359ffbd97f8a3c4c0=
593680ab200215b36 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power.pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2387,6 +2390,20 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >  }
> >
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > +{
> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
> > +
> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +             return 0;
> > +
> > +     qcadev->bt_power.pwrseq =3D devm_pwrseq_get(&serdev->ctrl->dev, "=
uart");
>
> Note that this ultimately ties the lifecycle of the returned pwrseq
> descriptor to the uart, which is probably not what you want.
>
> I ended up manually doing pwrseq_get() with devm_add_action_or_reset()
> so that the descriptor is released when the serdev driver is unbound.
> This was for the Realtek driver. I haven't sent patches yet.

Thanks for pointing this out. I'll fix it in v4 via devm/action.

Regards,
Loic
