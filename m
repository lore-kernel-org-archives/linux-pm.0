Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74263C4B68
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988604; cv=none; b=lB+ddSYzyjP7/tiqUNGaJh21/l4wDeZhePsuW2dnoAKB7T60Ac3teNHtHL9FfnVUTnUpZyf7vWak15NmIwmhpS4sF6+gXYfMNXv2Q3A29jtZsT3WgYiDVSRhurFNwkVDr2N+wtWtKb33Wznf2wr+JhLvWCkeAzylwwsBJckujjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988604; c=relaxed/simple;
	bh=vcKFUlMHhzb4aWhwKFgdD+usZHVbdciqtOJ1LMttT9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAkJ4hbS0zTFVdOyPDMLx3t1SOTBQKLdvxYEjoijJa222fSMTMrojiZMkt9r1hvsj/YIu24v1tTm8AOMQKdIipTLWkewdhDkgCZ/X3gKKw/OkDiNehG09W1YxHiAFsyG7fQuq2YvtJVsvPg2+BZ4HCg8cag6wMaE0PU/EnONyKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MGrn/8JY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NgEv+Ipa; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MGrn/8JY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NgEv+Ipa"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAJnQY806685
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IB/8dXjwtfDGBb987xwDsU6P3iiH/jaR6oo/R8A+4R8=; b=MGrn/8JY+3+qM2Gp
	T6czweznP6UkfQEiIZ2PHZWPsTiKPScMY/h53E2AuZVqUsuJOGuqwfL1bMO+1pP9
	YFzowEAcrVf1+p8KfYLhe41CFdR6Ff2wM3daFNRx6dEIQEYDLpqsmQm3eEF5V/lX
	8R3GwYVoe3AopBWl3i7U8DlBhRHL4zPjiwdzwG4J9MC11QmFFFi6hmKBoujoMaBL
	idQcLCjzHKVmHErLw46/7mLBWXvurW0puBpr2S85j0ot7F3ZFONo5wJBx8pHUMlB
	ymTWbND1uofE73G4gm4Unk5Lmy4eWD/oh9XZQz2xFOwLWFhw48VfElZMVGukx6XI
	rUSbaw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9ud6bxx6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:36:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93edac58b24so53896885a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791988601; x=1792593401; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IB/8dXjwtfDGBb987xwDsU6P3iiH/jaR6oo/R8A+4R8=;
        b=NgEv+IpasRED2O6Gu/wto8IJGjaCDmHLpKaHIWjJYIt1Uwx4MYkR1QETqb5RjP4rVL
         zJINPf9CNU3nMF/BCA8enR1V4NMHu8T5z3AgxcyPLXW/lvb4GC+iO8D+g7KlRKn3FnI5
         gNbA6B7yssaMo32xZDWpTVRcqdMCW/x3LEivmWVFsfhhTUmwvy0TjJ/OR6BrsWhz0ZmH
         BJmXwNzFCB3J7Pmz9U4atanD7S4/jLCfD4gn2kP7f35sn6nCC7I4r5rPSpRdUxqo8ysj
         VzURZlpVZf4Fq4w81tN8bh6BGA5+yEjlxPWfvOCWf46o8bYxAGJCN3bhj5mEebf2D4G9
         GHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988601; x=1792593401;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IB/8dXjwtfDGBb987xwDsU6P3iiH/jaR6oo/R8A+4R8=;
        b=hc6C9p0ht+zjbEUHDeEFS1N5K5ZqMU5FUiYtn+yNRJHEAD31auxHI4y7nczhRQEu/h
         aYNriKKsOHUlfGEfVOCXqTEBSs+t30fmphsyU5ViyOEfIK6eIQzkWHun0n4dthcjSuQz
         PSZzxGKj61aT5eD+tFMT+SBfxb5gcixTJiU/i9V10CQGYGwkdXJnKSlpgAFWDcZsThsn
         XfDAQxvdzKla2mHxu4S0OUwWEas288XnYZRmnGIELsVvTr9/xcC4Q1KtAkU8CTJKL71y
         n8RaHqeQuWOjOdOPOvQ9Sef2ZfTJSKvLLr1FkArqAUXhCTo0FpkWWvFmiAPzWC0BTqrZ
         7YQw==
X-Forwarded-Encrypted: i=1; AKwUvBwm6Hz4ybgRAAIz45pq+QX/eYQYDyprVkcGnvAAzVBkZtRnG56yuptXI7Z8b2/srzUmhezXI9Okpg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIGf7kdZiivglmf9cSaSkcFNBH/xWZO/HjMjg0oKgkWvg41GGZ7
	SNT0mUGMk9ZGqHGC6xdspb2X6Ot0FPNiXkTlDaZBXXKsjQh0bQARsIeDAFVAfmmx/Q1J0vI6vtS
	9Jma0/6Tw7fb24CfyQ3VbxXUxxDZBHQSirDyJspAwXYW1VWgbLH2QUOLbK7/DLg==
