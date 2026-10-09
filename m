Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB64E56CC
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 16:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791564022; cv=pass; b=ZsJ7dA2UW/0qpFz3qNqUQrQ4vs8g3VanBvjAWkkAHv17kTO5CR5uIhJVi4sRwhAX278p60AWZkD+nFxslZV3JYeXoQNowAILi0j2Uke2B5OP8+LDTxsFMl2ezxuaKc6vsVpfRBVbxpVnn8W+zk3P2t3utqPH8jIh+KHaSxWXksM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791564022; c=relaxed/simple;
	bh=O8BZgU9vbT9VzKGigoj0YhIQo4ixHDL264tHQrF7gDU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cDSZdAJXHQbUxJsE/GDhG46cCLojB3+ACt7MRgqkFRH74EEfSYSejVevpFXC6TSo65JwxulG29qgfcgOy96jA0xJsIjaedYkxBGjRInuj46dRs5GF6ExLkNJAPQVpS69LZMAgQjoYmj9U6AtSbRNK+CyKcTGFWuuBy0C98PfVXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BzVoZ3gE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fBs2swyv; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BzVoZ3gE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fBs2swyv"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699GbDeK2018429
	for <linux-pm@vger.kernel.org>; Fri, 9 Oct 2026 16:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=; b=BzVoZ3gENy1gF6ye
	qYehjQ26tYEkKPZmjWraQwf4erIChnc9V+zoKmw5bLBu/exRPi7Q4fQrYx3ftdoI
	K41uJG5h4TUThUzDcLqOKWXAZRWXwdyxHqyKdtPeGgIVQxaUQwckq2o981X/uk2P
	QMvc/NRZdN2sNRQIqMu8j4KW6cwuGjwHBGdUi9xWWEK47GmlC/04OS94KmujDl68
	iH6EB+Ce1KfP0MgEASzew9nXIUkc2wFJsB/uRNB50GfOwmEsXqfgSgZ4/uku8L/w
	x3X6Yb+LnS4+2cNJR5+V/SpJgJwA4Wlr/PtgkwG7jY4hYmBeF3Rc2nYg0s4dRhAk
	35WfOQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h71f1rqes-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 16:40:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-936aa34873bso1356241385a.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 09:40:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791564019; cv=none;
        d=google.com; s=arc-20260327;
        b=qRWwzcSJQSK7tjSEHCnLwJRmLaro8yEuM9s2RMiFeYZJL6b3yPV/k46BHUFTaHTKVS
         h/c0NxzS/tjLdM/Rgh2q1YdhQir5Pvo1MgnWgNxeflsQLhghJB9SUbiiazUk9Xu/9Gcd
         se+nw3XicQykcGJ+dHTxbwTJ3flGkWOAlyrO5Lp7R2HdzYcYcX5fSiyqpOB9/Zapo21D
         RqMKyrv5JmifGzC+KesUwbC+DpogDZNikEFUXSBG+E5YJbnhF0m0dvxYPGqHdlCeBOv9
         5ehM57mMnI3p0muzWQqVyBsqYA01BZrx6k6Wzh8et6GdwPjuy875Nr498u/xKrg2Ahmi
         PHIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        fh=rmPfGiPw8JMIJXWt/TSxzg/ljMlCuiJ6cdTr7olLqPs=;
        b=FLv+S0bWoWriaR341O+DA126eCFDC5+1XtRFoazimr4/WvnOUgug8dlW+gn6KRDEs8
         8sxWzoZptYe84wam5u4O5oeHP0O4CliVw3wu1mlaBdOo2O2Ou9yTRDkVwYw0YuvgLO6Q
         q8Jr1IQnmYUy7uYR18QPlJmBY/P5Wg1OowMQRuK+len9u0Cssn66fmNEEzJMELSGI/eQ
         bNVuhCk8rw5mmufaNulqLL0Jb4yB9hwCrpYdbjvi9O5pJKut9by5A0C+jcoMhBvvVmcm
         f6exOQqyoic1eTsZf9WDnC0aKALNxloFvov3Ju/NBB3cz78gOX0RW9z8BtM15ui7/r+h
         Tvag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791564019; x=1792168819; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        b=fBs2swyvZBOfk2KVO5FEc04xYgLuhAZMmXCuuPsSJu9J0LoO1mXm+ZSW/ovI6u/zmD
         NeHYZrYGip/ndFzhL3P7Wh1nTOAjaRQ/aYrzrMpUBQMmHJYdekLLzFBkUQz1YO20dyLR
         ACK2jkA1gg8UJc1d0JFdFAKSYHui4ICO4aHWYjcqdvr35QdJlCji6o94e/Dl0oBizIeu
         2uJYW2swCJcxv4o+fi+prOewV1nTP/ErPYml8l26JmmvKLoTyhHmblZXuIMeDaRF+Aw+
         4wTM1HxkgegNyl7wZF5hU+0xHPKINBQr966bKVbFCD1M7tTfWIykR1iKPW8tjczMgdpF
         s+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791564019; x=1792168819;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03cV0/SHCir8TBf41ccHk0p543FbvOFeT/DumSE7PMQ=;
        b=k7SVM+uW840c6EmPhmxbTlf72eRwSxahIiWPAumotzOLQin7snIbuE0QfNoQdZ1Mln
         PlKy9YHrX/Ge0KqKE/cPFSyo72kP+ROkWL5EkDYVwWqpMQQm4pP10Q4vsCpSovDWjYmv
         MRJMi+m01ac9rIqACwYbsOYjoTYIVvEX/lwrkc2vgS3B6PPI5lX1OvAc3FEM4g3tDUdb
         VNAH6pTn8BldMBq6VnjuYiTW1TZtu8VsYDB0S3i1v4OORiM+/tIJUSWFhiU2j+J7Zq1t
         Ob+qKks2OgHme6MMM08eVnaMXnYzuMRwdFt9fN66D/wHMLqyxDIvZsxJae0fQLwKKtZ9
         IxGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbMJ++gQX073rVIyD6o7iGjQaFM4QqZdTBU3r8zhcfctb6otPfcTzr0myFYi8JTyE8S7G4iGc+ng==@vger.kernel.org
