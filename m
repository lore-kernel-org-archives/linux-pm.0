Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD0E515971
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681916; cv=none; b=bvDSR5f+5/8llxSgxFeCXnGpRm8/Av4eLiaexhb1brxGsUPVlvZSfntVlJS5EMC73fdB+hC8j5Qm7TRYYFWbT651PyaymWUL04rOPkDLi/DZ8Hmf7CLQ4heuazwxPHfqKyovnO33u5HXoPNzcJ5NfBAQ1f83kTCOR1/v+RYEE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681916; c=relaxed/simple;
	bh=7JDEwZlYg8XjCuVnYsnKF2kSPqk9OomdJ+3Kd/nIeBs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=K5nN+j5HZBtHAtqHmm43Nodb8VyFnXSc+Jjg3716EYEyz2dcZcPo1UyX/Y/WrRTw8uQakNarElv9T2CONSBISB4s92YrzvYr7VxCCLgqx4gsELxJfprrkpM/uhbC3NzaEu+z1c9UfKdXVADnoFAGmna3O6e3KP3svx3RiJn7A2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hAWsyXEb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Inb5nIQS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hAWsyXEb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Inb5nIQS"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TAjDRQ736413
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5nbPD22Jbh6I0nCcqKz0VI
	PeO0cIL1IMQ0/m7y2jQ90=; b=hAWsyXEb7RIpElqN22JRYzn5Nod22BZ5uprMAD
	SPXUarnmTjFdY7qHs1aaTPic7Eysv9CsE+WnfG9h29Yi07wDFt7X0aEoPi7nfK18
	kjXSuuqcjbF/gTjFOINbWd9N6PWtgAuYFmX5D0B1SPCvNA9RqkAfMg18Oi7DLrJ1
	AE6GRM8IdpImSFbYWYwEZ6i92WuGBFUKhgtyxw2ZbZ43pJLqKpe1N7pkca/VXzt5
	JHuLo1SExDnPZieqD++XPwh0e2b2hjDd523Lnrej8Y4dnaSoD5y8gVyCwt8Rj5rr
	13/BClru+cJLFhn7E7ztRvkzdrY/5kb/2/wTVs9c3x0+8tVg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h05yxhr1a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 11:38:33 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so2719101eec.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 04:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790681912; x=1791286712; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5nbPD22Jbh6I0nCcqKz0VIPeO0cIL1IMQ0/m7y2jQ90=;
        b=Inb5nIQSzRAd8EPRHAUq0WPPRbeY9XUxZfpOzEYV4a2yUW1fkMGHPqaXB3st/m5t2x
         N1DtKIaUnwrFa/T+9B8nyF93XYaN3i0So5efjlpQSocg2FPeN6TDJApHdULhCAYAofmB
         wzBCpfVy+t2BEPYFzWXiFtl7op0r1oQuZRTbeJ54+IMJ1BmIkQEK/FyfUrX1CYAlKS/f
         bNcwYl8vH/kQ7L0lSDWe6o8tqbeTwFqCW4IihOjy2maNniEKEY/HzT51gbKyVRp7ysA4
         lZRbSDiMw3CI867+3/gw4JizhvUfM0XU8uqeENhZhcSYSWijWYdpbBmQ/UH8HPgnb6Cn
         8KmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790681912; x=1791286712;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5nbPD22Jbh6I0nCcqKz0VIPeO0cIL1IMQ0/m7y2jQ90=;
        b=UdJSXIPuZd6OMr1XakN1tTez8sovfR+VvJAjxT7UBi+Su3HLOA92BCWByBLdD0xAfP
         jbXfjCLx533sRLWmf+EMTwbp/RXBjczLDZpSfQrCyDdeR6EBiLaEV8LylOoy9WC+UN5n
         l1f6QHyV2qg0u84uY/B523BHLuciMH+aEBop1OH7jtBNpKEtbwhmzE1g4/T7l84oAxwS
         CLIoKR/xRm8RzPZDV5cYIzep6ePSAycoF5N8WPGia43r1sOI1lZN9nSLYJv8pM5JGagU
         SDq8pNa1tGNYd9KBO5CuNqGndQIcXEdfG+rfyNla6qCHo3Rp/bPYQQUnzNG2WgfQIx6E
         OQbA==
