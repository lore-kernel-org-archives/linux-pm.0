Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C5441DEE5
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 12:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748782; cv=none; b=IiiXZDDC00hBvlt5iXi68WQnlBtEEsMcAqL8khdEGmuM/vdCkziw6ADxHpDoe9OOpzHjNk5a80j36CxjneYoL5bvB1z/xtr6jRcOFzniXw1Yx8fbNj6zF4+NLuuU4+Kmy+VCN1zMjKNVC7K7o2D3a+v4RHsdY74DaazDfna/vbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748782; c=relaxed/simple;
	bh=tEj0puOMv3YPQfmZXyOKbvkusA1zz5vSWcDN0Blq+7E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpXp2b5Vep5A2o+5qE83wPKK0XpkB/mw3KuyQ4GR6+Uj004VGFfxwsT54epK7WJsxjLRCxK95H9BYkSJV3Oi/aBSarWb9TGI8xa7bu3KXzv4CLXs/9xvZjth0/MxvVcAxHEA43CA1iZZB+a3itFWIb6eUE54b7CJaP/686UEI8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fqZ207VW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DSmQfIRc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fqZ207VW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DSmQfIRc"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCCHU4374872
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 12:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2gECbtLim4IsFDtHK0zBICZjbKaXqnyx0T0kMypovFw=; b=fqZ207VWMmusFk0m
	dp5WwvtBTNzgz+Bfh15kZyfnhSlNTXBBiM3G101KbvL8B5lP7nbDSdxjrthYcpq8
	vYLjPqDi87xrdpu95sSyVm2y1oB25YBG0Ru0F42MmnIEAqpIYv+DmuJjTxp4f7sT
	vv6pgIKgnppc5TqS8ISIhcGr3HvLoagNlHKs3fHpX6oD+JRtgbetvGjXddelJJJG
	4sG5VEZPqviEHWF8RvuDJ39seOUucTc2jLiAJAiy9S66AggLpCcXF3ytIhiPWIxV
	GE7Tz9Dft2aHw0nNbdsC+XUOp7VnagTYlDgZwQe92puF0oWcJQN+zjLZVo2KuFqJ
	lE5N5A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9smx9va9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 12:53:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e661ce1dcso20120585a.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 05:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787748779; x=1788353579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2gECbtLim4IsFDtHK0zBICZjbKaXqnyx0T0kMypovFw=;
        b=DSmQfIRcrXVbUGNitJbFtzxYcBn5SR1YG43+hpGrqA7Cy8dlwbCce5Gt/xFvjL3n8z
         iJ4+/pEqBkBuc3snAFB2wPatthPH0pdzNVEi6IIvlzQsq9vdlFB4epoOv7fNIsaQtgeN
         2wVfE4OV9E3v8agsbU9qLebqFTRG8zlRXL+ah0KRioda79sDkDugY5CO5fzWZBGPdsyt
         m6or8fLxhb6nd4rIBmQ2oEGcjxfmgzBq/KkeW9M7frABA3lgFMU6Lvcj9dtpNvhDIeIE
         Z0uWw+zh7ivXgNi9gvOoYcSFa9L3ZjzBcQ0ijL0GK45YCcBAOvCeoUJMOXTQn1rI462l
         9ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787748779; x=1788353579;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2gECbtLim4IsFDtHK0zBICZjbKaXqnyx0T0kMypovFw=;
        b=htusLA73zpNHQcz+sgvxd2QU2gnonJcvdrs9IPY/8dxWgU1VI3ZbTrFAJaEVK88Wow
         0grWQ91hrBqMUpRbR+UlutF75YwX9ZBcvUukGPN7LHyTcPGHrMmKJbBOxgiuxwEgvVj9
         q0YwOvXlPFR6eq/a5N7x15KkxOLohY+uiMwgRwRe/tYz9saVajskiOCjPTXlTWKqa/P6
         1CQTTR7BvDfkbDwb41cTdEZ/dmTAZJCUPQT0lwrppDIAwRJlB9UniV+WYJk4F2cjdz3V
         yufPLTvgsDASJ+G/ELQruHMqo2WivBjQzZeW+OeVl434uZ7rX6fvOgA3oXDdyeEtZfgF
         JkkA==
X-Forwarded-Encrypted: i=1; AHgh+RoL+sBlsGZigRzfPd247awYiNEGKp1LXk50W1Ic867C6IhAMVDaqouBxp1vjmeRFQf5DLyKkLyueg==@vger.kernel.org
X-Gm-Message-State: AFuF++kMikhQzMcmBn70nwUb1rcNmCFn7W9Kq2xcWEyxP5l9o+ZVgPJI
	Y/HJbTCTngX70e5WMfo/gtcRMDiQxnAmwJXuLSm2CHOWyN7lK32KF7b1xZSVbMf6chD7L5XrF9K
	g+mF9mYNvcfk8bRt6Qy5AZY/nsYuAxU2ZDr/3zJdYdlsqRWZHEuOJ5GpNlmL4WQ==
