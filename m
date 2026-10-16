Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC693379ED6
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 08:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792140580; cv=none; b=aQZw5N2YNE5rp3JLrhP65pSVi4peKzpU+oLI/nKB639xkoBk5UTXmUbxDRTqOH4aTXW/xk5hBU4k1YkP8NELYL0Ix8graf5HP99XdfLBBEsnYMprwE9nM97Vv7gta1Gxy7cbfhGubfmMdDxXNJaKdczBkIrQWqI9QXSn0iM9ofQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792140580; c=relaxed/simple;
	bh=LV+tsjLIUEHEBxSJw3wNQTx+6xef7y2FTS1D05i/6N8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nmstxis8OFzGjCTXvXtcRkP/Je2ApjbWsEHXWuK3BzO6ZryFfHvqwihAAz2D07DnDi0/jdMZ4nEq1mnRHsUoPWlpVwvSIpmqW3uM9QH9yRfiR8NhBssL/cq08EvJ9iHqsUpy5itaGRRNfB+9Nl287WRlW6BlS1W6G4ZL2aE7E1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YfEJdmQq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=cqcm66Zq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YfEJdmQq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cqcm66Zq"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G8lJMS303555
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 08:49:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Ae9/W8idpRqilFnmg657Xc
	PTn01x9W+1TIzNRFLZYiY=; b=YfEJdmQqpLgjHu/zz2JCn+LtaGl9N0NK3frYcZ
	RDtbQvaPfZdJlLiF5BKczIHag/7NU3tAAiMMIImRsQhaQcSxJ+Q3iU0nl4W3JOwm
	RMVcOPo7SiLRst3NNRSd/E5kypzJUUi/9gB0M9I7BENIdz09I2dV+Gw1rdKMNaHr
	YOUc3FHqUIpOa9hxtSfzgVjaeTENCta+g8R4D1s+4pITvzSwTmIA7lHKf1bpFiaw
	rQSk3KBlW+7Gmcd6T2mGmWNNPj32ke54Tcs+0l+6isBZkCYTWqFOMd7uh6Eatb25
	nK9vvkyLoZjG1mz7UOBjHqBveQTUu4/N8UcLxs25NpMna2WQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbcjt90sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 08:49:38 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93cc40759b2so1307033985a.1
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 01:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792140577; x=1792745377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ae9/W8idpRqilFnmg657XcPTn01x9W+1TIzNRFLZYiY=;
        b=cqcm66Zq7HKfDzzy4EHRIfOZgfYX3Zjjme0MzZaNtZl7UJQ24PRZAWMdLj0EWDkQHd
         Gvej7mPiRrBdXV1ub2kJ+wOIO0yYMIJO19cffqou4teoz2gh3n6Y07XrcdHxHnxSSi2g
         Bs8LXPuvlp527AztqYLO3i/m0Mk4ow7sXPIftjy+p0zKO72o1Ejn/dl25KHQw7cKwoHU
         4ulNiedMun7dpRmB3RIfnHrKtZiTr/Ay7K0Wrf2Tfp7cEyRCw5xNF4zklUtAEyOh2Qqc
         qbPxBhA8nxfkL8d3pHzShVTk44/1A79EDbQc/WT8QIoS98dn+9yg5keYn4opiYWfG55+
         MA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792140577; x=1792745377;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ae9/W8idpRqilFnmg657XcPTn01x9W+1TIzNRFLZYiY=;
        b=IWm6hNBVwzupEf1zZyey5XGzOWXR2LVadVrYIk+G1GjS9PVrsxzlQImHzMQOJJA33U
         ALsQ/el7S1u57QK318GpykOK/DRKjXpd+5z5gpk1581H2GGoQIC57FZO6pd7mjwPkFst
         9QmvoSn0htSowQPwIQ7TmhyQlniUMpXt7oT1SSLb4t5e4ezEyrVyJ7/8cJ9MlKFP4ED1
         l8ILaIVb3A/QgGbzPNmiIvy0KtudHGXcYtEzKRS2UB2MGxFD1kY7wV8XcDbDUlNFg2LJ
         rwHN2bZyTh0RsHD3BkqAbsCGbspoSxp3w4PdFMEw7x7ciu/PBR6yhxu6KFW1iJ8by1lN
         WP2g==
X-Gm-Message-State: AFq9FYJNJm+Al6O+ofgpsoFLsmGWWb2FeZCWyqlPo9+WmSeW7j0Av75L
	27OKfZ//snUKjg+rSJ0oBFN46u6BgVSDvu+YPB7XVwyWBFvpGfLlz7+Eb954OiSUFwuPKEKTpva
	MxEhm6AY0nBTwDZMEcE32JfHMeBZN94SvorVkDqAHp7bfqPlq9uZlPAh9k/dZ6RgYIVw+sw==
