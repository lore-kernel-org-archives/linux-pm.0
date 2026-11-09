Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794237207;
	b=BaAKl9OhfpdGBUP2e1AKyrNEqgMIxLwso4h1JEcW2WiNy3idSnEnFGFzTt4uV8eEyi/H
	 +YJ202+3PrnvWVhGAvxmL76clJ5lbn0OFcUNdkQwd2bryd70Aw69YX2UpMZybX2U59Yse
	 Qd7FggfQkBVf0bYSB+GO9w8UNsDR1hMPO2S2F/CCXmqBBNYN9aPS4UyOCB6d0Bv5nalfW
	 WkHuJfywxremaNFo+7KbsQf9u3JPnDkEn7W3YBx/gLPUV0x9KRdIM/2lUNTBZHnNZ33bZ
	 Oed2ShT75cekrOfskxizG1wWy8A8ixHKBjsNHaMTMgvH6p8BK98HzpL01YsBR9BUK6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794237207;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:Content-Transfer-Encoding:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=f2bVAvGRQ8KmIiccMBatK2dy09lwBqE7j5syb8pUU3E=;
	b=F5UpoYV7jfIO7DyR8T+X+/SlIAqFqcqOtNKKilX4IE1VlenxGE3rQm9NeMLO82gJmrjm
	 8RCCpLu6J7C1C14ytnluqmEgnfA4wyBS+fSSBor1BGsjNlRJgBVMDcysQKwdVB+LkN0Ff
	 ZX+g6SAlYX0MpLUR9GNnuFDC4jXbjZsvcOpylZ/IGt1fPmftxn4ZspY6gyKo2JGVE/IwN
	 iatWC6X6U4z42m8bxPV0InJSz9/ww5NB/4DWJAzwlbMX3klcE/pIZ9qa7e704aMUYaY14
	 r8OddRwrw5B6g1cCXdAr8rQ4XRrM6WaDRN6FaCzeCos62LK2xqP7yf95DOLJhsoZiVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ALf1fyLf;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F71Q4QMP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738BB606A321
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2026 15:13:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 738BB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ALf1fyLf;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F71Q4QMP
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A9EPeg11141608
	for <linux-pm@vger.kernel.org>; Mon, 9 Nov 2026 15:13:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	f2bVAvGRQ8KmIiccMBatK2dy09lwBqE7j5syb8pUU3E=; b=ALf1fyLf2FjXdUoU
	6oeeOPdFeB1HyHQDhDkeN8ThA5C1tMT2b6TzcY6eT8wxJD4QoVVhh/M5IZBWRQmm
	ivVbAHAZv0MpvVkNN9khzL2abl1xU3wpzbKGwZQ7+lEtc3vVJyDz/UZ+Sq8AVATI
	o6qeLi08z5O5iqpANWASXnXDpBM11cuZ53nWnxtmoo3JlNYd7t8ViLyDskJgzeWD
	NpihyKfmsSKPJ4E8MZGT4ptrRGxSkVpR93BJlGB7ApdqQBkqpgw/TaRi3yd8Qr4I
	h+gORQZLHTZtFOMn2tTvBg1OvzpMh1QhBWznrWjEnt23FMlDI4lx6Q86OrXaoa9o
	ooxlQg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hufx805gu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 15:13:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ae6fda7a00so935706a91.2
        for <linux-pm@vger.kernel.org>; Mon, 09 Nov 2026 07:13:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794237204; cv=none;
        d=google.com; s=arc-20260327;
        b=RZKQzOy/0Y4oLx5C4s3p08B1nFLGy5WCyFZ78c/rkAvL7ZYrA8eBvAR4OdaX+SenZs
         EqA0U5b8kAhyKUQ4H/i5Ib5K2a9wBeu3B5FU+TwhudVAwfJ2pXUXadu1Ba9GxQPwYNa9
         upfd8T4lW1af6yGoYsjXzi45MozxxPWy3JG1l28IAdOYpIhpIwJAC1LhbgTAoTH5U2f8
         wSkLzLNyV7BVBH5XIZbc/mc9jGXNqQRv7Twgqx0o9ua+8fyxwp+b8QLyhertixRnVhUT
         Al5fUSx+fgu+RfJGpBt+2HY1dX2JMqFjF1CvQtnzJz1CTxGAujP3lfYG/eCfsboN8mlH
         acGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f2bVAvGRQ8KmIiccMBatK2dy09lwBqE7j5syb8pUU3E=;
        fh=NT/pqm7mZwRLpv1aa59roR/0PgzmMqZqn+I8j8GBWy4=;
        b=mImbR/ugPXlZXs67DqKUxbuX69RB/zqD+R8hjSVMcaSjwD5DCyfQmJ6WKeIM82DUOi
         66tfYtSpuKkCv5j2HtCTlDEugRl9J1Rij/CNOx7actWhh/TiBxGQfScpFt/kt1hl9/d6
         W+S78NIh20HB82PYgLb7No4AJ+K03NG1I/cEsUgkq5m8b87we0RbaNuooBeCK1LSgDF/
         JK/PTjmcFxnMwzz7+NZrwD1MCgjLUdwD2M8qCe0olozrIAADmCUqa1nWeMAtpyuD1Gin
         SzgwaqkkMx4YNhYlOa2R/2fVoeulQjhsozcGe0ODIIdgmeYL1a3HCKEVBdp3nZ49pqoC
         BPwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794237204; x=1794842004; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f2bVAvGRQ8KmIiccMBatK2dy09lwBqE7j5syb8pUU3E=;
        b=F71Q4QMPl2i6nrVcmYPZGFCmL0uUxDpjvOy2QDSsPwmHOVRCzUwBNPyhKb1BNoLW19
         CPF0o/r2CFDEbnaEbKK19NTFGlqqDZp20v9LEPeeX18ET0nBC4NCSsIPVpvPkLgN6jwN
         VBg+gjmmEPxRUpjco6aylVUn7dBp3mh5GPMUiorNrrJsWcrnN0wofwbEyN7yxzfVohRq
         tUMtTvacGzfVKuy8yiG2m5H6XPMCqZeRG3akSlki6KIbJXo2RydsyhGaKiSOAj3CuQvf
         vjwF4uXyQbt4CFmOWG/CN11uweG0BgW5FIGa1QoMQT8jcV/dNaakUPUA6WdwipiaIEeQ
         V9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794237204; x=1794842004;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f2bVAvGRQ8KmIiccMBatK2dy09lwBqE7j5syb8pUU3E=;
        b=1OcNqPnyKO3omvqv8WODUx7irRKMwYCVsDVdbXDG3QWbtVvhH9J2XHaanSaho07fSp
         dIkdUscDLULQdZANXKbGuNCEEv6sgf1igODRxzm9eENc5BP1uM05mKpI0vIsEgtZLhgk
         X5WsUxW73kWYWJfxtdjTplhEBWq9zYWqO4fzDNAQjUYZ/e7keFmcTJSEIBdZZE+NcyLz
         m4+A1E7UzjT3iHMejNMUAiwLXd8B8zpij/GxnriKdVmTOa7EhKkTxBTycL7VmcXv1Upf
         LYF35/2EAPvnItkVPB9BHSSlruNNyhMYyLgBw3pz3IIJPjPddDG+yM4PbdOMzY8usAls
         RezQ==
