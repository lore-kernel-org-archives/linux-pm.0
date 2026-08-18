Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A643E3DA7
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052937; cv=none; b=B1HAUkJRqfUCfQpNeFxOWAqOK9jdJHJWaWqEx5JQt9eK/GbpnzwvX4WAm/9FdP63VdJOIS6ZFFEQwzL3HT0ehK7PhVetLcn7IrzY+RmqoFzvcvYdf9w/owYgL8P0Fpib+rkFTlToriW4h/UabbiXpq6Cqw4QV7ID4cQUY7ZjbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052937; c=relaxed/simple;
	bh=TpPOJof160ltRBLWJr0jlr9nnADjc4wHTWbNe8Y0zdU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bLL9+NmsAFczAdLpTfOizT8qaY4wBV6bd3jRCPKdzNr0BcUC0FxR0LsKb5Y/HMEYGO2fep43AM7WC02OM9lKFO5a1ZnWUJgUAT+LywOatc8bgsqK77VP6/SJMaOYTvZdOn90oock6xwBggmtbprCbLMkDViZ2Sj8K0Y8a/5DWV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+PH8/EF; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hA6c6Qq4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+PH8/EF";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hA6c6Qq4"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IABal51336395
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=AwA/4o7QPcTU4D+pY4LaeM
	NZRNXCB3JtEwnZ07J7IIg=; b=k+PH8/EFrBgTLHWvXW2Oq3QJHpvFT6rWI4cMSx
	eiodLbAP3nnJjd7B0CBF01u/+T2APFQsSsdweItkK+L7jIEdC9OsInZmvUfQMlG9
	+S25NsJfLm9AntfQ4zDFll9jx4DVyO4tiv1enIeRNhI8y4TQiSWzhcfIODojoTF8
	5cKFgcYEsY7fFUuT8Io1oKsgGd8TE+jTCzgyL9eYMJ0moI1RdaHlMY0zk4YqbRMy
	fEGQFi+jkmSx2OQioI+ERpL8IVroZUu0NT3Oq0AMaEyavQkPBt0pufx55DyIqUBm
	PiZgJYIjNk6I2DMo3PkReh9w4t3k88OK/HeHzwMcElZODtYA==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4fvp1tja-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 11:35:35 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-9349c5af52bso750651785a.0
        for <linux-pm@vger.kernel.org>; Tue, 18 Aug 2026 04:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787052935; x=1787657735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AwA/4o7QPcTU4D+pY4LaeMNZRNXCB3JtEwnZ07J7IIg=;
        b=hA6c6Qq482G0vmNFuePBIfYF29KA7ZHFVkP6gmlmaeroTVz4joKZInTQV54M5Y6aDU
         bKWDDj/RZ3gbghkSLJX8ojcSk0RAOASKEXtu/aAaBF9xCgA3c4y6slH0Fmj08hMjXVGr
         FUiPvTiAuwOZv+lfq+1apOYcYgMyUXm+KevokZkoY/fUAbbf6dgl941IyEvjpo7a6yvx
         27ZoTzX8+TEwYrvv3QPHZiDyYVjQjxMRbEQdT4Kkflh48+1Q+QkRoTNIpUM/hEBHubbe
         aeZVICb+LP+6QGliurJsgqbJIuwtj7JQLN0Ma4rVJRw6rIflzZQWITgXvYc1DrJJ0RSq
         pAIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052935; x=1787657735;
        h=content-transfer-encoding:content-type:subject:from:cc:to
         :content-language:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AwA/4o7QPcTU4D+pY4LaeMNZRNXCB3JtEwnZ07J7IIg=;
        b=NitsSbilinEN7Rg04j38u1tYXwi8JF76CLE/NbnywWAwogIr5+B6SZau9Ak7AOtOgY
         e94kD1jVbbre8jJgWcsx/hOrMcspCXWFNceXYbS7fFjqzub9guOPe4nJf9w95V7XqXyz
         QFlRVcvBxzBiMoidQcGMNB8RDTzGMw6rWlrRMFGqdC83NkBmnHO48/F4WtykpZuy+osN
         j/AC3sNsaVxTOWZFSPdHQgGGELdNlabMfPtNhRd7hWaIJaM6Apl/UxisdWw7d1o4RBSU
         tDbAJmwGa6a2nNDj5xFuSS2ni9ChQVwV21l4pYyGK2yKVB7toBnzGgsM0N/p/eea/oOs
         xFJQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp/bqXn19rBsX8j2uID7N9JtOtrB2LABjzwY331TnG9C3pY8BJxQOGb3RLNRD1NCWA+u7hl2Eh3Nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrQ+M8m7ofmc0fgNHsL52RpiojL7gUzaM/kP6DdiJoV3a+gOM8
	INfHDlElgHeuIqrJyw9k8/7NsIt/neRzia/aol6f8NIDZ0OmbXADZsKSimZJc6lw/9mr0eBtO69
	ydqm40F4ULbQKkjIWpU62hLOEODdptWGof3JcV+4YslDmwEZjjbZvmsLjZdn5JA==
