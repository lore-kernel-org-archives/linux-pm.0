Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E1A41CB29
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 16:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526403; cv=pass; b=Gt45IzWwtjnWClo8REhB5xY+A+TK5+z1MWSROpvPyOx9A1qN2BvNxiJWj9A8SUBk9XJ9XHCR20K7qatiINIsMg+l5dmjwBskc9NCl2zvxO8sInFpQPPyHXw/dLKl/sJ2+4pfbi9bUJa8UDybGyOoJti6RvQfYLkIE6q2KaPE/2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526403; c=relaxed/simple;
	bh=+XvlrfevpEhHEhMG5k4mAyz1MKzMbdgxVvrUukUJ+iQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LDztuCczLLR8FQDMe5b5QDO1wsC/NZhETmMXrmGBrM12jtJKuzAN5xs2CigRzMYvHJnAjK1xvsZwI+NWje6dthQeePvrpamoNugZCMcRNvlIm8Fh64P15aP09075UOvmQ86V7bMyihLYgTihqBOwk9REvHdw6d6LM+GqnejEIc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hQyosJ2X; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZaD+ofyu; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hQyosJ2X";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZaD+ofyu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3C7c2791774
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 16:00:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/KDa/nFvcGqLtQCRCgYR2/CFmbZnbqY7AG66N1zAjwM=; b=hQyosJ2XSKj2/xX+
	Twf64aut2gDwjGjQ1XPht47ynSUGxROl1EFo4VfbbWCqK8zmQzL2rEBQXV32XXJa
	uB1xuIXo3VuooclO7RyixL4DBekeguURGHJqV+WsRwXClwoIV0Dv6/Vcxxws9Ey7
	qTFhtx9q6fXElirSUKnSD9eW/t3RzGJW1W8CfKyQcQfyJtxTAw7OlivxMs3uN2rO
	iLK6XwIP89nOP1qvMuh+ZWLIWMn6/BBBY2t5E1jfC9LcsyJKw4i5s6py9X7kKPwJ
	tWaXZEfGg/kxDB74HdDLx9Ac0rmqVNnrZLEfpEri9bBZz3kkMl8RT8jZJj5ejXjR
	FLt5CA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9cswbb8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 16:00:01 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-8ef81cc115cso128466d6.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 09:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526400; cv=none;
        d=google.com; s=arc-20260327;
        b=X88MsUYpo1xPtfKHV+NTIOQ+YVQmaGSC9ua5p1EhBn8EI/i6GUdChtF2dluAe9R9Wj
         HORwl+ox3Mw3tP9N+DZg0nFasC0+SH2Jg1XKbdH5tNB5imfJxS15yZS69ECFNlL+qDA4
         xbaPNYoyV6MkTSQXuwbZqpwSThGmATXQWjuCw/p19s020eqdrksTWUhWZJRVy/7NcsiE
         ZyZIbTMig4fYChxs2WWaNYdVCsfpviIF2uFoo7MdyStjz05g71YffBqQnuO3jXHry+sM
         U+9dr5Ni3rwvqSy5zNwmd2Gv0Tiu5nK+yACbZbPwzKaE+2948IPacSkujI04IeTtU7ha
         67oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/KDa/nFvcGqLtQCRCgYR2/CFmbZnbqY7AG66N1zAjwM=;
        fh=KGlY1C/ZEbqpL1BtnMe1X8Cabh8LTa7+Lf9AwhWxDPo=;
        b=GaEsY2JcJTtGECpmNT8C7oHqPvf+1gqmHM5QWOAXbBPsySdh3E+2o07IZKZmJo82ay
         NnSu5aOzRXOx0R8EdwB55CwTZgwUQ/lWbKU07W/2e1Fw/b36EsvevGjSu6Ue+DHOhXKC
         +pWE15db6GselBIPTphH8R8Fx4q0Z8MO2LwhX685/FpUYXEzqcXMVti4NfCb/I0977tK
         PHMlmY9VfTe1ofJI/Zz3kmsbgavGrw4cvzL1+4GlA2cZsda61rkN0wg9J9lMlsOQCVNc
         8kCUDmtthqujj/9HVp3SAh4dHbVu2Px/yz7eXqr0JHX8HjWxKTNaDPY9GqR9DEPmsf25
         JFcQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783526400; x=1784131200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/KDa/nFvcGqLtQCRCgYR2/CFmbZnbqY7AG66N1zAjwM=;
        b=ZaD+ofyuj9k7kQXbSWt+27z0ZQxQbMYIVViu2mZq55HsugpGHCJ+eTXeWYMYnz4vAi
         ZHtIHM4PV/e5ZBp07whz8bDYr0gww7me9jCM9Hbz2bOBUlK7JkcjYD8mXD/HSjiUf3qj
         SAL93CZHgdC6AnCgdOM//pwGcyxfloZZNHl7Bfc674CCU0ebL1VFeR1/1zPtRU88jTAU
         19y2AoxoSJQCKkLkzA9a6+Gl2ENXsRtxyvDYvbCPLNpKbQ/cciYRtAeH9zDsXwqf90Sg
         Ui3Qds6N3AcV+WW8qm4RThCHqzIfyrswOhPLBAyCe0qJKv42tbSK3xsJSuqWk/cWA6wZ
         JmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526400; x=1784131200;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/KDa/nFvcGqLtQCRCgYR2/CFmbZnbqY7AG66N1zAjwM=;
        b=C7oxBdx/qRKVAaKy0UIK5iLnoCzi70/GOa9KpETLzxRIYAwOoXa20QQRxU9Jgr5bCp
         kKXXoONYw2wHEkvQSg5h2DGUEWzt1qQkkZacM8G1IPkObDASDYP4lwit6Dccyu/9YJ5s
         tLUr9J/VaUWb5hU39vE2ICcruvOFR/evlHfQ/yWoa+sb6rDZeqZOpeqDIXxC9EzDfMeP
         YdLP4NAswwyK5JsN24TfphFnnC6Bzo8O6CtKsFmrkcPyw8SANuNay35FMRGQ1ON0879M
         mqIi44GTbQ0gjyX9myzflfwrm4hddJTP90QLysX9Uv+fZHPQZpXiL+hd51UeoGFXsnuq
         bqwg==