X-Gm-Gg: AYBFou2hzrfDMf/IfVbdkJcuH6LhXDMz/yKsQ15YM1FNYS3EkFofqO4U3VA42Md8il5
	YaVv52iVJ6Z404oJthtb7Q/W6jz+jn8DqhoM+GrN8Dtc9Cwnc2+YGmVVtjAFsDgIFILKAfSJ4/R
	YUeysIKSdGP5GiKQ0nCcW1uEuzMMDBPF6ivfUPpErCi+WHDxhGvpfqZNUESQ+UklgGKW41MADRf
	VzJxQttrbpZsHbabqdEbpUp0p2z5KtmxoN50ZZ76kS4S0gy6ikONfbO9TGsrgxP6dUldaFv70Hl
	mikxq5t0eW2hqYfHyDxpEv1kb59TsDFRRS4VEaEvXNFENFYX+sQ2NpHsLK31IS3x7Oyd0ESUA2n
	Q9pWkKqmWYFviKrs/J6McGA==
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1793496985a.2.1791988600686;
        Wed, 14 Oct 2026 07:36:40 -0700 (PDT)
X-Received: by 2002:a05:620a:6498:b0:93e:e111:2771 with SMTP id af79cd13be357-93ee1112d0cmr1793490485a.2.1791988600134;
        Wed, 14 Oct 2026 07:36:40 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c34feaf06e3sm361049766b.33.2026.10.14.07.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:36:38 -0700 (PDT)
Message-ID: <a8bdf3fc-7da9-4017-b61a-5b4f605ae0a4@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:36:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 11/16] clk: qcom: gdsc: Make GDSC parenting optional
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
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
 <d82177b4-8e93-4818-bd4d-b4f696396373@oss.qualcomm.com>
 <543k7ybncixqqdzyxhb3mnal4k5ethrsmutrho5yo4vcgxiddt@a5hisvaogznj>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <543k7ybncixqqdzyxhb3mnal4k5ethrsmutrho5yo4vcgxiddt@a5hisvaogznj>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: S9wghKpmOPsI0NpKNo4_Isn3fMpiHfhD
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX8vxBbtTzEOVG
 AIHsCoh1FRRnpclxt8rpKsMpFEY83sE1c9p/0xKHMrCLBZWZA9tFVvSPS7bi2CKl5fRyLGG4RaK
 Hc44K4UbVa2qfLObXlXNYAjmJOkF+vk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NyBTYWx0ZWRfX9NUR+CCvqBP5
 sPSGQogN+IluyVgOqAnnWY/yyOOHuxqY/jhjC6NFrttxDmqFGjICQW73Wso/kBvToEo5w0ihejB
 Ekv6sK3cYwrb416tK06mKl69juTzRdMvfB5AS4hmOAGk62ZIl+HA0dvn+1RT+gjp2KLDe/uYei0
 eC4H3AXV1JkNx2QXfYwk3rjv/aoYRsgGIl0VY76wWlxoDU8N75h1Czi4/5oCsifISMW3NZHYITp
 EWkmrC3DiMuf6aFycEtWYrdeuO9kiH+QXGBNKYCvsbnkKQxrQSfLNuasJ3fUkJAi1c8Hy5ES3Fg
 R1sbeKLBGN7Tuotp5vwUH9JYbQQPWi7DSQt7tmBMn2Xu8wYxQkcOUiSQEOLJ+DrlLpEoh9M8iL5
 8v/bw5/43f6XxlrVI4/dMONyuQ2qJxlOHejsEFTbIB3u7wJSwMmwV39UMbM+TDm9yhJDvdxcO6p
 Hdgv3AZlKP2g17stctg==
X-Authority-Analysis: v=2.4 cv=fJ6sTpae c=1 sm=1 tr=0 ts=6acf9379 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=JPrUV6RX21cUErznEBYA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: S9wghKpmOPsI0NpKNo4_Isn3fMpiHfhD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0 bulkscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140057

On 10/14/26 4:34 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 14, 2026 at 04:20:54PM +0200, Konrad Dybcio wrote:
>> On 10/14/26 4:17 PM, Dmitry Baryshkov wrote:
>>> On Wed, Oct 14, 2026 at 02:19:11PM +0200, Konrad Dybcio wrote:
>>>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>>>
>>>> Clock controller power-domain attachments currently become parents of all
>>>> top-level GDSCs exported by that controller. This conflates resources
>>>> needed to access or operate the controller with actual power-collapse
>>>> hierarchy.
>>>>
>>>> Allow callers of gdsc_register() to suppress parents inferred from the
>>>> controller device and its attached domain list.
>>>
>>> I think, each GDSC has a parent (in the hardware). If we don't represent
>>> it in practice, we likely need to fix that.
>>
>> The next patch allows setting a precise set of parents instead. Perhaps
>> this commit message could be improved.
> 
> Or the commits needs to be squashed / reverted. I really don't think
> that we should have a parent-less GDSC.

FWIW this commit alone is a NOP.

Konrad
