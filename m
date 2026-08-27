Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09D04963B3
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787853631; cv=none; b=EJiw6uFeS/s+e4e/NAbhqqIJ6A/p4TR023B4t6nUbpwMdtnHSSGkdnKOkJLrAMU1nY4YdTIdCMeqbSAAGMIjzyFUpHcz7MYViD9hKs6OvWIgFuY5yzM7or3LZI7phDQTo2IffHX/G3Z8J0JJ3wpqIHQJyzJBLGs6EakzLN0BssE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787853631; c=relaxed/simple;
	bh=UFbtM3Wi59vHG7aQiqHHkhJP0XzUIMUsc/8Fo4UwloU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fOLQIfoXymwo+R5TR3rA9j0ThgomvqArHTFx1cL+5nM+bQzjaDuORWgsqhyW9jFy9rbCOaVerT6JSC6d+AxwdVmLi8/LtBa3R4qZ1FZwAzydDzTCjyWjy+vG9yUR3Pkz7UUpWtKPHAAtWKp2eP4dv6zXdsY3dRGsQYQH4dpLAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=og+R+JU0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kRF7/ryZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="og+R+JU0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kRF7/ryZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67RHXa8o873631
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	gOQ6tcmRQHIn01iUxXOVIhspNTiTc1cqfMZOOm1oy+s=; b=og+R+JU0M/Xyh+NY
	il8boC8rRpr2LcJNFgKK3uRjBgXrJCotMPGRzS+MKtXlD/vZfvpsqYTwNZL+n74+
	ZikFJENA/nvVdHFCghsFjUHOYMG/7z1OEn7f8opKvUvY3g3OHMpXFgjTKkB92S4j
	DcuexOthjFH1MABKMS38AvH3ZESEbwesBPWJdh3Kg2eWXTpaZbk9sNzCVlCXHj7E
	e8KvOzxc6zjzbzmYrYzd7Fh+6jT53jFWBAfCrXmhuEr85be9WLgxjicnPaw1bVZW
	+xHpQlVtcJ9N7+6JXpBwLkAJ5fKgJycFGdRzOVgqXtTMZNK5gcLrod9DWUddz/JF
	g0WH3A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4garn0gjb6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:00:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so257731a91.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787853623; x=1788458423; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gOQ6tcmRQHIn01iUxXOVIhspNTiTc1cqfMZOOm1oy+s=;
        b=kRF7/ryZl5OWbetyzYtIDWIGxZ8DsHf2dbBV/sgp/C75hbJYi1JNJpyrKZvZFux4Qn
         jxJn872pAX+eaFrfA1wxNApzww6SJlyvQDUfrQmBE5MGJHWT16A5dR9YHZkEAanCbLZe
         6X/7Z8yTjEVVgTegiqK/IVbe05c/zrgmR+uQb0zg0lAh73dM/r1p1dWiLRXRt4C4xG6j
         KpHunjQKFL7V3+PDyVItcbOTffoMljuhhWkOcPZx3hCIaTamUDHjIvLy7u8s3fd6Fux4
         bilS4lkJWCuMseX2XgCN2G/a9t6SxHCZM09ODVQYvYEtDQy4d5I8kXr2zn52qUwnBsxv
         p3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853623; x=1788458423;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gOQ6tcmRQHIn01iUxXOVIhspNTiTc1cqfMZOOm1oy+s=;
        b=XB6uyDrGkL/o3WgL/czFSQZ/VhFG56FOpKXPVv6N0OZO05k79XUiBv5TW2bk2ZiszC
         tgqb6+ABvNcTo440JnTJns3cRkSKzOvpGME2ZTUlzW0Il/8JFyZQA1nnU6/HlNJR0URv
         fARKnQoMB/E4hJB6Qx5TyXk6IMgwlgIdpRNydzpbuS8N3/Pjeyr7A/INy20V6ojJ5J2K
         94cSlvEYe0TX1c/s0PrhaAqrZRzsmoZIhkgKF6NtpqmWdPEY/klNKzH17cjr2pT/9ZDK
         S+DidEBBB2KVz2OjO1XI2RaFrbh1GikJQkOrCyLROTir9hNGQZ3TJhn/b9Yd66W7e2uT
         Gftw==
X-Forwarded-Encrypted: i=1; AHgh+RrC7CrdGA6/PYGBm4RpnMj70htrDioetSggFNwAlJ7UOFjVZYxVBbD0bauM6gJ8SbYmSK2FA6J8rQ==@vger.kernel.org
X-Gm-Message-State: AFuF++mKWYQfnsy5ECJZGNsHFtv/Kl0b1z+G6ojnWIUivB+nMluOxKK6
	gBXDl7B8X0/1x7VLu0ZAFZjXOcS+PgCJYhkQZ/8e+e7HvGap1LmFdvgwjDUb83LcvClb8ImCM3y
	saFa2rFSbe2UlSyxH1lDHNIch0QvoFNVqxUT9tWi80P06E3sI7u/74HLGGTsr2A==
