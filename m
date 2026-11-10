Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312081;
	b=hf8vuzVJC40a7Rog4474bIrkpOsmRf12aDCKI6acO5vZmY5txkLqlE9WWob+zZneS74R
	 sVPhubzTpdbd6in0KMj7TIHaTE6kI0A6eZEmIRz12xXOENvya8xgAei1aSpgfVpb49TnF
	 wXW9LDA7Z7l8j63oEqfw+pLNN613XI621bDjF4NF3waQBgMY2mwTZIleJuGSNKJsaVxwJ
	 tAs/sdlGwd7VdYyjVm6BBkhAr3vpkQDAvOvuDiYPw/xI9T77J/5bl5v3/GL4DlprExpnA
	 cWGamgs3+WLZtJTyVL/AmOy5NkBFHXOan2rlLIE2qMufKT0eW4798NmC7tsYXkfpYyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312081;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+ivyhI3wFnjLJj5MrhIqbJpO551dowsyiUiy2aYJmX0=;
	b=iFYPlRZZk/FbhMBYmGXJu4Xf3G1+uVWvAelZP+kZZhM73ckWt2xEtXbNdWA41Xci9a0H
	 CQLDJHtgkxjhVy0q78fSA9sSAx1XpM21BZ7WOIRZPW+N6zpHXqMWNwNPu3oFt6pfTFQuf
	 mMaC5U+fkwkRrOlpgHXbcQwTyV6zb9yGUMPp1XmH9CSUZMQf6wZ5pfDJ4XK6g3T97J1J6
	 Gc+rzk2M+4giv52zByHZwG0Z9PxjaM4OnqcliMjRi0qyk5gHBBxQqyrX7CUxLLbNXcgl2
	 rebI4uSMmDA9hH4QR3u4c+arptwsRGIUM3WSKM+K/5Ts3nLaq8/rSk7h78Ki0HhPaXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="KYFQ/o2M";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="C3W/+ZM8";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55149606A337
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55149606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KYFQ/o2M;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=C3W/+ZM8
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AAB9tBh2253399
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+ivyhI3wFnjLJj5MrhIqbJpO551dowsyiUiy2aYJmX0=; b=KYFQ/o2MMIr1RdWY
	FUUiMBa0do2xwoS7/vJbrjRGH1FBOR0BZ1UNBAAI0+h2XJ6TR26I6M9T7LJ7HerU
	Gy/Mh2rvHHWdjyRnb+p8v+d5UsGr+Eip1shpBxpv5Ea3ZZ5+VbMB7NVvTGaF4tpY
	FO0ihg7hIHedNyoOQp/e+VrNFOWE3YAa0k20GMLL47sDyGgsJh1c3NzuscgVqff0
	MvkgCRLdLJFxFA+/hOWcAVoNw1G7gdJbJT/l9kggxSiryz+k3oalpLCmaJgp419A
	Ag6dcD0+IHmQ2YDEBnNXYrfbmpLb7+I1653XoqWeqCXxeyOdGnXlEDXFPZHos1YL
	QHKe9g==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huyw48q10-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:20 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5ee0977403bso1315757e0c.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 04:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794312078; x=1794916878; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ivyhI3wFnjLJj5MrhIqbJpO551dowsyiUiy2aYJmX0=;
        b=C3W/+ZM8cTwwlM0oh4T5P0kP7DhzhaugBTl7YAngv8Uos3uNXGRRgmyjR4LsZLuaIt
         KBbLwLMQ1x/XNRFUCBVevXDAEurNPKraOx1B5tBsXBM9YidfyT3IjFVBau5RkbBkF+a+
         K6akQRy51VtZ4Nj2lJpuSjk+GGMZCjHuOnGJUL5HxVN1SyMXShuMWW+aasDOf0tJP92f
         dyo8L6/DErBjfdEKXRvKqHJEtSeYROcTayMutxrVyvb2N8AhS3w+z/mI9lJSgNGpSZjs
         c54E41q8+/Pn0rVoTuucoN3hOTK9Dl1Fgkvj4wcYNCT1IoZQSifzkytcR/Gx7WeW9AOv
         ayBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312078; x=1794916878;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ivyhI3wFnjLJj5MrhIqbJpO551dowsyiUiy2aYJmX0=;
        b=w97MZKZt2rrGyhg25Xxgy41kWc4QcuLuBIdCintLxuScpbKM8I94YLCP+PFE4h1E4I
         1DbEZdQWi4aXOpFlQDJ1YKrwCuD21qg9LgGF0DvbTNSCsLnuzuLhvFfN7kd0XPnElYxX
         4cQOky/0x4qNH4K6amZlzmvexwPDz550U9jpGmxfPSLrPhM3XLGhiB9YCPgOFgVuFcas
         fJWahCpAIQJVt5NxR1suN7GSkkfv/TszKWhvhwtC3xS+nVvdXctlYbLUZNAmu6DqBg2E
         9SU3bdB1jjsjH7w1RhFJCAig8pPHIJBRnOq0DicKci9lhhzMK+zj3i6n77totZR6yjoX
         6nNg==