X-Forwarded-Encrypted: i=1; AHgh+RomG65i6vKompasgeO/Fe8XQvfhDI4fa+SRrCaJcuLLwZCb6Hz02GrbQZt/7wFj/P90IByIPrYbKQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0sbF59lKq2IPh2MF3GuYAFRqrQCOaMMCuJm1NRTFcfq9ICjS5
	ASVeNGV3Ds9OHlgOi+InT+yUOR2DJBCrKNRmQVpp0qLSOjRdrFJfJMCvvD+pJ0IiE3M820SIM9q
	uvHQMPptuZK5YfAGaw09pe1uRGWI23p22ag4o5gQPq1Wb+VPuzCcHzEz4PoX42NU0hNwNc/6xaM
	d2pl/BqmdYlGuNxjtqvoPCG9l7oQuWWY1a8E/p
X-Gm-Gg: AfdE7clyKscHhjUOzVfFD3Lf5Yfkvz+p40O7rT3/LMAwQN2IwzJgpZJ2jangwlCr7fk
	NXNfKkWa6zOgbV8Q03NM5wOiEWEgNTSTV/rJYzbjwcWcieQYCJ+LrcUlKsmAdVe00QYjSxf8FhX
	t/I3+jxDAqg3yq9iXhSC82rK4SVQ2DvzmO4CFjFeCCqMQP+vc5E4DZw0kk+T9oKT2onAsR
X-Received: by 2002:a05:6214:4197:b0:8e7:eca9:de1e with SMTP id 6a1803df08f44-8fe9ff3400amr34160636d6.3.1783526400278;
        Wed, 08 Jul 2026 09:00:00 -0700 (PDT)
X-Received: by 2002:a05:6214:4197:b0:8e7:eca9:de1e with SMTP id
 6a1803df08f44-8fe9ff3400amr34160336d6.3.1783526399826; Wed, 08 Jul 2026
 08:59:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611085238.37666-2-krzysztof.kozlowski@oss.qualcomm.com>
