Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312076;
	b=3hplaXPeguFqHNDnPgmiN0wpnk/YAmRPsPIMIr5X4tfFfW5zgW61mSxwZ5P9slkG7Vfm
	 poDrPRBALQxk8m0CVULGoYy2PC4sjyuNzzLf7CaFzqlq9LUAvwQTgGMhbNP4w/vlRSxoE
	 uXtuxuZWltNHaJSUAAKHZeEDVewLc+OOaahEHm6ATi0VuqcyvN6u1vfA4fvuY4CIAqLS0
	 9T3OvQ9G8zszdBaKxVyL7FIbU6YzmCN3tr01k7OvIEXvkxhWVAaD1p6LZ88Rc+U5y5rqo
	 7PpzX2EUnzU0EizAvTeRvDo1tlsVr6Yp4TUVX2VIaQ0M0lO5HmgKJt20fAcZJpVv3gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312076;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=wjHjihWkxK/xBC3DjLG2PqbN08tv/LZZbFWJaPS+3xg=;
	b=oChKNDiNHwj89x+Gp2F7PWIl1W/EDsTDDjHN5ZKf1O0vgyOl4sPW02hELzNdWAaLtvn0
	 gXP+rO3JZ0QuZGCKBnRaONqLksPT/JH0e/44rzH7SyTeUMV8cVhItPmV12bJJi8z/U4Hn
	 5qm+4Kqa2o4Pkf0LizfX3pWw+bIBeur8alOVMccWm6yiFugC41FBmd5HKUe6Zh2dkNgDB
	 WmiAJh4Z5ABbD8cGSh7oqDOCgY7BAfzdokYp4EF8t/WE6FYlQk2b0sMjW8fyDNQXmk6ct
	 KbnAryD6x0xBn2UCQsicPuN3DlHElzFUcyI1uiPpduQGXMZbyraoNDzt9krOQx+boPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sieoqw26;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OPy1LCNc;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42888606A321
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42888606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Sieoqw26;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OPy1LCNc
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AABAG1h2881242
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=wjHjihWkxK/xBC3DjLG2Pq
	bN08tv/LZZbFWJaPS+3xg=; b=Sieoqw26fV7zxgat8ywnjRWoRqGVzwhlOUxFxd
	Zbeatep+dNrwznKYZ1NeXO0oKYGPxqZjFNnr1FypTrXbW2mC15QPshPDKVm0Xjz0
	HuEDOItdecF3VenZXH4MGD5VAOX3NLIz+RAiORmZUvVRbDzv7l7RoUlm8waNYDt4
	Kh+t4m83KcpOf8LjIADTz/GL0Wy85EyhXdT8jRYvcU9rTbn/tDpohlHPEQ5ChkSj
	78KONN1rJMH3FCrOxuQWA2eiq54lVD5ZyYsFWzzOLLgSU4gdoiLjLZbyZZkSA6YG
	1Fpu20vfXsUa13fnE44pXC/yk+nv4Iugjhb7YC8jrwcu97iQ==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hux8495gb-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 12:01:15 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-9987bffdecdso1589129241.2
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 04:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794312074; x=1794916874; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wjHjihWkxK/xBC3DjLG2PqbN08tv/LZZbFWJaPS+3xg=;
        b=OPy1LCNc4gDTo7aO2Np75vIN2JnH4adhKQOfHNWpcLVmQmELefvMD1/+bfZX4k2Slh
         F6sZhX7ep0eMGe3Ji5wOFrFyQlKoKZmzl5021JORA8KHVMcrnqB+QnkI+GrjhX08tsaj
         g57VKVJ+/Gg90OH5vKFCCMEUFZZ10b7oOURpEGPjCQaFtmC0MeKq0HUYeHNdwxtqgrUJ
         z/4I30MagaPZ2cDvZbI5TSUDk4Lxa7qXw94aJyywV5lAqFCVj2IwRe6tlcJYvESZxAgz
         u5jzb1Urap+u1y77bXyLUjD6vKrOmdp8gknI98D0IhQbA0z6HHuQcKkVPw8t+JvBfB0k
         yhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794312074; x=1794916874;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wjHjihWkxK/xBC3DjLG2PqbN08tv/LZZbFWJaPS+3xg=;
        b=Bz8GfVKRmDyoUpUVfCwFk6UMrt6aWffC2T4SYmIVj3N71c0qUGqFbo/pn96VFdfDnl
         aGwN5FPpz9c5C7lptrWo8/2g0Qn8h3NWOh6oszwDbkehR00Iw0pH6WQqiKEBSh1bl7Av
         agUNywhIx7/IbFEEBkpMLoI9fqGvYaqwpFecEf78CqgJ3CIl45teYvoEmimPw+QLManw
         uXcwh27SO8CHdYhvP+PsUjL40ULTKnQoUiAY/lsS2t83k+JBOX9N5pYmCtUe+cRtMg8X
         srQZU5Rtq53vYUQxqDeBNcqiLQqcmGRmHOdBNXvOeKQarXgCDKaWdCtEVOgG8cVhhba+
         /FdQ==
