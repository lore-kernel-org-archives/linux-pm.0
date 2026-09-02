Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD943EE1D3
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 09:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342165; cv=pass; b=FvRitPPVPDEWtz8JbaRcdAhTA7h/KMLP7T+YnFYSsbOmFLEnFjlYR4dQL1VuRazMkNurSNm70zJVelESPcpNCKOSSA46UEQkOwH/IpkFVf6SbMgVAeJWNqGFiKuGAyFp6fJi/nJc7M6jz7zPa0rRbnl5+mKbaJA6B/qeR2MtrMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342165; c=relaxed/simple;
	bh=aWe+No8ZS19hz230sh2JorbsRWoGkguobu79Z1ROYkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C9db9r0S1ww0Bluc0Okqm8apkXkpkP+3PIDYrHhCiD4touPF2ZSW6/fNUT5jqdCwYtBfQVU/0rbRAXnXVtp/Ol8diV+YQ17qK86cjOGoG5MH/0kAr/ze6oh55j48U0E6kBof4ijtJgGtCGD1sVieIEjGSs1/2Dd4XEKvTgPVDRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VEL+W6so; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iej2BrSP; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VEL+W6so";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iej2BrSP"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829N6Hi1590199
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 09:42:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xIiOD0i6oZiqqv8K6peO0dyYUtMjzpeC8vLsBM0LYpk=; b=VEL+W6soir8eJes1
	BA69BHOtVllqXafA8ynp5/KFX/T7Gl3xJhtBesDN81kWMiizTe3IuDjE7mlvKU0K
	tWoH2QbZsGPyZmufhtS2WyrZqkGEp0kG0Ltfs9BPyOQvF32ukpmm6sD2SL1hCgjn
	WxckySLu1VMFbvmXXpCFdIbyAoblaC5CQg4UYvVaBVphVBJoZWNMVb3P3rAwKKlv
	xsaCWQVi+PyjsLUXFUT71R/ZEGOma3Inoxgout/EA9uFAP9ThFoadCtTB9qzzwok
	NcrcctZDzrdznAwRW/mfNjnyYenz1jUXNtIvchEz4KvaEd4gos8boScikaiYclpP
	RJWO0Q==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4geguy04pm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 09:42:42 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc1bbd7d6e6so1030685a12.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 02:42:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788342161; cv=none;
        d=google.com; s=arc-20260327;
        b=FFDEqMxYLx7W4HbIaavKI7POrAk23jZi0O73H6iugzOcSF2OE4wK87chPKg7jRp3ST
         QmYvOCXk2JfsaKWPcRwv88DSLjPuS6aG7eCY3n4aSmqr94e/chYMGyfcUeliYdecrPET
         ekTf3t+FjuavJSuxSfW3fdD6gdwpMY6G2a1aoIRA2feq3EzdJeA0nkFqVDVDEFoiz88f
         2ZdF3iKA6xIQKjdX1b9BfkoaVd9LtC5DhRI59ucWvBzlc948Sj20pz5+gKbVMf6FSa/D
         N2ivbj4x2F/OSMdRNvtQ6mSAJKku0OtQalF0fxD8LvgP9Bs7ZUwW8aM5Cy4CDjochrCu
         mLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xIiOD0i6oZiqqv8K6peO0dyYUtMjzpeC8vLsBM0LYpk=;
        fh=DC5gxhEK4mCUZ0Wg27pUhrqhPO/qIEcNcD1UHy/s+sY=;
        b=R8kUw52lKHpwBNtewo6lvM1rKzUbErcapi6MPk6WRiyp0CEpRnAWBJvBsPWi5qdUUP
         z6A9ZQrHjJ8nxVBcMgPP6fV8XSn0rKbFoKkPHwhfN/po2JVy99tdzk3X7fpRMBBkzaaS
         CfAC8qcESu/gYVEP2Ug4Zgz24oR8fGv5Rtm+w1GveuYb/bSbf1pF3NDtCo3asXXKbIcb
         erBl3iOc8sVwHQbuwAHstW3InWhhv/fd5qMVVr7I380/67yBdIiGIzZiD0WXFPOanlrS
         VIZFVbNUbCfBYLVK3WVszWOLFrAEks07GRbwcTi7q2FyPqlDvrDE8RkM4EoE6Lltt1ty
         phKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788342161; x=1788946961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xIiOD0i6oZiqqv8K6peO0dyYUtMjzpeC8vLsBM0LYpk=;
        b=iej2BrSPfzwdDczZYyfvqajQHFziNWg6vsepYlEEyTgoFTzuyz6M0ecyhq6OQg/7uu
         l0IRZeZ+h8U4IwVcG5yWWt9yc3cSsOstQaTOhuTGDkWMamiGeVc2EWzxUuM3W3DJBaal
         CH/+gZW6abrvbnhS5TGt7ILyFDuPbggJxzlw2LNRS7SW9Xbqm5FZZPzdBWGDMi0VJlp0
         P/yIHVBRKt1IJQvosIBs5CHl+uOZWGQW7+MtxyDrPzjGElRkLYhmvpz3uWCkEZIGgxUW
         HIEd3a1yb4MfO5b64/V18G183oK9+tg9H+FM/npecIrJygYA2KA+Y62aoEXTbj/kXDq4
         otqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788342161; x=1788946961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xIiOD0i6oZiqqv8K6peO0dyYUtMjzpeC8vLsBM0LYpk=;
        b=FpMKJVY6g9AbHE6ul5UMPtYQ305CCwircOKJKDF89X+Lwe5xSmqRXWMcfhuqdUPuVo
         YKaPnvnMPzOoof7clHvlSuE87zF5Ka2UUYlPfDoDd42Y4WlpKia4a2WMSgzhi/eC3WSf
         oMx+8Mpxeckmrnc+6Nux/689NtyxPo4cNgG6PKz/8Wo7eHocj+fcjcjMrmA1mcgflWs+
         Nw2lmh5XicHUrezKA9nuyoarvygaNugAkIf+YjaBO0c2wRFOOzq55UU0CZMeF0HUtH+P
         PRGowRbe/+numtWjjIrWVdV/DtHl9s1hL1AF6GQukYvFHTAzac75sYHPhML+VfZsv+H1
         imPA==
