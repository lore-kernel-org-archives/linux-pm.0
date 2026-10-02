Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA9343DEBC
	for <linux-pm@vger.kernel.org>; Fri,  2 Oct 2026 07:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790927609; cv=none; b=CNE3+Kg3d1J4oUH0kAb6nNVx7ZBPCsoYTHkTRT4ZZRgcvLi6Hzb+LSszWhdJbip1oKgaQj6ps+N374Kh1YNE9szcJ+8JkNTqwMIYXM634gEOzSxYXoKxaoboYUjRMoskcih00/Nra3xWvrwEgZZrEUVlI6cPquo43l0nVIxB43k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790927609; c=relaxed/simple;
	bh=o/RvQv9f1ZtZd51QR8FJOZby6EqzahPJ2E5K519w+Ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rec+gUXOmKRxgVVQnuDZA+r7WcQ9l5J62FYMCwzt+usEiSwqjV90qJqjbYc3DlRpFMe1t7nbwC6AVcxa1YBoQGImS/APEflr/5fAtpezQbtgxdMW9AH8vlQNM/zAl64Hz2Jp9C+kib9k7VJnnlg3j+lBYmZfdA8Gp0khthVbWFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FG8vwcof; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UbVmvE+5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FG8vwcof";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UbVmvE+5"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6925ikv01542451
	for <linux-pm@vger.kernel.org>; Fri, 2 Oct 2026 07:53:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6leoAHiHC58kTdNzD41rzsHZ
	ue8MEp5AAZ57oKNPKQI=; b=FG8vwcof6+Yymu+Xm20Dzq5uzPYgxmE7Oh+3KmL9
	4k+05Lbc2lg9qKNEPq9qtsiLUBRv3VR4dETGZ10i/P9o+KNQdNkUM7EVqedL/Ssa
	KK27jCk46B8ABvKq5zQ4XEA+fzDqbLSTEIu1HZ1WXYZsdicLSoJHYn8O5QLdi67o
	zemOmMenzMGG/BDqkhJ71t8iUVgI+KjzE6yKdJuOUIlfbE997K0uT7alHIK/xHZ0
	Oo24b23CSc50iIrinWNXkSiMqqLn0UbG49MXWuQtqjnktqJ7nEcX7AY7U3Xse7TO
	eeDAsgdGubFKFokXl9S49mTv3V8O+eOeXtKjEX/4/NsuPA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h256mrkbu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 07:53:26 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb6391e89so392691985a.1
        for <linux-pm@vger.kernel.org>; Fri, 02 Oct 2026 00:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790927606; x=1791532406; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6leoAHiHC58kTdNzD41rzsHZue8MEp5AAZ57oKNPKQI=;
        b=UbVmvE+5bhqJFw258+EkFZwO0AKJ8IHJzi4uChTtkuxc2nApZvbQhKyUw4cbnneBT8
         MMSn9x1v27ckHKJBa8e49fjxd33NGFoVB4ooyCNjOub6wYfJMJHemAKjmIcQLiDqss9l
         8Ww2+mTS2effUG+WhYZnr5SKtbDiBB5hhS4mf9+idWsX2Grb5g4zH2lQ+HPht3geF41C
         ULiGZDx5z8sLAUW+KjoD/URsLS7oTxHyOAXpzJX6B13qAjoaQOlwEDEH0UBGFUdi1tCB
         jeKWWbfjttMvNyxShfyDXXEah0CKqmAQGuoDKquYvPESn1W8PgaQXc2BB/XflOvIS6LO
         mVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790927606; x=1791532406;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6leoAHiHC58kTdNzD41rzsHZue8MEp5AAZ57oKNPKQI=;
        b=SIoD/PCVdr6JqCxdBqnu07vNUgIKMf3vn25xcbrEapsg+evshoKJBKS/lVFbdHrcY6
         W5UvF5b6x6ygnHqakkoXyH6oXrwY5R5Yzp/Z8awVtEp06+oAnFn4vP1JQzLP/fPfh6uV
         X51rZ/oRfLu86FE4MZzmYB1Gvb1scKg6vRBz1Q6REFlYnF3pb330V+H/0rGQcvp+zR1T
         zmjVLvUC3ZV+LujjfW26sPUTYhLE1SqDx4f+9FUCtSn2jhEduf/7eakELopJLaYOyEaF
         kIeG3K1TxLna/BSXFloxmSQt9xCl8WntiPG9mQH4D9zcSUdqQ5p3FCUJo5g4H8VEE/M/
         EiyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzPtLZTWQUIpf/yakADAfKTOaMElat9fzFEOmgMiLIcdfHP5agIcRwWIhfv4yqGPnrglQAq1i7MBA==@vger.kernel.org
X-Gm-Message-State: AFuF++mFZ7f3XLIwWygFPbB4SmePAO7IbCZRQbP37g0qinPQX1jyz5nf
	izl5ZVuA+yunUadYl1vOYAyhQkMVf8FWiZDlrxtu0q6EUVHJifSuP3VWCXIjEiogLxZ/ZjmRPs3
	Gp9GisVa+nx43lG00Sdpkwr6kvehUjrqDcwL8XSAa6dgfY+Ns6nkNUdS73ktumQ==
