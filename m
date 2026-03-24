Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6851194C96
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311083; cv=none; b=rCnZT8cZbolwsja5u6xhnhp9k3fvAUdETIshI9dKIsAWLknvVAHrhMv0ed7ywBuLkOYTe/nN8HYss3A8UQYd12+C3xDMS5kJx9hWM+b7DLeQPYq8UBJt94khhJrSb8rHYZRx/zRaqDHOB/esutO9s3ScAYBbqo6g6otdRYzIz6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311083; c=relaxed/simple;
	bh=ZWpPVJTyGZX5XAzeSYalFLMhBrxegI70Mcl/cCNi2FY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=As5xyFiX/p/ds9ChIN4teNt9ilhVamYCOLFdN7Jq8fDc9i9f8RaH8GMZb0UVQQFdNECc0l/pT6prFSPgLnZpioIWKbfBenGCl2vYOXxfJTRqEbjNMlWChsrFfdKKSZ4nVUbn7LAQXaAs3biNW1IOG4FTInHqyNCoU8TqaHc6u6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=INN3nadb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MNZA8HQZ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="INN3nadb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MNZA8HQZ"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62NHqYbd3170672
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	zhWKmPyos8mU3XZ1HkzNAW8a4RA/QyofgRQ7BpX4XV0=; b=INN3nadbUSDSPE2A
	/7JbS9NpFT72limzNsLUt3RHi1c9cnIJSVRoQ16TYgpKuKgtHvB7IXtP1EQFvttt
	UkKhUtIISKUGTrDChUwHgw2iYpC28IxWIEzJ/pBcea+ur8s5ELM5CTsDCJTrpvem
	MyccZH2syleEG/5ALEG635M5ULybWnJnbfFjaKMDAulPD1HhVkLggomMFv2NJTAa
	kzLwFxXT9R2DYr9zfSWb92w4rHRJnYNe1R3guwhG78t2YMpY75+EUV5+VtX0QxIP
	ii1U132RUF7uyMqso+24jMVeT2RyC2fBLjdd172E0w0MvCkuGAK5Qo1bavEN/c25
	Zx98kg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d35r226sp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 00:11:20 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50911c94db1so38824471cf.0
        for <linux-pm@vger.kernel.org>; Mon, 23 Mar 2026 17:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774311080; x=1774915880; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhWKmPyos8mU3XZ1HkzNAW8a4RA/QyofgRQ7BpX4XV0=;
        b=MNZA8HQZuIkZ/nQ1EdnbzXTaAyvbwxWMCDGnXz3uR4rgMbYsiYnQIA8BeFeDGji5bg
         IyH/Vzg1obaiS8alKGUNhjOdrVdH35G8ZP58GECyE81CUCHNYGsNWM6XzD5cZmy5+clI
         dGOyQdBObUAXlaye4A3/F1G8gGT347KS68kv7jSpruOw+b3p+ilf5iTWA+3fTlPnJbFs
         xJb8oCDsffCT66/1PV7y7czT0CU+TmKG7UGL0fwWjmGV1Cz9j6YLp0MRVH2oxzPnx/Qv
         s4UbKQM7QECeUaj2STeH8zPrSTnD7ZM0hoeJ1ueqcowGZsmPCt6+75A+EOMtilJnigMB
         0WtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774311080; x=1774915880;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zhWKmPyos8mU3XZ1HkzNAW8a4RA/QyofgRQ7BpX4XV0=;
        b=qTwtjGZ0xiMJRQCSxniHid/gwuH0tlprq2tPPJGD+nJRp0KVvxH8EP1uccEH6e2NiQ
         NllcQ7QC+9nsK4KvlW8MzLt7tk5K2VAeSiIk+LqWa1iHp12kvjrevb7hDVs17eMVltok
         Jq+Ahh9akb0tI+HsXE8kqosbmfJHxxGqA3S2ZmhphmGnxZw3DWT9hlw0QLjFQa/Rjzx4
         iSZ7YDynCTIiuV51DHELN4ep+8wOLKXCZvcc1vtNiJzRzuURkYGW/vZtYWEdOjY3Aifb
         olZzdF7N+W71ad7y+YWHJ5nTYCz79cX6G8g6QyTgIFEAG/fsegrfAVCRtq8GIaeqS+zg
         nyBA==
