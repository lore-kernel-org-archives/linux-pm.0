Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189A73382FC
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253167; cv=none; b=bmz2NDnnAEVk7LtEw+loclCWtRnB5A5giPmzllWJ36vwhUPi5V4tru08dG3AUuZjIgSUDVcQSEQGdxglTKY/vCchGqnPGvGW1GI8dpY3ibvs1q6IKMdrncEnpINOlEa8re8sJlp4KqesyLxUhqUVaF9DGtw/455zI9Ks8fM+Vr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253167; c=relaxed/simple;
	bh=I+J3lijk9qNAEc8We+uj5POGMAxHJEguo+5161ZH51A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJOGvsb8A0MkEXk5/NyCYYF40v1Ryt/xdnSpb/y0W6vqj5UwQ5SEUgtgwYPR3P0lNN96jgaZVo/E6sJxymeoV+Mh9myly76eu8pEybIqtzCamoN82kIGv1KNYPqBmp3x/HZShURWS045qAQwr7/Q/LFmbvVy72Zlk0k4IBnE0yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PsSn/PK4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TmwxhUL1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PsSn/PK4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TmwxhUL1"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4kIG1429858
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=; b=PsSn/PK4jle23gbd
	MNEt0oNAfO8sIJY3D/Am/tdXEQazyDYk1SG2Np7kO3KqBXVvdZI0Y8TJCwbj7Cnt
	jBJ87XwM7+yTUsxu+0rMfD7Uz2VYaVYIHuAlImjb9v5BFH5xivKsk/vfhYjmAfIq
	y5sNexITJMd6QCTG49+uZH+fMXcWPEyOknvI6rF9XH3Tk3cZCDHvCOKi0jRyR5TU
	VaF0XpYj8FzMvbPONhPYwfc2rp8gotzGr4wVK6vMyB4hrZFzAF5k+BnGtu17kB5n
	Qb5sBIogxoBqD20Ez44D15qaWkG+0+nd3FJ+gEbD8worjdTYGelVmDwP6ULqKEfN
	J4fmSg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com [74.125.82.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvvgha0c7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 12:32:42 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id 5a478bee46e88-30c0d568830so3715004eec.1
        for <linux-pm@vger.kernel.org>; Thu, 24 Sep 2026 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790253162; x=1790857962; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=;
        b=TmwxhUL1J/orAeuhjL5PWO/aOIeEP0TNX8q9QXleZVu6GB+FTeZKjbMjUtkEt8F1Kn
         WJQSKhwAr+Bnin1nsletVJ1l3HRSwIk3hlbpHRE3715w2P3aSge1HgbWDflltfM9ArFv
         HzMQPU9iy8zUh/pqWRk572C1Eqh8ryRiuJToUL8cbWaEszQvUh6xoLT6b5plUeI6Th+Z
         CJHWMWz+HPvNqLJElwfAc72r29IKit5tQ1I+3/yZ8PJiA/kepPwhfjh9THkKFoD99gt7
         /WF4bVqMmTVy5UxlNIHcE30eg6opb/if1FrtbBhTGQXiGNJK70Sr25SZ2xdRexBvUI85
         f7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790253162; x=1790857962;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=A0DzMsof/BPeClgNGuLflawDdZB+Su4EkTYJSKZSgpk=;
        b=gu/JEu8JUSZ6a3JwX8TW6fjY5ltXzU5hyOxAkIRT9lQBAzbxSTMJfun6ts+QgH+BeW
         ut2qvOZhznx9wuOtHhJZuwNO/hu2G96iBxn256mkuJ/JgOOjJoHw4OQ/eu6h1q7QZI2Q
         teiuDcwQiWDWnzQgmpOmpbq70igHi09GGGjzN5ZRYtKwyCt/6zNM4BdIZFkc/VdhsdZX
         058qs50tWbyIc6RHx8GxUFn7EXCybTsceuB/woLJEqHWXiFhfyaLVhafSomcZRJlsrBB
         CItIUKFb1Mirob8eMM5wXRMHcXe4v+qhcXxYI6obvMHwSkFwrJkIvsPe3g0zDtReqmwy
         57iA==
X-Gm-Message-State: AFuF++kVB3EicaUdBGJaT0sHGZP5j3EKgALw4EwI1h5fV0q5riQBOLdj
	RqRSnxnRpyrAn0neyPYGoHHDN1ZlmgbH2wWkesmnRT6TtLFbhgJhOAGzELwo82lNmJlqVF71i7R
	v5Nf+NmGnhEue2a2PBPgaabzDz3c62DxfRO/0YCgP1RG5ByJFKBudCTliaof+ow==
X-Gm-Gg: AYBFou2gv97gEfvWlNSpMEsPy6WhYX0xeRionF0vJZrKPROCE2MuGCCL3p89rHrLBM/
	PVJNy/c8obQ70UE7ej0RW1qaPe1BpzFEwLNvnPecYC11lUhwjJAWTuA56smaOXe6DCAf5y9gSt2
	x/A8U1pw/KEuTN6yMpqRscN0WcPna85SrpwQXb94zh7J1EGCcsTTG8L/4dStbCt9ih9kiGe9xvL
	hbSXxyZLTmYv+LCbU1yyD34DfnDyVNAWll1ihdKqfXzUPkzezJ60Gl79OFliQYyVuCcjiqdq9kx
	J24aLiBdBDiwa1+OTZO/khanJeMb4iCXepB680nJhc2Uix4v1qjGe/uUuwVsqrC296ei8mOfoLz
	FTlVRmAMZ60nvaaAqo75Qyplpcw==
X-Received: by 2002:a05:7301:da87:b0:339:d06e:64ea with SMTP id 5a478bee46e88-33ffe343a49mr1710413eec.4.1790253157157;
        Thu, 24 Sep 2026 05:32:37 -0700 (PDT)
X-Received: by 2002:a05:7301:da87:b0:339:d06e:64ea with SMTP id 5a478bee46e88-33ffe343a49mr1710371eec.4.1790253156373;
        Thu, 24 Sep 2026 05:32:36 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e95c7c63bsm13461908eec.10.2026.09.24.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 05:32:35 -0700 (PDT)
Date: Thu, 24 Sep 2026 18:02:29 +0530
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
To: MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Rajagopal Venkat <rajagopal.venkat@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] devfreq: stop monitor before calling governor GOV_STOP
Message-ID: <20260924123229.qkiyz5zo2owh5xtv@hu-mojha-hyd.qualcomm.com>
References: <20260721171141.1281754-1-mukesh.ojha@oss.qualcomm.com>
 <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260803181614.wk62kshvmbx6rpab@hu-mojha-hyd.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KYhHIgYD c=1 sm=1 tr=0 ts=6ab5186a cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=x_Bf0CEzfFRy0vkMM70A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: KaUEmMSBDfCsHtGex2VaQxo21A4iy7YD
