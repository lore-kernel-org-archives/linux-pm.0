Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794654810;
	b=K7swOfu0qeImOUJ8pYkEzYRQ5EDa5bcBVh683iTTP3RCpR3T4O+zAufhFPD/0hI3p6gd
	 lO2bGakH50D6aWZnayxNzFy+eDTgJOLrozfAGpVj0Ra7FC3rjmHT6wjrVb8iGjnpzwwls
	 IZA+S1ngLuhTuauvvAYTFFngrY5dp+mUoKWT4lRwF1KnLpZZFwWttIjUYjD6MpjBoyeEP
	 7uXRbSUyWsTwNEJUxz3hGRKq81pjQQXjcRF1M3EJZdEJjC+rdVEr1fmwc6kxaMOWhd9Xt
	 dPwk9H8akb0LpVhdXzElnL8ETdOpHmndxqSRyMMMvx1BwGnRVC4jRzn7d4Qjsn2XdGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794654810;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gVmJhbhmFmpNnBeZFMO8F6xPAmfr5dJB1/hcDGtiydQ=;
	b=lHBOgwAtiafXRZaSOQQRM3C4lp3z9XVC/CaerTeVgz4kxWdbU8mDt+oka5qy1OrbFdv7
	 POO0XIT8Xs7zmlN2OeTrq2bG2XeA73lbmy0lwZe5IZa0CoqtH1ebgWwe17DdLnRQlbOa/
	 kXWmCgqXHJiDpE71XUEIkZE58xYTBhBCyLG2PdGHg6FyapWhCNKfvS8DZ7qYDln2U1GMO
	 +fuJBYeZJKnstFYa8gQqpZrpc0wYtm3tYi6lBE3wrWQel5J+4dlNSSB87BNQJ2nk5cO7O
	 a2LzHyHbg7zL3ed6DWUH8VTEDnGIorVX2HXj+w5E38IFls2Lm/2yq+2+CuWZDEqAc6Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZP5sHK8b;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CrNz0SR7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EE9606A8AA
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67EE9606A8AA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZP5sHK8b;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=CrNz0SR7
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AE9wCnV3379129
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:13:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gVmJhbhmFmpNnBeZFMO8F6xPAmfr5dJB1/hcDGtiydQ=; b=ZP5sHK8bZNHl3KyR
	8j3zJXe1sf0pfDQCOR8SHwA6vfd0giftBYbg3PqHIl+S8vgLzhB1hksm3v9OeWkW
	Q9Z7X9PlngHp91ObKaRX79d1eR75CtihvKoVnLLR73z7o1bZhbCkhHIBa5kM/7hc
	BCP5WG2iig6D3od9LrlZR80+0q2K76c/18lEiCpUb1GugtlgSz3VeRFqME9cMuDa
	XjOmMIXdWepKljzAYCDEwdWWMlaYXIY2+AIbKkGIJVjXEGRg6DIbm4hVIsNWD1Hl
	3RVuM3oMBoUlNoK99cozSlPY0zmdUBbs8v3sCR7fJBsZgZnbjGMybUgDxE/S/Fj9
	YVNxBQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hxhnx0m3c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 11:13:26 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3ae19907a31so1760063a91.0
        for <linux-pm@vger.kernel.org>; Sat, 14 Nov 2026 03:13:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794654805; cv=none;
        d=google.com; s=arc-20260327;
        b=lDWF+WoWL/tCHJ7PzvXS2Whao8/uyyhpCMGVcooAkhvTG9toaVmDOQEH3YiodzNXYC
         VFIwP/uUSAVBSAN8yqpwE81uBeFeaF2DeKrfB7DQIKgWuf0qtwiZ2lWEqy55EfqMTP/F
         0zNeuFaJPQdnZ38z/NuVeuwSB7tGYAgSXZGf0LPTngnYGK1iRVq0xsxb0X7G6hAo5kLy
         EEGatWGU4/fuxN6sfRuTPoeSrbof/iCkoOz+uw9ftHwI6JRwFr8shAliLb59soKnhUob
         D2o3ygIo/GpUNXPk2lOscFOCEEHht+PMiGsuz/fWd8hmNidoHRoBelHkrfw6+co9NUAb
         pvww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gVmJhbhmFmpNnBeZFMO8F6xPAmfr5dJB1/hcDGtiydQ=;
        fh=7fmWh9i39XVIG2fNNuXNIpvFaPnVZ6voAKJB0h/Ae28=;
        b=pyH6DGsAfYtLdQOFGsJGho8SPtVEla/SoprQ8IVAFS6txel6pk7G8K3N5W48jHCAjd
         6FGkUG4oSpYUpNoHdbQJTK8G2tTG8V0g+GdER+qjui7fP8gyEUsQkxRrMCAL6hR897qj
         9UZKmZTSCNghwxTBLVcLhd8TyVnq+hL8lS1QFRLLVilb2aqQwEO8+4ntAFNJOIZNsZOg
         8biOtDuGEJ6omYdZX4XP4qztzzHYU57Md4n/2d7H89Nq16fJWIif849q9tvQAJlTylfx
         vXSFkX7FZuWVnMe57tv9D0VHo6NVhcC1IbZZ7sNPDuYbc1zeXHuiWp7Ap8Ct2N+XBfHC
         MDUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794654805; x=1795259605; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gVmJhbhmFmpNnBeZFMO8F6xPAmfr5dJB1/hcDGtiydQ=;
        b=CrNz0SR7Ae0D1SF3gcSbAbb8RxyJ+Gdfv6MysHEagtMiwQH+DhcxyNL+K1nNenuyhi
         SKvq7dsxD+yzEvR043YxTM5JREtdPS9zHgHtFouRO5Z5t5JjrTvsO9Ai6gRpCQsjK7zV
         V+MZpyUfVC1yzX+uJa2O9S91FSVMsGVQAEiOfWxdeNtYr0rQbAUYI+o8Yegzq0izqwQy
         SCrH7tcsE9EtmJ2Z8qb9SYhcluwqwCb6GjD2JDALYUQisomP9h0mKYWltiyVFq8LUmiJ
         9B7HltYqdivJiM9KEJWFMbuYaHBxmQvQBsdeB1OlwNZg/yW945liGNqMyVbDsqzZW9Df
         r1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794654805; x=1795259605;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gVmJhbhmFmpNnBeZFMO8F6xPAmfr5dJB1/hcDGtiydQ=;
        b=oLtR4z1JrwjzFnn2XXLBx6/BGjmgdR0dYxmqPTScMHIWPO1T239X0IZouKLJuuDSna
         IYU7awowEEO0Tu+rrApWSR68jvhPXCllaDVD37KRstpSmhXIHX1ifW+TQn3LQMKU+NeV
         UiMJU0baJ7OSlhyTNsi/irHf1F/QnI+GxiTY5w/Uw5nNZ7gHUqdcoy2BfE6zKmVAmMfx
         qi5Ty68OCXPOKwWii7ARZ7OZZzf2dMProc9q6yV6KCE/g6SU5pMMjaklzQs6pd+Sfple
         c4DRd78W5N1MOjv3ZUn2FE6S8Vzvg7CqY2A6CYZncbzYfLUqFTykpmw04IGHUl0T2GSW
         ovMA==
