Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792484409;
	b=Rik5kkgCZ9aYNiicbix8JEcf1Rwviozs2CnO4UV5hOvJgaZlp85mC5w/0x1bakYTaQ5F
	 1iCCgrDZgZ9Tj8fjgkjgu78t/OlZC7Y288B3dpo86MzK3WxN4CCfzGEVh4eiscbB6Dppw
	 gouUf5z+h1ZZfVuBC5uRnV+rsd8G2TMXkAUpOC1BL+bX55ZTHGQAN8P3VTt/zCtRKdL4W
	 XT1sJ98RqN7sdYwUpgNBE5aZO3GbLzz0MLmm/w3KvvZJSdWSA8oY5TYUP76gKnLNr4SRG
	 lkH8QVqS+IOjiBsP0KR/qbLiCe9oDoPJtJHkgG1T67IiHqIi0rWQNNpa3aZAArTLA7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792484409;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=aqxObPJ4qCr+tpFRrLBJEM3JoxynDOvIQyi41scKzgQ=;
	b=R7IgnsRjWGHhZZXdrRPClh+DX5ZCxXz1uV8KleO4Jb0OZwIRcYd2fQy60/qu3rKqf4wP
	 6EUtyFCXfqWA10xDN4P77XskN8ppY4yWykQ5Ye7dFDybTLq5CNs5yt5OHYFYqoSq3MiYz
	 xMhCqh3iBMlSVv63/nQfzL47sqZrnYNgsvtAH0ASTT/ZX/7zUepz5mSxNxyc/jxwcwsrO
	 mJGJqs0iZgRhwOOTpcaHNAoteKYIQkWfuB/fpBTxKHRptfomWQFGY4Xuqozz1ssSV4Xp+
	 alcDjKxNaWeuk4VC5oU7VI6OckTkHRDZflnyXbIdk8570u/VnW/jZYkPq3+sjpxYV2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L8SMxe8m;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V9LBQkyu;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62413606A319
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:20:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62413606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=L8SMxe8m;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=V9LBQkyu
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69K8BnE23306125
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:20:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqxObPJ4qCr+tpFRrLBJEM3JoxynDOvIQyi41scKzgQ=; b=L8SMxe8mPeqC1GjA
	XVf85Z6x4XUkNQHaWNO8+AyZezgTB8WJ86GYC4iAKV5VR+ZvE0YR0tfNUrsHYLB9
	PDhZWsrBvHPKLK/bthpZmxJHP3+21f7dI4mOLKKwoVcMkTquxUOoMCJevv2r7jwB
	q8OVOLSDX4dis2sZDZmnGizOgsUUUQnBGOVBagZQnFDq8p7eeLyA5f0UyvFTwb3x
	2kLuZHAzU6ErHdCaLQJ6VhAyCL4AsukoBU+yBcPpS7y7Ab/0D4tYevCChtVPoI7A
	tr/tB6I4g8X/GVTEw9bW9l+X3Nqc+zUMPeWemo86RRlvM5uM6eI3gsTfFTRm7v0c
	3P1U2A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdw5ssj2q-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 08:20:08 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f322ef7d3so530350985a.0
        for <linux-pm@vger.kernel.org>; Tue, 20 Oct 2026 01:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792484407; x=1793089207; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aqxObPJ4qCr+tpFRrLBJEM3JoxynDOvIQyi41scKzgQ=;
        b=V9LBQkyufLuphv5qclMvmj8bntOfGRxhWm2o8nhVQ9H6xck1vDuZjUrOpNtoQ7Pvb2
         RQsbGywrADW5VMW3JD6DP4oJpHyyONxQAAhqAEGnT1pHk42OyRbxIFdZcswHsIyjH8c/
         0unhLz2bxM8SCCAXcPWuuovdYh5BN1gr2kC43TenSQrkgSyxorytI+hsL447eGBpZHMx
         3ubJAn30Y33hGMk1E0e+9Oya3XNypCm3isJtlt7Xn3OwyBrQekIYP6MWU7BUOjntpqPT
         /511xq52MinJMO2J/Dg66VkYhVIHGRMMllA/uLMicrDwvM4CgXixjdKcvjOR+XqajsAK
         g5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792484407; x=1793089207;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aqxObPJ4qCr+tpFRrLBJEM3JoxynDOvIQyi41scKzgQ=;
        b=lB8JWzA13FDr1bod6XC7cEkpY+vehNs+g2s+Wtw1P7O5bpSvn3mZ6sXYNZezGpKdgM
         YR6Rc3YpUK3m5QkVyM6f8YCAe3raM7vDQqN2AjwbXPPR/4FQ/7NUuywnEpAbLQZMjz09
         CGqPyTx+xGJiR+nSXpJK8XRXRznjgkEcHTzsImtNB4Ngh/MXHcDTxywrXtA866uq0+ud
         bpJZzRENOnERoJLPpoM/zN+NATJ0yWJbOizSWI/gmyDadzHQO9jbuayTQB7/mhcu3Fza
         HHTIvAFJUmLp9BgoM8qScXAso6WfLrtLAU3wYUGYi2dpMIVbWta3r0AB+vCAj1i9qgt7
         Dz7w==
