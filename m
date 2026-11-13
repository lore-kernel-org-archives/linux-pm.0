Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794575411;
	b=lJf+Z2TAKLYgTgaI5AlfglVQT2fsCUwQrRxL0evQ/iQPcrPd1uFjDCx6zHG3r+q/E6QY
	 M1+TsLOCdkSohfUrWwEq1lx3zJuq9RcrK7r5Zwvhp4aLWKP6GWAbdQknBzY9JC0+AYMIv
	 6Hq/GaSffKNk/ZmI1/LTlizDCArHACEOhDHzFWPy4s+8Ls4qLMVI7uz85xVogORzly8Ln
	 0NQpOWZsEFHCAQL2vXn2yTP2ftyw4U38TGwuHp0BKrjc+CgLMOxxIYuOT4E337zIta90n
	 mSl/BjQJuHZTW8THU5QgnclyNJJ7GAzAdzC55DHJWnGBROOGFtpAAbtYHSgMerVDczQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575411;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=j8L2acpwy+A3uiHYtid26iwQmvXr9vBuqO0OxDxRSPQ=;
	b=UaQDOwwulbczMDhwf4QaNRMipuogKMAf3zG+HZWZzEPJn0kWA5AZ75NhAlzVcF9sFmBj
	 N61oR4F2ZcAmEA4WpEGGoIC01STOKE9vMDrUDmqhXbfIFrpFAJwJHRIG0h7o2pU0LQtot
	 f1Jvii/5RToFIoXs47LcG2Q7i7O+Xeqn+2dFQOim1x0tY4CcZXzmPfkvB5nHULSSeWC1F
	 X2peh3V8OHQOJbtkXh3taI5f4JrKnjOsdxIcqINkmR3psErlNUXRGv6/8l29NNybBzZcS
	 p4nO28dQfIpfYX9C0NvwKlnlQIvZvezPP0ZC1008oLAYubWm1colTIxkMiVdbkaXfdg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQZEuSZ7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FHGCVubF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EB8606A337
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:10:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48EB8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=SQZEuSZ7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FHGCVubF
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCJQ2a1525303
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j8L2acpwy+A3uiHYtid26iwQmvXr9vBuqO0OxDxRSPQ=; b=SQZEuSZ7/wGLKUxh
	SZQafe4FKG169IlGo5w2z5LX2QhGIOIambc41mKtHex1LIldaOimJFyoDqEMriAd
	1fwZQnuIc8aTSa740MiCIvO9X0N5M0wCHPjDupl/80QPEMSOrkkzhosQHAviy5dc
	mFxZB8cYlzWfDg43f9HAaM8JWZnI5CppA1JmvN7rlCuwOj6x22NK0Hzysox6dfgN
	igJ45io14zaZwgQDWfPaxpRT5XbkhekdxvdvNJYSa8DLQKlZs8C3jAbNqhnLVTLQ
	R1kO3B/Sj7jr686oS1akO7kAS2ji0+1fMGEgtaYJyKc15Z91AdJgwyzHe3hGZe9p
	wv5euA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hx0g20m1e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 13:10:10 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-cd61bdc8683so461223a12.3
        for <linux-pm@vger.kernel.org>; Fri, 13 Nov 2026 05:10:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794575410; cv=none;
        d=google.com; s=arc-20260327;
        b=k/vRKO1YcW7kvTycgk9tGf4dNzfp2q8nC/eF7y11vIuatIs0eXMjaUW2+Vkaa/B0S8
         6WmGJyHCfjW+vPS4wMDO0XK0M9A0PJ/jZ9hVYWYjh3GymlfEKuO3ADvhvyBnni1G1Ppf
         vi76nY7c+KUjKDpiK2coA8x/G6wrxJ6zkrHHo4VOsbXJr1Nidd4wwLGqft36ACEqWUet
         ru56qnFU1gqAgArUo9rCKQFA8twxYnRLpks4Wor4ZlmqDu3OT37RQ/SpVnDRSG46H9II
         ZCQ4p3el3sri7FdoxzBfo0Iqu62M3GRoBVxJuiXCyG/cepVOpjt5gXJYsHlOMAb7tLG+
         udsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j8L2acpwy+A3uiHYtid26iwQmvXr9vBuqO0OxDxRSPQ=;
        fh=TEKtXw+8yszrrHtU7DQplil8h/Q8WSdv6DNTHoKHlVg=;
        b=n4ID3+X23TyoY1jpiOTYOK6uSX06bF6fyZduuCfEmslCdXwJBWDXv6jyKm6R8vgTo7
         6HYkv7YeZwP3gAV53sXpOwPzeUKHN604zhxgSosKuOxO3df6Pjb6fOYG2kZ15XN1yjCC
         zQfjypS9/1gYF9dLSxmAgYDw8i7qq2l67yjspuK4JOzL9PXYrK3ptIPmCcBD7JHm+6+D
         nVMYCm3xl+tiO8lYYhDO4koZn0eGHhU5FQaRU6QVRSAG3SMeiifgbVw0iEGNUPsooeqa
         cdK71wrZBo0+1us3Qe0wCfrNO/TqM7y9qv3oIduECMQQVoXY82y2/c5+EKkuIxKZAjrY
         LTxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794575410; x=1795180210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j8L2acpwy+A3uiHYtid26iwQmvXr9vBuqO0OxDxRSPQ=;
        b=FHGCVubFmUzYHITtw/8v/jAj1vRj8VZZ7EFvT47bna43R8aeFAuUDykqPRR0lBo8ZN
         rAukflUV6vljEk10jmN4oQm6GdC2lYSW6cn1iCkKchMrS0+cm/xkNmx1kD7SoyCriMMt
         O8c3fl82wUS0BYwxQIq/06aQwFo1u+pvsGInk9VaDalb80yvuuB2GhOWYxWeIA0hHClB
         4zZLYyaF+UQXCIUx+H4qAFKYs/qfwOsz2gAJq6qEAiw4AVQJuwkSqnWs0c8o8HqLa8UA
         cPFIasqyb9vAPfFLZZm48xjmo7a9lUJ2MYF2RY6Kf1/4F8C2XEzfnfwe0nbzN9AXml3y
         iS3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794575410; x=1795180210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j8L2acpwy+A3uiHYtid26iwQmvXr9vBuqO0OxDxRSPQ=;
        b=u47oWca1rYO7lSNzInEZvlaiC3gsFXsS8J5QxwTJjgxqhGTcSnNzE/BUfAy4TXgoOL
         +u434il4WCJxEn0cv2J0piCOdgfbQm5ngpBWmXDpfaE+FHaLa3YuYKgFKc+pt6xgq87+
         7FWfwZUJJWBJmfcNSVzfk58bAHmaacJJAKSHKLiXl4q/67mch2bsUVHraaSZ74CNWScM
         uxbnyHjz2j+WHsQ2sZp7in1F/jCzehChgL640kNU6YcW7dcSxs7A9t52yf/9wYxi2Haa
         u5ByCLxENbx78tcQV7vphnJk+qgANUDFxZw4mPnA/IdQquEDqfsdvTnb7Sd+aSohIx6k
         yaYw==
