Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEFF48B388
	for <linux-pm@vger.kernel.org>; Thu,  4 Jun 2026 16:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590164; cv=none; b=uIGbcXRxiAcibj4KLqzGnx6vVFPtjT2QDFtVXjjAPC2O/ZnxJDgZ9FjAvM5quf0i06AIfmFElO36iG5LkD5Sfup0+/9jVE3RzT0i7TV1Rq/VI0l9WoX5+H7JjCQBw4QvbcvmnZaww7q5m5UjFfgtMVZOvJ0kEctA4B0NPzBWxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590164; c=relaxed/simple;
	bh=XKrmOUE+ITe0K52I3f+8XQpNgOZVciYbk2KqzJHOOj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ofeXi9wHbb94WqRXKIpWrZsdK8PIIYUOTBNhPzbvr9g2XKb3nah+6IDPy+6ACypgQPmEjd06CFiX34c+EgAfXU1wSrdYjRMoYuhvbNsjszovO2uSlpKoCQFXON1X47b34582alSyyq0B016tIhMPKjT1XTTvM25gFh0HxRQq3So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kUgmbA5Y; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GAq6uKlS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kUgmbA5Y";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GAq6uKlS"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 654CCWR13221067
	for <linux-pm@vger.kernel.org>; Thu, 4 Jun 2026 16:22:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	xKGI1tkayHJ/4zmc6j63m1NJbgsynd524kpMerhxDG4=; b=kUgmbA5YPEkzYKoJ
	8qEBlEWgjXCABWUgHI5lA1iNEqxpswvx73fZ3pKI0rMWEeVhVEooj9FElOjGqZZI
	HeBL8nTBCopxi/mS0LSpQgVgdNrj1VZC0nq7ztVCj0ixyNvvxCHqurbnIJ18WdV5
	jRPtVo/etZ0eBRk1Y6TXfBb7PDauoO7ZtwkDLkjTwgSmXtDx3IJezRZanCEbTEPv
	9gG7PE26dfrBnP9vDkQKKSGUz3MlFHoBlYkYp+IjpFAZ7GT6m+yXTdYuwNx9Jgl4
	Q3N8i3sgy5BHPDvePu9ZEYH2Ugfe8lh9V+2b0SWuZV5a1yDTntRGaw8UZYpYr8k6
	mgOZ5g==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ek95u9894-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 16:22:40 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-6751db2792dso572247137.3
        for <linux-pm@vger.kernel.org>; Thu, 04 Jun 2026 09:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780590159; x=1781194959; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xKGI1tkayHJ/4zmc6j63m1NJbgsynd524kpMerhxDG4=;
        b=GAq6uKlS/LVbsnOxL+dwBMsSw/tr0PTpb3dOOwZD7EFA7YcTm4ojYVJsffRFacot7u
         lUzDky71sJTfjlIX6sxje9eKlHk1j8y8MRoIkuIPkHH3t6WYuEMN4mR6VbQ9kJ3LE6ax
         0/9c2X+nXYP7aITfrwU19NRKXpExHYczRcSqrj6xN45kU0mYMivviNhZs7YPikpJfIdD
         NQFkHd7l931EBrAethpwAR0s9N35qBG1Y/pIKSRmNktVn7GnX6UGKGKNEBWHSuynWsvr
         hXU3AsE+X2QUtxXOkui/KF77Yflwkw5bM80FMmPKGK62IggjjMqLQ1XKsarlMpjSE9L9
         sAbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780590159; x=1781194959;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xKGI1tkayHJ/4zmc6j63m1NJbgsynd524kpMerhxDG4=;
        b=ERlTd1Wnk5OiVaROPHruSHE/cnORNgjVsKlnVn1UT5sg/kW1eywv+gjbbeK1oFr82q
         6PvjdG80qmz9ox5m+x86f76aTYfNWPJgKO7dO0XbTk9rCENLQhw8DsejoCLKNndhHnZK
         I1PXqSzoNS3GP17f38b+H424jQ9ix5pRWBzKuNaf+nbuzDqIuUSro7XPS4fAP8lmse6C
         nvSPfMtrlhYYbvDB27cmUuG3o39le2gXn/qaEbFyWqMnAWARIc+Xpwwvg1wd//f10ilH
         NeZFDQQ7kQwzJJgse+/miVb7lLUZR3Jd232vOJvfP3RbpKQYl9GrL+9ZDJ/+q4C3QFXs
         L50A==