X-Forwarded-Encrypted: i=1; AKwUvBwCxNShmfoQ00NHBXYwd1guUt+KCzU572q1WIhu2qObb4TdHLdoCbnynogQdRCLYfkufkFVvSD9lA==@vger.kernel.org
X-Gm-Message-State: AFq9FYILxIZ7n/9oGTbL71JMTPuMB5xWsSoCg3kBFcVrQwet/KNWXYF3
	dIBBcpW0/8f5XmkSv71LQsOvp1aq3HYIaIVVJ550wZ2wnd7KgOWgYevGhvTHyjsrP+mE56QuCJg
	12ceK7GMywT9g33pj7/eYRI+WUdLkWTSAF4c0odxmRI6xN4Sk3Ls/LwSPRYo5BQ==
X-Gm-Gg: AYBFou0sp/9ETYqQ8JA0HF/IlapQrsuv46yr2Dha22w2McZZilmqmj1HOnUJpjlFPw/
	NZiaTsG8JD/G9z9w6eEnTN2+YlVSD7B78lruThUrluW1LLOATRBWVYLBSwTID3XFT+VZ54ocwYo
	QiLgNDIEkDtgrCVABFyHnOWwT/imVIwxfHi7M9g7uoKUUDfvBtBv+FbjxNHHzcm/0aM0R55ZKpM
	W/GHSLXgoU2KYtaZung/ut9gxOa+K6VuUZrG4d4jgweKN0+1UcFhM0ivyY3TqBaNdxEyo1f8VIz
	JV/Bz9dwzOcl7xJgKd7P/RhUQQXc3DH8fJWlyjzAFXYnKgD/TJLRTnCDHzIlivriSZgWIlxl9t2
	8mHFxS5ALA19tyvu1+YvS8imDwA39kwO1H5AQAumQnRA5nN4ghTAqN4auR8ppcc5ir8gXs2hxnZ
	22Kr/k5x6h2xEyXbU=
X-Received: by 2002:a05:7301:5804:b0:33b:e3c8:a757 with SMTP id 5a478bee46e88-342705b865cmr19524586eec.1.1790681912106;
        Tue, 29 Sep 2026 04:38:32 -0700 (PDT)
X-Received: by 2002:a05:7301:5804:b0:33b:e3c8:a757 with SMTP id 5a478bee46e88-342705b865cmr19524547eec.1.1790681911529;
        Tue, 29 Sep 2026 04:38:31 -0700 (PDT)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34145d0fc9fsm37145604eec.25.2026.09.29.04.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 04:38:31 -0700 (PDT)
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
Subject: [PATCH v3 0/2] sched/cpufreq: fix schedutil's boost frequency
 handling
Date: Tue, 29 Sep 2026 17:08:05 +0530
Message-Id: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB2ju2oC/42OQQ6DIBBFr2JYF4NoFbvqPRoXiKPSKFRGTI3x7
 kW9QDeTvOTlv9kIgtOA5BFtxMGiUVsTIL1FRPXSdEB1E5hwxnMmWEZR9dD4WQ+0thZn2jqYPBi
 10qA3gzYdFZDXLU9FITNJwtDHQau/Z+RVXYy+foOaj+XD6DXO1q3nFws/vCtYMvFPcOGUUX5PE
 y6LJM3L8mkR48nLQdlxjMMh1b7vP21FiVftAAAA
