Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69C431A2E
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212896; cv=pass; b=eBTxs0UJYQSilJhUdeqJS1h4/5ak9+TmeaRLw8aaMyNhiHEY36QMYRPysIlDEeUHk6LEcMQRJXWIKgdfiqG4oR1QE6FTNeSLUJdML8qiZ8VrveyuD6JCXHM3/Z7HUxR/A9204Dyj8Sy66+xEv9ik2WMtB7dS4Y7PvOxRxxd374E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212896; c=relaxed/simple;
	bh=hyj3UnvN1eL7blZIruI+pgZz/uFUOhtMU/v3/gNCvNo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c5y85SayMIubCO/cgMypsGxSeGwPTAyzLwGlpy0CF3U0me6coSiesYQmRrc94Bj+uB7wX8VscWdgGrS0YbqPinyAQBj4amQOwiJpMuE8BC67A/kKY8i9HCgAoSwwRQLhXxMlXkLlJrvT7p2+ZHcj22BBXbd29OQjTVsTdX3HQlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fq32eMEn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wmm9WxTd; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fq32eMEn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wmm9WxTd"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66GDJm962734531
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=; b=fq32eMEnkSDXCyNI
	O+OEn+jRvMsMTtmNa8m8gqiLuPqA2oGtOQ7mvg4N+hT3NzUjClAuV6CScNuA0TdU
	9GlVijnYeCmS/lYORwfduWOa0mCSQ+XTxd/KZlJ8EhYxOkHk6phRqtYkMugLqSw9
	LPoSTjBDF7DYXdaOBt0fVBPki4cWKimQd3lNASYCEUJMmPcX1dmXxHTBL3kvRqRz
	DNlTd2tZzOkZbFCDvgIIP/2gbXc0oRYzq50cXSc1YrpWpOcmTFyfH1eZGNskfRxV
	8i8Jt7O1K68TUzD3qb/YC2zQSc+00matnHCWmrWfkio3K8+oRzkTlrx3cBJalygz
	NfxUlg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fevkv1dk5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 14:41:33 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ec91dc265so328974385a.2
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 07:41:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784212893; cv=none;
        d=google.com; s=arc-20260327;
        b=WlwKAvT9AP4HDxJhbKC0aNSDIZFTD8VSGDMT1aph9QX91meA3wkYfgpHXuqKdHKtcy
         uPma1EtHavjId3plw27TJp0Ix7Ntzmd2QzVQ64TeCUUUNbtaeqR3/Usm26ycQrJhGSmu
         TPXp3s2XePUu16RG5W4sc6XvDds51Ck8hHSeu+lQLFrj2B6FGUbwHV6/aJNBM790gCWG
         ij8kJAP7pNWMcYC6kPa3T4WDSuonoBkKXcI8baTBawKS5pvsmV+PcH+WP4t6q+RWtpUE
         B7itQRjnmoCbwq1hAtrAqgI/4Mq2Aui9MZMJYdpX4htfPnYYc5vmUgKcfqzbbqq2yB/K
         waqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        fh=E/CJ/oDASUuk3H8ZCCTl0VhO2tSowdV+S+xCFm6fuNE=;
        b=CcxH4MDITBi0oimmZiy2N5I09GsA2xWpVCxZL2ni9EucBIrycoMlajxmKCYBos52xZ
         avBB5ORuqHlsK9Hmz0EIxiKBiiJpf+0slUFJbwAVig6iBlVfcbj3mlQLzsREdorhiULZ
         lYwG6ujC1Eu2n5lfGEo6hi+jku4a55jM9gT4dpOsN6X09F4TtB6MQrKsteozdPD+W3EW
         6dQdkEc8EiQcjWYV5E5QvgT7vBq73aO2H7BRpiQySli2YNQRJGlL0lILnvMkj0Tgh9n8
         Y5oBeb5LoDIJxNdPCmRzvH1c4af34J6JykJhVTVDdkgJ8v+3DQmMCyilgI5cndUdJqKe
         ce1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784212893; x=1784817693; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=Wmm9WxTd8EUWtvr9KorvXD8wLWoCKYO9rNJTzlbdqec0HlUIF/9ESodj86I4hapIaL
         LFepfgInSYfl+u4JLXVnt2Lf6K3y5TB4PbFdV5ES0Cq7eYmPk4VoCIXZ5nt4fkfvGpHf
         Wi+6HpC0hFDzz2BUTte3h8SatKbHfITuUNOF6pzvhEujIMLRvqJrtaxW2H3zuJx6wMUf
         hWe9IjyzbBEu3aNM6aaqDtX9foQvWOxXvbsVPYPL0w5n2xp0f2ISQijkWtN4V1ae5x9O
         O1W+HADEVks7SY3gjOioq6g+jpLbVyRAQtWYEHu230Hkj22/heWUYp+vcH7BnHDjFTF8
         i8og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212893; x=1784817693;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uUqxKURSoOVb/5L3BwAiJscutjj+pBqwPiIBk2WAZMY=;
        b=UyCicFqwuTvD6/FM++qBp7XpKjFC8hPNknsvLq4L3/8eAM3bkz24xUxjkb0a6DT/f/
         eAgvij0YBwpsywyF1Uhrva0JWCBtWLvNG0Gc3pbq47Kkle/9cQHGjkTnsbR1+qI9A619
         7c28PJEMDeyybcumAhN24bhtONOjp3GLuuPWj/PviUOatb8KA5jwOgZWc8smfIcU5m1a
         jSto6g/BZZZVnx0OjVo6+93d7y5Mwn01iVcOrPohff/zJitijJQ/7krVpGuAK0mA3VBB
         PW55mEZGnZkDTLnNqzEZ5oRmP95DIxiCXDx7kbO/F3G9FkpmdyJVsFvIlLuIE2xjYR1n
         YMEg==