X-Gm-Message-State: AFuF++kvYgeyaeQK4MrVyasQFiuBLcUAtBW4AyeL/FijX3mwnjVYPWt9
	mFtk4uo9mBfnunvbIGhHczq+Ut7/wEVSfyAzt5tiDh28UGne5cWw29mkwz2g9RHkTtowuyadLXV
	XWQUOBbNaBEdOuEHNXZrmaT6f0nnrSHFyH+GSjXc1Afh4/QC7do1fDRnDkLeilk0nD/V5LJ2H7a
	pUkru/Cd7yoIQoES790XEe0m/z1tbwM3F+vNIZ
X-Gm-Gg: AYBFou1n80BfsfWrQjyNhZzDzl3J88HjgRF8RR3BobH5LJcBrtQSxGLitYeERQ+rLM3
	F/9Ytm8hGJ1ZocAX7mAU9aA5ZWj2Jfg6bpXhzz7Ov7UOcEsWGeeD74tsKhz4pFZpYRWvKiWgXO1
	beHHf0V54PkRAO/2IniS4b9FvHBtDhqwhliCoP+S282YkeS+AfkQH84c0b9pqe9eT/Q8nQ7Xdhf
	PIx5fl0NNpuWMme88hD8MEGYKfCRqUsPhbXvMii+6Tx2ECfzlrpkFdC6FJF6l5E/z0fbSkBGfSB
X-Received: by 2002:a05:620a:269a:b0:939:13a7:70f0 with SMTP id af79cd13be357-93ebd0c260amr388805585a.5.1791564018697;
        Fri, 09 Oct 2026 09:40:18 -0700 (PDT)
X-Received: by 2002:a05:620a:269a:b0:939:13a7:70f0 with SMTP id
 af79cd13be357-93ebd0c260amr388800385a.5.1791564018141; Fri, 09 Oct 2026
 09:40:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-monza-wireless-v7-0-5a6de7662dcb@oss.qualcomm.com>
 <20261005-monza-wireless-v7-5-5a6de7662dcb@oss.qualcomm.com> <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
In-Reply-To: <bc7730e4-8b47-4c2b-84ef-277749f2aab8@packett.cool>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 9 Oct 2026 18:40:06 +0200
X-Gm-Features: AclHuK9ldJgKtc_xURMW1e6eF51wDo8WFdbnPxmGKItG6GLqTwM1Bp8vW5CtXNc
Message-ID: <CAFEp6-3Mt-CCJEz=RAJUh6pxH-Ssgkqfx3QQfyzvS9HwzFp9QQ@mail.gmail.com>
Subject: Re: [PATCH v7 5/8] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
To: Val Packett <val@packett.cool>
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: A6FgRkiNONkYIpnCr6upqtImhBhCO-ZN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX+aoC2EebK1gg
 CZfet28IOO0FW1d10HWZVngkyv6XOGfY3Q0/3ZcamtF133mSbtPoc4+zI+1+FufEwmsUHJ0ZD9Q
 wm8Qv/4hn454/wCr4mFWgg5MLwjIByw=