X-Gm-Message-State: APuU4Z9tnmAKVezx35HCj5r1QqPavBPwl/CEFKEfBYmSqs9huPVZBoZG
	LjxYxFrYj05RcQ19EW0LecV+r0sl2W9qq7I1OJDJKeLmFmh0ilmTt8vv5njTBQ5C7mUPExbA2F0
	W8n2SKQWETYn52s+JBiN0ZedIhpcQBMkliJ4MOCklgDnu1FNnCvYiyvpx0iHTTah1U8CLIA==
X-Gm-Gg: AYBFou1w/Qvdlg/QoyZM4pu9BN9n1UoUwqFj0dNkajNKSBHx2G6Bsdwg9fDn2ryiVo6
	OvxCEqPg7c1Bbca894l4Y288lgo2KSfxZgSMQstBCuBUS4cmhab+i7Iqb7gzsdI01wngFkA80Jt
	BBOBARdlfofJ57Y0gH+FuIyslCJNEGQll7YYoB688raj3uchM4DZv5ECii9qWCNrPnMCvYlCj7q
	29SkmYNHOQ4cLhrINYEytlwlCmpFm+xlBuQ+KMmdTrm87Vw09kPyQjIf0DGLwJbjlQmRhZbjvZ+
	CeOh8d8hOgsjN5vCFEGL07W5KYuvUFVKQrH4DMdQmtRfWPYtDDZc/cgr7cK+qv+8D5q0vt/Rhsf
	wNCW3WyXSNc5ZqPxY/LLOps+UUMRJvDEiN5wa0od/8Re9g7O4zzqN08xPbKmFZEU7U7LBH/ta/2
	wh45rCKR6hyWupZuUpe5HjJksIboq+nEufjjUzKZriIhfiJe+eGpmD07C844GE81Ppble/pEgv1
	uJ1+ei1Bb+bukcRVCmuYID+sro=
X-Received: by 2002:a05:6102:2928:b0:7d0:6e40:f3e2 with SMTP id ada2fe7eead31-7d301c19bf8mr734199137.28.1794312073191;
        Tue, 10 Nov 2026 04:01:13 -0800 (PST)
X-Received: by 2002:a05:6102:2928:b0:7d0:6e40:f3e2 with SMTP id ada2fe7eead31-7d301c19bf8mr734163137.28.1794312072593;
        Tue, 10 Nov 2026 04:01:12 -0800 (PST)
Received: from QCOM-eG0v1AUPpu.na.qualcomm.com ([2a01:e0a:830:450:a91e:6b1:bddc:2951])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01fe2cb2sm56820295e9.3.2026.11.10.04.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:01:11 -0800 (PST)
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Subject: [PATCH v2 0/2] PM: clk: Release clocks across runtime suspend
Date: Tue, 10 Nov 2026 13:01:07 +0100
Message-Id: <20261110-clk-leak-v2-0-d044cf0c3f1d@oss.qualcomm.com>
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
X-B4-Tracking: v=1; b=H4sIAIMH82oC/22MwQ6DIBAFf8XsuRjAiKSn/kfjYYW1ElFaaE0bw
 7+Xeu7lJfMymR0SRUcJztUOkTaXXFgLyFMFZsL1RszZwiC5VII3nBk/M084s4ZQjZ3pLMoWin6
 PNLr3kbr2hSeXniF+jvImfu+fyCaYYHbQZlAaW9T2ElKqHy/0JixLXQb6nPMXU8Qan6cAAAA=
