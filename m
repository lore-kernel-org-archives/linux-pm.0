Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DD654B1BA
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791991570; cv=none; b=tz6MflEUkugFa+5Hlb8g4OR6R1rPKa0fyxJOFEd1IlxjsvC4/c4Gp1MDZ7TqOJfxkpDuhjSXP2nilr5wWozs0JyNhg5wH0r3aLrO/8Kn9y6zQ7IrttQpblsqDIhVqIHczUhMBXJpk0bkzEo/pBE6BOh8e8GrQsBE5ciurDgP4Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791991570; c=relaxed/simple;
	bh=MgNox4Md7ZzWyjo6WySC3eO5hUras1nROqxjZW1sgXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ym7wA0xTxx3pJHCYu/gCA/T/h91Tp0orsiSDqhmnzkxCYLwn0ZxXOaISElAABfEl9GCJHzbgpOsMj/0Fi1Gs9DlW5qo1yCbgufQGwxc2sQfaFy77wCr+4HPh1drM1747rcNacs/2mFXd25fPhc1ww3jf4dQ6lCM07FQiInvSpQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mv+lG2Xn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kgM+n7EK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mv+lG2Xn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kgM+n7EK"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EFMm2a1682677
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:26:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NsI9BnJ1GJjPhVfcszodjRSmPz6tQ6Lvgi/KHCWFPcQ=; b=Mv+lG2Xn0yvc7mVg
	WjDJCKrCrk9uZ0cB7HC72HGG5aoyl+qfKpM3gsd8wQmpwbBioydx2u2Nnn0hBnmR
	S3zmtoD6Q6s1sTICoSXo5M4PY/4hT2z3OrZWGt8uT6vmLb0akIUFQ3m/uPOsw3xE
	WQYFJpMBHuL33FkWpiIvGi25FCN73iSMcbTw7Qwb/YBLFgFRo4x0lijAF9Ea0JwC
	MFsinWuCDrWcLSBmRoT63Wf7hidJzsKZe74UwPUnwUWcNfNWPM2/Vc1A+XEgCglA
	aLZMRJO956+v+tbx4TS4clcizd3ItlkEzPjqPNn64Edvvu03jWOKgsk5pXZhaVXW
	dW4qeA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hacb000ev-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 15:26:08 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5de7ad7cdbfso153668e0c.1
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 08:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791991567; x=1792596367; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NsI9BnJ1GJjPhVfcszodjRSmPz6tQ6Lvgi/KHCWFPcQ=;
        b=kgM+n7EKgFf50zQb1+OL6yxHLgF5FJ7YuRKglacOURShhPN1+TvylAoL+wt7gZ7Xwc
         qm+72wZ66peucYwXE4FbO6Hg5dzADOx5Wy6mkl/ELxs0uoS7ygIePvJgYQVQGpJxYhOJ
         0K0RU85NCE07ulraYL6h+6nVzuSJYMCWp67nq4/nSqz6/eMNvJYh6r1Pn/K6fAmVF3hQ
         4YYepst4dFiOJDjH0hHwCpcH9hiFvD6uZlK8hGQNNhQHuTj+iTZteFuJNC6U1Py8Yjod
         Ab1tmX4acv/NlHSo3Kh98Ph15oAT53aj+8wcltzxrOiIN3g+nEliwCenqn3VvT2xLDQV
         wx1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791991567; x=1792596367;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsI9BnJ1GJjPhVfcszodjRSmPz6tQ6Lvgi/KHCWFPcQ=;
        b=M7x7eYCtQoRBIu0/CoVmt+m/qaC+0J3WsHczcTuYINCB7TjjHURKu1y4TLZrrZPIgv
         UGk63vbd8CB9ok2FQjfOo9Ebq8LMOe2JkI3xDlcpFtRelWBQqm3FyXdjxOI2yIAj6+jb
         0n5YvN72HhiG9EyR+Hixtk0fYUAQvbEr5hhG4NTTG8SaQgAuR9wFIqwDJKYmnxiNqdZg
         jlERJgb3+tA4fD4HYYj8nC5LHy19eV+0ZxKAcJVDrlyfoPQPyH+Zbv04Il+QE7YJ1F0Z
         kbtYZkJK338FTpHE3Z699JA/a/27AAcftQ+D8NSGX6IDorY36bwX6jFFMQgGQePnbhBm
         YyNw==