X-Gm-Message-State: APuU4Z/jgANaAiVnhmT6P7mWDrVr9FQiYqNU4eg5fFv34kMYXNczn7W2
	h0K3VrjQws5t41aC/R4SugmeQLNHuDj0HiYgFWzfQaLY34FG4EcCaVEawK1svbJeaTEijyGVFbB
	IKcpazA8xUMEseOjOTdJgvjG4EgUBQfT7tnnNHceqZ/FtrSYwphfd1ZpX5a7RssugBaVjsg==
X-Gm-Gg: AYBFou39thkb5R39Nx6TYqUY/Zn4rxb5aim4VoiJh6xcZULUcbeumcGVnLoUa5DQdA5
	0fPEF3RFD0dVNfuJDOPCa1/4IghX7hd+oha5aB8sADLLVWY2E4Efu5pT29w52f8LApvXJxtc+7x
	BZibQYNgBVSmY938VUY7RjNsEGVf4mRJvNpw19VKLwoHfE9xquiO525qsGEXzhFTURPBj5/VkIO
	zsFPirSRe7/V9uo9oJxnrZ3J5qxkH5k8VPp4D6WQK1ty2BjG4rSeUhc60b3QfXQhTi3ieCyAOFh
	snekkzS8v+pUkiaK0zwdw1aVSJlIwSojOV2qXWsUfOzRw3APbhDAVDLDHGkgb1kNlW0e+MBzSR5
	TSlr8v88B0DJikABJDKa2o4AlrS7+va8uZPhWLlJ7lyXuxiDfh4RpIh3J/iSbWdpRfYunSNKzcw
	s0lff4w5FW4Y5cZK/XE8kZpeVNU5Mw/xQA6TFFxjPn3kplx3m0koeXip/8CjWZOYi7imsEOijmB
	sq6zgUIOgFZN61PSNlOMVjOZO8=
X-Received: by 2002:a05:6122:511:b0:5ec:d84e:3833 with SMTP id 71dfb90a1353d-5ee0d16f2e3mr729569e0c.14.1794312077751;
        Tue, 10 Nov 2026 04:01:17 -0800 (PST)
X-Received: by 2002:a05:6122:511:b0:5ec:d84e:3833 with SMTP id 71dfb90a1353d-5ee0d16f2e3mr729530e0c.14.1794312077191;
        Tue, 10 Nov 2026 04:01:17 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:a91e:6b1:bddc:2951])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2cb2sm56820295e9.3.2026.11.10.04.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:01:14 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Tue, 10 Nov 2026 13:01:09 +0100
Subject: [PATCH v2 2/2] PM: clk: Release the clock prepare reference across
 runtime suspend
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-clk-leak-v2-2-d044cf0c3f1d@oss.qualcomm.com>
References: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com>
In-Reply-To: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX3aZmKXRxZ79z
 xBizM3u2UPFbN011Puy523S6RtRI4XZnYf2J5qDFwbGO6FxmcSTiaEr5ygGkmyETJZZfsrJ19oP
 uixcq8jBrf2De7FOmuQrLlDLyxZ/mrEuilCJuVceDI6zigsUzO5eyxxaym6AFYYw0Tg2Y+Fr7Ux
 lnmqjN4kVtpAf0rwgDP90n1dYLyZu6BXIGubR07rCnQ3PfPG130VSiBe9typ/1Y9KbAZlIP9Uun
 y+za7hQm1/3ULd+XbrTwbm7ZWbq54etMudv2o95xYKPsz8MFuBL7uHguq/W+f6sS9rYZkA1M+Lm
 ckcIKShA9MHu+PObOPtjPOeVVw7WPjIqpYBrk59MfeBrPpXk3J57uI/1HaVYDOZJADwzmoxYpW6
 hO1RNdplZWfBQ6pqCYFr4aJdsQtfAhDJx2eakYp+jBaGCpGX610qv313fr66QZLwMaAcM6gREu5
 iil+O9LVDg68pvv9QWQ==