X-Proofpoint-ORIG-GUID: A6FgRkiNONkYIpnCr6upqtImhBhCO-ZN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2NiBTYWx0ZWRfX19YsG86VYfH9
 SLe6YLYkQUNLp1wk/RgNM0N1+wt1LSHsYBXD4ttx14od0jr1aXkg7AoCdLp+u2P3VouRK/S6hMU
 DutBPGDGzDz6Tp+BPCG3sS7IL86w8ADJjGLfGuoIq8rdkzUfJROLmKB/iVS6iV7Kt/j1MncteKO
 OI1UKaOU5vmJofM6r0c+p1exYkXXEKklGr5y55JvjjZb57wwg8E9pS5y7Q30cwM28xFqCI/+8a+
 sxKw+BcvAHgTnR/r+ZQtTrj1f6HNYl8JQGxiGEvqXg0LXzeT+VCJQa47q/UDZLNeJlCY3ccVrKQ
 fWk0tbPWmWKHjv0ExZ7cKJPTEd/h4E4T9z6kbQajOMS3ec6uu5x8kFO3gGMI+xxjKcBjfVG0hD2
 axNYEWPkoSLC2YOfJSafYWvGnaONKmwEUkqlHBEZnkE67YWBKF42hpI74QsPoSmogLcrmaKBhxv
 sQuG/ND/NUX9oDzCPnA==
X-Authority-Analysis: v=2.4 cv=YIUKWhGx c=1 sm=1 tr=0 ts=6ac918f3 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Zz9X-WFLHu0qX2yPYA4A:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090066

Hi Val,

On Thu, Oct 8, 2026 at 12:58=E2=80=AFAM Val Packett <val@packett.cool> wrot=
e:
>
>
> On 10/5/26 9:21 AM, Loic Poulain wrote:
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
> > Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >   drivers/bluetooth/hci_qca.c | 47 +++++++++++++++++++++++++++++++++++-=
---------
> >   1 file changed, 37 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> > index 1d27ff98034ba99d0783e48db5c605f3b31117ea..b6ec1a57248e2cf4bd13889=
8ffc5cad45b1b4a8b 100644
> > --- a/drivers/bluetooth/hci_qca.c
> > +++ b/drivers/bluetooth/hci_qca.c
> > @@ -1875,6 +1875,9 @@ static int qca_power_on(struct hci_dev *hdev)
> >                       /* Controller needs time to bootup. */
> >                       msleep(150);
> >               }
> > +
> > +             if (qcadev->bt_power.pwrseq)
> > +                     pwrseq_power_on(qcadev->bt_power.pwrseq);
> >       }
> >
> >       clear_bit(QCA_BT_OFF, &qca->flags);
> > @@ -2396,6 +2399,34 @@ static int qca_init_regulators(struct qca_power =
*qca,
> >       return 0;
> >   }
> >
> > +static void qca_serdev_put_pwrseq(void *data)
> > +{
> > +     pwrseq_put(data);
> > +}
> > +
> > +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> > +{
> > +     struct serdev_device *serdev =3D qcadev->serdev_hu.serdev;
> > +     struct pwrseq_desc *pwrseq;
> > +
> > +     if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> > +             return 0;
> Seems like of_graph_is_present does *not* return false for the existing
> (non-connector) setup which is currently used in all the laptop device
> trees..

If I understand the issue correctly, this can only occur when a UART
'port' is left unconnected, in which case the failure is legitimate.
The laptop device trees should be fixed accordingly, either by
connecting the port to the corresponding M.2 device or by using the
usual Bluetooth UART child-node approach. I don't see this issue in
mainline.

Regards,
Loic


> > +
> > +     /* The pwrseq is looked up on the serdev controller (which holds =
the
> > +      * OF graph to the M.2 connector), but its lifetime must follow t=
his
> > +      * serdev consumer device, not the controller. So acquire it with=
 the
> > +      * non-devres pwrseq_get() and release it via a devres action bou=
nd to
> > +      * &serdev->dev instead of using devm_pwrseq_get(&serdev->ctrl->d=
ev).
> > +      */
> > +     pwrseq =3D pwrseq_get(&serdev->ctrl->dev, "uart");
> > +     if (IS_ERR(pwrseq))
> > +             return PTR_ERR(pwrseq);
> > [..]
>
> So this returns EPROBE_DEFER and bluetooth gets deferred forever :(
>
> ~val
>