X-Forwarded-Encrypted: i=1; AKwUvByVyPZS3U+agJalilpCgHdq4kKBB2jm0ULmK7VKyo1w0pA2M1hk2STAPzprbTgZQ1F/Aa50Cc0KdA==@vger.kernel.org
X-Gm-Message-State: AFq9FYKpugzeQzCLy7MJen06ZqgatwXXiuu5QOdLZxHfI+9kuBGipPWT
	IFYttc4PLLseAj8UYP1pId50gODu1Sn0ZVzDjqDwTP++qCJELj7ux12zRDP6yHFyK1vpnBmB/uR
	iysyuu2Ecie6u1CK94PoFBpyVahq5ZdIJso/YuJ8ob7iyI7nUqz7fZm7idqN3vQ==
X-Gm-Gg: AYBFou3r8oJRCGMzZ05WvTkDtq2TcUcSpQXdyjowTOActhr6z53j4aCpPOQxXbuzD/A
	38woT3xrkOCWA4AF+dybWtgv+MvKY9RPXcFyCh50JBcmUG1+hLx+LGwkQwZdTHJjz3HDnKjbySE
	ABHemwcnKH2BB5rdOc7jIRUa/yLrKeZe5nlXgDIJKED/MtnJbGmitFybV68df2i1ST3fgj2XC27
	MajTnGLtkSSeaporQC9+sdSfhSpkqo8Jcqp2eHZMzxKizSK94OZcZoDHGLBUM5ldiXcXldWxJe8
	G+w/lkqaqjgyyoyGeqeEUJy57XfFVhZFzdKH2EV0indzpWIZMtHLQF/penIFibHZ91j5LdFhV22
	nm+9pkzZM+rfK2yQz9355kA==
X-Received: by 2002:a05:6122:6857:10b0:5e9:6763:368a with SMTP id 71dfb90a1353d-5e9676339a6mr1252115e0c.2.1791991567189;
        Wed, 14 Oct 2026 08:26:07 -0700 (PDT)
X-Received: by 2002:a05:6122:6857:10b0:5e9:6763:368a with SMTP id 71dfb90a1353d-5e9676339a6mr1252091e0c.2.1791991566556;
        Wed, 14 Oct 2026 08:26:06 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b20383a22dsm1272817a12.6.2026.10.14.08.26.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 08:26:04 -0700 (PDT)