X-Forwarded-Encrypted: i=1; AJvYcCWO7zFIqTrakIm/5lzAlT6H0bTkYdwvgMozl2Vbw5OT+iR25ir3rtCWWxThi4Zz16Ht8HZUCzmg5A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9uwlv3U0g+Veh4bdKCAN3BE2xrxhqlfcZWmRNiRH2GSlEu6Mc
	qr9eovI+RX8yphzr8OKwyfvuwIaXZyJJGk0xnU7XQj86/uMPbnrutE7SFXQbB1embCpU5+tOk2V
	NyEMSO6uA/0vibLHFwf71O9JoGNi5SazIgtetyxSdwgG0kFh4aBG36tmyFrKQCQ==
X-Gm-Gg: ATEYQzxs+1E6DtVZ+JObzgtBgFT+27KceTrhr08Mqa0se1fLCQRT4T5QSnR3yWMsctl
	bJMBhn2cWKIbwWcZi+h0BYoYBvFlKJh3U27WPmzu6oDaun882Cuodp0J5UjkGwbhvlN1ogC8WB6
	nlst4KxipNhm+ycBTxlyT97RsUC7VRBStw383qHDqFU15TaBRh592FpxNlGc9GMo9xIp0SdIMHZ
	2ulluYP/wYqO35Z1r1iPDEx9Cv6DicX8aYwyilJbVw1cOb3XcyQKMDtqkR00Bkcsp5JBaojHH4v
	wEZxJAh8CJrBGhlUcgIu0QCD8INb00FF5G2yQ5ibC7eroMJKYJS5arfJOSGKph03/SniXS8dZXj
	784n5mPvrrGFebc+VhtGn7JFeVtl2hAeYeJJgcvANH38+c7ScgdaZOjUCLXfrn1EAex016aU0+z
	aPn9hrQitM6c1QsZxkJpEcXyiZ9XNDfYSznlM=
X-Received: by 2002:ac8:5816:0:b0:50b:51f7:c660 with SMTP id d75a77b69052e-50b51f7d5c4mr123019911cf.61.1774311080115;
        Mon, 23 Mar 2026 17:11:20 -0700 (PDT)
X-Received: by 2002:ac8:5816:0:b0:50b:51f7:c660 with SMTP id d75a77b69052e-50b51f7d5c4mr123019611cf.61.1774311079591;
        Mon, 23 Mar 2026 17:11:19 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bf99820f6sm30339021fa.19.2026.03.23.17.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 17:11:16 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 02:10:43 +0200
Subject: [PATCH v2 7/9] interconnect: qcom: msm8974: switch to the main
 icc-rpm driver
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-msm8974-icc-v2-7-527280043ad8@oss.qualcomm.com>
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Luca Weiss <luca.weiss@fairphone.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Brian Masney <masneyb@onstation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15014;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=ZWpPVJTyGZX5XAzeSYalFLMhBrxegI70Mcl/cCNi2FY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpwdaI3lTenV7zncKDJm5AR0B0kfk6aJMyW0Vb/
 yQWMs4Fy5SJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCacHWiAAKCRCLPIo+Aiko
 1XVTB/0bDTHNacN143azpIqnrc8H16+x78i0XMXOnVRK/m3N9u4qotwmloqY4Dm40hjy5wzZDFI
 QY0NjM7Ki/uQySWN1ezJHjluYO40hzY342N5RYF1LJ7Tq60Nfw/wl5R+ixX68AsupAb5yhTS6RU
 X38EGKu+lX/Jup7624+0LoRUukCVKrfazS+1COcJtxECJF7XFJ0ghzZ9QMdPWBrPUQoTnWatJGo
 NwNDLPz6ScREQv6kUwv4MchYRBbrFWV+CkpdnNfVDWANJU+utm4PRpBYVNkTHI8GPWgEAQCTY/B
 BbF9Ei4e22zG2PpoUxsu+8l/TopIU3sEm5dHOFTfn1de/yM5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VvUuwu2n c=1 sm=1 tr=0 ts=69c1d6a8 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=vNxNlsk0RTatv9OKPSEA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: ENazq5Rd0HX7LypDD3YTd6A6WDJ07rP6
