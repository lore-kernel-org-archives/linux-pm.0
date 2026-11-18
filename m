Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795018616;
	b=mJZ0co67f0lBIHgg72rGvAog1A29G6fdHPJuyhPWV+tBuSlvq6/LldlZ62vLVhCiOFkJ
	 BQQoTTpukAJMrA+y1w79JSZKfEoJrLZ0QdUXwWbRp/KegwIMqUKvmpYI166CGaQSZpCw2
	 d4W+50pMfvcsZDDa4S/G7cXqE8Kgu+zBBlTAYM79RddpH901fLXdwKeQnNE5BewanXDvu
	 6S3NPElI98KRUl4RojJPR54dDHuYLSebBmuh41GkZ3+ADA07aUsYSnXt8pvRUM7TJFhlZ
	 +CC9vNqSApk0ZD0AtA1Qrij10GQQ1xOi4WI2blEgZ6HiVWFFm/3A2ZzWYD1ckD3LXKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795018616;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=iTvIF9xRP0uN+SwNc6JxvB4VOROFp75+Uu1hHT20jpo=;
	b=4tMpfg8xV15NohMG21dJVhdeqsiNLKd/vmVGfEBz9yQxjReV2Xi13b6jsAhMCRPRVHNs
	 s79mn2+5dP+aqkmb2tmrXTlG3QP6z93YV+GfJ7EXULTH355N7zzTq6M30kq1slXJ1wCWO
	 D5XnprpS+JEm5XcSzMnDuQ+YUw718Fggnu3J7gD2GyoYU2oQXZTmx4YX2R2NtWDDumaYQ
	 XbIxPbRjgMtk4ppTI5HMq7KHwidaz5ruS0ejeRcIlSRxNAaPKZvFZ5N+lXN+Q5KMaBLJW
	 SnauPnoh/7tmw6pi419S/R8mRk//QyKAUJV+xj9U5ypZqDcOx0lsjiPy57Z7+HfhIyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpSRxbv0;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hgZ4sIRf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B852B606A31C
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B852B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TpSRxbv0;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hgZ4sIRf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AIDQIPG376882
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iTvIF9xRP0uN+SwNc6JxvB4VOROFp75+Uu1
	hHT20jpo=; b=TpSRxbv09hrbhgSonNLCOwk+MS7oGBadtVKM++L5ec7fAptEewo
	FVMTMTrDhoTtW2NO/4/YK82Ee7wiUbgSNcNz18h0t6fSQNKunnJ4dIp7e4O2NYBY
	37CN4Ry7FGuR8yn8tNVfevW5+Rwng9zBK7p2u4aZZOz51PJZcPeETcbsCFas/pDl
	hw5KRSFr7naDwvmfU8M9AghqD2YREEwyNfoDBaEQGVwCOYC6MzKftNhbrbLd0hSJ
	gfrIa6dnATeR1c2dRNHaaxRU6rb7rqwyIXZOaSxH/+E5UV+HelYZ+ceIjwH5Jaxu
	8KooB8qHBkMqfsf2w+VxT+og4RlV1MLXaEA==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9kxcf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 16:16:54 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eac41ff334so923544e0c.0
        for <linux-pm@vger.kernel.org>; Wed, 18 Nov 2026 08:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795018614; x=1795623414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iTvIF9xRP0uN+SwNc6JxvB4VOROFp75+Uu1hHT20jpo=;
        b=hgZ4sIRfBCwSHTx4j/uBdCdsZhRz72SlokZWFttgo5b9sTsgmArW2vxE7g+CtHhk2I
         U3GB5n6TXSei90JfLb1TEY9/t4Qt5xYzARXNIe7YwLpk7+JGldGLDApFMUHNfKBnQU3X
         EDx2g0HFWqjeflLMWfG840C9rYXXrGmjm7bIMqk1GEUs22+tHWU6L8vQ/AOa9fOMd1JZ
         ZlB3uIsO5yvpfvRBniItymMibsbWjDzg7dQumHlkVGmin4JhmG+UiCkxqXMe2wSvG72G
         n3pCJPQ3ljm2g61eyYDMcTReeEDkgrGV3d19ookQ8zbEKWdZh5Zd4xY+Ykl1bxEx/Arj
         tYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795018614; x=1795623414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iTvIF9xRP0uN+SwNc6JxvB4VOROFp75+Uu1hHT20jpo=;
        b=UuAaaPVmaLhik53rpFzgqlsVoRUXrWjGUs71PNadk0dUUJZeWLbkufDtpNaUhNx6kS
         p8Mi+jUH4V0Ks3vokrmePIFQtSxarWew6pf+88lfIwdo8q7dSoxn3fMAiTcRZorbSNLf
         INsXujjz2bpZ50LOCrk8qfhUXJt1WwgnPoUDqSprsq/yJaGNN1KXFWMdCOpsB6YOAERX
         7HbqWif/W+5uHrDxmobkRmC2KnzXmqbSZDNZVRLP7tMsiMvf0TheeQrO5zkCSpJTGBhq
         GdcIQfD+f3ViLdutJO74jIN36fFla7Y0DyKZqgf9vBeH5DTRthO1xJ34FIHGO9DXZ+7Y
         AVRw==
