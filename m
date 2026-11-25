Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612206;
	b=DjZc5Bl0+JPBcrhbyeWob2TDXQpKgvmMNfBsacRKfj+48Tp7NdApYmaKHm9A8vk84W4V
	 ZnluGPvtppIyVhT7HToB0tEJ6JIjDZhKUOMeK7lqjzJ5N7c7oJz5ubzELl6TQnQN5jodP
	 eMa4EqCkUsss51op4P1/jJK4gdXZH0I39Z9nyHiIxIIs3NygxHwTxCOV5NMYWXlz/4L79
	 sar1dNNPiTOWNjFLQE2nNkl0963IYjxuLmGcOWctiSvVZ1ULmMIrAynPcrROh79xFA+IP
	 jhdU/SkBawpEaEm84usbD9TGdZMb5uQzkSBhUIUgHu+9qv/p4j7qwAcVc2GIZbOJPnQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612206;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=7zYC14kkeeAydLtOuE3dZ/lyIfuyBLa6WSEsS0ZThvY=;
	b=0UqFjRjqb9j4BQPzvoX3tCenma7lYkHzeCESoozrJc+SiDh76mg6oQjtqoYmUhvjYcSe
	 mJtV5bwWVu4/KF6sIpqmqY40KhkvfQ3xuqTk24knwoWEBuomlqvRHCQVZnkKE5C1wWlzK
	 grfEYj6FAGTVG4dhYMpDumWMovyp6qM3sYUz2FEyk535ysTagVsMpx2A1OgkJCr4QTIdM
	 YF9qJpUjYiIMhiCiobi2gyXYy5U2qmUjN2Nn+cE3EIKMTbsFLf7ADV0G/8yFhD6dwL9sy
	 8MQqGMt4maEIi7chHpjWxfghKIixwQOIME/UYe8KBfZNwx+IV57tTFL5c1TQQkVc61Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XP1uVxlM;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HCTsscWa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8DA606A326
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:10:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8DA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=XP1uVxlM;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=HCTsscWa
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9mNol555490
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:10:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7zYC14kkeeAydLtOuE3dZ/lyIfuyBLa6WSEsS0ZThvY=; b=XP1uVxlMIAT52RJ6
	U9GJgrDIM6cDgB3qq5Udzh/EG3fWMBTEkexAfef9+HRsup89OlthsGib/Y58NBkT
	3vzJ9UPhFt0O3P87OPZda+jjqojkoPp6Htp25iWkVaHhd5CT88vfjLtXsZW0XEJc
	R00lw8tuXWN9W8qwS3h2Um9zBNl9S0qNUWQE+ZMBdzSqDV/9N+tWyccR1ZKGs65L
	Ug0Q7R+VEJlPmGiML16PG5Lme1zfEK02jbLRu/NyV9ymzRfMrG5e2u129tQOcWPu
	raeMT1soGb1sQfhkbbgRszux6zuqrU8b6lxp8ie/HuTtqah7MUWjQIFyfl9eZgD9
	Itib/g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5vvnrx6v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 13:10:05 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3b0a7cbf164so4783512a91.3
        for <linux-pm@vger.kernel.org>; Wed, 25 Nov 2026 05:10:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612204; cv=none;
        d=google.com; s=arc-20260327;
        b=Ui1hb4HG7YZV7qqNRE76Wc+okuFj3u76Dh1sFlX+1QKZr86anltofIO81JLSAkSQfZ
         6Qs4/5s40UxDkgUhikR17rxtYlp0Md7vM88dsLKq7Dbf1Sx5yRZVjEYkl6zZ4nn80C9B
         vD0kOtbEmWzKCVtiFFHJFjH/F4mYuVJ5FbG0XWzxU17lvWqOpoReNxC40X5ppTs+Bwf5
         fiTIe9/NChtR90i75C3O7FIZBAoc+gKFhg1zE++XDa50VvTpcOdPwGCjaUPsJFRNjK8j
         uQlxTwPyGV/nLZDxmqD8MTvTxh30hP8xf6EdFdfOmKYEQihrwCRNh33WiWGLxn1sy1lH
         xO2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7zYC14kkeeAydLtOuE3dZ/lyIfuyBLa6WSEsS0ZThvY=;
        fh=XDKktV6opsWIUDF7kBWGE7N5uk19GCGLDgzUTCP2iMI=;
        b=WIeA9yHOpeLjXiokzcaPhFr7+yFkDSzp5NZ6Ry7lWr6BL4cKIy2FvKKpXcH79T8zTX
         7CIUkwKudDJ4rvt6YFWUKU0S81yrIu6kLA+OLfRwgbY/afIzIKRVha0PQwRqVw4O12cR
         uugFe5XkGp/rh7tyYmyZpNmal49hkT92ZfbP6ojHggdNrIw0lpMnKUvTGYZFxIXRJknY
         YF+IqU+Et46qhuiVWvRmxr0orN/6vKa8s5gTmD5mtVnZoWXRjU6CJA6KYpOKJqsB9YWO
         GEVmG4iq0wslO9MLPRCrcXtMy5CIQYvXtUUzgg36PQS3ucem6XjGw+D7Yx8NKCkjmjQZ
         qJmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795612204; x=1796217004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7zYC14kkeeAydLtOuE3dZ/lyIfuyBLa6WSEsS0ZThvY=;
        b=HCTsscWaQ0D/mLUs3YEjnkg5QclaMq1At5oYtldJ5fjwzF2x16N+otkCNG53wwaNzI
         IhdT4WZlYW4Ufm+0ycBj5wnFbKit+0UQv+rUZchlOVytuxR1kznYro7E24+kzisjehjf
         wijIxlJvOZ9ikUVsVWHw4aDJB9fira0HQy/9Xc3tbubxsLXzt/tX4evuAQWofuogu9ry
         M9Y+GIebPWFyr66FAFQOfLqX0+g33k4ho2pGFpjICNYKayzTsdt7W/w3MyvQLG7u47P5
         64ve9mjHkF5Soiy2Zzl7ZlANa8qU0XEKnPuTx54kEX7wEXPlXxC1pcn9/A1091lkKq7d
         MmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612204; x=1796217004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7zYC14kkeeAydLtOuE3dZ/lyIfuyBLa6WSEsS0ZThvY=;
        b=Xe/RnXHU/NeuSL4ZP66rbXtJkpVi14W9uQG+hkCIR9yav4NIBI5VSYrznr9lCw4Bj9
         6pFUW6gMXlM/o0u5OhMgvFmnSsEFz+SpaYWEQhl1ZjTAN32LRTO1bXLmOH5hz6sP3RW/
         FhJ+jrsUtDldTtrGV3ICGxBO+eCzRZKt8W0deUuyv1Aq32PAf2gNcfltxuzOdqHT1TjY
         N8w/szOwjT8OtVOPxe87veXTTD7Bowh+Uyae30wAZYPoXyX6sA3Zr6pvmT6qcVGIqELF
         x63Ljp8RrygezlXiSb/wBzHXm55OqQCMtW/8p9VvN/xGw/3wiB6hvtSFuzskOAXPt1rE
         cboA==
