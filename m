Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7AE549392
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791987663; cv=none; b=u2nOowhlSj/drKtQxl+sJhJM8bz84p5JQOivyyarQKs4d0rysxNkipLrmYNLp+8+042bXPb4quvaSdsodJ/TwznZDbsQIueHTxoc1YTFFH3eoRF1Fchxz1Rr5zGfdZHV3sHRF9BCyqugn7JDW5cuV6pCuCo1cifi3RUouxhN/jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791987663; c=relaxed/simple;
	bh=XGNrFoZ7MV8C7/dY+VSILAwCYiTvCmyJQJRuuRE54UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o+gVMwEVENlBm5FuFeP69MFIDfHrS2w68Wmu749U547IFWsC1NxMcN75GJEem4V8IOYwebPzOhX/lZAxqROOZP8P/pgjmlUNChmghr4obPTYJwcPTj3uhLPT/hBkNih4mH0EXKIiTpHYD7H/Ob6dTtnfJZfUY2V2KBQkANjCg1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XQsQ3V2+; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hCsYsYns; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XQsQ3V2+";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hCsYsYns"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EB978i3365335
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:21:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	guDtRT+BFrNgrMr9QvoZtjIgkyZewpK+lc9ir5W7b48=; b=XQsQ3V2+7aeVELol
	Ty82a8+AuF1t9jlkHQFWPGqV0R1T/GK+hcYNI/jB/xE2U98nVKQjh5LTXxgH9Z/p
	vXORGa0AWtbQzyGpze8vXqeSkm/EQSTQUBEDHb4PIce784LMrvhQQisXC/+VrQg1
	uqEXXg1kM64HJJ0Vb6vywpDypIJZ+5ofYbMUUCa6vkaVMV+zhIRGXm+OyNQMYJmA
	tdBDVH3qrmhCc5rDyyGwV2XdSDQ5DWw1QXD1+5F3vt9ggiq/cVRAAQ17B2qEVMLj
	3RbBcP91MMTjRXH7h8bYm0/ezdrYQmBFfkFgDhiK2OgCf5/fzf4oytw483Dyw4iM
	FYpRpg==
