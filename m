Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90884AF69E
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487269; cv=pass; b=DeYkHv97Xsn1JfQz3u89a+stAQFnqQI83l39RqRZRrVz3/Pb/WDItBYrtP1LQDn4FTU/eaA+EVpG9RQH9rKZrdNz8l4vM9X7gBHH+4jMyfUxB4/6621VUw1wtEiCQXmYTTTH2Q29UlBQK5LXXUqrYi5LsJmIiBbkvY4I8spriJQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487269; c=relaxed/simple;
	bh=YU/40tz1OiGsBRVDJIrOosPM2xe9ZXCtd1OUPGAbvho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S9XIDMtZb2mendtc2RG+zujn/+Tfz9mcrzlgwGpJURZOVGZnWCw0rc5ZnDMW/HFfSQ2C55CG+rC0lqC7tuqM7zefoLwaRlBhi+9cVzHdPnTYGmG0bXhGhr7LVqIbZ+mup2Mr1BiuI1SQBfV0LG1AQP7BfNUMQAiWFUgocHYTQG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UuqQLGPi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QTYIT+V4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UuqQLGPi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QTYIT+V4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FFAgVo3419511
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 15:47:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YU/40tz1OiGsBRVDJIrOosPM2xe9ZXCtd1OUPGAbvho=; b=UuqQLGPi6RwKHBON
	dYUZOaX4xL7lhyYzbVQ+38hF8V4hkwKxj8i7ct7SGEuUwtQU8gbbB7g9UFQVcLTE
	Z9tY0fUXyRB7+fOWh3KJB+Ub7YhF1wNtr/PxkTmL+gOSSfOhlQ1TGNi6kDBtrTLo
	nqVKJxSpdNQxR3kQeBsSI3SrMYadaIQZiHpHEef7O3mbT5/yg0+C10wCcyQI4OsR
	5xBRxrFWQM8PNaAiEYgHiH4SyqdbGaFk7TgmFuQsfCL+PM5W4F+TPiUecdTlpnqk
	aYHpmIhDlByW5YvtXqGMWxAi66Fx8ma19WynfSsXmu1lFrZ6NfK/fwG7Qv5uePuK
	ZCXEcQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpye72sxh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 15:47:44 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d9057fab9eso72825735ad.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 08:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789487264; cv=none;
        d=google.com; s=arc-20260327;
        b=mgva0Uy6v7FBsgYkRIonfw9lSjDH7yFgvjhUW7Cy3YW3qYThGNApXOUdmExQr1cU31
         bXWqKCggFK4y4y0+6BM2pAAjY16oq8D8qTFY7OVZDks3IeX8x4TI7MQ99LvRMm9VpZ7d
         M3FimvAXYB4YzX7/T9jg1o7fWHbCP8sRFvk1Ph7wdDoNy3ctTpW0LRqE5MDo6B+5szZk
         suGe6SGFhRIvfra72GLKvGyOiG5eysruqN+c4ysm3wV1ft2z499xv9D+3IDG3cA3DO3h
         C/0nZntssTlkiMeJbeZrD7DQ1Vk4jhttmWFXrFjfDDAA/hJPPa2C2+EgWoMgrEDhte61
         MdkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YU/40tz1OiGsBRVDJIrOosPM2xe9ZXCtd1OUPGAbvho=;
        fh=lbvhtu+3V+2T5Uoq3tDwCTgMNH9gC2n07WW1Ei3yEWg=;
        b=GSq8zdNdtkCm+/HRIRmmp8BB7H5Md+vJaDBcLJCjf0T64TjZesEGL+bu5RmNvBLUi1
         a2KFy/cAx3Ax49nT3SlR3iv0k+VTZPLxNR3HhrPcKyhiCrLBep/NsAo/znPVI5nZPfII
         KCGHMtiqYcFLl2A3nlBScbpW8iZRTucOYfizFzH8fepMnYJHvWEn7hl2/n0CL5BlmQ3C
         HFFIgziLYOZZgrpSX8wrJiP7NryxQzuAytm7RuOcAh7HaVfOM7eLRk9GLm0y71hxPvoC
         xE/4jVLmh2PCYtzxpKjh2isWEeXdrHfaxfrETAPdebfRFDkQSCgk/j/z6/8JsbYqhieK
         Ffaw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789487264; x=1790092064; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YU/40tz1OiGsBRVDJIrOosPM2xe9ZXCtd1OUPGAbvho=;
        b=QTYIT+V4b1JJmM1rb5rRx3slHx6vq5Ny/OUSyu8xEKqOdZF7ZNKyDTjrTRL0kMNoO0
         gjey4rE6Er2pYwr21yzosbwrmje0AL2Gy94xbtJVvtiRYy9aMIdInFKOIU/dsNj4KRD4
         sBRtUFaWFSdFuR5ig4G4HXy2iGfvOIi4UvPYw6vctDPsfAaMiEO0nnTK09Mi8W/G/QIQ
         r3Sh3dR0M7DdZgG5/LRWyQkN9V7VGDBFFPWoXX6pbIP9BJV5RbeUoD8kL8zKgMQ1rTlr
         3vjquA4e2vBpkJ2hEvspY0PY8JB5/tMTIUoM/qfkFexp6ILHnJy+KbGqhrs1wMjiLrC9
         RmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487264; x=1790092064;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YU/40tz1OiGsBRVDJIrOosPM2xe9ZXCtd1OUPGAbvho=;
        b=YMSu3Ll+OSj+aCiRhnbxDvDgS3F9pzU1LrTSBeLzLuRO9mB/saIEsjRWqP4zg9mlK2
         npvULcf8aXcnh1Y93J2j+9xOjrJRnUKZB86RnLMPVJ5Dw6C+AR63G31PNK8GQew4IiDN
         cwvHryDOXFY0Z+BV3rM2TEwUx4kxKJ7i/jhNv9YQ7WiwV9VdGgNN4wSl6xhAgEyehstC
         uzh7pE3YMYZuuz919dsARFS7jSjC5CyoB2tWQv97g6pa8+RrsKoV3ITb3fipxLEOXQAr
         yCcve4yyOjpbO3rA2eiwEuiwBs3QgcOGjaqgcg/TxGgFQubqmTx5JhY9Yh+GcnTJinnE
         yR5A==
