Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254CB4F93AE
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790061133; cv=none; b=lc4M08W+QDYf5lp+65q/Qy+y9slrawo1TZQIU8ejYVNCaJDy+cHaDizmUM24RSXykvN5aQPU+mxh2ivXvauZC6J82IY/K1aR9SiujeUc3yxGX9i98eaeUAxdnAPOWF60yGFPXWl2QxDp+Wj+U/ShgDLD81pn/IHJje8uDaf3aj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790061133; c=relaxed/simple;
	bh=amoJdgWWQbLSjgNmiV7HrTvLXx4hLFbbl9R1KQVVgCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TugvXmahrSJTqbrCxWgQ4weseNNCvGk0Z/EpnJGkAz9siqkZ3F0LGCo8D5zo/IYZoEar4tstWfUhJSQYzpIhcR+R56HhgAc1/Ei7Uy1kV17EuG/nAmqA8ctSxcDPpvtedbFh2qmt4DN/iGcu4TAmfBPZ1OWgq4a5c1PMmvmnWeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NQb403SJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MbbpT+XF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NQb403SJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MbbpT+XF"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68M76cYn1978521
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:12:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GBJ/0UkEEEvMLYROxOxDAaLG
	rY7JF+jywo60Cz099dY=; b=NQb403SJqmiKwKE/JUh6oPtdgV+QMg9zmNqoVEyN
	V1hcWpMr6jU9xZ73yeOtZF+OntFgRNL3/OMi/j3a2x6gw80f54DAKkid3GSCWnlR
	nhF0+3W4Tl6UhyZSG/zxcWmqM2ggXRvf3rpzSbBuySIAtnJWWqsDD2JZmHZBMGGZ
	6N4wVwAaFugWb5LCQL5fvvdBaL672tWr0FF1sbc6VUJZzwPHF+RUHgBhYvhjbl91
	t7yMaV6TCBDcszc+pgyg3MsH6PsCM3WG9oKD5t9CXNR6KUoFmTtOAONOYcAux2YW
	PWFoMA5s9B6yduJcgAhz3mVjBJUTm/WNgiYnr2hRIGH1Lg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0hj26-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 07:12:10 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2dd1631d291so46530815ad.1
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 00:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790061130; x=1790665930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBJ/0UkEEEvMLYROxOxDAaLGrY7JF+jywo60Cz099dY=;
        b=MbbpT+XF+ipjuknJhnYaFgh4anoO5wibmcj2aLqIYsJQEseA8SK2DdlEOEWKQ92HLr
         GNX6zqFv7uxOdE1DPk641btVhv1UGrdzyB7mWiqi301YraowZ6HTaeUcsn60oLpGafRm
         ihriDkltsjqBnc/ZBQW9AIJSMTsbHJYIcP11lpG6O41MfKnM2Tpj3XO3YDDWYWLYGMF1
         BOclE4hPcQeEt5EjtxJcDXps0iWXWfEBBOa0KC48xrQY/GAHnNylAfH9UXJRAjM8D4Dz
         YZ20oNLw8AYjM1pvdGaCD2Ruj5Vmz6UoRfOja6WLFicXAQ7ukYkYVAyBmyNnVK8adeAj
         PjKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790061130; x=1790665930;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBJ/0UkEEEvMLYROxOxDAaLGrY7JF+jywo60Cz099dY=;
        b=rTXIWnSnHnyg2azXDN81zi8n3YXe1396gWL2pZAIZJqXPo+iX065M20msi36ebsEi3
         da94DKYhWTwCmu0l/wzweRt/YOoGLj/ZoFiiYuftusaf2ZSJb47k3T8YH/rRe5CWUapF
         kldhliNV293DrCi2Mg92fbSS3KLO4W+xBFTu5/u8Xghpm206rpk0QZUIRPomq3VWYvQP
         KbxyrvMo+FnlTf5anKl2YxJJt4DSpvIuzJuerXXb8xAkTbXQfczrKiKaDCySW+Irg2/v
         2pJ/ta75MNvwl8ykk/Yyv9LFfaHCbOFhaS055BV9mefPj26OphlbgUV/ibfD99cV2yV0
         1fCA==
X-Forwarded-Encrypted: i=1; AKwUvBxlaEnGs4HgptZ59NGMpYsJLCgsA/uAbLbykv6arDO2TklMYCK3Y01DxYBvGKsn63+HDhQBkrczyw==@vger.kernel.org
X-Gm-Message-State: AFuF++mtcgRrnoxTyKxBr7YwdYWUnvnNPRPyZ6qmR32lTvpzGZfCiLrm
	FoHykdrjd1e/ALbPq3lDIOV0lw2uR82G8AlwnbfW6ItXbjEQhc3ZZRQuv5D39wmBWclgFAfHlZM
	6sUL/1cOknXyZcABDFVbGfuKclZhAW/1drZjAMbkD9jy3QzWIveQVMOPlzvwtuw==