X-Forwarded-Encrypted: i=1; AFNElJ/ID1saRGgElGczATs1oGdPyGa4ZV5RYnNYYUk98f1suS44UHqLyim7SYbD3gdYrj2lsZsbuakL+Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxxtzUcda027zSiLx+MHFwep29NrAutfpAD9vlIvnrco6UvVqhK
	MlZDmWamZ7r1RCqp6deJVl4vM4XqQSxLhp87nJ2bWIRvaS2Oo1+uNBN1BB4obA9IiZoOnXngg66
	2E9hyW4H8LOS4ziV7bT60gvTvir953LHHelvLbvZRbOMUJm5T5oT/tF5VcCbcdg==
X-Gm-Gg: Acq92OHeR0yeLvJp7ofnMVuommsZFWT4cbzAsJS7CdO6wFqvYERG3fRXI6SiPo+sbOm
	FgHnhlgQvbI2uuszauyckulSd4IeYtpdpZlUkjLp8E58rB9urysXEWUpsTxuTzIi+eCuGdKYd98
	oOuWVpqMDJ8rmkcztVMRmln8GKRX9eB7l/yznwPVXaxl4rXSFUkD9J2Nw+LR1v6TyIGSzolT/ud
	OsthUzBAp+KTZ9YQfuI4MhIucBdAt74bsv0Kn0spLLgeU3QDefHSjH+8YxgVCPBHQZjwV6+omRJ
	iak7dIIf66xW/GCge3owKtWWtvsvXkBCc+1m2eJEU1ic8UACT4pP87xuM8ocyodBNsz6MtcQmP8
	g8GCCltKNWq2pg8E54Hh+1PvzYs8jvljs0gJXIr4fb/4kCnKxtztTmfYvExzP80EtLkoe7XezGE
	LX6v+eQyIOl7nizmEvH3URsmRTkCv0H5wol5tdLJPzJCiLFA==
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id ada2fe7eead31-6ec2a218ccemr5618144137.6.1780590159113;
        Thu, 04 Jun 2026 09:22:39 -0700 (PDT)
X-Received: by 2002:a05:6102:554c:b0:6c3:1bcd:31dd with SMTP id ada2fe7eead31-6ec2a218ccemr5618115137.6.1780590158504;
        Thu, 04 Jun 2026 09:22:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-396ac2d5034sm17591591fa.29.2026.06.04.09.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 09:22:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 04 Jun 2026 19:22:24 +0300