X-Forwarded-Encrypted: i=1; AL+hErH5CTyhun3BrwF9KiPf5BDEGNqkHnAdla30DbTQY+jjVjE9FuFqk7+uyZDkno6ZrL9qAbwjEoL5Wg==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Opyup1sQOwMR+Qh2c+EmWJ5gzjblQ6fPfeJk3PY0KYxIkOvpL
	O+K4iV+aYUq8M3JNybv3J6mHepXzJLXS7KemexBoFkFLGpcHt4giz2Ua3H9wODeHToB5DrOd5Zl
	ojBnZGylPs2WXJX9toWnrw9qzvdWrefV9K+aezxAr4omlU+WKmLkhwIeanrSMyeTDI7UqJWiMt6
	qNsw+Wqh+LSAN5C3Gw+fK6SGulAosvk/Fq4vff
X-Gm-Gg: AZFdTZfLqmslqzerpUFJo7pnfet6mYqSbT3XrurUQpM94PkDm2XMeUefpkpbinTDoq/
	0tOP40zRGZvknKbHlJSX+V0pmBdVQVrpQwX+dfQJXrabg+ytD+oO2eKe+T3Sm+Gqu3anwz3IYYB
	gL5oy3BK/wgnpkZyGbimT2o1fzOd/1lfSsa9Le6E8IVR8vkz5N7PpiQGDUIQ==