X-Forwarded-Encrypted: i=1; AHgh+RqATyQJBF/UiYo+J9iM9Bks2TjMPfPo35qyHUsYEsu9GABEtTIk4tmkqBv8uIKT87Hfm41L9/Z8Hg==@vger.kernel.org
X-Gm-Message-State: AFuF++nXcrqH46v0xaygb53cf6tj9J8fMeQS3DdvpG1q3/YnQ5pv5p/v
	v9DchnD/bBRnHHKdiGZHVno04DKUMGEkGSpaY3cdcGRDuLtdBQTcayQDjCRoo1kSy0jNKDHfxjS
	pD+9pcPl4QjrUfKr8htBjcCLSKzvBXuHsEgIYzQZliqoSQdha746b0CUYTFRjNtFjNVJqlU5nqQ
	goz0bxNvLpYTR2pV8vj97TE+ZBMbharabi4wiU
X-Gm-Gg: AR+sD11Kp3pX63EXuCTxhTLzEF44I5U6LpKpFqg2UlNABTiFshjmPl/uWQEu6eAxOEZ
	5DA7SiunMJPoTCslGYez+S0AxzF0mF2SrCa3nEFlm/Lq+ny648z7XcM61VRqPgMYTbU2WnMVVXq
	EEGvQ9lwzfyvQ+U4SMt65mvR7SUXFg9TOJQHAq46m3AH0scMEqtkB2omYI2A==
X-Received: by 2002:a05:6a20:2451:b0:3cc:c7cf:5a44 with SMTP id adf61e73a8af0-3d9ad268503mr5043421637.2.1788342161543;
        Wed, 02 Sep 2026 02:42:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:2451:b0:3cc:c7cf:5a44 with SMTP id
 adf61e73a8af0-3d9ad268503mr5043383637.2.1788342161086; Wed, 02 Sep 2026
 02:42:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826135454.658615-1-shengchao.guo@oss.qualcomm.com>
 <CAPx+jO8RVUv=mqDZ-GeJa=dEYdNCK9L8Vi=UCDY9GqQ1TefCsQ@mail.gmail.com> <apfVvXLAW0j7g3pD@QCOM-aGQu4IUr3Y>