X-Gm-Message-State: APuU4Z+R9MXf1br8QvfRac42yj5DUwxqZ890M+qtlPz/xzm4h2uhkFJE
	BX+WDcMpcfqqM/1SHTI5FZ4f0JEHb4SkkCPoA9+rngOV73V4jvjd6trwvEKKp+hIuCJ73PUpLSD
	Y4IZEjMOiMLzRgEVgAwvm9NyVodsx9Sag720icedArXvk26dpHkSDSyoYK/TOfQ==
X-Gm-Gg: AYBFou0r9BYlBHBEr3wzo0oMlhxs6LUgSpZPDjw6toJ2YffLVKBFRWjgtKy8FfV1MO3
	HqB7/8fPIZWXP6tf47461ynRxwK3nhLLYPGRrmWDBm4P2jYwkcky9r48PLY0sKptLoOGAO2d29G
	mKxJncF0sXo+oO96Y2x2nm6scVJ+gWJ113nAn55dBVRc8zc0fb7PEKv1pRIjtWJz22QuOQLmT7V
	i+MLHuh198MqVI4AG10RBwx7LmpDwc+P5Hji8F9+vZmSFglmG+GTZITAXwbjp/pIVere1cRyX6p
	ftLtFhlUmqLyXajI4/sWYy9Yk0/V47oRjB5JDmWhZ8IRrHHUwaV3jtM2Dy2WbxUvu08NuxScwuz
	OtIesV+r4NSFuxCpKDi1J6CQhxBYnwPQ7Ptn4OeO8B3Zez4ldBPSGKbiI4gPrEPoLMskcPRSzBE
	ji
X-Received: by 2002:a05:6122:1d48:b0:5ea:d2fa:c2e6 with SMTP id 71dfb90a1353d-5ee646fe5e0mr1635602e0c.14.1795018613864;
        Wed, 18 Nov 2026 08:16:53 -0800 (PST)
X-Received: by 2002:a05:6122:1d48:b0:5ea:d2fa:c2e6 with SMTP id 71dfb90a1353d-5ee646fe5e0mr1635579e0c.14.1795018613364;
        Wed, 18 Nov 2026 08:16:53 -0800 (PST)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:d355:fe70:14a0:ac8d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb78418853sm217090495e9.8.2026.11.18.08.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 08:16:52 -0800 (PST)
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org, tglx@linutronix.de
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Bradley Morgan <brads@mainlining.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH RESEND v2 0/2] powercap: idle_inject: Create threads on demand
Date: Wed, 18 Nov 2026 17:15:25 +0100
Message-ID: <cover.1794992905.git.daniel.lezcano@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yWeH6nW6aFkU-giT5TqFMWhOYK_VbNwG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX5o7urYlsZQan
 oY382ilC00Z7+KYcvEeM5C0n2Vo7EZMgtLxdDRgMzZ/Ijp/PmYUNtSMRUmno3a5SKqv2mUrYIko
 mF8wjRCV0K2ycm5mJktgZJNsf6dJeVA=