X-Forwarded-Encrypted: i=1; AKwUvBylg+yWesmNDgdQ0xKPhsSl7IQX+gIGjXtpid+mSnw8ilLREAeZXCq469bNxfc+3uEE95/PF4SzcA==@vger.kernel.org
X-Gm-Message-State: AFq9FYICi66XUODpuTamfL0Btz+xnlP278xHMNn1KxtSPexAmkmNQ+vp
	xKVUUOcjI3jQ665WyGpwY8mJFuc1to08Aqyb6QhDiU8reJJaw2AhlGjW2Eg3FEiqH6T16F42qNj
	arwv6FcQiVh8txO4PQSD4CjbDktSFWsjM68sjCzh+RWtsou3HUHqqBd8H0JNbvA==
X-Gm-Gg: AYBFou26SQxp5Y1mk2kG0IPWlb0mHjQzzaLtFcMbMMHG8+fRq/WXLgJnb9UhvWq1O2n
	D0pYDX13j5i0OtwcaBBvzNwCmjN6CLt+rn1JMRKjNKNMvauJZpK0VW3qchLn0G83EzYMYcS8BWk
	z5wOwrn+LDnGrCFwpKoOpFtw3a21MSUetzZq0x0wIUM5Cc6QZ9W6vjbspS3E5baTPFRdJ2D07uL
	1Uiop0i75VgOoXhqvQsBD0IaEF7iHmjzsP0MQhUYR8IPyTLghGKVF9F0h19Cd1sd1M/Nidh948v
	osrMOTLmehvHzW6bCklx70PpDnrzAitxhcx118ylcLDvaA7+8wQWeGWm4/wOYgzsJGRYEae6w2g
	GouMhT7dG/P2ZZzZwIM+PDpS6FQ3QPEE=
X-Received: by 2002:a05:620a:2989:b0:937:6de8:b40 with SMTP id af79cd13be357-93f29ceec65mr1712837485a.15.1792484407401;
        Tue, 20 Oct 2026 01:20:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2989:b0:937:6de8:b40 with SMTP id af79cd13be357-93f29ceec65mr1712835285a.15.1792484406890;
        Tue, 20 Oct 2026 01:20:06 -0700 (PDT)
Received: from [192.168.1.73] ([92.247.57.178])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f3833f93sm28793665e9.3.2026.10.20.01.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2026 01:20:05 -0700 (PDT)
Message-ID: <75a64aa8-cc9a-492f-9f49-008c9f34f280@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 11:20:02 +0300
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] clk: qcom: camcc-sm8250: use icc-clk for camera
 NoC AXI clock
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd
 <sboyd@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
 <20261016170701.1504338-3-atanas.filipov@oss.qualcomm.com>
 <g56qnvvcuvih7pm2lhkppvpbj6squhwyi6sfvahw4zvuqitrkj@mewzkeerabm7>