X-Forwarded-Encrypted: i=1; AKwUvBx8sGyP49YTRTLRPZ/mxQwMG8G8wJhINw/8j/cxbdEOZ92lj3WB0PllUtOCxom0zliCIY6L4uVzjQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lKsoNoqZLxDimX8Th9I31kJxS+HOot4HV3+uGFkLgZ6oZ2XM3a
	f/chcfobImYgIfvSKPsczrUh/qvZEridPnWi2h+N/InnQs4tOlkYQOTEZO94Ez/yWYFdXEQ6MwH
	mcjHryOpphYhLXW3xxM634uXQI++HaITgF5MAYkXoB/WtIVU+yXHGKCJntwGxtXzCISJIrzJ/Mw
	7EbTHYFa7+zS1MaHhiXHRMYulLyf1Dm6JZ3N9v
X-Gm-Gg: AYBFou13vC0w7xC3sP+FwvJF5kga0Pzh6jDKyhN/pt7VonMCaydS+ndOGo8rxu/FgwQ
	rDsAT+7eKPH5ZiocADFpVlFtGdZLIz3EkHWd5xdO0z0+svTJmGR69jKOrLd8pjRhGr+aaM1fLBM
	gMHJ9IwldYQuTvz+QOEgQUm715SzV+KJ0X6EbOiyU9gWBZd48ZJyVwS9Lw0A==
X-Received: by 2002:a17:903:3c4b:b0:2d9:b60d:7755 with SMTP id d9443c01a7336-2dd837b0f4dmr30164905ad.1.1789487263782;
        Tue, 15 Sep 2026 08:47:43 -0700 (PDT)
X-Received: by 2002:a17:903:3c4b:b0:2d9:b60d:7755 with SMTP id
 d9443c01a7336-2dd837b0f4dmr30164475ad.1.1789487263399; Tue, 15 Sep 2026
 08:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914-a9-pwr-eth-v1-1-752005131135@amlogic.com> <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