Received: from mail-vk1-f200.google.com (mail-vk1-f200.google.com [209.85.221.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha4622055-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:21:01 +0000 (GMT)
Received: by mail-vk1-f200.google.com with SMTP id 71dfb90a1353d-5e705718bebso136825e0c.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791987660; x=1792592460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=guDtRT+BFrNgrMr9QvoZtjIgkyZewpK+lc9ir5W7b48=;
        b=hCsYsYns9JjdldGvVgZdsiZ/Ap5OQD/8g3yztfGHtisUHqhoYTSDeVBR0CjrpxsBcD
         FFLe5spTCOecLGum9Irb+2Ujvyfm4izc1/jq0+dlFw5yp+ODXdIC1qV9g6aASoxFKdnh
         ZAcUaqEOnLhajrikc+0CMi4kmSb1tkv+kOXSGLiPNJT4YXcgoZhft6pnU+dwH6dHhs2A
         /0BbonRX3LvZZtlpCH4XX7X1K4DGxptj05XHRNNlL3AFoCI5o/xW8uZdAEnLDe+6LvCt
         fnQq2989W9hfpTIXc75UBVRK13WLKvzY0bskNLENjHndrzqTP7nFjf4D1iLwU3Fcj2K2
         34Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791987660; x=1792592460;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=guDtRT+BFrNgrMr9QvoZtjIgkyZewpK+lc9ir5W7b48=;
        b=Bhbm+WRWy3FdJjqbmil1sd5XvCLXBS4e5hJbHvQtaVL5rSvW6D/L9tY6Md4gCJukVI
         rSyzUymDqvJsutZRe9vxShSCmwBOKJn6hsa2uxY3NEFkcWlAIIz9eieXIu+GHHT1/I0t
         zh26U2DYrUR+KdJwKlmMSnU8XD6ZCxuui1uRxKMJqBBy+oOA6rXFLrcYiPSwePDnkRVg
         oyu7nLqFDJExmFdt4+1JqvTgEoWnJcEe2w+e4CrKHLU6dWf/DnqNAmGg+C+dwRl2tCA8
         fSYlr3nwZB4iwdXBfvcYpMnmtL36DmmmT73gFVmDy/4lSQLzCCGcb7lWCp4sSk3JEW+r
         +odg==
X-Forwarded-Encrypted: i=1; AKwUvBxWNb4qCu3tw0d7N3E8pa4Z7wCxym8Qy67rz14UpTLJdUtkFUxM5DTHCHEyxbLj1CmDbIBYA6u+ww==@vger.kernel.org
X-Gm-Message-State: AFq9FYKcXdWYMB+fmKjr9K7ISRPfwwRRexvjbe1/b07c9YaC34VrJ6QN
	pYI0zXR4bPgx/yJD5acYkL4brisr/m0GCcJxef/rhSB4VlnsN73gvEK5c7qMXILIiBb5Jq04pRg
	WyzkgcBFLT6HNJL5DNHnBsv94K7rykAuwaACFsUQlnKlqSwNURYJUYx8+qf68tQ==
X-Gm-Gg: AYBFou0XUpqhKOeYoj+2h/U//GJwWcnHZXvz6axhhVAS5m5qS1cfFwCtpg9zR9dbvtD
	wTjt6JSG9eUIpPugjmwTv+42xhPs8keQoH/d1e49l6WjDbCq0IFh2zZINq2yWN0rPCQvWDTSQIe
	2TuSeX4oOwdXqhraaOk0XWznCjspAredeF16+IL2scd9TYGlXzb0g2zskKkDSi4v7nkFyDNenQu
	q0Ul7dcDV95NiV5IpGr9XWtQch+0nipzmaqnzjnL497JteZWUEuM/E1URBhJjGXLmj7tE/nGF9l
	r+a0fRAL+ysrueCDDqJLr/uSP2T1qeMv2TUJAH3NFCVPd2LCMpu9ENSUbUf316FCe2jtLD+aBcl
	J1YkTxXny5conBGEdc/QzCQ==
X-Received: by 2002:a05:6122:4a0f:20b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5e91f49ed42mr3157597e0c.3.1791987660448;
        Wed, 14 Oct 2026 07:21:00 -0700 (PDT)
X-Received: by 2002:a05:6122:4a0f:20b0:5ce:bde0:9b53 with SMTP id 71dfb90a1353d-5e91f49ed42mr3157584e0c.3.1791987659925;
        Wed, 14 Oct 2026 07:20:59 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20388ad72sm1182036a12.24.2026.10.14.07.20.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:20:57 -0700 (PDT)
Message-ID: <d82177b4-8e93-4818-bd4d-b4f696396373@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:20:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/16] clk: qcom: gdsc: Make GDSC parenting optional
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@kernel.org>, Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Mike Tipton <mike.tipton@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261014-topic-qc_clk_dvfs-v1-0-3041b788e9f7@oss.qualcomm.com>
 <20261014-topic-qc_clk_dvfs-v1-11-3041b788e9f7@oss.qualcomm.com>
 <lx5jywz6pnwfcoczp4z6k55qeol3ruqkyfsutngmg6n3xqnynq@6jgoutrnav2f>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <lx5jywz6pnwfcoczp4z6k55qeol3ruqkyfsutngmg6n3xqnynq@6jgoutrnav2f>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 3jcC2-9348aw9hCOOlU93klmPzJWAEna
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX3ewjEk1WJMiz
 UxD4zffuMD57fzaiVWYOQ7Sfz0AHesf4AmctX0qaIJMOKppa2Jrbv0UBdWuNKnZ/W6LzqiXm4pW
 8eOMwWnwgnUC5033YWGeY1mLDRlplA7PPXWLZWDfVycr/o/PKp3RT9npYiMOPSjdtJNk1NarX8h
 1XRFRHJUqz299RRaENweU7eokPyZNDC3TZM4Lp4hit7L5Nk6ZUeuzghw+UnfHsYvVtw7Cf2W95/
 sFF7+Ncm2Ni8wV4Pv+KbT+z+7rg0lxzbpzD1yPSfGzgLjz4S4hv3HtpaYGEzLZzcP2KNelzmK2c
 3xjlFFpjjnGoN+eNfLVJ8JIsqd7KvQrFNwNgArUfaSFVscTV9DilXRH8gFoiHCFNUs+BKgpOS6C
 WMyWeqMDS+k1cY9oFBqiLS0CXzJLnDYRnkwXUHBt9dki9LO0vaaog2wX1esnvKeClqjitd2K44h
 74WMbUAph0jWgcHedkg==
X-Authority-Analysis: v=2.4 cv=ErZHPicA c=1 sm=1 tr=0 ts=6acf8fcd cx=c_pps
 a=wuOIiItHwq1biOnFUQQHKA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=NbljYO6N7a6c2dGYBmcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=XD7yVLdPMpWraOa8Un9W:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX2IFc2S6nBzn5
 TqmTMHt35qOJEb1rzXeYxiC80zIHlfpXraK/6ys2ezM0DryO/Kc3JBj1yikVn8ZKVw8N9mNIEU9
 tbDq1Jq/1eoTnEftItH91Ogx7HouYa4=
X-Proofpoint-GUID: 3jcC2-9348aw9hCOOlU93klmPzJWAEna
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 suspectscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140057

On 10/14/26 4:17 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 14, 2026 at 02:19:11PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Clock controller power-domain attachments currently become parents of all
>> top-level GDSCs exported by that controller. This conflates resources
>> needed to access or operate the controller with actual power-collapse
>> hierarchy.
>>
>> Allow callers of gdsc_register() to suppress parents inferred from the
>> controller device and its attached domain list.
> 
> I think, each GDSC has a parent (in the hardware). If we don't represent
> it in practice, we likely need to fix that.

The next patch allows setting a precise set of parents instead. Perhaps
this commit message could be improved.

Konrad