In-Reply-To: <20260611085238.37666-2-krzysztof.kozlowski@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:59:27 +0200
X-Gm-Features: AVVi8CctTLAuJ9qFC-jA3hxZEr_XvCSE5_0BizoiE3Fpxud_73f40EnOZ9z0jJ8
Message-ID: <CAPx+jO9k_Rcd24UErqHSi9-4AHyGYYcq8E6Dy=n6wGQ6kcJt9w@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: qcom: rpmhpd: Sort table entries by index name
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-ORIG-GUID: nyI5XLnAgWs99Das6IogwU4E1YtxvjCu
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfXzbJ7UYjEtK03
 1LlO3q1iMZl3XckpeMXrX6qdJ8c1oNguBZd79RR8DUsr4sdo4QXUYaJddQK+GcIr0HkrS2yIDYx
 BAz4zD7j/i7SvR/zlp/CuTOJJxdESz4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX07wfkf/uaHYz
 V06BgKhb2DdkkzLB/1Nx0MluUORRK6nm+dRpRSvJJHvpGwrie/z4fhXhPmeXF9ipKU6B433d15k
 101zV5GfFTFVeHIKUmOPgaAmdQ5XRlx5lDqMf5lMCz5C+2EsjLX9jmdtc18sO+h1oKSFZPDxSXh
 bRlnS0jH15eVZe/Udi6xW0oWRLmTGzXGCq9tJhbFRJS1aPrjRCVaEe0OuoNXjblvkIibpO+Ulxl
 +BswJnDu92vZ08wn29AMqBz5uahBPHlL9mcUXpTHFWB59szmfUSYCPdecttzPOkfDP7TX463EMU
 4W2K6dRnBSbdhqGHU6DUTC5B98nF18/5WGhJM+NntSjXHQWL0mYfNWsi+lcyxkvlgfYODh2w3yW
 u67uIkcYo03t2Zd+kj1NdsvcP4Vf/RZPh3TYEdEo6W4GAOe6K7fXGUQ4+lOvCxVgXmahJgByCH7
 qGfCg2+tIwWz8Q9lQYA==
X-Authority-Analysis: v=2.4 cv=HaYkiCE8 c=1 sm=1 tr=0 ts=6a4e7401 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=c2wLe-LXPUWkI_yqov8A:9
 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: nyI5XLnAgWs99Das6IogwU4E1YtxvjCu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080157