X-Proofpoint-ORIG-GUID: ENazq5Rd0HX7LypDD3YTd6A6WDJ07rP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDAwMCBTYWx0ZWRfX2mhJ1roBoc6i
 AKAn42suMRsBJRga1Pq1btu+KzQ+OWWewDUGENttYe7Hg/Qs/xr7ssoFSLJbrJxWazqbCqoVUVm
 2TVHiBUkVNsy2418cwggMlx0Z5TO9yjgOz69WbkIf4jGT8OPNfBJWgCfowYkI6cLOUhonGI035d
 6YAvjqMPZKF8YKN/wYEgU+teK47pMPlYt2qDJFkhgVEen6lHnB9mPv3LgLX0Vye2eHVHsDei2/W
 g/xGI8QRUlnjhHnHvS737kZ/0q3sehQrYIsbjpPpKR7jCDRN/ax40hpMMOAm6joTuJugJa9gOpN
 jCqHV4smadQflOVt3nGJTRT5h9Kd7bUuDwXZIvojLYEef+w/+wXV4QwuUbTqKlKgrg8R97/gKMU
 e8403wpxIE7xyFzBmdwn8Q9YxXbihfe1Q9ai6/QikWnBzZhQewlDe2XNe10stAivo/i/hX3jIaj
 PtSateZySIRt27Q+ZlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_07,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 impostorscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240000

In preparation to restoring the ability of MSM8974 driver to work with
the modern kernels, switch the driver to the main icc-rpm set of helper
code.

As platform-specific workarounds, set the get_bw callback (returning 0)
to prevent initial setup from programming INT_MAX into the RPM (which
otherwise might hang the platform) and tell RPM programming code to
ignore -ENXIO errors from the firmware (until the QoS programming is
sorted out).

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/interconnect/qcom/msm8974.c | 304 +++++-------------------------------
 1 file changed, 43 insertions(+), 261 deletions(-)

diff --git a/drivers/interconnect/qcom/msm8974.c b/drivers/interconnect/qcom/msm8974.c
index 3239edc37f02..144f225ec885 100644
--- a/drivers/interconnect/qcom/msm8974.c
+++ b/drivers/interconnect/qcom/msm8974.c
@@ -173,65 +173,27 @@ enum {
 	MSM8974_SNOC_SLV_QDSS_STM,
 };
 