X-Forwarded-Encrypted: i=1; AHgh+RqE2uDEpEgTWJ7gQ+mlehXdfKztaXd7djXQCtF9lCIfgQxAedBX6utODdzR3cTMoYMmBJt5N+zI3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsCnRqK2f1Ce2+xRXeTXPfgdLqXCFD/rDZXhRlLM7A6fouR7NU
	P4Ev5dLKdnDhUxnRC+hR+rJo0gAt9bI9XKpcj4cu9Gz/gAPjcAMwM3Mfkpk5saEC9O8YlR+Tlos
	P/uBQMGxpWIqDPUuql/OW+LaxqLuMbwe2r/TJV68qPz5OIbJ/5FCSncPf+fDWHppoj5Zj/P4Ljp
	wR4xMkyu8Dc6OpXRvI3cWiE27aOPOKkx2tokn8
X-Gm-Gg: AfdE7cnqoCQ8CQ43dWVaci48QythKUzKLB2pwRM1tem/ZIJB1vlLeCCnG89E7mYU8LX
	VVqInCvYlY1ybbdGoc2w2YcS/Pz0Ix/YgAsigVv4ixlR+qCnzRZ7gPS0RUdArn7DI94fxqXsf/8
	ygVqRexq7codkDzhVZReySOXwF79iK8TKV1rxVVAWeRCsPcLbLSD3AEFktadJ3PN2FggFDnWR3H
	O5jHnEBc+vP7QwbAaNPxh3afZhXK9ybd5i7CT8ETS710+T1WA5oyHj7ikEINXKPFq6Dlt9rVvkY
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id af79cd13be357-92ef2c61899mr2368569685a.41.1784212892752;
        Thu, 16 Jul 2026 07:41:32 -0700 (PDT)
X-Received: by 2002:a05:620a:254f:b0:92e:7733:e398 with SMTP id
 af79cd13be357-92ef2c61899mr2368564085a.41.1784212892247; Thu, 16 Jul 2026
 07:41:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-9-46253587af64@oss.qualcomm.com> <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