To: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
        linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>,
        Ananthu C V <ananthu.cv@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790681906; l=4900;
 i=ananthu.cv@oss.qualcomm.com; s=20260903; h=from:subject:message-id;
 bh=7JDEwZlYg8XjCuVnYsnKF2kSPqk9OomdJ+3Kd/nIeBs=;
 b=t1huhPnVrum/f6kWecQp5ubUmg+2ETdQrzjbk1l74PU461Nh7oOH1ZX/W4MXjJVbQX7WcX+KF
 2y1r9w7PiS4CO6QlogUUc3sdXfohdqdQkSY89t/uL89eDeO+xYMk1f2
X-Developer-Key: i=ananthu.cv@oss.qualcomm.com; a=ed25519;
 pk=gutNfLSMVTRkB+MxVviMFq9I07C5qPe9xHY2J5XCMpo=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfXz7EO9jnO1Kpb
 EXt5rwBqcvLmPqRwzqPpUOW2XZU+PG7EMgZUaZ/0UEEEjDqHPC6qVN2JGaEu442L17oTMUjBApp
 thMK9gNLTyhTm10sJ2J8/guQEUiTe6U=
X-Proofpoint-GUID: G4IwtQY5MAObdFI1NFgRhcckQE3tpMLQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0NiBTYWx0ZWRfX8GxTiBUH46oO
 HlnNmkdsGW8Y+0jhq4K7dl/4PCQQczv9rIiFh8Ae3haEdCebA9dkKJOp9XH4+hk1PhxFjEfY3Tq
 quyh5EkhlP7gCtiQgmCYThyNIpRXhNK+JZD0AUJ7qJitI0dXg/JvJn0bc9wLJIeJW0tvm4lO7un
 geQUWayFfTMmPHVnbAF+XMxsnh+lNMmR/sC60XtHbCmRwtrkFmGTDJTdqvt32FZWkU7ThPdwpt3
 UiLHPikoVsxIF+jTvXHXRFbcn14Kus4dfMiAJMJcw8UY3RgImwFXIGrsUooKZHkS8Go4GxCHULk
 ByhWfhVg7+D2fzZbUPe51cG0Zy5UZp9rUKLMnTvTXJKfiG8323xUKsL2x1Byqhzv0B+QPMbn1NE
 ODhYzZv0DgNCf44zKpJEbTGKhdKefrdyS7zevgjWFCM7vjoJUtVGZ/rtRhnK0dfDu/QhjfQ0l4N
 UazjTYc0IPEFE/dNR1Q==
X-Proofpoint-ORIG-GUID: G4IwtQY5MAObdFI1NFgRhcckQE3tpMLQ
X-Authority-Analysis: v=2.4 cv=SaFi5fRu c=1 sm=1 tr=0 ts=6abba339 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=ag1SF4gXAAAA:8
 a=BTeA3XvPAAAA:8 a=7CQSdrXTAAAA:8 a=QyXUC8HyAAAA:8 a=pGLkceISAAAA:8
 a=qyfCnS17RIpad1FwrgoA:9 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
 a=cvBusfyB2V15izCimMoJ:22 a=Yupwre4RP9_Eg_Bd0iYG:22 a=tafbbOV3vt1XuEhzTjGK:22
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609290046

Schedutil's ability to reach boost frequencies depends on two values
being correct: policy max, which caps the resolved target frequency,
and the per-CPU capacity frequency reference, which anchors the
utilization-to-frequency mapping.

This series fixes a few gaps in how these values are maintained across
boost transitions:

The per-CPU capacity frequency reference is set once at policy
creation and never updated when boost is enabled afterwards, leaving
schedutil unable to target boost frequencies even at full utilization.
Introduce a helper cpufreq_frequency_table_max tp retrieve the highest
value listed in the frequency table and use the higher of it and cpuinfo
max_freq to seed capacity freq ref, letting it know the highest available
frequency from policy creation.

The generic boost callback only raises cpuinfo max, never lowers it.
Once boost is enabled, disabling it leaves cpuinfo max pinned at the
boost ceiling, keeping policy max stuck there too. Track the max
available non-boost frequency and use this in conjunction with the the
highest frequency retrieved from the table with cpufreq_frequency_table_max
to control boost frequencies when boost  frequenies are available, allowing
the frequency to drop back to non boost values on boost disable. In
the absence of boost frequencies, the handling will fall back to using
cpuinfo->max_freq, preserving the current behaviour.