X-Gm-Gg: AR+sD11bskDrREbOHAtw6fh+CJMFG5EFa2m/pvZ5v8f7ImHxVjgqz730sOUDtAgyW95
	D5PT0+tbVjldeZZwvzf4jkTm0kcpcGhIkWAYxdB4xhThHijDp3IuosLQTtCxdXdpbJ/Tg0MQvQv
	8OqJQOMGOWHijpW8z7k/qcKKJ18lptfxlradwSSqHcdP0P4TkFgbINQBMjNSlm1vBwI/odh4PLj
	eXw5Cxx63DhJKCsR4m11zhZHCpbKlUj1W839OmECrHNjilJqTTEGcaKAqh49Es1Rn2a4AYSHXEn
	I+KMNEnlsUQZhDkmkTqzvT48m1DDVe/LTlgNwG466WPzrSWfOttnLz7DvT2L+ruv1VCL31dVuel
	RNfbL9s7YcIFE6eIP16GVSF6HLQ+/qCk9rw==
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396d0f2f709mr1910690a91.11.1787853620700;
        Thu, 27 Aug 2026 11:00:20 -0700 (PDT)
X-Received: by 2002:a17:90b:2d82:b0:38e:5c6:4db9 with SMTP id 98e67ed59e1d1-396d0f2f709mr1910262a91.11.1787853619265;
        Thu, 27 Aug 2026 11:00:19 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a905cf38sm27437523c88.12.2026.08.27.11.00.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 11:00:18 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 23:29:24 +0530
Subject: [PATCH v2 7/9] i2c: qcom-geni: Vote for SE clock rate using OPP
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-7-091697dbeb02@oss.qualcomm.com>
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
To: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>
Cc: mukesh.savaliya@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        arm-scmi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-i2c@vger.kernel.org,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787853566; l=3900;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=UFbtM3Wi59vHG7aQiqHHkhJP0XzUIMUsc/8Fo4UwloU=;
 b=SuK46GH8fU7Buoy8TzORlm6WEiTSHXMtcOF2tPugNtpZDBh4ldOCJthkNf1e+NaN4d1ZK5Edy
 hg5t7jDP88uBZIMEGFemCXKBci5gBezainJ+OKoU0BCFjS0noAt1+I5
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfX6GdGdXh5v/T8
 a8Hv4sZ9KIBMgBRyHA+vQP7dDC5fxDN3+DN6+vP2hLYZlC/9PwBtLKagP/W1wVcd33loczVpLLY
 RzToeZuka9HS0YOZm3e6Ctk5xp/9lsEkJywzexLDDDpTAUumFt8M7paiKLuQbDC6B9X94Nfsizd
 jioc5T4dvZ4xbiBu3y/U+mJUJPwZhhGjwSkk6Qkkaar0kSVIhnLvHsJX+12Rd2T81D2Hufl4/0o
 7fean0zFER9OFSHcaMty7h46DorBhakpu5RISZF2pzbC0To9vh3aZqlpplSW8hhg8u4TjFiCts9
 AzmqgVRG53ZcH/q1Idz/s0GKuZSN6KhJaE64mGIxhzIUZTfu1SPaWpLGHznib28QvSpzaOpPTyw
 rURBPSrjt9JsefqoMqL9UtfTPVOKke8MnZx8va8W5zbyQx6ZFmPnErFJd1HY1qcaZH3S4xDB+ir
 mgS911wYO4nEqdLaSnA==
X-Proofpoint-GUID: VTbyV9br156vh_kuxe2-wrXaWrV5rw5A
X-Authority-Analysis: v=2.4 cv=C+3ZDwP+ c=1 sm=1 tr=0 ts=6a907b38 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=YnqcSKFZeAXWn-m59-0A:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: VTbyV9br156vh_kuxe2-wrXaWrV5rw5A
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE1MSBTYWx0ZWRfXwuD2PAj8MicC
 tbDLTV7YHY6qEi9GTxXfrRk/Kuv04ZD0PFCXMX56jn59okyEqM2Wn6+mihIDDymuJ9M3RFEVZVV
 Wq6qf5kA+tqHGlI5JDg9FYO738cha3A=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_07,2026-08-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270151