X-Received: by 2002:a17:90b:5346:b0:3b3:ab74:74f7 with SMTP id 98e67ed59e1d1-3b41c955bc5mr17028242a91.39.1795612203979;
        Wed, 25 Nov 2026 05:10:03 -0800 (PST)
X-Received: by 2002:a17:90b:5346:b0:3b3:ab74:74f7 with SMTP id
 98e67ed59e1d1-3b41c955bc5mr17028202a91.39.1795612203470; Wed, 25 Nov 2026
 05:10:03 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com>
 <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com> <CAPx+jO-rMeg8BvemcMUcC10enjt0dkqWvsK+uRwc75rWpLXhMg@mail.gmail.com>
 <CAAq9HC4doEs2v=aW0-tR+ARD8a1OGes8xDi2BV=T7m40YFBmww@mail.gmail.com>
In-Reply-To: <CAAq9HC4doEs2v=aW0-tR+ARD8a1OGes8xDi2BV=T7m40YFBmww@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 25 Nov 2026 14:09:52 +0100
X-Gm-Features: Aa3M54oxcK6RC0Uj2-RqU1IkNrdUwbjccr03Fd36W2QS4bujwoCnie3WcicoJCs
Message-ID: <CAPx+jO9CHiWfHNqApccUb=srYec+Ep-bupo+iQteu9ZPVZ9MYQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
To: Reza Kurniawan <imkyufie@gmail.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Val Packett <val@packett.cool>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Alejandro Tafalla <atafalla@dnyon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfX2dvf6a1JkOzw
 MfFUEvqHuo68LrKFtIF2j3OrtFi09OnggrcOPvIBYk2z1fNyyyySdAXmyneJ1Vap2EPqq/wEzPF
 z1oITW7A1rqJPV2EnB/TAN2cXGvxdSuzmyWp53UPDMDmXmt9CNUR607DaiAfHwrSgwwyKBl9psN
 cFrctIgxdl2SQmmd+USKb+uL6Y5CMLraNyudBc8f4pzH0Q9LirzEgaYX4gNhvc9BUIPk1ahtVN2
 9SHlRzYhSG7KKacsL/5mAbB+E5877rP8jaBXtbkC9KaFo0iuP9imhfdk7YIQkI1wpTGL+4mtrvq
 6Ix5KMJJz/i80Fo4/TqflAdvWLNPwRpDRd1r136YE2te+Af4jbfrF0L4DCbFR4KPZtx5dkziPgM
 H3etn2v/A7GovK8K9dpfEU7fl+6aiU4pJiYuGvlgayCRe1jd6telrH0QoEDFaDG2b7JAeE50OuI
 Z0M92cVvB4dacN5ap1A==
X-Proofpoint-ORIG-GUID: EJb1Oz8SyEjPEaCGHG-FEWGvoBMgK9QQ
X-Proofpoint-GUID: EJb1Oz8SyEjPEaCGHG-FEWGvoBMgK9QQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1MiBTYWx0ZWRfXwXdQ7yBVWv3D
 /t9lDeVPceMN2YmKomKKqjcdmW+R+vG35SXd29zHBzafEaQJ6aCB1am8eB2ekD3fdtc29jhDbve
 npHGXcY9nHJQ8C8FqIjY+zmwLjbMDh8=