X-Authority-Analysis: v=2.4 cv=Ee1d0/mC c=1 sm=1 tr=0 ts=6af30790 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=PTOVzwXgyN4xjwbCXrMA:9 a=QEXdDO2ut3YA:10 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX8TjbTCyqM6yj
 J2onU3yvhnkQZDttKsyIifiYaecGrs9WlYLAeYFt6ETv01KQHcUpQaX4QtjtWNIEajOrRb/kfVc
 fTKo+YYrGSxkrsbmMUTynMj0Uf1R9iw=
X-Proofpoint-GUID: UGsiCpcxZauSCar3yDr-vFLKknNBHz3E
X-Proofpoint-ORIG-GUID: UGsiCpcxZauSCar3yDr-vFLKknNBHz3E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100047

The PM clock layer prepares a clock at acquire time and keeps that
reference until the entry is removed, pm_clk_suspend() only dropping
the enable reference. A prepare reference propagates to the parents
though, so a clock with enable/disable ops can keep an ancestor that
only implements prepare/unprepare running for as long as the device
exists. On Qualcomm platforms this keeps the RPM XO clock active
across runtime and system suspend even though all of its consumers
are suspended.

Unprepare on suspend for devices that are not IRQ-safe, as those
suspend in process context, and let the next pm_clk_resume() prepare
the clock again. This generalises the clk_is_enabled_when_prepared()
check in pm_clk_acquire(), which only considers the clock itself and
not its parents. Most drivers managing their own clocks already
unprepare in runtime suspend: 245 call sites under drivers/ against
27 that only disable.

Reported-by: Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/base/power/clock_ops.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
index 6f66e11a12428fb718abca197f5519b1ee21ff90..43150ecb58add7783d8602d525219c676fd808fe 100644
--- a/drivers/base/power/clock_ops.c
+++ b/drivers/base/power/clock_ops.c
@@ -33,7 +33,6 @@ struct pm_clock_entry {
 	char *con_id;
 	struct clk *clk;
 	enum pce_status status;
-	bool enabled_when_prepared;
 };
 
 /**
@@ -174,9 +173,11 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
 		ce->status = PCE_STATUS_ERROR;
 		return;
 	} else if (clk_is_enabled_when_prepared(ce->clk)) {
-		/* we defer preparing the clock in that case */
+		/*
+		 * Preparing the clock would also start it, so defer that to
+		 * the first pm_clk_resume().
+		 */
 		ce->status = PCE_STATUS_ACQUIRED;
-		ce->enabled_when_prepared = true;
 	} else if (clk_prepare(ce->clk)) {
 		ce->status = PCE_STATUS_ERROR;
 		dev_err(dev, "clk_prepare() failed\n");
@@ -460,6 +461,7 @@ EXPORT_SYMBOL_GPL(devm_pm_clk_create);
 int pm_clk_suspend(struct device *dev)
 {
 	struct pm_subsys_data *psd = dev_to_psd(dev);
+	bool sleepable = !pm_runtime_is_irq_safe(dev);
 	struct pm_clock_entry *ce;
 	unsigned long flags;
 
@@ -472,7 +474,7 @@ int pm_clk_suspend(struct device *dev)
 
 	list_for_each_entry_reverse(ce, &psd->clock_list, node) {
 		if (ce->status == PCE_STATUS_ENABLED) {
-			if (ce->enabled_when_prepared) {
+			if (sleepable) {
 				clk_disable_unprepare(ce->clk);
 				ce->status = PCE_STATUS_ACQUIRED;
 			} else {

-- 
2.34.1