X-Forwarded-Encrypted: i=1; AL+hErEOT/58CbKfRxoo/FsaVfSaGRJ7PiPDoN8gkXXyPbZjrqQ+HrwJsQbd4f7d13zNz0K19gpzb4mfoQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z95urbM+wO+t5s1y80+HBXuoFs/1Oya4KF7R+9qHDailuOox0Pe
	9hh5v+ecdBTMFqz0+1+N6y+WDQXPTruKaGsvx5EGPTi/VZdDil0ElJnYWdojObUA1vCSk+M3bom
	7Im9up7OKxx97JF0VXjUSVVaeCwgHrnVj29XpyEJa247Wj9EV58POmjCzxpFMQIBXznj+84fueA
	ENelYKaEdoQZVylB+WXHSrCtDGVhiSJxl7TuDn04Fh3TNYZsk=
X-Gm-Gg: AYBFou3T+ufgUi6pKXxUjjUDcrYlaG1IhRkQlp7B9ZWJ8Nzn38cbaliGe/NsznpVDEE
	O/0ArXblC2UzEY8tKIZOW+UjhnV83I21fpb0EzI3EmlmVMPBQ+hJK+V3QpwKNijvLxj2rK1hj0r
	DppCEG5IO3DiGgmKBZhzqN7RTX0af5A05um1sTflqcoPeWoK6FIrtGrITEbw==