Oleg Keri tested the v2 on Lenovo Yoga Slim 7x Gen 11 and provided Tested-by,
but it is not picked up because of the implementation changes in v3.

Logs below for clear context:
Intermediate values from the time_in_state output and logs from bench
runs are truncated for brevity.

Before fix
----------
\# cd /sys/devices/system/cpu/cpufreq/
\# ls
boost  policy0  policy12  policy6
\# cat boost 
0
\# cat policy6/scaling_max_freq 
4454400
\# echo 1 > boost
\# cat policy6/scaling_max_freq 
4723200
\# echo 0 > boost
\# cat policy6/scaling_max_freq
4723200

\# echo 1 > boost
\# cat policy6/stats/time_in_state 
355200 36958
4454400 650
4588800 0
4723200 0
\# 

After fix
---------
\# cd /sys/devices/system/cpu/cpufreq/
\# ls
boost  policy0  policy12  policy6
\# cat boost 
0
\# cat policy6/scaling_max_freq 
4454400
\# echo 1 > boost 
\# cat policy6/scaling_max_freq 
4723200
\# echo 0 > policy6/boost 
\# cat policy6/scaling_max_freq 
4454400

\# cat policy6/boost 
0
\# cat policy6/stats/time_in_state 
355200 40147
4454400 79
4588800 0
4723200 0
\# echo 1 > policy6/boost 
\# cat policy6/stats/time_in_state 
355200 44834
4454400 93
4588800 25
4723200 569

To: Vincent Guittot <vincent.guittot@linaro.org>
To: Sudeep Holla <sudeep.holla@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rafael J. Wysocki <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Viresh Kumar <viresh.kumar@linaro.org>
To: Jie Zhan <zhanjie9@hisilicon.com>
To: Pierre Gondois <pierre.gondois@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: driver-core@lists.linux.dev
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Oleg Keri <okerixx@gmail.com>
Signed-off-by: Ananthu C V <ananthu.cv@oss.qualcomm.com>

Changes in v3:
  - dropped max_table_freq field and added cpuinfo_frequency_table_max function to retrieve max
    available freq instead
  - changed the condition in policy_st_boost for not relying in cpuinfo max_freq to be whether
    boost frequencies are available, instead of whether a freq table is present.
  - changed fixes tag for second patch to Fixes: db80ad776cd2 ("cpufreq: Remove driver default
    policy->min/max init") - thanks to Zhongqiu Han for the checks and suggestions
  - Link to v2: https://lore.kernel.org/r/20260908-schedutil-boost-frequency-handling-v2-0-25312a713699@oss.qualcomm.com

Changes in v2:
  - introduced max_table_freq/max_base_freq fields in cpufreq policy struct to use for seeding
    capacity freq ref and handle frequency switching during boost cycling.
  - does not try to update get_next_freq or drop the one way guard in cpufreq_frequency_table_cpuinfo
    anymore
  - Link to v1: https://lore.kernel.org/all/20260806044230.909961-1-sibi.sankar@oss.qualcomm.com/

---
Ananthu C V (2):
      arch_topology: seed capacity_freq_ref with highest available frequency
      cpufreq: fix policy max not returning to non-boost freq on boost disable

 drivers/base/arch_topology.c |  3 ++-
 drivers/cpufreq/cpufreq.c    | 16 +++++++++++++++-
 drivers/cpufreq/freq_table.c |  9 ++++++++-
 include/linux/cpufreq.h      | 16 ++++++++++++++++
 4 files changed, 41 insertions(+), 3 deletions(-)
---
base-commit: a8c591ed6b672915e0be57843f943a2a723aff40
change-id: 20260804-schedutil-boost-frequency-handling-8e6bf2387a4a

Best regards,
-- 
Ananthu C V <ananthu.cv@oss.qualcomm.com>

