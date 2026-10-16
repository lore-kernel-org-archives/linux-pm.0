Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ACD55198F
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170448; cv=none; b=TOAf60tVpDqIlzfBx0/zHcJy7iTNepm2OZHk7Ent0j8OhAYFjiwSFL/EbhztNqBo4ggYrhwAB9+1UVXQYf/kYEHA5p70XHeckf0zRuGQGkJRrLwcsDSB9piDPS/zq3fEHeufH0hmIspPCqU97ArRJhcaq6WOz5jy83tkLRz4NmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170448; c=relaxed/simple;
	bh=0KwjSoWukgYqAq90gzgdo8eC+3oMOgU4b4WGUOqDh40=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EUjE3jEjzIhV/yQYha8bzzPcbhTppuJsIyscaeYPUOs9GJHFKZfK6O931dHBPmfVAweR49aYEG9n5xs8WiCpW1P5hE51Ks8os1NmawAsnw5JpONg3zS44306oxmg7x+2VD0VJKEHguwVBy1e73QMru11n4tf7TbAIQFCduC1jTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NWvzoSh1; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jVwyF8Hu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NWvzoSh1";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jVwyF8Hu"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE5jMw1910966
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ImWkS2heDc2
	Mx/x5aRQGs9bDAjmLZqH7xoOSJfYrzZo=; b=NWvzoSh1p62XSEgmMB/HEKXEtO6
	sAe/MuUxPyfdVmDwHf2dzxakqobVi0zjc7rvkIqR3Jn7LyFEwCrLARGRqGvyj5uN
	mSpdGzrpf69drK4dTgN3eFcFQ6WtrHqBjjLbt2Gd4CCDAEti/4iQxc+cGePfqILP
	DC4No4Zj85+aCgJo4n9ipVj6Ri4bThQRCPJPZk6KcNoggudGkSr3UuVN8Z9YVyAb
	tXQ+DhDPbdG6JFY9bGhVjOE/ExIxI8CgOkrdrHbv/2D/0P7kWcAfxNm5LQ8TaqHe
	OPXOmZ5G+o+dkj4dpyTWEFeexsMSPcokf9O9RpT2lF44rhKt5B8P7Ff5kkQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbjmf9dbf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 17:07:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb71b1443so29175485a.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 10:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792170444; x=1792775244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImWkS2heDc2Mx/x5aRQGs9bDAjmLZqH7xoOSJfYrzZo=;
        b=jVwyF8HuYFFwSpvDUQ9MHOqWYqZzt7CI2rlFuiOPpuThK51SmNu2AToEW9qoAdjBOY
         q+PN4SMYspTxia7MgtcKjjuHAujgsEeoK5VAaDgU/UHYhShLoT4FSLxeniSvr/t30PUb
         PiXQjVvtwwh4pzqOV3sWcJEXpu/ak8Od+8DXncy/oOW93zALDYQ1YztIC+jD9fALHczB
         OCsodbavBB41rDkTRlgXW45OraY/+FJnmm23xSD0dyZSE2Wyh2MKwIVhXffUMNNxcNW4
         2YW3gyu5NEUsdqVVgnYxNzdrePqAFRqwwTvPXmNvZo1qK/6rWF+QTKx6pM4yXdyWw7gG
         AqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792170444; x=1792775244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ImWkS2heDc2Mx/x5aRQGs9bDAjmLZqH7xoOSJfYrzZo=;
        b=ITAZgx+BrIL/0w+o7obML6S8IIB7p86IAxH1KYPazLTsYy6Uy7ndSW+SRiLOOY07XT
         fzEygwudX7a2agrnKORIwGxI+zPvGHrWpPUWkQIAO/5MTSU+Vv7ylgVogaTqd/3UU2bW
         hYLJ25o4lUvqZyatSMAB5og9Ykv8sBJtdK7V87OJwiZOHsCvbMZHW+KFOHemuCg6Rw5J
         5vI68gp7H5c1bYULWVelZ+MGvKmHJJ2wEEUfjNG89ymo4jXbiW9lMJ9RS4HFGJg8OhAj
         YyMPYwwdNnC+jRERu/wfcpAXe8OW91roNkwQwTnUsgXz9bTLesy8OJ0hlr64jKR+oJnQ
         SeZg==
X-Forwarded-Encrypted: i=1; AKwUvBwDStci/fvlWC52WGNSd53s+OkSPuUnroXaTxa58KbUJB/rUOdl7JqEGqzWl9jU+Qt5qe8eKrojvQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIknAKQltKw9Od9Rtg3f3RUqHJ1TmPh1nkuAeYW/48dWKucUPKQ
	u8dHOoVSiMhsXUvBCAa0osMP1bdn5f9grs5+t9a8rj7oeWqjf2HetvVmUk6utCPG/DqS5VRzzq4
	XsiUXy1n6kBaGmriqhwyct3ypEni5jrZBgM0KmtFGX+k3Nsq+JUsJyn1vP71B+w==