X-Received: by 2002:a17:90b:4cca:b0:3ab:5832:72af with SMTP id 98e67ed59e1d1-3b12d33ca53mr3640809a91.32.1794237204163;
        Mon, 09 Nov 2026 07:13:24 -0800 (PST)
X-Received: by 2002:a17:90b:4cca:b0:3ab:5832:72af with SMTP id
 98e67ed59e1d1-3b12d33ca53mr3640777a91.32.1794237203488; Mon, 09 Nov 2026
 07:13:23 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261008091032.2832333-1-joshua.yeong@starfivetech.com> <20261008091032.2832333-3-joshua.yeong@starfivetech.com>
In-Reply-To: <20261008091032.2832333-3-joshua.yeong@starfivetech.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 16:13:09 +0100
X-Gm-Features: AclHuK-qxobxprSMzZBUYKJj_uyReksqIyxGSuqu40gW9TvUywVmIwdWYsE9eVQ
Message-ID: <CAPx+jO9-fANS=WN74rFz=dFZqE5PQo9gDcqb1A33W5ohEsbevA@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] dt-bindings: dvfs: Add RPMI performance service bindings
To: Joshua Yeong <joshua.yeong@starfivetech.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, pjw@kernel.org,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rafael@kernel.org,
        viresh.kumar@linaro.org, ulfh@kernel.org, rahul@summations.net,
        anup@brainfault.org, lftan.linux@gmail.com, alex@ghiti.fr,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=AbYkjHXG c=1 sm=1 tr=0 ts=6af1e315 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=gEfo2CItAAAA:8 a=V1jnuoLLAAAA:20 a=Bq6zwJu1AAAA:8
 a=TxQ1F8pul8oCGEKA_3AA:9 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22
 a=sptkURWiP4Gy88Gu7hUp:22 a=KQ6X2bKhxX7Fj2iT9C4S:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: B0LsE0afM-SgW-fx1zJhXIamOxiAQA99
X-Proofpoint-ORIG-GUID: B0LsE0afM-SgW-fx1zJhXIamOxiAQA99
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfXzyEpAa9nso1f
 mOAhfxMETmLmXtcLSvggbZDOr/qzr8Bpb6r/tRygeg9wcQkcjzEt0lLvsGfrtWLJcmMrIoUzf8+
 IXhA/0SNArWWSkdIEivjNu5Zt3VEg3I=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA2MCBTYWx0ZWRfX9sf/tvYfATPv
 AlWtxC+vEXHPmUOllQouVSnHssESts+CV/Zg1PO5rqxnmPJKrGQXjtmxmWbm9htnZLcYVOQwg+N
 W/Tx8hq/jBA0e4/bSahJb9KuR9iRhpnI5fWOdgcLYDpfzl2niMJhEzol2xIEMBslEkCH73Bi42N
 XBULgnSzzvL7sEU77bBVj+cArty47U1dZeOAhZCBPqVaxYqxKfb8NsdET43teor1ZNwSu7puDKb
 M+IDvPZyvT1dFYL6wcnE8iH4OoNcTAF2K6nLN0ftHREJxxFJBzF9/WjD2HHCrPK/qv/GimofttH
 xUNNXQyoJwKj+XjmCQRwmt+hvciLiETzsjlbbNSe8ABLtUtrwIslQSEwQ6R1fpstShmJfSVIA8O
 IJcyXkaOHdqlaXH8u6JuQ8nWdo/ZASZLHbcbZKeBfqw8ZF+rHykhfnbKGI6IwDVpBXjHStp3Pdr
 0hKABRjIXMQjOsA81Rg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090060