X-Forwarded-Encrypted: i=1; AL+hErGbMgZnPN+/xbGtK0L2liymW4e0kR0C4Sl5Y90bxbARzOozx7VVVEazRNB6ktlrgBsPNNEIAlkigA==@vger.kernel.org
X-Gm-Message-State: APuU4Z9XMN+wgJThmTsaTa1XbJ/AndGwa8GmURyu9piJP6skLrurZfRb
	PjL0w4tOarD/2Q90J0hhFYBshowyR1Csgi3CFeUuePuo3gMLA/Hgktd1LSGJJ2UsmkOYs+7RqUM
	emRnP7d0ypbD461QQMIOte2oal3+JA3OYYREyJI/nScjTtetEFNPOiCjT107Mw4OSJx6vSGgeoj
	5wRFUF1I8/cMlA9jOy1BW3N1Anb+RtiK9HCIDL
X-Gm-Gg: AYBFou0PxAz29e9FU1VwZh5f23/UjBCf9zMnM6Zf6q5xPwSMJDosKqVK19BxDVPYKWd
	/eWs5hR5URjKNODVd2zdqQGqhWyKDjlsTWAATM7CxdllxDn2L9cnwJ+KoOVnrC2Vt5HD4ZDHvbS
	HxUcwMTggHx11/kIFVPrn7U9aoG73JZoB9GQsAZRBJl+XiHiFCwvqEX3oDHg==
X-Received: by 2002:a17:90b:33c9:b0:3ab:8288:b8ce with SMTP id 98e67ed59e1d1-3b1b0ca5085mr3649577a91.24.1794654805164;
        Sat, 14 Nov 2026 03:13:25 -0800 (PST)
X-Received: by 2002:a17:90b:33c9:b0:3ab:8288:b8ce with SMTP id
 98e67ed59e1d1-3b1b0ca5085mr3649559a91.24.1794654804653; Sat, 14 Nov 2026
 03:13:24 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-b4-arm64-teo-defconfig-v1-1-5e3763385f89@kernel.org>