In-Reply-To: <6txwszoqlx5msqhspafk2t66hpdf67tfvc6qejeave3gg4fuby@rosphqguupiz>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 16:41:20 +0200
X-Gm-Features: AUfX_myENjJrfTQJZMSC_KpPtznIhruyFgPIX7MpMY0JW25MDOTnZMlXQyQrAw4
Message-ID: <CAFEp6-07-6wzV7c-8mLDCkfVhgwVQ59BdTGvaXovu5PUGBCDZg@mail.gmail.com>
Subject: Re: [PATCH v3 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
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
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX2fdkU0SZiJZZ
 nSpxLxS7mC4qvgESAJy9paoPUTlXdFWHAInCwUtbwIHrFFkwjcMj6khwsyGvDYlorwS9rvgxKhS
 kAmKmf+w9rMJP1xPnBHOImv2PuQ82YqtDRc0B+t5MGTIRKhMaUs34rKKX3HvtUJqehGqW+lC/r8
 pNTBBepMqadoUhqCJMRvS2BIBiyh3Oo5ZxTnW9Y1ORE7RcujYeRG+CGh2KAT+c6wDmOhqdDE/uI
 BRyPXYuNdvF4uFVvmCKHN1T0cxYFxQkYq1YuSBy/1pO8RlwWxmX1s8/d6rkFekLTsmTHLBPZgtW
 MxC7PBgx5yu6rMrkzt0p86g04IejwkYXQ+joyQriTC2NkwEdWlVa0LAugBEgu9+42cGvF/1Y7m6
 gqFBedqs+ZfELVqFL6WJfXl/iERTOZFc/dvD//jqxTUtLDHt2FKa0n3j+NjCSJBxxMRgsVGZhYY
 aoCbzq62tnNKTtsMFjA==
X-Authority-Analysis: v=2.4 cv=WrEb99fv c=1 sm=1 tr=0 ts=6a58ed9d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Kcl6yQRxnNA2GZFW2kQA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: obh5XW5t6ScwaaJmCulIyZfASAP4Z1sH
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE1MCBTYWx0ZWRfX9NtRAVcz8Qro
 gkT8N/eOwWOv9HIzw/Ni9HwkTYmqG6N4gv2+4cQ+/XsYzvtXlb9CectLkAx+5pGhyrHf5tit/jK
 SyeftwZZmu1dsDjxWnxLuxU7v17cND4=
X-Proofpoint-ORIG-GUID: obh5XW5t6ScwaaJmCulIyZfASAP4Z1sH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160150

On Thu, Jul 16, 2026 at 4:30=E2=80=AFPM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Fri, Jul 10, 2026 at 11:57:35AM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
> > rather than plugged into a real M.2 Key E connector socket. Such design=
s
> > are not actual M.2 Key E connectors, so describe them with a dedicated
> > vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> > fallback for the shared signal semantics.
> >
> > Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 module.
> >
>
> Could you please also add "qcom,pcie-m2-1620-lga-connector"? It is
> functionally compatible with the Key E connector. Otherwise, I have to wa=
it for
> this series to get merged and send one more patch to add this compatible =
:)

Sure.

>
> - Mani
>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> > Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> > ---
> >  .../devicetree/bindings/connector/pcie-m2-e-connector.yaml         | 7=
 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-conn=
ector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connecto=
r.yaml
> > index f7859aa9b63469cb43919c0b5719c18694c5364d..0282c6ee9272446064a99ec=
6314a5ceb1721e0c4 100644
> > --- a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.y=
aml
> > @@ -17,7 +17,12 @@ description:
> >
> >  properties:
> >    compatible:
> > -    const: pcie-m2-e-connector
> > +    oneOf:
> > +      - const: pcie-m2-e-connector
> > +      - items:
> > +          - enum:
> > +              - qcom,pcie-m2-1418-lga-connector
> > +          - const: pcie-m2-e-connector
> >
> >    vpcie3v3-supply:
> >      description: A phandle to the regulator for 3.3v supply.
> >
> > --
> > 2.34.1
> >
>
> --
> =E0=AE=AE=E0=AE=A3=E0=AE=BF=E0=AE=B5=E0=AE=A3=E0=AF=8D=E0=AE=A3=E0=AE=A9=
=E0=AF=8D =E0=AE=9A=E0=AE=A4=E0=AE=BE=E0=AE=9A=E0=AE=BF=E0=AE=B5=E0=AE=AE=
=E0=AF=8D