X-Proofpoint-ORIG-GUID: KaUEmMSBDfCsHtGex2VaQxo21A4iy7YD
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX+vyg4SlG+nkS
 Mj6/Agn9YANveY84RN9mpVGwmGoXaPwYxw6JsIcOWiDYxW7qwLxePALqwFX6M5FWgumlD2djPV1
 u7jPJj8SHs+WQt4TNa7Z0oPGXcOuWDs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MSBTYWx0ZWRfX6msfdwSy+Pmm
 R0+hczFpQpG8tzcW82GItAQiAsSmdtMPCe/aptoiOTXzatsBb3h5h6tdJD5x6qBF5WeavTVltLC
 zaMzg64qxo640BSdpyvs3bQ8V9Xif7rFwZTXxw4EeouNN5gG/HoyQ0EwVhAwdsQOU+vUdwWqDEI
 2ym/MPddGCV5zf73S0wn18i2b7+bK6jgonpmQ+Q1lOf1jsk6BOGcU6qrJEd5uG5qtb4ZXjjbNUm
 0gtTPHaY8IQqHfSWM5oKyfNTgRrirgatvc9c62teagO5iYWj9pGNxrAh+jx8XlxlKiqyydgG8rc
 0LpDbGSjj6Kp72iu1EfuPAwAZ4H5ehLToLFtt7fcRzvhedbAkKRXi1TqD1iNNhQpfPWzazhlPUb
 dh3giYW6Zys5wjF6LMmH1r0cx4MLA2xAvpdt34+2XoGr2qMn+K5fE+DgffH3PQSWD/KJpnYYcNl
 TpjOECVqg17snBspTbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1015 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240051

