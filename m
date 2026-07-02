Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F93C374A15
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 06:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782972526; cv=none; b=VnQdjOai39iQMgIOapD6+AlalQ39beE3cyd/tVCGbdekH22r4O2bjcSIjsYbFSEOk7twQdtedO1iHFK38COdL71sStpYh5720PgIUeOAVkalQreeYuEPs9UKdJ+etVilTXjVkqCLQC2ieggqr+QId+wpL7Hu3j0/hGICmaKhVmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782972526; c=relaxed/simple;
	bh=xIzMABhrBVOXS12KhXGxjbw3vGblyslZPLNQnrZtcYM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sZyhnyPFrp3tV/DoRmQLJ6CJYIq1oM835/a6o0uBpSPPA96kIFqjs96jEOGZ10m+Sigx1/dsGNfZYUg2iA/PdC0ynTy/ZY4+XM6fBDSAL6EHTuAWguKbgJqHEPefvgbclSA6OD9IwVFF6FAC020EgNXCgSb73HfpqfCLa2qipF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ni/umDJi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JCI9ZxfK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ni/umDJi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JCI9ZxfK"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6621LBw02920557
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 06:08:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=7LHd9c1QICTgnfClv1h2ci
	DcQzquFOL+HXfQ434Enz0=; b=ni/umDJikvsXP2fL5p5CK9HmBCOcnzezaLQ2Ix
	7RF7AZ1yHiZXMy5MD+00KGaKX5jGodU5EqPGdv0jlGSagO6HQSwhSEozQxb8voUL
	cw1i6A38iHrJjvFN+Z0Pao9eiOjbkupEl48tCUYKimuFJIStf8VWhpxNrhg4iUK+
	608prt42LHzJR/RQQG/vQEIJ6fc1a+WPHoOM7E+K9qU01wKw6VuYeiKEKcq5P+Zx
	ZWKTYpNNA7n53tFtUt4M2xzSUifGN3vwjB+/8nD0nt2PZ5wsM+kn3YwwBS97H0O5
	nqMsGkeRtbh7z9QuvxvU+4W/DTSn8mkHKIQfN9TWkKGx72sQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f53q0bc1s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 06:08:43 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2c9d85160caso3597895ad.1
        for <linux-pm@vger.kernel.org>; Wed, 01 Jul 2026 23:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782972523; x=1783577323; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7LHd9c1QICTgnfClv1h2ciDcQzquFOL+HXfQ434Enz0=;
        b=JCI9ZxfKTVTmeXb2zST0+eqGa5lQ1Wrx//817IW7G7eUiJuroQfBxKFrrWrdW6gH0a
         MW/w6+5B8EnOVq3mxgqkQGk+eUoiTzPzwkcWz3DR6QxIu/Jh9sNLmmku+RZyQSKp8Nbw
         Nd3KZgKR4EBBI2VJPsQk9ksdrbWBE8LtJJZhHPnU4fRqhMtOHEzXxeS/Ok0wxNGVyAgy
         9pytmyNItRSkxjqsCyMOEQU6BxybjuoPEbukTIy68S75n4VeoXGsIqFc4XocEKmRtl2M
         YxCc6D520MRlRyHC85KuG7CRDGaxmj02cBMAQt1ZTEoonovjrcVsJ7sDPQhlxLUU8SPs
         7r4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782972523; x=1783577323;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7LHd9c1QICTgnfClv1h2ciDcQzquFOL+HXfQ434Enz0=;
        b=MOxEE2vCd/Laj4M0D0svWk5y0T/LN2XAeC2pyjneFwDBsDDHYgtEE/Gr40o3CmPuxl
         ydPdcxKk4hK+A3q/BsfMzA3v4FTgMSYeJr++kUwYYpS3yAAzi+IapaM/Sq/ILAV7fO71
         +4qXb7kpi1VyPc/cvbRcH6SiW83G3NbgNl/DPa8Oj2PK6VXm7pa2CCLu7SYRjsdhb2kV
         PXixZ8z7M60tU0mlXPQO8D44ARV+T+kj+qXsD6CkCxziqLA6JU7/BFpYeHRFGu6zJ8EQ
         qdpKiMGC084lwoaopZZZnraEc6PtMiHEErIvHCX8PcF3DPlvQWi4BHEOqH/YOO9usRAa
         qrnQ==