X-Gm-Gg: AR+sD134VwiR4k5GJiw9bN9n/flTW8z5BEydSLkNJFikhECPXI7tVIcXcUEgheDn/xz
	T4/wbiAaAA9ENnFs1LxMJHSCp0B+3CBsH+IlpXX5hj23ex0yk/H+1jkxb6LyUW4JAksHJRaejOD
	P5JmOAMKZkxoWzGwSXdAtfpdSBB4w1uN649kuknGfYcBDpVfFTVbnrBACQ8ZQseGiNM6Vrqi8GG
	2AN0L5kPM8nY+T/5nGe+UZJMHBg6f7k9iAFGI/+XOYV55fE5l+KwHhwSAE4WKZZGZ7R/nCkZBWm
	w6ixTDUO5Kk/u439LSt9XUyCaDi0/dgv3aJMSt9wy6XDmi5pSMN2heyobnxDngrZ1xeC8LEORjs
	SrrqcG/ByRQYQYyYHGNcA9Xvm
X-Received: by 2002:ac8:7f03:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52f9f774021mr205091cf.4.1787748779028;
        Wed, 26 Aug 2026 05:52:59 -0700 (PDT)
X-Received: by 2002:ac8:7f03:0:b0:528:3722:a372 with SMTP id d75a77b69052e-52f9f774021mr204581cf.4.1787748778493;
        Wed, 26 Aug 2026 05:52:58 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fd676sm501014066b.17.2026.08.26.05.52.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2026 05:52:57 -0700 (PDT)
Message-ID: <a986fdf1-4acf-44e9-8abd-46dc6928eb34@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 14:52:55 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] dt-bindings: remoteproc: qcom,nord-pas: Switch CDSPs
 to NMXC rail
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>, Ulf Hansson
 <ulfh@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski
 <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-4-shengchao.guo@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260826102746.633076-4-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=O/oJeh9W c=1 sm=1 tr=0 ts=6a8ee1ac cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=IZIQwfiFe1kYP54-uPYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: xWsWrvJtP0_J0hMREfvtNRUr-BCRUj5q
X-Proofpoint-ORIG-GUID: xWsWrvJtP0_J0hMREfvtNRUr-BCRUj5q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfXyvifWNeEAOEg
 ITMuhal3Z+g0SOjYbC92tsbVgCMtPtJWe92JLO6LnCGTZjb97fuq1j75zL7vtvJn+ACVB4o3qpA
 hnKm9wlRDEqYg7cQwDCT3xEKMEfLufbOpT/EPUeA2Q+IU/LkqmdeCOqeb4REnXZc5zlVR7zcoL+
 UO7rbEM6nUbxoWaCERlKtEMV9q8IP2AxpedfYt620ylSW4ktVzNY4P9j5ymy1kNeJPWgF+b2LH7
 PfFTbS+MNhKHfAmwFcOMCMvbyAIu1O6RnGXADkcjHHNSIcDoWU/WfmlNIHHd6gLEkSalSqqYW9D
 t3RaROK6LBWjifZq+LwKK9GsgPsnv42sinmUBXvKNbnH2ZXBkCG6ZZtk/p01k/VmfrXnBJIejLA
 61B+lYh8Y//WL2Tyc6SCp+xaJI+/2PM/lCGdRwoxjDoJLFin9ECVM0hXjSynAlYDHdIswEQxtXe
 gDgQvirYKN0d5zJCKxQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwNiBTYWx0ZWRfX4X5ovxaAPsow
 yDKeMqyq9/j3Mr7i2Ng/FL9cb00K6jxIptekwwjRPcCIN9KOYbVDlRQdo63BwMLEbwr4p77k8G+
 jeG4Zyj119kpYexV/IlOoi5EAW/s+yo=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260106

On 8/26/26 12:27 PM, Shawn Guo wrote:
> Nord supplies the CDSP memory rail from a dedicated NMXC RPMh resource
> instead of the shared MX rail, so the CDSPs have to reference "nmxc"
> rather than "mx" as their second proxy power domain.
> 
> That makes the ADSP and CDSP name lists diverge at the second entry, so a
> single top-level 'items' list can no longer describe both. Keep only the
> item count at the top level and move the per-domain descriptions into the
> respective branches of the existing conditional.
> 
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> ---

Is the name of the input not "mx" at the rproc anyway?

Konrad