X-Gm-Gg: AYBFou0HzFwNfS0Gk+pEXZaDkZRpMRXXYB1Q2r6OpChDKxjT+5NDjUuodibBXOo+Hy5
	Gzn/GBKt0FXHTDhdK3mctw1fW9HarD8/LgUMBHlQ2EFAm9dhSJkfZI/NoiQO+KG/FOymamD6X+b
	uN7jlf6qI1jc95Xh22VdEvrCMtT5SEDPIz39klQ6Ks8qWNBCIWNWr3IObP1bN+ZRnRko/eVjhBR
	uHtWP5l2KNw5cjBhk2oQWZJWEkCLoJnxUszc/OLpi+ePu7iIswTtqQOxCanVaLRJNnY3moNzGVF
	NVWKEG2zeLl4wkvtAT1AYNpK6dWumqxOnUzEh6NVREdrTp/pU81MdrqkH77cfsn+Jj1dLL+9air
	ucqYj7n+gKMgsLU2v1Gm03wP8
X-Received: by 2002:a05:620a:8811:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93f29ce767bmr84846185a.38.1792170444186;
        Fri, 16 Oct 2026 10:07:24 -0700 (PDT)
X-Received: by 2002:a05:620a:8811:b0:93e:6ee0:c074 with SMTP id af79cd13be357-93f29ce767bmr84841885a.38.1792170443651;
        Fri, 16 Oct 2026 10:07:23 -0700 (PDT)
Received: from lin-0772.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f5b2dsm6630571f8f.31.2026.10.16.10.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 10:07:20 -0700 (PDT)
From: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Jonathan Marek <jonathan@marek.ca>, Bryan O'Donoghue <bod@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Gjorgji Rosikopulos <gjorgji.rosikopulos@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, atanas.filipov@oss.qualcomm.com
Subject: [PATCH v3 3/3] arm64: dts: qcom: sm8250: add camcc interconnect cells
Date: Fri, 16 Oct 2026 20:07:01 +0300
Message-Id: <20261016170701.1504338-4-atanas.filipov@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
References: <20261016170701.1504338-1-atanas.filipov@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jGNBYxeMKRIATr-AcOFGBe6qPj54XTga
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX7RscmKxwtE92
 eJREen+lpvTfmoeEWQvFexPpy0SNs0+vKF6zx1kxoswnCPtkTz55OwL/q59DKrQYqj5qo+szx4J
 dVVfNUbR4vAgod+bV8XpPXA2pQBo6Go=
X-Authority-Analysis: v=2.4 cv=SrAFe/O0 c=1 sm=1 tr=0 ts=6ad259cd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=UCxR3cWr3m5Lf22CgesA:9 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: jGNBYxeMKRIATr-AcOFGBe6qPj54XTga
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA2OCBTYWx0ZWRfX8bbTiok5kbVf
 ulS2x9UxBCVxqqJ7NzJx2zoYvN8NFYQkuM4iSiT57DN0UrZVi5mwDA8SjximaWFtaX4pyk5F79Z
 xbCshXUnCfaCaAcVjapqxeM9lAgEAhxh+32giFJFaF+/DBaj4ks6BKTzQExTvBH+1eonAvw4mdE
 LGy9rfxCuWwvtz1BOvz25FncQEge2uGjUmIKzJwn3ykd1P+Ck0wajKPXRdYmqTqLLjl4s1ejcoC
 ZBkeBI88XZJvyE57h3c/Acr+ph5R9Bu7/tChViAihoaFwL7+ranAcdtVVmDN0KmEApVb8dziVNd
 JZY0b0/VrdFI8fUA9+HwFVmiPoRwaQfKDOFijbcVx806SFGUelpt86vki0Gwl15oeCO8VlkhfHD
 21mr6Sliz4BHoFTEcFWGw6JszbpmFxgDe+IZlmHaU67SRWFG03TWUlqWVWgUpSOpWSo8hKKq7DX
 kCSsUymq41z+6ACs33Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160068

Add #interconnect-cells to the camera clock controller so camera
consumers can request camera NoC AXI bandwidth through the
interconnect framework.

Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sm8250.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index f975c2183269a..e923c74dc1435 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4675,6 +4675,7 @@ camcc: clock-controller@ad00000 {
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 			#power-domain-cells = <1>;
+			#interconnect-cells = <1>;
 		};
 
 		mdss: display-subsystem@ae00000 {
-- 
2.34.1