X-Forwarded-Encrypted: i=1; AHgh+RpSZjgOA1umu5V1GcmQR7TmqkfAJBTnSU6pWNzsWcYag4WBc+GQcmzfPhDE7jVqWK5UOYG2wIIN8A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxKyOrfvfXgDpm1qVpGUDCJ+HZvgIvlZ8APa5MWjxnEm0TnP+YF
	7DDXIQL2xLPfEMgsQtzha2fYjN4TtEysT2qneDRs9y+TlWMx//JV+pQiPTsnDjpPCSn5lBiqdYm
	xkjvEYS6fdkxHtNAfo4l7v1x6+A+KZ3ozYhiESnPFtDzt0qqNsusZjMPvUUXGjQ==
X-Gm-Gg: AfdE7ckfzNuMSbOsyUdE1AU16OvhJOSwYgKow+1EFBduWJ0R2KOh+/BIMnIWiLjhntC
	QqVzgbGB5+q2xEPgbdBuqpTbU7n6mH6KW9L83Ds/2nuc87BUmox8cPQ0XaFMZvNG5KW04U9vCaV
	voL1ofsUl48kndr6YCbe7rJGI2He0wcUgScVvWfQNaT4KSkWbr8xGm8rsnQMU+oYFTTb/Ppaj/J
	xxwqu2IpuZsac1oMNDRnwjze1zonupIDBgPp122RhZi1rdonAhI/H4YnLTDipNbZY9JGoF65itq
	DPN0l2h1PIIG7C0hG7s+C1FEZtAwNZ36m7AUjuAoRPF0DbmQlSwvI766QXuo6FzyIAOG70wF5Rr
	Xp4PQc6E8c+cKvq8pyzKbih8RWC9P6gRJFhi+J6DwqFLT
X-Received: by 2002:a17:902:f651:b0:2c9:c913:e214 with SMTP id d9443c01a7336-2ca44a1cdabmr75889335ad.20.1782972522461;
        Wed, 01 Jul 2026 23:08:42 -0700 (PDT)
X-Received: by 2002:a17:902:f651:b0:2c9:c913:e214 with SMTP id d9443c01a7336-2ca44a1cdabmr75889005ad.20.1782972521787;
        Wed, 01 Jul 2026 23:08:41 -0700 (PDT)
Received: from hu-ptalari-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9aa00970sm8176325ad.71.2026.07.01.23.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 23:08:41 -0700 (PDT)
From: Praveen Talari <praveen.talari@oss.qualcomm.com>
Subject: [PATCH 0/4] spi: fix sticky -EINVAL after PM runtime resume
 failure
Date: Thu, 02 Jul 2026 11:38:19 +0530
Message-Id: <20260702-fix_sticky_-einval_after_pm_runtime_api_failure-v1-0-6ddc317011c0@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFMARmoC/yXNTQrCMBBA4auUWRuIoU3Rq4gMMZnoaBtDfopSe
 nejLr/NeytkSkwZjt0KiRbO/AwN+10H9mbClQS7ZlBSaanVIDy/MBe2jzcK4rCYCY0vlDDOmGo
 oPBOayOgNTzWR0ONhdNIMtncSWjUmaonf8XT+O9fLnWz5bmDbPnyJc2STAAAA
X-Change-ID: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0
To: Mark Brown <broonie@kernel.org>, Dilip Kota <dkota@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Girish Mahadevan <girishm@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>, bjorn.andersson@oss.qualcomm.com,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Pavel Machek <pavel@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Douglas Anderson <dianders@chromium.org>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        aniket.randive@oss.qualcomm.com, chandana.chiluveru@oss.qualcomm.com,
        jyothi.seerapu@oss.qualcomm.com, linux-pm@vger.kernel.org,
        driver-core@lists.linux.dev,
        Praveen Talari <praveen.talari@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782972515; l=1503;
 i=praveen.talari@oss.qualcomm.com; s=20251114; h=from:subject:message-id;
 bh=xIzMABhrBVOXS12KhXGxjbw3vGblyslZPLNQnrZtcYM=;
 b=ywxqrVcRff5Xmtckb5XEgw+rGsMHvNYpd6paW5OAHepe0UfyIbHv/NeHi74nUfLY3pdC9uWgU
 9Dw3548w0aSB/xbmjvjovTzWw1Dtz9XBcmHTBFK9X5x278+d8NxNuuO