-#define to_msm8974_icc_provider(_provider) \
-	container_of(_provider, struct msm8974_icc_provider, provider)
-
-static const struct clk_bulk_data msm8974_icc_bus_clocks[] = {
-	{ .id = "bus" },
-	{ .id = "bus_a" },
-};
-
-/**
- * struct msm8974_icc_provider - Qualcomm specific interconnect provider
- * @provider: generic interconnect provider
- * @bus_clks: the clk_bulk_data table of bus clocks
- * @num_clks: the total number of clk_bulk_data entries
- */
-struct msm8974_icc_provider {
-	struct icc_provider provider;
-	struct clk_bulk_data *bus_clks;
-	int num_clks;
-};
-
-#define MSM8974_ICC_MAX_LINKS	3
-
-/**
- * struct msm8974_icc_node - Qualcomm specific interconnect nodes
- * @name: the node name used in debugfs
- * @id: a unique node identifier
- * @links: an array of nodes where we can go next while traversing
- * @num_links: the total number of @links
- * @buswidth: width of the interconnect between a node and the bus (bytes)
- * @mas_rpm_id:	RPM ID for devices that are bus masters
- * @slv_rpm_id:	RPM ID for devices that are bus slaves
- * @rate: current bus clock rate in Hz
- */
-struct msm8974_icc_node {
-	unsigned char *name;
-	u16 id;
-	u16 links[MSM8974_ICC_MAX_LINKS];
-	u16 num_links;
-	u16 buswidth;
-	int mas_rpm_id;
-	int slv_rpm_id;
-	u64 rate;
-};
+static int msm8974_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
+{
+	*avg = 0;
+	*peak = 0;
 
-struct msm8974_icc_desc {
-	struct msm8974_icc_node * const *nodes;
-	size_t num_nodes;
+	return 0;
 };
 
 #define DEFINE_QNODE(_name, _id, _buswidth, _mas_rpm_id, _slv_rpm_id,	\
 		     ...)						\