X-Forwarded-Encrypted: i=1; AL+hErFlzZ0C6RKuDweggenAqwhz8zTTUvMhz2pxZhQNpabtmncR8/c6WixFSMziGdzOkA9uFs801OSn9Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z90zd+Jm72EEOtfgIMXQBmjFDkr7t4zFcSx9vv5GgaYh2SKJ+UD
	xQaXusPJ0Rb2ZZ5dHSL5jTBDitp5WIsz+ogY50FSyMPJgFuNSJTW34ENeRFdBXmEI9sBH/ohnn5
	9Fxx0KgEKLz2REm5Gk5XpWZcpyuOR8sGNlvnPsRqftsVTDq8Pkpiqsl52pJOQTNdfwz0b4ckzqN
	DjWVGBFw4JVCCrUrkxik37SrIrImJTHUq2ZqhT
X-Gm-Gg: AYBFou2U2YV4coCM/JN54SiLkuzukpt7Y1/0puF+mt8iQ3mps0il6xvByHFPBYb5Fzd
	+NRV4P8UL7jiOTu5U5C4QomH6LknruBj/I3HvLWppLwOuzcP3Lg7/HJHMdha9Q3lLkCZA1OLFrK
	b9XPkPDbQlnjXyAR73g3+DmZIdmwe8bxA4y0VQK9dMMXYfD9xu21F5T6/dfQ==
X-Received: by 2002:a17:90b:2f0c:b0:3ac:6e91:3f22 with SMTP id 98e67ed59e1d1-3b1b0b85d23mr1919436a91.52.1794575409674;
        Fri, 13 Nov 2026 05:10:09 -0800 (PST)
X-Received: by 2002:a17:90b:2f0c:b0:3ac:6e91:3f22 with SMTP id
 98e67ed59e1d1-3b1b0b85d23mr1919378a91.52.1794575409140; Fri, 13 Nov 2026
 05:10:09 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261022-psci-fix-v3-0-9ce2133c5659@gmail.com> <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com>
In-Reply-To: <20261022-psci-fix-v3-1-9ce2133c5659@gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 14:09:57 +0100
X-Gm-Features: AclHuK-XrooPPikBTcYU6ieoCi2hLf5EMDtx-gXhYpRfrFw3mVoiL0ydev7kJnM
Message-ID: <CAPx+jO-rMeg8BvemcMUcC10enjt0dkqWvsK+uRwc75rWpLXhMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: arm: psci: Add skip-suspend-mode-switch
 property