X-Developer-Key: i=praveen.talari@oss.qualcomm.com; a=ed25519;
 pk=NGK/88fjyHXgfhIKwag7+uIytOmyOypvZ/hDFaYPEss=
X-Authority-Analysis: v=2.4 cv=dtnrzVg4 c=1 sm=1 tr=0 ts=6a46006b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=E9aaBbxYo9AZKUvAECAA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: C1W-BOh5GsXmgcLW0tfw2nK0LvZt5lIT
X-Proofpoint-GUID: C1W-BOh5GsXmgcLW0tfw2nK0LvZt5lIT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX78kIKM4nI8hk
 MJ3RsL0+doQdzTcZG12ijuVDD+gKl82mSdLvfpZ/etcmPMmoB5Elh+aKOR2t499Yf0lzUgQxdXc
 7o8nyXJubYqzXh+9bog88uETATWiAIKkYdiKFYwSooeZBMpUJIXYEwMkxsEi1ILy/XFPcwrLkDP
 O+R0K62WwAR7etzcgCwLJuzOLv4uqb5Hp+GoLRSl5o4xYoZgkNQ72Kfcza8aEkiLwCcQcZUZef+
 T/if625oKAJArZc3/wzH8xXWh/NGYOVuQ43jvasXlD5eNYfoHAWNQCEOlGsntx763H5sWMF39X+
 rK2iGWD5KtE81kQJ/v9eKciLMQ021o6Tqj3KHZPcmpTDQbE9rccYVZLnZeG6w4NQ6xjLZYiRIRR
 d4dSMt2vnhlHBHgeW2XG3iMLpNwOvIZmAnZoMUjqzjKcNaeZYOvQvaPyKdPOlNeB1vMMoVSQ7Hy
 6VRml3HwxemnO1tRwNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDA2MCBTYWx0ZWRfX8LKzYSMUCbb4
 oQa/DCN0m+d8pNNtl8VdeuE5fh8hwsaYFnoQjjBybIrxm/4q5nsxo/mRNq93H/EodkGjBPQ4XQr
 oGVyIGl8qcG+aLSh0HWxP86P4fICbTc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020060

When pm_runtime_get_sync() fails, the RPM core sets power.runtime_error,
causing every subsequent get call to return -EINVAL without attempting
the resume. This makes the controller permanently unusable until rebound,
requiring a driver rebind to recover.

Fixes the missing pm_runtime_set_suspended() calls in the SPI core and
the qcom-geni driver to clear runtime_error on failure, allowing the next
transfer to retry the resume.

Symptoms observed:
    spi_master spi2: Failed to power device: -110
    spi_master spi2: noqueue transfer failed
    geni_spi 988000.spi: Runtime PM usage count underflow!
    spi_master spi2: Failed to power device: -22
    spi_master spi2: noqueue transfer failed

Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>
---
Praveen Talari (4):
      PM: runtime: Clear runtime_error on supplier after failed get_sync
      spi: core: fix sticky -EINVAL after pm_runtime_get_sync() failure
      spi: qcom-geni: Fix missing error check on pm_runtime_get_sync()
      spi: qcom-geni: fix sticky -EINVAL after PM runtime resume failure

 drivers/base/power/runtime.c |  1 +
 drivers/spi/spi-geni-qcom.c  | 18 +++++++++++-------
 drivers/spi/spi.c            |  3 +++
 3 files changed, 15 insertions(+), 7 deletions(-)
---
base-commit: 4e5dfb7c84012007c3c7061126491bbc92d71bf1
change-id: 20260625-fix_sticky_-einval_after_pm_runtime_api_failure-6797d0a5c4d0

Best regards,
--  
Praveen Talari <praveen.talari@oss.qualcomm.com>