X-Authority-Analysis: v=2.4 cv=R4mWitRX c=1 sm=1 tr=0 ts=6b06de2d cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=UY4Qpe7uAAAA:8
 a=gEszbayXw1Bg4_vTXsgA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Dz9CbhmWzz49oM4s8yQO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250052

On Tue, Nov 17, 2026 at 7:15=E2=80=AFAM Reza Kurniawan <imkyufie@gmail.com>=
 wrote:
>
> On Fri, Nov 13, 2026 at 8:10=E2=80=AFPM Ulf Hansson
> <ulf.hansson@oss.qualcomm.com> wrote:
> >
> > + Sudeep
> >
> > On Thu, Oct 22, 2026 at 11:41=E2=80=AFAM Reza Kurniawan <imkyufie@gmail=
.com> wrote:
> > >
> > > From: Alejandro Tafalla <atafalla@dnyon.com>
> > >
> > > On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES repor=
ts
> > > that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> > > call is rejected with NOT_SUPPORTED.
> > >
> > > PSCI provides no call to read back the current suspend mode, so the O=
S
> > > cannot tell which mode the firmware is operating in or why the switch
> > > is rejected.
> > >
> > > Add an optional flag that tells the OS not to issue
> > > PSCI_SET_SUSPEND_MODE on such firmware.
> >
> > I think it would be nice to further clarify what's going on in the
> > PSCI FW. If I understand correctly, the only supported mode is the
> > PSCI OS-initiated mode, hence it's always running in this mode, right?
>
> That is correct.
>
> >
> > This is clearly a violation of the PSCI spec - and I guess updating
> > the FW isn't possible at this late state, or is it?
>
> Just as Val stated, it's not possible sadly.
>
> >
> > >
> > > Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> > > [Reza Kurniawan: split out the patch, rewrote the property descriptio=
n,
> > >  renamed the property]
> > > Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> > > Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> > > ---
> > >  Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Docume=
ntation/devicetree/bindings/arm/psci.yaml
> > > index 0d04389c81..2eee38d155 100644
> > > --- a/Documentation/devicetree/bindings/arm/psci.yaml
> > > +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> > > @@ -98,6 +98,19 @@ properties:
> > >        [1] Kernel documentation - ARM idle states bindings
> > >          Documentation/devicetree/bindings/cpu/idle-states.yaml
> > >
> > > +  skip-suspend-mode-switch:
> >
> > Maybe a more descriptive name can be found?
> >
> > osi-mode-only or broken-suspend-mode-osi-only?
>
> I initially settled with a similar name before (with 'osi-only'
> phrasing). I ultimately went with 'skip-suspend-mode-switch' because
> the root cause was only due to the mode switch not functioning
> properly. This property doesn't do anything regarding the mode the
> firmware is stuck at as it's only fixing the failed call. Normally,
> the driver sets the PSCI to the preferred mode at driver probe (OSI if
> supported, PC otherwise). This property simply skips that part and
> assumes the FW is already in the preferred mode. It could
> theoretically work for firmware stuck at either OSI or PC mode, as long
> as the platform shows the same symptom, It is mode-agnostic essentially.
> That being said, I'm not completely against the 'osi-only' phrasing.
>
> What do you think of the above rationale? I'm open to suggestions.
>
> I admit that the word "skip" here isn't really helpful since it counts
> as an implementation detail. "broken" should better describe that it's
> a quirk.

I guess "broken" deserves to be part of the property somehow, to
clearly indicate that the FW do not follow the spec.

People have different tastes and I have no strong opinion in the end.
Anyway, I suggest you to respin this to clarify the commit message and
to suggest a better name of the property. Let's see what Sudeep and
the arm folkz think of this as well.

Kind regards
Uffe