X-Gm-Gg: AYBFou14uhEdPIxCTZGV+vVcJll/X2s7sNsohm8XBrQXSNbFToUBDFDtQaxVUo/V77Y
	AwoJYH2tjIbgl7N5WSZdzRH/92UbbKIStUv2R+0k/oZWE6AZTquApu836/fk7+Dj4S+a9J+uinC
	1lpNYrqm7XbxgexqQClt2LpS65ceP/LgjQHufPi9C1bVQ8OLArJKyZG4RupWqGccES4heH1JoEm
	Jogv5CersuXlXvYIUCIRjSUe0cESBxLwgkkOmBdbN5RlNFrEsvK/FdLowm1R1+xPvnOIbOGYEG+
	NYNkW6WIgMmbsX3aJ7UKf8mbwD6Cd7csAeu/QHh9LbHTqC+tHnCkzvXgalreGDr9UARUifoCyb0
	Fvbf/RqiZSSQNlW/9V8dTbSWxs79wDwRpfSPt5rfAlPM=
X-Received: by 2002:a17:902:ec81:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2df609d455cmr3177335ad.16.1790061130052;
        Tue, 22 Sep 2026 00:12:10 -0700 (PDT)
X-Received: by 2002:a17:902:ec81:b0:2d8:d4ce:9f32 with SMTP id d9443c01a7336-2df609d455cmr3177085ad.16.1790061129514;
        Tue, 22 Sep 2026 00:12:09 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e612ccd46sm3438401eec.18.2026.09.22.00.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 00:12:09 -0700 (PDT)
Date: Tue, 22 Sep 2026 15:12:04 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Georgi Djakov <djakov@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] interconnect: qcom: implement get_bw with rpmh_read
Message-ID: <arIqRNsz8vwxslTI@QCOM-aGQu4IUr3Y>
References: <20260909-topic-sm8x50-icc-read-rpmh-v3-1-2bc65d7b25e5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-sm8x50-icc-read-rpmh-v3-1-2bc65d7b25e5@linaro.org>
X-Proofpoint-ORIG-GUID: 6aCDVP6W0CEBaG9k8HcMrO6S8Xj1uuYN
X-Proofpoint-GUID: 6aCDVP6W0CEBaG9k8HcMrO6S8Xj1uuYN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDEwMSBTYWx0ZWRfX0IqLDLQ+OQlW
 2BVoGRuYIhJxospa9vggZR3hfhvF64ubj2KewXzyrPpsj1wsJl0f8TcDgo0Qt3W+rOrQdrabFjD
 2NhkO7VZcLiwP7UIR4YMCmDQZFK27DCykMWtAn07QurvdHn5jgnTKZP3iZlwkFX8qPTpw/D0JtB
 LijQhM1/qtmtMslD2rwk25zjgTRdm5j2zvenR6b+6aqZnZd7O+u69sfRjvR2AL4bsLO5XW8r/3y
 n675iPOH7GIKPM4F01SaGhDRNirpjVHluEcRA6rXYbHK6xX1mbYAIX768Vr9EYF+VuWcJYyFPZO
 5SCZBteKbmP78XNsK0V6gmgvCuMp8fGZ391FvED3Fg6IvFOGTUfHIz+3waMdPcCfXHdRficGwkn
 ucD8cu8Pr7PA6DHJMbJHoxYPxw4E+CkSILVCuGaiV3bsRPbKAJcHaKT1YZw7qcpl/6fpYYOrMF7
 KvzTHDAw/yzCrDhyCZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDEwMSBTYWx0ZWRfXzx2miycHis+7
 HMVzI+/lXyA9ILUHULuuGj//be3aA435RcQgkiaNW/3HTBwkq38zDBncNxOuSzis72T4DWx6+FR
 N3tZboDaJ4UROF/JQbHEhdm5Qi6iuJE=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab22a4a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=xvi7Oi9V8tZAOkKAYt8A:9
 a=CjuIK1q_8ugA:10 a=324X-CrmTo6CU4MGRt3R:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_07,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220101

On Wed, Sep 09, 2026 at 05:26:29PM +0200, Neil Armstrong wrote:
> Since we can actually read back the APPS rpmh interconnect
> BCM votes we can actually implement the get_bw() callback
> and provide a coherent average and peak bandwidth at probe time.
> 
> The benefits of that are:
> - keep disabled BCMs disabled
> - avoid voting unused BCMs to INT_MAX
> 
> If the interconnects are correctly described for a platform,
> all the required BCMs would be voted to the maximum bandwidth
> until sync_state is reached.
> 
> Since we only get the BCM vote, we need to redistribute
> the vote values to the associated nodes. The initial BCM
> votes are read back at probe time in order to be ready when
> the get_bw() is called when a node is added.
> 
> Tested-by: Georgi Djakov <djakov@kernel.org> #db845c
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