X-Gm-Gg: AYBFou2QdnrqpWf16CxramIr8sdpapZ/Bxf2hYtB955CFZq0Aa0nflEp3Z9YesrzOmX
	xv2mMpTTPNfQkLdf5fDrec5OsvqbiDForF7hkTmPvm+omHUBOqg8vRgToMbD6HBil1Ecvj8ri+9
	XyK7lse5VokijuPtv+MqLyS45WIgKAQ1OOxzsFekNkZ9rm8Wwwvl49YiNnq/rYjX+drGeA9chUR
	7cHzOusxj6MncnhnRUQ+VDcSDq6DZ/dVjIFeSfCqUxHTilYkqPhvOVEzfETB3+MxLvKwXOceJ48
	8wECx33V9/OUxRWpsRTlkfXE7z4O8OnhCk35mVXuMkeY447lkKwyBAa7zlYFcMi+aV1ftyH6xbi
	njWZJ4SJrzOCbBojqP9Hd
X-Received: by 2002:a05:620a:a0c4:10b0:939:fc74:b6af with SMTP id af79cd13be357-93cf16b3fdbmr230241385a.11.1790927605475;
        Fri, 02 Oct 2026 00:53:25 -0700 (PDT)
X-Received: by 2002:a05:620a:a0c4:10b0:939:fc74:b6af with SMTP id af79cd13be357-93cf16b3fdbmr230237685a.11.1790927604917;
        Fri, 02 Oct 2026 00:53:24 -0700 (PDT)
Received: from mai.linaro.org ([2a05:6e02:1041:c10:f14c:b716:c104:4712])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b380fad53sm4411184f8f.19.2026.10.02.00.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 00:53:24 -0700 (PDT)
Date: Fri, 2 Oct 2026 09:53:22 +0200
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        avaneesh.dwivedi@oss.qualcomm.com,
        Umang Chheda <umang.chheda@oss.qualcomm.com>
Subject: Re: [PATCH v15 3/6] reboot: add parsable tokens for power state
 change reasons
Message-ID: <ar9i8i-7a7ZnT5t8@mai.linaro.org>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
 <20260924-pscrr-framework-v15-3-7af87107e0d3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-pscrr-framework-v15-3-7af87107e0d3@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzMSBTYWx0ZWRfXwijfmj2/mhi8
 MXF17VcAGWijFREO/AZUr99RHSBM1epYF6RP/+rxN/mrNkn5WKCsWiTGdIwc/tmnC3LRJlNrksl
 1Yj4+q4Ogh4Wj4XNYlZnidwt++OtMC0=
X-Proofpoint-ORIG-GUID: vcs5ElFtaMsVH5tW1XLtu-ZG5EuIJy3l
X-Authority-Analysis: v=2.4 cv=b80ncdGx c=1 sm=1 tr=0 ts=6abf62f6 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=WjtHAGiS79jxuaiHvU8A:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: vcs5ElFtaMsVH5tW1XLtu-ZG5EuIJy3l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzMSBTYWx0ZWRfX8tP7l8STOMuC
 K9LkOC2AvRUdDfgRNbXDcMVb5c+KhHhlu6ckIQO8eYbwRUSzjFgaOUoobEs1hFFlGZXH6jukotk
 SZ5LG0P/kWPCUX2ZaPqYHqUAIzEu2Xx8Aqm0OIxFBMPI5+gnxltsxtMn76J+AlvNkDbjFhdmzCz
 Zu3XASxIVhFlbdZ1C9U5MRrbBExHrrFAcBGwZEQ1VpMBGiqOXZ2DSmjbWBR0CwD0MC14pe9MljM
 eZgqRinukVCVwpMuh5ReLxGHadvZJzHciwpy480oSb1CTkYjoOlLm48WMjJp1tsZppM11JJ2Sxa
 I2vHdhRXOD4ICNxECMEXPCho/eXroHjijjBKitvTqonrkWlkpy9kkvrQg0ZiwQab4objTyqwZd/
 dlNKfL2WRkInX+Vn/XAzKD/MNwqDHp5kJCFAH18BvbdKL1Lfk71cRqx8uufU4/Zz+DLerWH5zW6
 eXACphuzeetEPA5Xp1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020031

On Thu, Sep 24, 2026 at 12:38:44PM +0530, Faruque Ansari wrote:
> psc_reason_to_str() returns human-readable labels that contain spaces
> (e.g. "over temperature"). Those are fine for logs but unusable as
> values in a space-separated sysfs list or as a write target.
> 
> Extend the single reason descriptor table with a stable, space-free
> token next to the existing label, and add psc_reason_to_token() and
> psc_reason_from_token() so consumers can emit and parse reasons without
> inventing their own string table.
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> Chnages v15

Nit: ^^^

> - Add Reviewed-by tags from Matti Vaittinen.

Reviewed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