In-Reply-To: <apfVvXLAW0j7g3pD@QCOM-aGQu4IUr3Y>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 11:42:29 +0200
X-Gm-Features: AcwNN1WALDMALJ5RAAfaqSF_k5ijpG9fT0E4A-HNX6PvS4KOXseUtPzRxqcGeEM
Message-ID: <CAPx+jO-q3JwY=i6P0K_r4OBie9bnPaR5kUm8+T8uGFq1oK9vFA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Add NMXC power domain for Nord SoC
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=UZthjqSN c=1 sm=1 tr=0 ts=6a97ef92 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=VllaWavPb-a1161Ruz0A:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: ZEALr9cE80FQzX8fe8Dm5KNzeo2S4bzH
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA4NSBTYWx0ZWRfX5UzDXakDt375
 HyDB++QZiX7IQvudDNwrb7sFFWVFUJBW8z1TAYz96/lqHsUlmOwnlSKgqR6HV3mjQNP4375D1LD
 FDCe2AkbHJNVoRMRZcLJ2P4UaIV1mJE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA4NSBTYWx0ZWRfX3tM28VPiK2dD
 osC2k0jI3YkAId9sCoB4XcxSvQW7fwuvBbhXqEe2fq5AGbVmmILEHrV0DosGq0Cpp56vYD8oQOT
 cV/VUbi1V+N7t6lQRKpIKwZbjj6H8McHlPAtx0QtByVCzBSzh8xfgJl7JPSluJWqNVyU/ioLkV6
 uf2Y2j94PXsaRbqxriMfMStBgLub+uZO57BoJoO3vItkZl48Nz0Ds6ksR1qQQitD8TNb4HPqxqy
 zBeKiDUDDzUqIx4iFFOCXzA2xORClCYq3/bDY/8XMQQ+wR7jojKD6+QILuRzQ2uGxjG6p6/HuID
 BVYvTN9NC70yBp81tHrCOAloddoyjsEnyAXwuxaAZkIgYbsUiJ2nwDj0YHFu3RvlcO550JPoocu
 uN1D7lc7e8UOtYnGgV0a+9v7/LQdFvDoGgzwLzWGbyb3AftXBYt+jEgYVBesG4SnsXB7iJaqQmy
 VHaMEKm6vEyr+BvmV0g==
X-Proofpoint-ORIG-GUID: ZEALr9cE80FQzX8fe8Dm5KNzeo2S4bzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020085

On Wed, Sep 2, 2026 at 9:52=E2=80=AFAM Shawn Guo <shengchao.guo@oss.qualcom=
m.com> wrote:
>
> On Tue, Sep 01, 2026 at 05:46:09PM +0200, Ulf Hansson wrote:
> > On Wed, Aug 26, 2026 at 3:55=E2=80=AFPM Shawn Guo
> > <shengchao.guo@oss.qualcomm.com> wrote:
> > >
> > > The Nord CDSP subsystems do not take their memory rail from the share=
d
> > > MX rail like all other Qualcomm SoCs, but from a dedicated NMXC RPMh
> > > resource. Add the nmxc.lvl RPMh resource and register it in the Nord
> > > power domain table.
> > >
> > > Changes for v2:
> > > - Drop remoteproc changes since "mx" of remoteproc is just the name o=
f
> > >   memory rail input which can be wired up to NMXC power domain in DT
> > > - Link to v1: https://lore.kernel.org/all/20260826102746.633076-1-she=
ngchao.guo@oss.qualcomm.com/
> > >
> > > Anurag Pateriya (2):
> > >   dt-bindings: power: qcom,rpmhpd: Add NMXC power domain index
> > >   pmdomain: qcom: rpmhpd: Add NMXC power domain for Nord
> > >
> > >  drivers/pmdomain/qcom/rpmhpd.c          | 6 ++++++
> > >  include/dt-bindings/power/qcom,rpmhpd.h | 1 +
> > >  2 files changed, 7 insertions(+)
> > >
> >
> > Applied for next, thanks!
>
> Thank you, Ulf!
>
> Could you maintain a immutable branch for qcom,rpmhpd.h patch? I have
> dependant DTS patches planned, so an immutable branch would help Bjorn
> to resolve the dependency.

I am always applying the updated dt bindings to an immutable branch
called dt. Allowing SoC maintainers to pull it in, for the purpose
that you just described.

Kind regards
Uffe