-		static struct msm8974_icc_node _name = {		\
+		static const u16 _name ## _links[] = {			\
+			__VA_ARGS__					\
+		};							\
+		static struct qcom_icc_node _name = {			\
 		.name = #_name,						\
 		.id = _id,						\
 		.buswidth = _buswidth,					\
 		.mas_rpm_id = _mas_rpm_id,				\
 		.slv_rpm_id = _slv_rpm_id,				\
-		.num_links = COUNT_ARGS(__VA_ARGS__),			\
-		.links = { __VA_ARGS__ },				\
+		.num_links = ARRAY_SIZE(_name ## _links),		\
+		.links = _name ## _links,				\
 	}
 
 DEFINE_QNODE(mas_ampss_m0, MSM8974_BIMC_MAS_AMPSS_M0, 8, 0, -1);
@@ -242,7 +204,7 @@ DEFINE_QNODE(bimc_to_snoc, MSM8974_BIMC_TO_SNOC, 8, 3, 2, MSM8974_SNOC_TO_BIMC,
 DEFINE_QNODE(slv_ebi_ch0, MSM8974_BIMC_SLV_EBI_CH0, 8, -1, 0);
 DEFINE_QNODE(slv_ampss_l2, MSM8974_BIMC_SLV_AMPSS_L2, 8, -1, 1);
 
-static struct msm8974_icc_node * const msm8974_bimc_nodes[] = {
+static struct qcom_icc_node * const msm8974_bimc_nodes[] = {
 	[BIMC_MAS_AMPSS_M0] = &mas_ampss_m0,
 	[BIMC_MAS_AMPSS_M1] = &mas_ampss_m1,
 	[BIMC_MAS_MSS_PROC] = &mas_mss_proc,
@@ -252,9 +214,12 @@ static struct msm8974_icc_node * const msm8974_bimc_nodes[] = {
 	[BIMC_SLV_AMPSS_L2] = &slv_ampss_l2,
 };
 
-static const struct msm8974_icc_desc msm8974_bimc = {
+static const struct qcom_icc_desc msm8974_bimc = {
 	.nodes = msm8974_bimc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_bimc_nodes),
+	.bus_clk_desc = &bimc_clk,
+	.get_bw = msm8974_get_bw,
+	.ignore_enxio = true,
 };
 
 DEFINE_QNODE(mas_rpm_inst, MSM8974_CNOC_MAS_RPM_INST, 8, 45, -1);
@@ -295,7 +260,7 @@ DEFINE_QNODE(slv_ebi1_phy_cfg, MSM8974_CNOC_SLV_EBI1_PHY_CFG, 8, -1, 73);
 DEFINE_QNODE(slv_rpm, MSM8974_CNOC_SLV_RPM, 8, -1, 74);
 DEFINE_QNODE(slv_service_cnoc, MSM8974_CNOC_SLV_SERVICE_CNOC, 8, -1, 76);
 
-static struct msm8974_icc_node * const msm8974_cnoc_nodes[] = {
+static struct qcom_icc_node * const msm8974_cnoc_nodes[] = {
 	[CNOC_MAS_RPM_INST] = &mas_rpm_inst,
 	[CNOC_MAS_RPM_DATA] = &mas_rpm_data,
 	[CNOC_MAS_RPM_SYS] = &mas_rpm_sys,
@@ -335,9 +300,12 @@ static struct msm8974_icc_node * const msm8974_cnoc_nodes[] = {
 	[CNOC_SLV_SERVICE_CNOC] = &slv_service_cnoc,
 };
 
-static const struct msm8974_icc_desc msm8974_cnoc = {
+static const struct qcom_icc_desc msm8974_cnoc = {
 	.nodes = msm8974_cnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_cnoc_nodes),
+	.bus_clk_desc = &bus_2_clk,
+	.get_bw = msm8974_get_bw,
+	.ignore_enxio = true,
 };
 
 DEFINE_QNODE(mas_graphics_3d, MSM8974_MNOC_MAS_GRAPHICS_3D, 16, 6, -1, MSM8974_MNOC_TO_BIMC);
@@ -363,7 +331,7 @@ DEFINE_QNODE(slv_mnoc_mpu_cfg, MSM8974_MNOC_SLV_MNOC_MPU_CFG, 16, -1, 14);
 DEFINE_QNODE(slv_onoc_mpu_cfg, MSM8974_MNOC_SLV_ONOC_MPU_CFG, 16, -1, 15);
 DEFINE_QNODE(slv_service_mnoc, MSM8974_MNOC_SLV_SERVICE_MNOC, 16, -1, 17);
 
-static struct msm8974_icc_node * const msm8974_mnoc_nodes[] = {
+static struct qcom_icc_node * const msm8974_mnoc_nodes[] = {
 	[MNOC_MAS_GRAPHICS_3D] = &mas_graphics_3d,
 	[MNOC_MAS_JPEG] = &mas_jpeg,
 	[MNOC_MAS_MDP_PORT0] = &mas_mdp_port0,
@@ -388,9 +356,11 @@ static struct msm8974_icc_node * const msm8974_mnoc_nodes[] = {
 	[MNOC_SLV_SERVICE_MNOC] = &slv_service_mnoc,
 };
 
-static const struct msm8974_icc_desc msm8974_mnoc = {
+static const struct qcom_icc_desc msm8974_mnoc = {
 	.nodes = msm8974_mnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_mnoc_nodes),
+	.get_bw = msm8974_get_bw,
+	.ignore_enxio = true,
 };
 
 DEFINE_QNODE(ocmem_noc_to_ocmem_vnoc, MSM8974_OCMEM_NOC_TO_OCMEM_VNOC, 16, 54, 78, MSM8974_OCMEM_SLV_OCMEM);
@@ -408,7 +378,7 @@ DEFINE_QNODE(ocmem_vnoc_to_onoc, MSM8974_OCMEM_VNOC_TO_OCMEM_NOC, 16, 56, 79, MS
 DEFINE_QNODE(ocmem_vnoc_to_snoc, MSM8974_OCMEM_VNOC_TO_SNOC, 8, 57, 80);
 DEFINE_QNODE(mas_v_ocmem_gfx3d, MSM8974_OCMEM_VNOC_MAS_GFX3D, 8, 55, -1, MSM8974_OCMEM_VNOC_TO_OCMEM_NOC);
 
-static struct msm8974_icc_node * const msm8974_onoc_nodes[] = {
+static struct qcom_icc_node * const msm8974_onoc_nodes[] = {
 	[OCMEM_NOC_TO_OCMEM_VNOC] = &ocmem_noc_to_ocmem_vnoc,
 	[OCMEM_MAS_JPEG_OCMEM] = &mas_jpeg_ocmem,
 	[OCMEM_MAS_MDP_OCMEM] = &mas_mdp_ocmem,
@@ -423,9 +393,12 @@ static struct msm8974_icc_node * const msm8974_onoc_nodes[] = {
 	[OCMEM_SLV_OCMEM] = &slv_ocmem,
 };
 
-static const struct msm8974_icc_desc msm8974_onoc = {
+static const struct qcom_icc_desc msm8974_onoc = {
 	.nodes = msm8974_onoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_onoc_nodes),
+	.bus_clk_desc = &gpu_mem_2_clk,
+	.get_bw = msm8974_get_bw,
+	.ignore_enxio = true,
 };
 
 DEFINE_QNODE(mas_pnoc_cfg, MSM8974_PNOC_MAS_PNOC_CFG, 8, 43, -1);
@@ -456,7 +429,7 @@ DEFINE_QNODE(slv_pnoc_mpu_cfg, MSM8974_PNOC_SLV_PNOC_MPU_CFG, 8, -1, 43);
 DEFINE_QNODE(slv_prng, MSM8974_PNOC_SLV_PRNG, 8, -1, 44, MSM8974_PNOC_TO_SNOC);
 DEFINE_QNODE(slv_service_pnoc, MSM8974_PNOC_SLV_SERVICE_PNOC, 8, -1, 46);
 
-static struct msm8974_icc_node * const msm8974_pnoc_nodes[] = {
+static struct qcom_icc_node * const msm8974_pnoc_nodes[] = {
 	[PNOC_MAS_PNOC_CFG] = &mas_pnoc_cfg,
 	[PNOC_MAS_SDCC_1] = &mas_sdcc_1,
 	[PNOC_MAS_SDCC_3] = &mas_sdcc_3,
@@ -486,9 +459,13 @@ static struct msm8974_icc_node * const msm8974_pnoc_nodes[] = {
 	[PNOC_SLV_SERVICE_PNOC] = &slv_service_pnoc,
 };
 
-static const struct msm8974_icc_desc msm8974_pnoc = {
+static const struct qcom_icc_desc msm8974_pnoc = {
 	.nodes = msm8974_pnoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_pnoc_nodes),
+	.bus_clk_desc = &bus_0_clk,
+	.get_bw = msm8974_get_bw,
+	.keep_alive = true,
+	.ignore_enxio = true,
 };
 
 DEFINE_QNODE(mas_lpass_ahb, MSM8974_SNOC_MAS_LPASS_AHB, 8, 18, -1);
@@ -516,7 +493,7 @@ DEFINE_QNODE(slv_snoc_ocmem, MSM8974_SNOC_SLV_SNOC_OCMEM, 8, -1, 27);
 DEFINE_QNODE(slv_service_snoc, MSM8974_SNOC_SLV_SERVICE_SNOC, 8, -1, 29);
 DEFINE_QNODE(slv_qdss_stm, MSM8974_SNOC_SLV_QDSS_STM, 8, -1, 30);
 
-static struct msm8974_icc_node * const msm8974_snoc_nodes[] = {
+static struct qcom_icc_node * const msm8974_snoc_nodes[] = {
 	[SNOC_MAS_LPASS_AHB] = &mas_lpass_ahb,
 	[SNOC_MAS_QDSS_BAM] = &mas_qdss_bam,
 	[SNOC_MAS_SNOC_CFG] = &mas_snoc_cfg,
@@ -543,209 +520,14 @@ static struct msm8974_icc_node * const msm8974_snoc_nodes[] = {
 	[SNOC_SLV_QDSS_STM] = &slv_qdss_stm,
 };
 
-static const struct msm8974_icc_desc msm8974_snoc = {
+static const struct qcom_icc_desc msm8974_snoc = {
 	.nodes = msm8974_snoc_nodes,
 	.num_nodes = ARRAY_SIZE(msm8974_snoc_nodes),
+	.bus_clk_desc = &bus_1_clk,
+	.get_bw = msm8974_get_bw,
+	.ignore_enxio = true,
 };
 
-static void msm8974_icc_rpm_smd_send(struct device *dev, int rsc_type,
-				     char *name, int id, u64 val)
-{
-	int ret;
-
-	if (id == -1)
-		return;
-
-	/*
-	 * Setting the bandwidth requests for some nodes fails and this same
-	 * behavior occurs on the downstream MSM 3.4 kernel sources based on
-	 * errors like this in that kernel:
-	 *
-	 *   msm_rpm_get_error_from_ack(): RPM NACK Unsupported resource
-	 *   AXI: msm_bus_rpm_req(): RPM: Ack failed
-	 *   AXI: msm_bus_rpm_commit_arb(): RPM: Req fail: mas:32, bw:240000000
-	 *
-	 * Since there's no publicly available documentation for this hardware,
-	 * and the bandwidth for some nodes in the path can be set properly,
-	 * let's not return an error.
-	 */
-	ret = qcom_icc_rpm_smd_send(QCOM_SMD_RPM_ACTIVE_STATE, rsc_type, id,
-				    val);
-	if (ret)
-		dev_dbg(dev, "Cannot set bandwidth for node %s (%d): %d\n",
-			name, id, ret);
-}
-
-static int msm8974_icc_set(struct icc_node *src, struct icc_node *dst)
-{
-	struct msm8974_icc_node *src_qn, *dst_qn;
-	struct msm8974_icc_provider *qp;
-	u64 sum_bw, max_peak_bw, rate;
-	u32 agg_avg = 0, agg_peak = 0;
-	struct icc_provider *provider;
-	struct icc_node *n;
-	int ret, i;
-
-	src_qn = src->data;
-	dst_qn = dst->data;
-	provider = src->provider;
-	qp = to_msm8974_icc_provider(provider);
-
-	list_for_each_entry(n, &provider->nodes, node_list)
-		provider->aggregate(n, 0, n->avg_bw, n->peak_bw,
-				    &agg_avg, &agg_peak);
-
-	sum_bw = icc_units_to_bps(agg_avg);
-	max_peak_bw = icc_units_to_bps(agg_peak);
-
-	/* Set bandwidth on source node */
-	msm8974_icc_rpm_smd_send(provider->dev, RPM_BUS_MASTER_REQ,
-				 src_qn->name, src_qn->mas_rpm_id, sum_bw);
-
-	msm8974_icc_rpm_smd_send(provider->dev, RPM_BUS_SLAVE_REQ,
-				 src_qn->name, src_qn->slv_rpm_id, sum_bw);
-
-	/* Set bandwidth on destination node */
-	msm8974_icc_rpm_smd_send(provider->dev, RPM_BUS_MASTER_REQ,
-				 dst_qn->name, dst_qn->mas_rpm_id, sum_bw);
-
-	msm8974_icc_rpm_smd_send(provider->dev, RPM_BUS_SLAVE_REQ,
-				 dst_qn->name, dst_qn->slv_rpm_id, sum_bw);
-
-	rate = max(sum_bw, max_peak_bw);
-
-	do_div(rate, src_qn->buswidth);
-
-	rate = min_t(u32, rate, INT_MAX);
-
-	if (src_qn->rate == rate)
-		return 0;
-
-	for (i = 0; i < qp->num_clks; i++) {
-		ret = clk_set_rate(qp->bus_clks[i].clk, rate);
-		if (ret) {
-			dev_err(provider->dev, "%s clk_set_rate error: %d\n",
-				qp->bus_clks[i].id, ret);
-			ret = 0;
-		}
-	}
-
-	src_qn->rate = rate;
-
-	return 0;
-}
-
-static int msm8974_get_bw(struct icc_node *node, u32 *avg, u32 *peak)
-{
-	*avg = 0;
-	*peak = 0;
-
-	return 0;
-}
-
-static int msm8974_icc_probe(struct platform_device *pdev)
-{
-	const struct msm8974_icc_desc *desc;
-	struct msm8974_icc_node * const *qnodes;
-	struct msm8974_icc_provider *qp;
-	struct device *dev = &pdev->dev;
-	struct icc_onecell_data *data;
-	struct icc_provider *provider;
-	struct icc_node *node;
-	size_t num_nodes, i;
-	int ret;
-
-	/* wait for the RPM proxy */
-	if (!qcom_icc_rpm_smd_available())
-		return -EPROBE_DEFER;
-
-	desc = of_device_get_match_data(dev);
-	if (!desc)
-		return -EINVAL;
-
-	qnodes = desc->nodes;
-	num_nodes = desc->num_nodes;
-
-	qp = devm_kzalloc(dev, sizeof(*qp), GFP_KERNEL);
-	if (!qp)
-		return -ENOMEM;
-
-	data = devm_kzalloc(dev, struct_size(data, nodes, num_nodes),
-			    GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-	data->num_nodes = num_nodes;
-
-	qp->bus_clks = devm_kmemdup(dev, msm8974_icc_bus_clocks,
-				    sizeof(msm8974_icc_bus_clocks), GFP_KERNEL);
-	if (!qp->bus_clks)
-		return -ENOMEM;
-
-	qp->num_clks = ARRAY_SIZE(msm8974_icc_bus_clocks);
-	ret = devm_clk_bulk_get(dev, qp->num_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	ret = clk_bulk_prepare_enable(qp->num_clks, qp->bus_clks);
-	if (ret)
-		return ret;
-
-	provider = &qp->provider;
-	provider->dev = dev;
-	provider->set = msm8974_icc_set;
-	provider->aggregate = icc_std_aggregate;
-	provider->xlate = of_icc_xlate_onecell;
-	provider->data = data;
-	provider->get_bw = msm8974_get_bw;
-
-	icc_provider_init(provider);
-
-	for (i = 0; i < num_nodes; i++) {
-		size_t j;
-
-		node = icc_node_create(qnodes[i]->id);
-		if (IS_ERR(node)) {
-			ret = PTR_ERR(node);
-			goto err_remove_nodes;
-		}
-
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
-		icc_node_add(node, provider);
-
-		dev_dbg(dev, "registered node %s\n", node->name);
-
-		/* populate links */
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
-
-		data->nodes[i] = node;
-	}
-
-	ret = icc_provider_register(provider);
-	if (ret)
-		goto err_remove_nodes;
-
-	platform_set_drvdata(pdev, qp);
-
-	return 0;
-
-err_remove_nodes:
-	icc_nodes_remove(provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-
-	return ret;
-}
-
-static void msm8974_icc_remove(struct platform_device *pdev)
-{
-	struct msm8974_icc_provider *qp = platform_get_drvdata(pdev);
-
-	icc_provider_deregister(&qp->provider);
-	icc_nodes_remove(&qp->provider);
-	clk_bulk_disable_unprepare(qp->num_clks, qp->bus_clks);
-}
-
 static const struct of_device_id msm8974_noc_of_match[] = {
 	{ .compatible = "qcom,msm8974-bimc", .data = &msm8974_bimc},
 	{ .compatible = "qcom,msm8974-cnoc", .data = &msm8974_cnoc},
@@ -758,8 +540,8 @@ static const struct of_device_id msm8974_noc_of_match[] = {
 MODULE_DEVICE_TABLE(of, msm8974_noc_of_match);
 
 static struct platform_driver msm8974_noc_driver = {
-	.probe = msm8974_icc_probe,
-	.remove = msm8974_icc_remove,
+	.probe = qnoc_probe,
+	.remove = qnoc_remove,
 	.driver = {
 		.name = "qnoc-msm8974",
 		.of_match_table = msm8974_noc_of_match,

-- 
2.47.3