X-Proofpoint-ORIG-GUID: yWeH6nW6aFkU-giT5TqFMWhOYK_VbNwG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2NCBTYWx0ZWRfX4U9EZMcgxqK9
 mCNyCOMHP3GGAyL6De+7Nvo43AlrfNlrUHK3gWbYELGrVM6C6uBrBKHmrQ9rx/ebgvCRynokb2I
 a9eWoJsr62JJDhOcEMvWSqIcg6ilsJmA/AB9yGcsXgxjAmZE8eavWKmCi2jlwihLlbZPamGKjdu
 Cu/vFFhz7otnstP3QAaAgmOjpva6jPDFvAx6pZA+q/5JKGm1gtoR2hDFigHjDYDLNAk7EPsM8LS
 OgCpqAYs9Pcwh5oIjPK0EDE8jUKUr9v+0pcwCbZz0HIv/IilxGGO8iuR/kYKcieBrOhv5SfVkld
 8A2B1A6LBSCpCAG3+s+5htsU4xF2yygn6btO4WJY///lBM9FnoJg7XylEDJOve9AbXPy/DO7Qk8
 LHmmAdZWmj78Yqd+y/vSTM2YwCehCrCt7IFMJVjOK0fmo0y/lcFZXIba7Q/5LJeFDkmDLw0Y4dM
 A3elRnuwcIFG5ASUxmg==
X-Authority-Analysis: v=2.4 cv=RYIFmFtv c=1 sm=1 tr=0 ts=6afdcf76 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=zJRp6_cAMcgA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=OuZLqq7tAAAA:8
 a=x1L0ys6JoTQEvF2T-JwA:9 a=hhpmQAJR8DioWGSBphRh:22 a=HkZW87K1Qel5hWWM3VKY:22
 a=AKGiAy9iJ-JzxKVHQNES:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180064

Idle injection currently registers per-CPU kernel threads during early
initialization, including on CPUs for which no idle injection device
will be registered.

This series makes thread creation follow the lifetime and CPU mask of
each idle injection device.

The first patch adds an optional CPU mask to smpboot thread descriptors.
The mask restricts thread creation, CPU hotplug handling and teardown,
while preserving the existing behavior for descriptors without a mask.
Registrations sharing task storage are checked for overlapping CPU
masks under smpboot_threads_lock before any threads are created.

The second patch uses this support to register idle injection threads
when a device registers and destroy them when it unregisters. CPU
ownership claims, registration rollback and thread teardown are
serialized to prevent overlapping registrations from sharing threads.

The series was tested on Rockchip RK3588. The updated smpboot code and
idle injection code also build with W=1. Concurrent registration and
CPU hotplug runtime testing remains outstanding.

Changes in v2:
- Reject overlapping smpboot registrations sharing per-CPU task storage
  with WARN_ON_ONCE() and -EBUSY, as suggested by Thomas Gleixner.
- Default a NULL CPU mask to cpu_possible_mask at registration and
  remove redundant NULL-mask checks from the lifecycle helpers.
- Use scoped guards for the smpboot registration locks.
- Document the overlap restriction and registration return values, and
  update the core commit explanation.
- Add Bradley Morgan's Reviewed-by tag to the idle injection patch.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bradley Morgan <brads@mainlining.org>

Daniel Lezcano (2):
  smpboot: Allow restricting per-CPU threads to a CPU mask
  powercap: idle_inject: Create per-CPU threads on registration

 drivers/powercap/idle_inject.c | 69 +++++++++++++++++++++-------------
 include/linux/smpboot.h        |  6 +++
 kernel/smpboot.c               | 45 +++++++++++++++++-----
 3 files changed, 83 insertions(+), 37 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.43.0