This causes a linux-next regression on Nord platforms. I guess it's more
than just Nord.

[    1.729012] Internal error: synchronous external abort: 0000000096001610 [#1]  SMP
[    1.729014] Modules linked in:
[    1.729019] CPU: 13 UID: 0 PID: 156 Comm: kworker/u75:1 Tainted: G   M                7.3.0-rc4-next-20260921-00010-gb1438d2a2208 #248 PREEMPT(full)
[    1.729196] vreg_l8a_1p8: Setting 1800000-1800000uV
[    1.729375] vreg_s1a_vdd2h_l: Setting 904000-1096000uV
[    1.729553] vreg_s3a_1p8: Setting 1800000-1800000uV
[    1.729733] vreg_s5a_mv: Setting 1328000-1368000uV
[    1.729913] vreg_s6a_vddq_l: Setting 504000-568000uV
[    1.734224] vreg_l3f_vdd1: Setting 1800000-1800000uV
[    1.739052] Tainted: [M]=MACHINE_CHECK
[    1.739052] Hardware name: Qualcomm Technologies, Inc. SA8797P Ride Embedded (DT)
[    1.739053] Workqueue: events_unbound deferred_probe_work_func
[    1.744610] vreg_s7f_lv_sub: Setting 1040000-1136000uV
[    1.749261]
[    1.749262] pstate: 214000c5 (nzCv daIF +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
[    1.749263] pc : regmap_mmio_read32le+0xc/0xa4
[    1.754473] vreg_s8f_vddq_h: Setting 504000-568000uV
[    1.759295] lr : regmap_mmio_read+0x44/0x70
[    1.759297] sp : ffff80008153b9f0
[    1.759298] x29: ffff80008153b9f0 x28: 0000000000000001 x27: ffffd5167fb5c7f0
[    1.875707] x26: ffffd5167fb5c678 x25: 0000000000000000 x24: 0000000000000000
[    1.883040] x23: 0000000001000000 x22: ffff000890e5a800 x21: ffff80008153ba84
[    1.890372] x20: 0000000000057008 x19: ffff00088deff380 x18: 0000000000000000
[    1.897705] x17: 000000000000000c x16: 0000000000000000 x15: 0000000000000018
[    1.905037] x14: 0000000000000000 x13: 7463656e6e6f6372 x12: 65746e692e303030
[    1.912369] x11: ffff8000828f4000 x10: 000000000006c9e8 x9 : 0000000000000004
[    1.919702] x8 : 0101010101010101 x7 : 0000000000000000 x6 : 0000000000000000
[    1.927034] x5 : ffffd5167f1a0678 x4 : 0000000000057008 x3 : 0000000000057008
[    1.934366] x2 : ffffd5167f1a0e4c x1 : 0000000000057008 x0 : ffff8000828d7008
[    1.941699] Call trace:
[    1.944220]  regmap_mmio_read32le+0xc/0xa4 (P)
[    1.948789]  _regmap_bus_reg_read+0x70/0xb0
[    1.953097]  _regmap_read+0x60/0xd8
[    1.956683]  _regmap_update_bits+0xfc/0x14c
[    1.960990]  regmap_update_bits_base+0x64/0x98
[    1.965558]  qcom_icc_rpmh_probe+0x44c/0x540
[    1.969954]  platform_probe+0x5c/0x9c
[    1.973725]  really_probe+0xbc/0x29c
[    1.977409]  __driver_probe_device+0x16c/0x19c
[    1.981977]  driver_probe_device+0x3c/0x114
[    1.986285]  __device_attach_driver+0xb8/0x118
[    1.990853]  bus_for_each_drv+0x88/0xe8
[    1.994796]  __device_attach+0xa0/0x190
[    1.998739]  device_initial_probe+0x50/0x54
[    2.003046]  bus_probe_device+0x38/0xa0
[    2.006989]  deferred_probe_work_func+0x88/0xc0
[    2.011653]  process_one_work+0x180/0x2dc
[    2.015784]  worker_thread+0x184/0x2fc
[    2.019639]  kthread+0x118/0x124
[    2.022959]  ret_from_fork+0x10/0x20
[    2.026647] Code: d65f03c0 f9400000 8b214000 d503201f (b9400000)
[    2.032913] ---[ end trace 0000000000000000 ]---

I sent a fixup as:

https://lore.kernel.org/all/20260922020623.398913-1-shengchao.guo@oss.qualcomm.com/

Shawn