On Thu, Jun 11, 2026 at 10:52=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@oss.qualcomm.com> wrote:
>
> List of power domains in arrays of 'struct rpmhpd' are sorted according
> to index name (the define, e.g. RPMHPD_MX), not by actual numerical
> value.  Fix few sorting mistakes, so comparing the tables between
> different devices will be easier.  No functional impact - same binary.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/pmdomain/qcom/rpmhpd.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhp=
d.c
> index 63120e703923..c12127d8e8ae 100644
> --- a/drivers/pmdomain/qcom/rpmhpd.c
> +++ b/drivers/pmdomain/qcom/rpmhpd.c
> @@ -305,10 +305,10 @@ static struct rpmhpd *sa8775p_rpmhpds[] =3D {
>         [SA8775P_LMX] =3D &lmx,
>         [SA8775P_MMCX] =3D &mmcx,
>         [SA8775P_MMCX_AO] =3D &mmcx_ao,
> -       [SA8775P_MXC] =3D &mxc,
> -       [SA8775P_MXC_AO] =3D &mxc_ao,
>         [SA8775P_MX] =3D &mx,
>         [SA8775P_MX_AO] =3D &mx_ao,
> +       [SA8775P_MXC] =3D &mxc,
> +       [SA8775P_MXC_AO] =3D &mxc_ao,
>         [SA8775P_NSP0] =3D &nsp0,
>         [SA8775P_NSP1] =3D &nsp1,
>  };
> @@ -325,10 +325,10 @@ static struct rpmhpd *nord_rpmhpds[] =3D {
>         [RPMHPD_EBI] =3D &ebi,
>         [RPMHPD_GFX] =3D &gfx,
>         [RPMHPD_GFX1] =3D &gfx1,
> -       [RPMHPD_MX] =3D &mx,
> -       [RPMHPD_MX_AO] =3D &mx_ao,
>         [RPMHPD_MMCX] =3D &mmcx,
>         [RPMHPD_MMCX_AO] =3D &mmcx_ao,
> +       [RPMHPD_MX] =3D &mx,
> +       [RPMHPD_MX_AO] =3D &mx_ao,
>         [RPMHPD_MXC] =3D &mxc,
>         [RPMHPD_MXC_AO] =3D &mxc_ao,
>         [RPMHPD_NSP0] =3D &nsp0,
> @@ -480,9 +480,9 @@ static struct rpmhpd *sm7150_rpmhpds[] =3D {
>         [RPMHPD_GFX] =3D &gfx,
>         [RPMHPD_LCX] =3D &lcx,
>         [RPMHPD_LMX] =3D &lmx,
> +       [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
> -       [RPMHPD_MSS] =3D &mss,
>  };
>
>  static const struct rpmhpd_desc sm7150_desc =3D {
> @@ -698,11 +698,11 @@ static struct rpmhpd *hawi_rpmhpds[] =3D {
>         [RPMHPD_LMX] =3D &lmx,
>         [RPMHPD_MMCX] =3D &mmcx,
>         [RPMHPD_MMCX_AO] =3D &mmcx_ao,
> +       [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
>         [RPMHPD_MXC] =3D &mxc,
>         [RPMHPD_MXC_AO] =3D &mxc_ao,
> -       [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_NSP] =3D &nsp,
>         [RPMHPD_NSP2] =3D &nsp2,
>  };
> @@ -809,18 +809,18 @@ static struct rpmhpd *glymur_rpmhpds[] =3D {
>         [RPMHPD_CX_AO] =3D &cx_ao,
>         [RPMHPD_EBI] =3D &ebi,
>         [RPMHPD_GFX] =3D &gfx,
> +       [RPMHPD_GMXC] =3D &gmxc,
>         [RPMHPD_LCX] =3D &lcx,
>         [RPMHPD_LMX] =3D &lmx,
>         [RPMHPD_MMCX] =3D &mmcx,
>         [RPMHPD_MMCX_AO] =3D &mmcx_ao,
> +       [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
>         [RPMHPD_MXC] =3D &mxc,
>         [RPMHPD_MXC_AO] =3D &mxc_ao,
> -       [RPMHPD_MSS] =3D &mss,
>         [RPMHPD_NSP] =3D &nsp,
>         [RPMHPD_NSP2] =3D &nsp2,
> -       [RPMHPD_GMXC] =3D &gmxc,
>  };
>
>  static const struct rpmhpd_desc glymur_desc =3D {
> @@ -834,15 +834,15 @@ static struct rpmhpd *x1e80100_rpmhpds[] =3D {
>         [RPMHPD_CX_AO] =3D &cx_ao,
>         [RPMHPD_EBI] =3D &ebi,
>         [RPMHPD_GFX] =3D &gfx,
> +       [RPMHPD_GMXC] =3D &gmxc,
>         [RPMHPD_LCX] =3D &lcx,
>         [RPMHPD_LMX] =3D &lmx,
>         [RPMHPD_MMCX] =3D &mmcx,
>         [RPMHPD_MMCX_AO] =3D &mmcx_ao,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
> -       [RPMHPD_NSP] =3D &nsp,
>         [RPMHPD_MXC] =3D &mxc,
> -       [RPMHPD_GMXC] =3D &gmxc,
> +       [RPMHPD_NSP] =3D &nsp,
>  };
>
>  static const struct rpmhpd_desc x1e80100_desc =3D {
> @@ -860,10 +860,10 @@ static struct rpmhpd *qcs8300_rpmhpds[] =3D {
>         [RPMHPD_LMX] =3D &lmx,
>         [RPMHPD_MMCX] =3D &mmcx_w_cx_parent,
>         [RPMHPD_MMCX_AO] =3D &mmcx_ao_w_cx_parent,
> -       [RPMHPD_MXC] =3D &mxc,
> -       [RPMHPD_MXC_AO] =3D &mxc_ao,
>         [RPMHPD_MX] =3D &mx,
>         [RPMHPD_MX_AO] =3D &mx_ao,
> +       [RPMHPD_MXC] =3D &mxc,
> +       [RPMHPD_MXC_AO] =3D &mxc_ao,
>         [RPMHPD_NSP0] =3D &nsp0,
>         [RPMHPD_NSP1] =3D &nsp1,
>  };
> --
> 2.53.0
>
