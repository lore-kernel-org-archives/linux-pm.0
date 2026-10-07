Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0BC44605B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791363223; cv=none; b=YzwZo/pZDOrxFdOoCwflnOAlkYoK/GmtxeL5ar6kJsTLrmSIIE/xyIT+J19HJbRO4CYChmC5VYaahfi6zypPNI/LNcVWszD7HVad5GmoPWA/8gT0e2/B8KldtLxYh+A1GK12HMaDchdEQCE6XvjCtckgR09EskxeWFGo0RjMW2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791363223; c=relaxed/simple;
	bh=WTVvgTyFxqPZ1cVRs5+G5TuhvBcCfAZuVdQtmFu7emY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHZ1MH7/8qv6pdzCLDuF8+6o8aMvUiERjDE9axFsocHOFOYaTNQkxK37YMMpzn5fY4sk+vdAlo46M8+xmHiuUhCoFCYuyGPyjUx1WyNd+anps+LdAELwbn2BX+BPpPsn0zXoFmK9/SrGJYCUxMuplc9yO1AZoeljZvuzOId6x4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Si3LRGom; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MIOkY4fu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Si3LRGom";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MIOkY4fu"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6977jWL02481343
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 08:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzNv9rZcCmK3aNjaFhrMCv7zcIlZ12WL5Lp8BkuyCMA=; b=Si3LRGomJBkswzF4
	FEsHiLfRGE/1ARlPkJsHTW4L3Ik1E+D2u1cblV3OBFyMX81tB7ItaLEMxfOBdC08
	NMBThEXeyYJ8jhDXwtDK+Oizush4NKYyM+ngV3Jkx21fHGkSjnbfu3Pkd7LnIw1N
	QhZLpdznME4jAB8bu2cexTOk1RvCiWf6sSE1hrlfS41scJkmkkZbdcS3FNXkk8WT
	tE3cb1ijOLfmWbwjs2xQTVhO9AIo260X4eI65VK+00N08kCkt1xBPVx94RxwYeY5
	OUvutugyRpaatT1gOZq8kJJkbPk9+2Uk593e4XemgdJPw0k0YFnH2TidmxjqLJL5
	qYWK4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1bcv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 08:53:41 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93caf7856ffso663230185a.3
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 01:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791363220; x=1791968020; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzNv9rZcCmK3aNjaFhrMCv7zcIlZ12WL5Lp8BkuyCMA=;
        b=MIOkY4furi4ndUjDacHdbp84/Rbvkz5+ELa1vOCFST3KU3AUWbyvlftrwfMK+Jxq5D
         xQ2oRVLN3YgTfWZhePc3lROLQ9hlIp1F20WyFsIAwJCq5coGCawk42bOZhrI3Uyo9j8a
         /hfXOU8NSGStbCYWLsOvrY7GNnn9mbfXC2ZNq4IuEsLe2nzdHfJ4YnMBO4PpMqulJzcc
         z6WMYct470DN7R82AS7qUDocWTbT6T+ZfmBVnTPXc0ZlYseGD6076VUu7SqPa+Sos0rw
         Qm8/V/jVwH2VbW7jA/JDxzC2NT47oo8PSaCrIaz8sFIoZv6QItFmgCG1y4iorVUHblVL
         Unmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791363220; x=1791968020;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzNv9rZcCmK3aNjaFhrMCv7zcIlZ12WL5Lp8BkuyCMA=;
        b=FIXFuLYA1S8spog2SUz9SZBKVKxrR8YgFQVufjPOGjB3RftQW7nRVamxHm58wtlaSL
         qb3XzY+zKl6NhypfZ4qkMPoZq+uT7BS0Cq/u/HLLaSdfQ8IDANAGefkC48RwFL94TsoA
         F0qEFX6ib39JTKqz/ToMo7/bBRpZ2jlUHpInWQFKz/S39uSRhu5UGuZE6lYh285ANAAv
         q94BAA13tWXEpPjdHK29WyCXN4W7fnf/KSARN8x0l5JtBXsq4qi193u8WXpvbONqeO+T
         RTGLBScLDRthz4nP2we2wZRAeOl/apuUCTwELd73H6XyaiwA6HKcYY7gCHPFecxAx+L0
         1IGQ==
X-Forwarded-Encrypted: i=1; AKwUvBxUzbi44Z20rtmwLPJMqhZKF5MpTeyYNOYoRt0UeA/I68hgLFyfmQth+rKmMBJ6GwLKwOGjCAgFww==@vger.kernel.org
X-Gm-Message-State: AFuF++nRqXpAqwgpvTpRaBhse/oM3JN4oaT8ksiLr1eE7OJW5j82MG80
	bo69QZeiG84Lq1px26orTgIxL7wWyPULYFmeLCv81Re/Wh07B0dPFcl/GJE8e98ydZ8l9xEzzO6
	WioIV2Omc+Hi6kclxIzv5MHpTehnFcvKzFO6snuO/fK1Pzqn8VRKsCad13GBdiQ==