On Thu, Oct 8, 2026 at 11:12=E2=80=AFAM Joshua Yeong
<joshua.yeong@starfivetech.com> wrote:
>
> Add device tree bindings for the RPMI performance service group based
> controller for the supervisor software.
>
> A CPU names its performance domain through "performance-domains". Any
> other device names it through "power-domains": the controller is also a
> power domain provider, with one power domain per performance domain and
> the levels the domain advertises as the performance states of that
> power domain.
>
> The RPMI performance service group is defined by the RISC-V Platform
> Management Interface (RPMI) specification.
>
> Signed-off-by: Joshua Yeong <joshua.yeong@starfivetech.com>
> ---
>  .../bindings/dvfs/riscv,rpmi-performance.yaml | 88 +++++++++++++++++++
>  1 file changed, 88 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dvfs/riscv,rpmi-per=
formance.yaml
>
> diff --git a/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performanc=
e.yaml b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
> new file mode 100644
> index 000000000000..ec7856cb7257
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/dvfs/riscv,rpmi-performance.yaml
> @@ -0,0 +1,88 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/dvfs/riscv,rpmi-performance.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: RISC-V RPMI performance service group
> +
> +maintainers:
> +  - Joshua Yeong <joshua.yeong@starfivetech.com>
> +
> +description: |
> +  The RISC-V Platform Management Interface (RPMI) [1] defines a modular =
and
> +  extensible messaging protocol for platform management functions. The s=
upervisor
> +  software can send and receive RPMI messages via SBI MPXY extension [2]
> +  or via a dedicated supervisor-mode RPMI transport.
> +
> +  The RPMI specification [1] defines performance service group (performa=
nce
> +  domain) for accessing and controlling platform-managed performance-rel=
ated
> +  resources, as implemented by a platform microcontroller. Supervisor so=
ftware
> +  can interact with the RPMI performance service group through an SBI MP=
XY
> +  channel or through a dedicated supervisor-mode RPMI transport.
> +
> +  The node is a performance domain provider. A CPU references its domain
> +  through the generic "performance-domains" property described in
> +  dvfs/performance-domain.yaml.
> +
> +  The node can also be a power domain provider, with one power domain fo=
r each
> +  performance domain. Any other device that runs in one of the domains
> +  references it through "power-domains", and each level the domain adver=
tises
> +  is a performance state of that power domain.

It should be sufficient to use the power-domain DT binding to describe
a performance domain. See
Documentation/devicetree/bindings/power/power-domain.yaml for more
details.

For example, a power-domain provider node may have an
operating-points-v2 node, indicating that it can scale performance.

Kind regards
Uffe

> +
> +  For example, with the provider labelled "performance", a CPU that runs=
 in
> +  domain 0 and a device that runs in domain 1 reference their domains as=
:
> +
> +    cpu@0 {
> +        ...
> +        performance-domains =3D <&performance 0>;
> +    };
> +
> +    gpu@40000000 {
> +        ...
> +        power-domains =3D <&performance 1>;
> +    };
> +
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +  References
> +  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +  [1] RISC-V Platform Management Interface (RPMI) v1.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-rpmi/releases
> +
> +  [2] RISC-V Supervisor Binary Interface (SBI) v3.0 (or higher)
> +      https://github.com/riscv-non-isa/riscv-sbi-doc/releases
> +
> +properties:
> +  compatible:
> +    description:
> +      Intended for use by the supervisor software.
> +    const: riscv,rpmi-performance
> +
> +  mboxes:
> +    maxItems: 1
> +    description:
> +      Mailbox channel of the underlying RPMI transport or SBI message pr=
oxy channel.
> +
> +  "#performance-domain-cells":
> +    const: 1
> +
> +  "#power-domain-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - mboxes
> +  - "#performance-domain-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rpmi-performance {
> +        compatible =3D "riscv,rpmi-performance";
> +        mboxes =3D <&mpxy_mbox 0x1003 0x0>;
> +        #performance-domain-cells =3D <0x01>;
> +        #power-domain-cells =3D <0x01>;
> +    };
> +...
> --
> 2.43.0
>