Subject: [PATCH v7 2/2] arm64: dts: qcom: sm8250: correct frequencies in
 the Iris OPP table
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-iris-venus-fix-sm8250-v7-2-7bd2f0e5bae8@oss.qualcomm.com>
References: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
In-Reply-To: <20260604-iris-venus-fix-sm8250-v7-0-7bd2f0e5bae8@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Taniya Das <quic_tdas@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bryan O'Donoghue <bod@kernel.org>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Hans Verkuil <hverkuil@kernel.org>,
        Stefan Schmidt <stefan.schmidt@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1944;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=XKrmOUE+ITe0K52I3f+8XQpNgOZVciYbk2KqzJHOOj0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqIaZB8KW2EJaZslWv4cgtu4BtIbj4ClbJQflSg
 BNh3H7S0HiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiGmQQAKCRCLPIo+Aiko
 1b7UB/9WRsG3yOEdy2z7QpRpAjy5xLS0+pDuTCD65G9a84L8W1/UozRyuhxDaz2PvTKPYdOspLF
 EkOOglEk96ACEuMTjOzPgecq+ozYKVQXGHp1txCaY1NLQCnT3fSYxXX4/lYILH/9KDUWCUBaXwS
 O62zgRGLw07XXOees9Y1+VjWsKKEGosLGUGCNAcW0ZhhSM9Kse1PYWBzgE9m1v+veIXnhPiv3yZ
 gG9dvuM/PDW6Lt9ywCAxrsm4w92z8pVoQGUcwbc2J88dIu1d3pDHS9F0mOGNSqqQ716CF1TIQD1
 ed8wwf9VgAjjmDk9+utlciBkdkszso0LYBvr9tg5ypn1P0L5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=at2CzyZV c=1 sm=1 tr=0 ts=6a21a650 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=EQKuo8RqpatckOKiKW0A:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDE2MCBTYWx0ZWRfX0BOGVKn/e6rt
 mZICn6EQ5JbyWWuhydW9MMOeUPF6WR+jDZrDSC7jtGOMovYd2CMJspFDYqOVXzeAgfXbX/ObFTu
 Tzyr7c9ubufFXs6rF4jtFX6aTuYaDnGvZ/i1/vu/BW8FCl6EAQLg8AkfNvZHxnI6TFLWHjG3KcB
 WKpTV2oWIvAlhtlbHepRAJOefu+UBV1hCPPDiswk/2uQUwB/9RmksBT0EKjWMzbZjaL9bDCA0eg
 DSxF8h5JGgz43oPSSQp5UGBKi3IX/E7LoDRy4eBKqqPXNsiTB7Mmi/Eia+A3wr8knYvq7pddyTc
 J/qbmRXqMsu1oJ8akr9q5VIqQdNp5zzmal3mGPS8j2P7GTqyEE2AWeggr4ybE4tXzWKjGcuc0dC
 0rwhB3RsE7AmzBOa264EKagDeetFGrOH6GnTYnnbPDHsnhUIYYxPwm5BshhaUMRUyZ39jT9AHI1
 FebeQfT4Y+Jr8mEf9IQ==
X-Proofpoint-GUID: MzJ1nKBxJqhvLFYDCayXL3HZlS77aeFv
X-Proofpoint-ORIG-GUID: MzJ1nKBxJqhvLFYDCayXL3HZlS77aeFv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040160

The OPP table for the Iris core is wrong, it copies the VDD table from
the downstream kernel, but that table is written for the
video_cc_mvs0_clk_src, while the upstream uses video_cc_mvs0_clk for OPP
rate setting (which is clk_src divided by 3). Specify correct
frequencies in the OPP table.

Fixes: fa245b3f06cd ("arm64: dts: qcom: sm8250: Add venus DT node")
Reported-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6150380795b8..f6044bfaef87 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4355,26 +4355,26 @@ venus: video-codec@aa00000 {
 			venus_opp_table: opp-table {
 				compatible = "operating-points-v2";
 
-				opp-720000000 {
-					opp-hz = /bits/ 64 <720000000>;
+				opp-240000000 {
+					opp-hz = /bits/ 64 <240000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_low_svs>;
 				};
 
-				opp-1014000000 {
-					opp-hz = /bits/ 64 <1014000000>;
+				opp-338000000 {
+					opp-hz = /bits/ 64 <338000000>;
 					required-opps = <&rpmhpd_opp_svs>,
 							<&rpmhpd_opp_svs>;
 				};
 
-				opp-1098000000 {
-					opp-hz = /bits/ 64 <1098000000>;
+				opp-366000000 {
+					opp-hz = /bits/ 64 <366000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_svs_l1>;
 				};
 
-				opp-1332000000 {
-					opp-hz = /bits/ 64 <1332000000>;
+				opp-444000000 {
+					opp-hz = /bits/ 64 <444000000>;
 					required-opps = <&rpmhpd_opp_svs_l1>,
 							<&rpmhpd_opp_nom>;
 				};

-- 
2.47.3