X-Gm-Gg: AYBFou13CsJlNMAIR4r83CrcFhsuM92Pi8JldPbnr2X1TcGaqoFnE+sVnpWhd2XJTfk
	q93e1EX5Lt5vyp2jtm4M3k2qrn+7anVwHI5prBQWbvjz2PcNd++qXZg5OgtP2S3GUW3kKJwgkED
	RC1eMairh4pw+SGNlYvEE4fkn99mvu3m+0oeGa3fnsaTTORHQJxHDOg+1EELFWBjasCM1Jf8Z0p
	nmM5wU2HsByUYzj7tsRIPyf9TL/WXy4brqEvzBzzFjv9D3LG0MGW7CadadEk/Cn2ExekAbqfwdb
	S7MdD5/fhX+6/Zz+C4TYn9UOSPk7IT0RtHkV42IX+xiPNWTRzi79oZIPMS07VdHsU54FlelKs7l
	Dr7ywKy4buJ9Az72/1vrogS5ADjM=
X-Received: by 2002:a05:620a:628d:b0:93f:1dbf:6cfc with SMTP id af79cd13be357-93f1dbf7018mr123107885a.36.1792140577099;
        Fri, 16 Oct 2026 01:49:37 -0700 (PDT)
X-Received: by 2002:a05:620a:628d:b0:93f:1dbf:6cfc with SMTP id af79cd13be357-93f1dbf7018mr123107185a.36.1792140576712;
        Fri, 16 Oct 2026 01:49:36 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd50d1bcsm3649332f8f.54.2026.10.16.01.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 01:49:35 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [GIT PULL] power sequencing fixes for v7.3
Date: Fri, 16 Oct 2026 10:49:32 +0200
Message-ID: <20261016084933.39924-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX95L4RsI+PSZQ
 JowY0EyT7raEv8jIm8XTpiib8OJ81xAeBynYrM4LXlHoo/OIs1q8CRAOOSMHXbFkw9khE+Jddix
 brYXGOQvLxFvmWskk7xNETQdkl3FCc7XcvoZjKeaGaRkUyIhEetOyPSWsneVOD2hXGgkY/AEDCr
 jQyEyL2uK9uBxn22CZUc/lcQDYE/KTimY9+6VCGisZw0AhY6/chedi2rdgy8S8XdqDmsizz7v4u
 0FVaoXr95nr5rjdQI2wW3xMhvvbL/mjqO4m3ajmiMusBmDqeGdw5oU1+qzS4AXmRHROeQePVGnR
 7mAlXvzVG9kYS/EvPyuv7WfhdMEgEgy8YmZ5gEZaZ34UJhu5AX26IIqYt26LR5AhVCqSzlPO/EZ
 DspDou8U3ug4AslKrlK8/DAopzJ3XWlAOpe7InwdIcu6tr0F+I2KFdus09KUv35Xg/DWM+9jjjb
 3Ona8j+yVQ3/cF3RXRw==
X-Proofpoint-ORIG-GUID: bINhkDoRo6pbFl9fbkHpqFs2rpZGWLlS
X-Proofpoint-GUID: bINhkDoRo6pbFl9fbkHpqFs2rpZGWLlS
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX6JbKY39Zt7DT
 1Mk+vyxhJhbES7S5kAaR67QZpj7sp48LLCeM7ixqE/0lF1vg/U72PBOTCfgcMatUIeQDL963Jr9
 WKEQNjdmmLaK6GGqsbnRB2vixwxn0v4=
X-Authority-Analysis: v=2.4 cv=VpS2kO2n c=1 sm=1 tr=0 ts=6ad1e522 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=i_sB5PnZ_mCEERRZbpYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610160034

Linus,

Please pull one final power sequencing fix for this cycle. It removes
a workaround for a PCI core issue that was since fixed and the workaround
started causing problems instead.

Thanks,
Bartosz

The following changes since commit 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907:

  Linux 7.3-rc7 (2026-10-11 20:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/pwrseq-fixes-for-v7.3

for you to fetch changes up to dbd674ccf30f66f5eccf637964a93910df8dbf84:

  power: sequencing: qcom-wcn: power off WLAN at probe (2026-10-12 15:36:07 +0200)

----------------------------------------------------------------
power sequencing fixes for v7.3

- with the PCIe code reworked to power the endpoint via pwrctl before it
  starts the link training, we can now remove the workaround for WLAN
  power which instead started causing an issue with endpoint enumeration

----------------------------------------------------------------
François Roux (1):
      power: sequencing: qcom-wcn: power off WLAN at probe

 drivers/power/sequencing/pwrseq-qcom-wcn.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)