Content-Language: en-US
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
In-Reply-To: <g56qnvvcuvih7pm2lhkppvpbj6squhwyi6sfvahw4zvuqitrkj@mewzkeerabm7>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfXwDVmdVLiwsMb
 WdwU0RtGLOzunj9Kxp7zQA+THZ9ZlbOrqr02Gmv4e6phlf3K0IGVVjq29ACoBt6G94fIOwLDk0j
 p1w5MFJxfhWP/8vGoagu6VgKa7FswbqX7xTH3q+Z5M+SxXEh9ZvloAiLhR6Wyt4nMtKjbq1iufn
 NWNflx7/C2klijO9HdFfUUmJ8oksd2dZhJ6h24R4M8i9oGZCgOEcH8w0dLVidBfoqiblU24JGAY
 3s85Be2agVX4fGU0XTBROQRzmVNzQg2Tx8C5we3VLOoBW4gkbCnO3owhSFNmCI16uRUl5GdVmfK
 nw/B9LWgeyvkFCuCNxjDXPBClKDpIGJzpaK/8KsXop8fJBeCHIO1yl2CVKFbtqMkreP8eGbSZ3g
 ClmdOC1uUKnbaPbTMjfD0K+dS9FFNTDxHl0Hm5fdfaLkgZ4Gptn8VzNZht9qmNlzxRWx2EAhqB3
 6JXQid2NkP53epfWl2A==
X-Authority-Analysis: v=2.4 cv=fIusTpae c=1 sm=1 tr=0 ts=6ad72438 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ybD9qRDIDfZaXNPQ7Ca20A==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=KSjN1H3_7EXrvi_VFQkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: O6SN0QeP4CcENUkOmSribk8_LmIAII-7
X-Proofpoint-ORIG-GUID: O6SN0QeP4CcENUkOmSribk8_LmIAII-7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDAzMyBTYWx0ZWRfX99EkPn4RwWL2
 Ol+IuTEZVDC5CubjiB/qS1Lg9B3FZJN5fCJF57AXAAQZrgzmIfXbZJAw6oQ3uL+VWF8QxoTyrIY
 u7jJt5EXRitwEx+76+nJXPLQK9J8HMU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200033

On 10/19/2026 5:49 PM, Dmitry Baryshkov wrote:
> On Fri, Oct 16, 2026 at 08:07:00PM +0300, Atanas Filipov wrote:
>> CAM_CC_CAMNOC_AXI_CLK is shared by several camera blocks. Setting its
>> rate directly from each consumer means the last writer wins.
>>
>> Register the clock as an icc-clk path through the common icc_hws
>> support, as gcc-ipq9574 does. The interconnect core aggregates all
>> requests and the clock runs at the highest requested rate.
>>
>> Use the RCG rather than the branch: icc-clk enables the clock at
>> registration, when TITAN_TOP_GDSC is still off. Consumers enable the
>> branch themselves.
>>
>> Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
>> ---
>>   drivers/clk/qcom/camcc-sm8250.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
> 
> This is a nice approach. Several quesitons: if there are multiple
> clients, should the clock track the max of the rates a sum of the rates?

Max. icc-clk sets the clock from the aggregated peak bandwidth, and
icc_std_aggregate() takes the maximum of the peak requests. Each client
asks for the bandwidth it needs, so the highest request covers all of
them. A sum would overestimate the clock.

> Also, this clock needs a certain level on a rail. Are you going to add
> the opp table to the clock controller or to the devices which use the
> ICC?
> 
To the devices. Each consumer describes its own needs in its OPP
table: every entry carries the core clock rate, the camera NoC
bandwidth and the required rail level, and dev_pm_opp_set_opp()
applies all of them at once. Dropping the OPP on idle removes the
votes. For example, the JPEG encoder (to be posted separately):

         interconnects = <&camcc MASTER_CAMCC_CAMNOC_AXI
                          &camcc SLAVE_CAMCC_CAMNOC_AXI>;
         interconnect-names = "camnoc";
         operating-points-v2 = <&jpeg_opp_table>;

         jpeg_opp_table: opp-table {
                 compatible = "operating-points-v2";

                 opp-100000000 {
                         opp-hz = /bits/ 64 <100000000>;
                         opp-peak-kBps = <25000>;
                         required-opps = <&rpmhpd_opp_min_svs>;
                 };
                 ...
                 opp-600000000 {
                         opp-hz = /bits/ 64 <600000000>;
                         opp-peak-kBps = <400000>;
                         required-opps = <&rpmhpd_opp_turbo>;
                 };
         };

The consumer asks for the bandwidth it needs, independent of how many
rate levels the camera NoC clock has on a given platform; icc-clk
rounds the request to a rate the clock supports.

Best regards,
Atanas