In-Reply-To: <20261106-b4-arm64-teo-defconfig-v1-1-5e3763385f89@kernel.org>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Sat, 14 Nov 2026 12:13:13 +0100
X-Gm-Features: AclHuK-HAQDbXPhoocW6FrnwtwdKTq5H0HXZJ5dbq7n3fwl8l1vAmudy8rO9hJQ
Message-ID: <CAPx+jO8LZs-VXehHwjWvR4G4aoS-Gn7AyicGQht-9g6rtse_mg@mail.gmail.com>
Subject: Re: [PATCH] arm64: defconfig: Enable the TEO cpuidle governor
To: Linus Walleij <linusw@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Krzysztof Kozlowski <krzk@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE0MDA0NCBTYWx0ZWRfX5PlcC4tOmgdL
 Gj75P7JooFPZdUAm3ZTRFZtvfMcZh3yiMK/C3NH7Oqnrp7OYjHeW9Fyseo692aWilkWjptb8Zmi
 b6ZBklptkHO4Rne0yJQmVRzqKex88MMLxztjhK7GVj2LjaHE7b2eq+J2ILdMYvVshR18pLcheHL
 AqdqHOKBI6T4Uhwfr0KwUfFxtQTZlbmCTSj72nLzXEHOvbO5Yo/g1/Ox10yIjkLdSo4Rz9R1VuE
 ej08qRyViW8XAAnFQD0P3cQGY1nCXU0VeMqp2oEAWOOp850o8aQ4rDNGlMUjCx5rMn9Ii0kKwmb
 O3Jg8ydL0fkdE1gfjjfifYIgwNRmkFm3vKLk5Ez+aSsIBJbHoRzuU8W3c5qeuCYwGTMUX++NDo5
 EEtIb0VowXkWS/rdLtzZk4QAJJXsg/OhCp+S2B2a6UTPnN9QKXuPXTs4k1E+xQ0Q4D1HH5wAQAJ
 9kPLR0ppCRSwtjOTmtw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE0MDA0NCBTYWx0ZWRfXwUqrTiYg4k2r
 aqZ6xZ0CEpY69rZ2ic3WU88T4xZutwUXm5awqLj2FBjXaS+GnHOAIuaOnT3RuroB8x1DF0BxTO4
 2XtqrOQ1YTH6O+s3CRsBQr/EBPCg8Jk=
X-Proofpoint-ORIG-GUID: hlPk0UKTPWSHyLON0JAtPhbrwJcmLGKh
X-Proofpoint-GUID: hlPk0UKTPWSHyLON0JAtPhbrwJcmLGKh
X-Authority-Analysis: v=2.4 cv=Jr5kP84C c=1 sm=1 tr=0 ts=6af84256 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8 a=taXE9TO7TXhWlUUu3z4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-14_03,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611140044

On Fri, Nov 6, 2026 at 9:48=E2=80=AFAM Linus Walleij <linusw@kernel.org> wr=
ote:
>
> The TEO governor introduced in commit b26bf6ab716f ("cpuidle: New
> timer events oriented governor for tickless systems") takes a different
> approach to idle-state prediction from menu. The governor gives a
> better behaviour than the current default for tickless idle systems,
> and for the multi-platform configs that enable tickless idle, this
> should be the default governor.
>
> The arm64 defconfig enables NO_HZ_IDLE and ACPI, which enables
> CPU_IDLE. Selecting CPU_IDLE_GOV_TEO suppresses Kconfig's automatic
> menu selection, making TEO the default governor for this tickless
> configuration.
>
> Signed-off-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Ulf Hansson <ulfh@kernel.org>

Feel free to add that for the arm defconfig change as well.

Kind regards
Uffe

> ---
> Prepared with OpenAI Codex assistance.
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 7b4985b29b21..fa99d62cda0f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -93,6 +93,7 @@ CONFIG_RANDOMIZE_BASE=3Dy
>  CONFIG_HIBERNATION=3Dy
>  CONFIG_WQ_POWER_EFFICIENT_DEFAULT=3Dy
>  CONFIG_ENERGY_MODEL=3Dy
> +CONFIG_CPU_IDLE_GOV_TEO=3Dy
>  CONFIG_ARM_PSCI_CPUIDLE=3Dy
>  CONFIG_CPU_FREQ=3Dy
>  CONFIG_CPU_FREQ_STAT=3Dy
>
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261106-b4-arm64-teo-defconfig-b1616afa4d29
>
> Best regards,
> --
> Linus Walleij <linusw@kernel.org>
>