In-Reply-To: <CAFBinCCgvMbM5zf8OXFhjNRWjDMTjAVPu_BBJf1GRKp7JPqk=A@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 17:47:32 +0200
X-Gm-Features: AcwNN1XLltJ2FYh8c04_i-F6ztWC1xrsL6gII51QJfaGjk0kyDplWQBNgu8CYL0
Message-ID: <CAPx+jO-Fh7RDmHz-YH=odsHxmqYaj=vj4R9iUSSmbSqcRr-p6Q@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: amlogic: Keep Amlogic A9 ETH domain always on
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: xianwei.zhao@amlogic.com, Ulf Hansson <ulfh@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Qingpeng Yang <qingpeng.yang@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfXyi/DV0uoEtFy
 ifi6V4jMzw/pmxKGtAyYB8w0zNZB+j9RByk9ex4W461YwpYEpI/ksLIpf2X9yN7cplqu7p8uvVC
 tIP9i8uNtCmXksNHtK/LIT5rCp1FmwdAbFT2t+wt95q8JkevW+L3fN5Cx2CBR63ZJmhjMZgUs4U
 HfYQM4VvCEmC8/E1nKXQO/VSWA+OMnzawooYHo0NxBZh/RPddaNq2QZbwymqc8ZTAAvlko50xEZ
 Ke9/gbeO9eiXujZP+Wxx7BCvoYxK/YKBsjh6ita0H+Gbr9ORoLoCLXkyfVe7+raLjJySOSjKUHN
 bldaST3HgyqgP2HJER8l4vxpFRVDkoD8ZUj9MGGfKjZODfC/zg5q18pHglS/vI5Nk+vNHp9rNQk
 g+luGkfkdc3CO6Hh/VgF7bL4UMh8vZ3njvYjV0CRy1NrQXCsG0cxcqAwUrAeWqA3UFE/zrVXT44
 EauKqoEi5EHSpIFj55A==
X-Proofpoint-GUID: u95RtaTjlePNaMfQMez3fRdO94c1pBwO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDIzMCBTYWx0ZWRfXw39isDUhcrek
 XYaicauRVDWaQxzs4QxrnPnYsnf7j91WkkMj/EpP58ifxCyuf6pO0MRl02dkefML9dC8DA4ex/E
 Oy5xrgjblEIrD271uKCNLLBnX9tg4jE=
X-Authority-Analysis: v=2.4 cv=fck4WEQF c=1 sm=1 tr=0 ts=6aa968a0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=mK_AVkanAAAA:8 a=VwQbUJbxAAAA:8 a=BY5PBP3jAAAA:8
 a=PMt6m80IFYFBIeLpiBcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=3gWm3jAn84ENXaBijsEo:22 a=gQW0MTutLl7eKD3OLfcZ:22
X-Proofpoint-ORIG-GUID: u95RtaTjlePNaMfQMez3fRdO94c1pBwO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_04,2026-09-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150230

On Mon, Sep 14, 2026 at 12:40=E2=80=AFPM Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> On Mon, Sep 14, 2026 at 10:56=E2=80=AFAM Xianwei Zhao via B4 Relay
> <devnull+xianwei.zhao.amlogic.com@kernel.org> wrote:
> >
> > From: Qingpeng Yang <qingpeng.yang@amlogic.com>
> >
> > Mark the A9 ethernet power domain as always-on since it is required
> > for ethernet online wakeup and must not be powered down.
> Is "online wakeup" a wake up from suspend?
> If so: is the Ethernet controller listed with the "wakeup-source" flag
> in .dts{,i}?
> I'm wondering if the pmdomain and/or power (wakeup) frameworks in
> Linux have other ways of managing this case (e.g. only keeping the
> power domain active if needed).

We certainly do.

For in-band wakeup we have GENPD_FLAG_ACTIVE_WAKEUP. If this is set
for the genpd in question and the device being suspended is configured
for system wakeup (device_awake_path() returns true), the genpd will
remain powered on during system suspend, see genpd_finish_suspend().

In genpd_finish_suspend() we also support out-band wakeups via
checking device_out_band_wakeup(). Although, I guess that's not the
case here.

Kind regards
Uffe