To: Reza Kurniawan <imkyufie@gmail.com>,
        Sudeep Holla <sudeep.holla@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfXz6LHMtlnF+1t
 hdySJ4JAKRCmHtgUWVq8/+4PQ6gm2ZqsB5XQTuRSHmSbRF3r+6cCJPQYI/vO9WWQGEMJxIkf5Az
 L3N3e35+8F71JLNoRJYMrm7RfE6Xrlyl9qv5VounFUbbx607qPanSzvgQvx+PJ4aksrXj0u5VPG
 aDwthoE0EE23p06mSlIvKUdlT4xtO7I/Kbg8Ss8OQECZmXNu89GlJIAs00F/hLTqnz7ZaiUq0uo
 3uC/tYyIiIbMD8sEwq/rUrhEh8foCsFDD0+2g0uXqeTYfowTNYKJWPayskfgPvIIEBB3892jc4h
 yNFMosP0TSFHpIQb2K1tEQqr3Sd9L5BiTogZx7TqYz6GSnQThEsbE6LJ6FwsvPKd260dCVo+wI5
 vEvcfjSrAT97/BKR6EUP45cW8VFkXaC44TX26sqKm/10HOPrkSf/vEhGsdfR1N4sxYHgKIvmbPz
 EHPuHRFFLkssOY17UgA==
X-Proofpoint-ORIG-GUID: aPQYoJ0v9-XTTATF4etb5h8y-qs5t7YM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1MiBTYWx0ZWRfXx+1F0DFQlk9z
 yMnzyCGLTgulk4brKjGwatCgjZg8g6BDqn9kfd3NSqRr8poKtIQKYMs7urcPOGld2y6sErBHaoK
 XC54Y78GCSg8KQESMaT/ug4lZ9+wXiA=
X-Proofpoint-GUID: aPQYoJ0v9-XTTATF4etb5h8y-qs5t7YM
X-Authority-Analysis: v=2.4 cv=SpIFe/O0 c=1 sm=1 tr=0 ts=6af70c32 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=pGLkceISAAAA:8 a=UY4Qpe7uAAAA:8
 a=E9o5ywDmFEx5B8TChakA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=Dz9CbhmWzz49oM4s8yQO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130052

+ Sudeep

On Thu, Oct 22, 2026 at 11:41=E2=80=AFAM Reza Kurniawan <imkyufie@gmail.com=
> wrote:
>
> From: Alejandro Tafalla <atafalla@dnyon.com>
>
> On some SoCs (e.g. Qualcomm MSM8917 and MSM8937), PSCI_FEATURES reports
> that OS-initiated mode is supported, but every PSCI_SET_SUSPEND_MODE
> call is rejected with NOT_SUPPORTED.
>
> PSCI provides no call to read back the current suspend mode, so the OS
> cannot tell which mode the firmware is operating in or why the switch
> is rejected.
>
> Add an optional flag that tells the OS not to issue
> PSCI_SET_SUSPEND_MODE on such firmware.

I think it would be nice to further clarify what's going on in the
PSCI FW. If I understand correctly, the only supported mode is the
PSCI OS-initiated mode, hence it's always running in this mode, right?

This is clearly a violation of the PSCI spec - and I guess updating
the FW isn't possible at this late state, or is it?

>
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> [Reza Kurniawan: split out the patch, rewrote the property description,
>  renamed the property]
> Co-developed-by: Reza Kurniawan <imkyufie@gmail.com>
> Signed-off-by: Reza Kurniawan <imkyufie@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/psci.yaml | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/psci.yaml b/Documentat=
ion/devicetree/bindings/arm/psci.yaml
> index 0d04389c81..2eee38d155 100644
> --- a/Documentation/devicetree/bindings/arm/psci.yaml
> +++ b/Documentation/devicetree/bindings/arm/psci.yaml
> @@ -98,6 +98,19 @@ properties:
>        [1] Kernel documentation - ARM idle states bindings
>          Documentation/devicetree/bindings/cpu/idle-states.yaml
>
> +  skip-suspend-mode-switch:

Maybe a more descriptive name can be found?

osi-mode-only or broken-suspend-mode-osi-only?

> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Do not issue PSCI_SET_SUSPEND_MODE.
> +
> +      Some firmware advertises support for OS-initiated mode but rejects
> +      every suspend mode switch with NOT_SUPPORTED. Since PSCI cannot re=
port
> +      the current mode, the OS cannot verify the state the firmware is i=
n.
> +
> +      This property is an assertion that the firmware works correctly wi=
thout
> +      a mode switch. This is a workaround for non-compliant firmware, on=
ly set
> +      it for devices that ship with firmware known to behave this way.
> +
>  patternProperties:
>    "^power-domain-":
>      $ref: /schemas/power/power-domain.yaml#
>
> --
> 2.56.0
>

Kind regards
Uffe