Message-ID: <6c9937a6-88c3-4e5f-85a3-73d929d3ba01@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 17:26:00 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 07/16] clk: qcom: Add clock-owned GenPD DVFS
 aggregation
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
 <20261014-topic-qc_clk_dvfs-v1-7-3041b788e9f7@oss.qualcomm.com>
 <ygwhik5t6w74xcqz4igmb6t5esmjjgrmtwqqqmo4doj34t7rpu@jkngx4v76rxg>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <ygwhik5t6w74xcqz4igmb6t5esmjjgrmtwqqqmo4doj34t7rpu@jkngx4v76rxg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=VKpIDNPX c=1 sm=1 tr=0 ts=6acf9f10 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=LsIF7cSu6wHuaSuSEXIA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX5jmL5FkyFVRl
 9H2d0u/3a7GNneTo7TuMbyAc9OpRs4c5iqI33+hlZbHRB72+BGk3W5edBsJPskuGwQzLLLvgQD0
 gTiRILNaQBLSrbOmXqF53R6FhktjIpo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA2MSBTYWx0ZWRfX0Gv2rfGJOMtW
 NJKbolAda5Qhi1Icz/pJZa9eJi+6QxusuT9tRQ9LW9cbhL2yqBsXG/EcqVgvOGQzccpyOEh0+BC
 y2slMr8zr8sar/3cmc+UUxyQwcRdcSFwwMVazOtitKq8q3GHf1V9ESaXnzUzjLdUJGPBF8W3OlY
 2LCKvAZAOqfjvK6oZwIYc1wMG9ajYOv+yjZ7cJ1GpxODZe2I6b/neEn0cdoqYFyI1r051nBb0hA
 j9O3KsblOPlKSfsbF4eAK1HoXHgPrOMFKH/hxlmbxWDM1y6/z/8nZThS6x8Afq56xy4fmFvoLZf
 Ev9ADhAUlXRA99DeELfFHFvj4KwTO4gBj6R6GslFVzEi+mwyJomBuaf7629X9/e3NkAMlcXvN9U
 wpVlZS7uYU9cFpu3iZkYJ0mwuU8S1iYR9cCPAYMnl+gxcGtO9nBvHIt0XQHN8syd1LY6ZyUqx5U
 iUvPwAQVWH/k0e0kqQA==
X-Proofpoint-ORIG-GUID: p9UC3LweX49J9wWffy_r0KgLsTe3q4Nz
X-Proofpoint-GUID: p9UC3LweX49J9wWffy_r0KgLsTe3q4Nz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140061

On 10/14/26 4:36 PM, Dmitry Baryshkov wrote:
> On Wed, Oct 14, 2026 at 02:19:07PM +0200, Konrad Dybcio wrote:
>> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>
>> Clocks on Qualcomm SoCs need a minimum power rail performance state to
>> operate at a given frequency. We currently leave this to clock
>> consumers, so a driver has to know which power domains supply both the
>> clock and its parents. This ties knowledge of the clock tree to
>> individual consumers and doesn't protect other users that prepare or
>> change the same clock without making those power requests.
> 
> Why would they prepare or change the same clock without making power
> requests? If it's a legitimate user of the clock, it should have an OPP
> table. If it's not, it should have a separate API to set the clock via a
> legitimate user / aggregator.

That's the entire problem that motivated this series. The consumer
doesn't know what it needs on Qualcomm platforms. The power
requirements are that of the clock controller's, not of that device's.

> I see one usecase where this would help though. If the clocks use
> different power domains and the corners on one of the domains don't
> match voltage on the other domain. E.g. it's not infrequent that the PLL
> (powered by MX) requires performance vote change at a different
> frequency than the rest of the clock tree.

Correct

[...]

>> Move these requirements into the clock provider and aggregate the votes
>> per power domain. Keep the highest level needed by prepared clocks and
>> in-progress rate or parent changes so that one clock can't withdraw
>> another clock's requirement. Use separate virtual GenPD devices for
>> these votes and controller register access so their power requirements
>> can be managed independently.
> 
> The biggest question at this point would be the locking and lock
> nesting. What is the expected order of operations? Currently it's
> limited to pmdomains, but for some of the (older) platforms clock
> supplies are expressd as the normal regulators rather than pmdomains.

The Qualcomm case is easy - RPMH is *always* reachable, so the
pmdomain provider needs no clocks itself. For the other cases,
"patches welcome".

[...]

>> +static unsigned int
>> +qcom_clk_dvfs_aggregate(struct qcom_clk_dvfs_rail_voter *rail_voter)
>> +{
>> +	struct qcom_clk_dvfs_vote *vote;
>> +	unsigned int level = 0;
>> +
>> +	list_for_each_entry(vote, &rail_voter->votes, node)
>> +		level = max(level, vote->level);
>> +
>> +	return max(level, rail_voter->safety_floor_level);
> 
> I guess you want to avoid having too many voters, but would it be
> possible to have one voter per 'signficant' clock and let GenPD itself
> aggregate all the votes?

What does "significant" mean here?

Konrad