On Mon, Aug 03, 2026 at 11:46:14PM +0530, Mukesh Ojha wrote:
> On Tue, Jul 21, 2026 at 10:41:41PM +0530, Mukesh Ojha wrote:
> > The following NULL pointer dereference is observed when devfreq_monitor
> > fires after userspace_exit() has freed governor_data:
> > 
> >   pc : devfreq_userspace_func+0x10/0x2c
> >   Code: 39402109 --> ldrb w9, [x0, #8]   (x0 = NULL)
> >   Call trace:
> >    devfreq_userspace_func+0x10/0x2c
> >    devfreq_monitor+0x34/0x134
> >    process_scheduled_works+0x1d8/0x804
> >    worker_thread+0x1c0/0x458
> > 
> > The fault address 0x8 is userspace_data.valid — an 8-byte unsigned long
> > (user_frequency) precedes it, so governor_data == NULL is the cause.
> > 
> > The race: devfreq_resume_device() reads df->governor without holding
> > devfreq_list_lock, while governor_store() updates it under that lock.
> > The stale pointer dispatches GOV_RESUME to the old governor
> > (simple_ondemand) after the switch has already completed:
> > 
> >   CPU 0 (devfreq_resume_device)        CPU 1 (governor_store)
> > 
> >   read df->governor → simple_ondemand
> >                                        lock(devfreq_list_lock)
> >                                        GOV_STOP → monitor stopped
> >                                        df->governor = userspace
> >                                        GOV_START → governor_data alloc'd
> >                                        unlock(devfreq_list_lock)
> >   simple_ondemand->event_handler
> >     (DEVFREQ_GOV_RESUME)
> >     → devfreq_monitor_resume()
> >         stop_polling == true → re-queue work  ← stray monitor!
> >         stop_polling = false
> > 
> > devfreq_monitor is now queued with df->governor == userspace. When
> > devfreq_remove_device() or governor_store() next calls userspace GOV_STOP,
> > userspace_exit() frees governor_data. The stray monitor fires,
> > dereferences NULL governor_data, and crashes.
> > 
> > Call devfreq_monitor_stop() before every GOV_STOP dispatch in the core,
> > ensuring the polling work is fully cancelled before any governor tears down
> > its private data.  devfreq_monitor_stop() is safe unconditionally:
> > IRQ_DRIVEN governors return immediately, polling governors that already
> > call it in their own GOV_STOP handler make the second call a no-op
> > (stop_polling already true), and governors that never polled get a harmless
> > cancel_delayed_work_sync() on an empty queue.
> > 
> > Four sites are fixed: devfreq_remove_device(), governor_store(),
> > devfreq_remove_governor() (governor module unload), and timer_store()
> > (timer-type change performs a GOV_STOP + GOV_START cycle).
> > 
> > Fixes: 7e6fdd4bad03 ("PM / devfreq: Core updates to support devices which can idle")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
> 
> Can we consider reviewing fix for the mentioned issue ?

Change still applies on linux-next tip, So no need of a rebase.

Can I get review on this ?

-- 
-Mukesh Ojha