X-Gm-Gg: AR+sD11uoxAo010U2LcYQjT7QteW8vW7ulOuZWPqUhxJMZd4PCkhrDtVpWH0i9qXZ6m
	a7G1wNl1COdXBfVJOqYNqrlUZOaulGz+MfDOwr2M9EU28SPQK+0Ny9tQ4WeZs0z8WLkb8t8+enL
	lvRb4SrH0bjgqeD4Mgx2DQcO0Q9ZiwXZ2dgxeYtyMhvDVyiye4viWBEX6ce6czG1oOG+6WagFuk
	9kF+KUtCWcq1cN+eN3E3lFELA5jlPKaV0U5icNgmihCc+lN1iZsc2o534gy3Hd8lQwq3tgihF0L
	PTWVv5jmam13T90ScSfGgBsEM0tU/nUJ1NiplmSMZZm9e76paOORK8BCw11JJzefr538R8iVUpY
	Oh1qbKFOcECdO/UYYQoDM7Kj97jNB5XCvHZE6AP2THKzrc88c2mz9JDnJAzPp
X-Received: by 2002:a05:620a:6646:b0:92a:d10e:bddf with SMTP id af79cd13be357-936d2142e63mr2493364085a.4.1787052934911;
        Tue, 18 Aug 2026 04:35:34 -0700 (PDT)
X-Received: by 2002:a05:620a:6646:b0:92a:d10e:bddf with SMTP id af79cd13be357-936d2142e63mr2493360085a.4.1787052934527;
        Tue, 18 Aug 2026 04:35:34 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7469:ae7:2b43:7ef3? ([2a05:6e02:1041:c10:7469:ae7:2b43:7ef3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b783basm11740408f8f.30.2026.08.18.04.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 04:35:33 -0700 (PDT)
Message-ID: <8bc7b131-891c-445e-8084-1f7e4a11d272@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 13:35:32 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Lukasz Luba <Lukasz.Luba@arm.com>, Zhang Rui <rui.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM mailing list <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: [GIT PULL] [resend] thermal drivers fixes for v7.3-rc1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: QHbFmaVep9D8JvZt6ZcWwFGlWvVNUDxl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX6Hp9mkaXtlGM
 70SR04kf8HkgtSIXN5m9D+dNXWezQvnGB+Ef0VnkKl/LzSPWChXFR24RrpRJolyxU1pva/2u4IS
 iNSOaQlvdbiHB95UaDmvq8o8E0KFofiNCwIu2lc62/bedZik23cICwK6+8nfuvmljGLk5/Gf/Ey
 GU1n+zMyGtfsXLQjJVn8B/KJw29knpuNBKrkVJ9PhmNa92zLexIiR3I5NJQQjwC4E9/FscdBC6P
 kbQf2wq3P3IdGyNmLhsRKaYF0jC7LuByVa5pyO/6+2nFAvEEw6LdYJ49XTLpUGH1tb83SryLCSS
 IqUxtne5t9yas+eCWqfUjMCvvhxDxZ8+fsUpnWhofFFJt2W4lPL8CPQnFRpbjQy83mAOHDEEPDK
 Xi4GlQSdf9YkNreIKs0O/GeG2ixVYgXCpwRXBjq8RMPwMeQqWvPlResAraFxYCRmK77tYoiQ+/E
 LOl8S5xvXdii+6CB2Dw==
X-Authority-Analysis: v=2.4 cv=K/IS2SWI c=1 sm=1 tr=0 ts=6a844387 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=u1sppcH8U0u73v3hj_AA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDA4NSBTYWx0ZWRfX5aVGeeC6Nsbn
 L7XLPQUTsRHSPtM4Q/J8WZWkhyMJB1yT6DmbF001A0NhdwZTO1A3ipOOE5j3SHl1FllQuTWPl2n
 UrJvg7AxEnfscIN+nH/fdzZZZVCnkgw=
X-Proofpoint-GUID: QHbFmaVep9D8JvZt6ZcWwFGlWvVNUDxl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180085

Hi Rafael,

Hopefully this time everything is fine :/

"Fixes" tags have been fixed.

Please consider the following changes since commit 
ccda015d76736dc5ccefc70a040b9304a6c2000f:

   Merge tag 'thermal-v7.3-rc1' of 
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux 
(2026-08-10 12:53:41 +0200)

are available in the Git repository at:

  
ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git 
tags/thermal-v7.3-rc1-fixes

for you to fetch changes up to b115930d716defc3a7daa2bc2ae2465d864b7114:

   thermal/drivers/armada: Fix missing bitfields include (2026-08-18 
13:09:22 +0200)

----------------------------------------------------------------
- Fix missing bitfield include headers in Armada and QCom SPM BMG
   drivers (Daniel Lezcano)

- Fix missed file when manually applying a change after a conflict
   resolution for the QCom SPMI ADC TM5 Gen3 (Daniel Lezcano)

----------------------------------------------------------------
Daniel Lezcano (2):
       thermal/drivers/qcom/spm mbg tm: Fix missing bitfield header
       thermal/drivers/armada: Fix missing bitfields include

Jishnu Prakash (1):
       thermal/drivers/qcom: Fix missing spmi adc tm5 gen3 file

  drivers/thermal/armada_thermal.c              |   1 +
  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 
++++++++++++++++++++++++++
  drivers/thermal/qcom/qcom-spmi-mbg-tm.c       |   2 +-
  3 files changed, 436 insertions(+), 1 deletion(-)
  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