X-Gm-Gg: AYBFou3c1DpeDCY8G4hE2Xn66f13uEDzwS1McQEDsWPspWeW8MgCxlN/+pjicvCTJxK
	6vHn9WTQLsUYQKxrLYL+tNUaK6aNZFR6BHCTVEvg1fp/93Y8tbmMRdr1d3dqO3ZezfvTPch6Dwa
	dysSjGlrjL5akJpLXsmeE8MdVO3AkfLU9gpQ9BoKF0+R/f2YqAe3ME0VXq3sfQI/T0sFsa4tf2D
	3CazCyypleKUtPHWfvHgwCuUu9DkigiJIaGOyk2mOxyBo93RVYXtfJ6u98Ej1EofE4CiHdtqimT
	Z94JI/hMJgMNgFXEYgt2Z3gZMWUNYuZthCRj3DC7aMvq7J9OyuouWelnIHu8lpY74GlpNRd6CDB
	UM5ubmJAjBfdAg38Y
X-Received: by 2002:a05:620a:4013:b0:93e:9809:dbf9 with SMTP id af79cd13be357-93e9b8e0532mr259044685a.76.1791363220480;
        Wed, 07 Oct 2026 01:53:40 -0700 (PDT)
X-Received: by 2002:a05:620a:4013:b0:93e:9809:dbf9 with SMTP id af79cd13be357-93e9b8e0532mr259040285a.76.1791363219916;
        Wed, 07 Oct 2026 01:53:39 -0700 (PDT)
Received: from [10.40.4.24] ([37.168.19.198])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f493761sm81524535e9.2.2026.10.07.01.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 01:53:39 -0700 (PDT)
Message-ID: <37c88c2b-e500-48fb-a982-9a56540ecac4@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 10:53:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v16 6/6] Documentation: Add sysfs documentation for PSCRR
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
References: <20261007-pscrr-framework-v16-0-3642c277bebb@oss.qualcomm.com>
 <20261007-pscrr-framework-v16-6-3642c277bebb@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261007-pscrr-framework-v16-6-3642c277bebb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX2FJyPPu9z2Zs
 Ivi0+Q0tLP0sD0bkrkLfGND/7WJdv5xx89HqqagCeE5aPJzFOeCihxtQXCF1P7V/i8KSGetjzCP
 L4nHdaz00+akBA88aSnBYbrOxbqxiI0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzNSBTYWx0ZWRfX/BxxrtFCSyyR
 fJNRZBhm1zSSHPTV9SyDifEcFujdprRWnlbARCv2P065H6xzokfY30qMhKOcswuTS7dhsPB47yJ
 VH3kodr7plbtEL9kLYcMMEVNfrzZ6TQKez/YOENMLfnovRITtO05b+OmvvdrhAHSMzpb22dY8S7
 LQMX27XFqnmiRaYivH+MJ+jBocYj3ll1CWqqw9R4CwOlf5Ax6pNUAaNUasc4quDe/mw2KuOwxL9
 L+C90OlAAoP3Oe33C5pGXzKhORfVJa91xkls8WIZ3mu+lEC5Qa6RBdpD9C5fZ8VZPm9YPD9tCS6
 6zI3zXAZ3/jNSai5bdXFRk15ZdV9aVvht36ulCbpSqZbHuRJq2cY5YtYoNHq2/OCKMhUlYl3krx
 tpyUF7BWUXwaNHhWuHsxhnObedsKWar9AEpTQBzHwteQ87VgguIGnhcXd4tU3ixv+ZORZIuR2ib
 Bft8WxZ6ZsJHTVBc9FQ==
X-Proofpoint-ORIG-GUID: miVUtBmi8S3z7bEEm8SJ6WHRjW6MF0Ut
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac60895 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=YKLnzF1Vlz+PFNxJOoRadg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=IOfPLNtac2teg-F3z00A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: miVUtBmi8S3z7bEEm8SJ6WHRjW6MF0Ut
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070035

On 10/7/26 09:06, Faruque Ansari wrote:
> Document the Power State Change Reasons Recording (PSCRR) sysfs interface
> under /sys/kernel/pscrr/: the per-provider directories and their name,
> device, reason, caps, supported_reasons and record_policy attributes,
> including the stable reason token values.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> 
> Changes v15:
> - Add Reviewed-by tags from Matti Vaittinen.
> changes v12:
> - rewrite for the per-provider interface (providerN/ directories with
>    caps, supported_reasons and record_policy)
> - rename the file to sysfs-kernel-pscrr to match the sysfs path
> - refresh KernelVersion/Date
> - drop Reviewed-by: Matti Vaittinen; the documentation was rewritten
> changes v8:
> - simplify and clarify example sysfs value comments
> - add note that not all values are meaningful on every system
> changes v7:
> - document expected values
> ---
Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