The I2C driver currently assumes a fixed source clock selection and always
programs SE_GENI_CLK_SEL to 0, which is not sufficient when the controller
needs to switch between different source clocks.

Add the source clock index and frequency to the I2C clock map entries and
use them while configuring the controller. Request the required
source clock rate through dev_pm_opp_set_rate() and program SE_GENI_CLK_SEL
with the matching source index.

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
 drivers/i2c/busses/i2c-qcom-geni.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index 658636c1ee0e..a3b7609e3cf9 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/soc/qcom/geni-se.h>
 #include <linux/spinlock.h>
@@ -165,8 +166,13 @@ struct geni_i2c_clk_fld {
 	u8	t_high_cnt;
 	u8	t_low_cnt;
 	u8	t_cycle_cnt;
+	u8	src_indx;
+	u32	src_clk_freq;
 };
 
+#define CLK_19P2MHZ	(19200 * HZ_PER_KHZ)
+#define CLK_32MHZ	(32 * HZ_PER_MHZ)
+
 /*
  * Hardware uses the underlying formula to calculate time periods of
  * SCL clock cycle. Firmware uses some additional cycles excluded from the
@@ -180,17 +186,17 @@ struct geni_i2c_clk_fld {
  * source_clock = 19.2 MHz
  */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_19p2mhz[] = {
-	{ I2C_MAX_STANDARD_MODE_FREQ, 7, 10, 12, 26 },
-	{ I2C_MAX_FAST_MODE_FREQ, 2,  5, 11, 22 },
-	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 2,  8, 18 },
+	{ I2C_MAX_STANDARD_MODE_FREQ, 7, 10, 12, 26, 0, CLK_19P2MHZ },
+	{ I2C_MAX_FAST_MODE_FREQ, 2,  5, 11, 22, 0, CLK_19P2MHZ },
+	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 1, 2,  8, 18, 0, CLK_19P2MHZ },
 	{}
 };
 
 /* source_clock = 32 MHz */
 static const struct geni_i2c_clk_fld geni_i2c_clk_map_32mhz[] = {
-	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38 },
-	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19 },
-	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15 },
+	{ I2C_MAX_STANDARD_MODE_FREQ, 8, 14, 18, 38, 1, CLK_32MHZ },
+	{ I2C_MAX_FAST_MODE_FREQ, 4,  3, 9, 19, 1, CLK_32MHZ },
+	{ I2C_MAX_FAST_MODE_PLUS_FREQ, 2, 3, 5, 15, 1, CLK_32MHZ },
 	{}
 };
 
@@ -198,7 +204,7 @@ static int geni_i2c_clk_map_idx(struct geni_i2c_dev *gi2c)
 {
 	const struct geni_i2c_clk_fld *itr;
 
-	if (clk_get_rate(gi2c->se.clk) == 32 * HZ_PER_MHZ)
+	if (clk_get_rate(gi2c->se.clk) == CLK_32MHZ)
 		itr = geni_i2c_clk_map_32mhz;
 	else
 		itr = geni_i2c_clk_map_19p2mhz;
@@ -218,8 +224,13 @@ static int qcom_geni_i2c_conf(struct geni_se *se, unsigned long freq)
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(se->dev);
 	const struct geni_i2c_clk_fld *itr = gi2c->clk_fld;
 	u32 val;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(se->dev, itr->src_clk_freq);
+	if (ret)
+		return ret;
 
-	writel_relaxed(0, gi2c->se.base + SE_GENI_CLK_SEL);
+	writel_relaxed(itr->src_indx, gi2c->se.base + SE_GENI_CLK_SEL);
 
 	val = (itr->clk_div << CLK_DIV_SHFT) | SER_CLK_EN;
 	writel_relaxed(val, gi2c->se.base + GENI_SER_M_CLK_CFG);
@@ -1228,6 +1239,8 @@ static int __maybe_unused geni_i2c_runtime_suspend(struct device *dev)
 		}
 	}
 
+	dev_pm_opp_set_rate(dev, 0);
+
 	return 0;
 }
 
@@ -1236,6 +1249,12 @@ static int __maybe_unused geni_i2c_runtime_resume(struct device *dev)
 	int ret = 0;
 	struct geni_i2c_dev *gi2c = dev_get_drvdata(dev);
 
+	if (gi2c->clk_fld && gi2c->clk_fld->src_clk_freq) {
+		ret = dev_pm_opp_set_rate(dev, gi2c->clk_fld->src_clk_freq);
+		if (ret)
+			return ret;
+	}
+
 	if (gi2c->dev_data->power_on) {
 		ret = gi2c->dev_data->power_on(&gi2c->se);
 		if (ret)

-- 
2.34.1