X-Change-ID: 20261030-clk-leak-3ea6f7c7da25
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Danilo Krummrich <dakr@kernel.org>, Johan Hovold <johan@kernel.org>
Cc: linux-pm@vger.kernel.org, driver-core@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Nihal Kumar Gupta <nihal.gupta@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfXwIzilDt55IXX
 CT8Iabp0KFewlA9D6CxqGKVmwSzDWaqSCVp/KVWFceHpzhxb8LKAVO+ESG+DvapjDawhjwVWmtU
 cj7cU8g2IGEiggvCKeGh9XjhiEAdvcvHCTE9CDhgZTEhVcjpuOu5Cim7irQsy2GDddJN3omApu/
 fdxVhwMRPXkGgMQHsOjMWNFM1HfI//MIizPZFGPhlJUOw8TtELja9RTscIzOugOs94xHdEfc34a
 1K7PuPNuoe/D53DiOJlesei5xksJjKWVTug2lzmltiIMKjKe4/JaJXRSWriqZoMZ/eWAmJbEEQY
 CEuQYUNtRHPwxsOOc9naS/Wlr1aB0L/Ff3pY54zjUs126y6iewI8xf3eQFB0lOpWMkNdcT3y1nE
 KilcXR7pz0ujjgjTjXuY0UNOPLsMU4pcybYTvKkrkXHmnVnDbnvhV5vQuNosaJjEaBDf2rKYLjF
 KqNGA3YialxMdPdaiCw==
X-Proofpoint-GUID: cxVrq3wfqV1j_X5o7GB497xqZHbAPguc
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDA0NyBTYWx0ZWRfX9fckWTvIT9VP
 y7atezlNlbXoFL2xYoHRwwphWItUeBwPxsya3imOfh7UUQHRrm2Rs/ES5IaTKjmVqV7qAzLm/Bv
 6Y7Yt80Xry/78hTogoRggmSTk4DbKTk=
X-Proofpoint-ORIG-GUID: cxVrq3wfqV1j_X5o7GB497xqZHbAPguc
X-Authority-Analysis: v=2.4 cv=JNSuIMKb c=1 sm=1 tr=0 ts=6af3078b cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ZpB3dmDekyYojdqYHaoA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_04,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015 adultscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100047

pm_clk prepares each clock when it is acquired and keeps that reference
until the entry is removed, runtime suspend only dropping the enable
reference. A prepare reference propagates to the parents though, so a
leaf clock can pin an ancestor that only implements prepare/unprepare
for as long as the device exists. On Qualcomm platforms this is how the
RPM XO clock stays active across runtime and system suspend even though
all of its consumers are suspended.

Drivers that manage their own clock usually unprepare in runtime suspend
245 clk_disable_unprepare() call sites under drivers/ against 27 that
only disable. pm_clk is the outlier, and only because it cannot
sleep for a device that suspends with interrupts disabled. So rather
than asking each clock whether it must sleep, ask the device whether it
may.

Patch 1 derives the locking from pm_runtime_is_irq_safe() and drops
the bookkeeping, patch 2 then unprepares on suspend. IRQ-safe devices
keep the current behaviour.

A non-IRQ-safe device now prepares and unprepares on every runtime PM
cycle rather than once per lifetime.

Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
Changes in v2:
- Split into two patches: the locking rework, then the unprepare on
  suspend.
- Keep clk_is_enabled_when_prepared() in pm_clk_acquire(). v1 used
  dev->power.irq_safe there, which runs before probe() can call
  pm_runtime_irq_safe(), so the flag always read false.
- Drop the clock_op_might_sleep count, the pm_clk_op_lock() retry loop
  and the caller name argument.
- Reject an IRQ-safe device holding a clock that is enabled when
  prepared in __pm_clk_enable() rather than from an in_atomic() test in
  the locking helper.
- Link to v1: https://lore.kernel.org/r/20261030-clk-leak-v1-1-db8cb68a5a8d@oss.qualcomm.com

---
Loic Poulain (2):
      PM: clk: Derive PM clock locking from the device's IRQ safety
      PM: clk: Release the clock prepare reference across runtime suspend

 drivers/base/power/clock_ops.c | 145 +++++++++++++++++++----------------------
 include/linux/pm.h             |   1 -
 2 files changed, 68 insertions(+), 78 deletions(-)
---
base-commit: e726cf08ee6ba7e8b852c77760f12c59f90f1338
change-id: 20261030-clk-leak-3ea6f7c7da25

Best regards,
-- 
Loic Poulain <loic.poulain@oss.qualcomm.com>

