Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D54360ED1
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372153; cv=none; b=GtgYK+u+Q8IfUQzXuBI6YIxKH9+HiihUfMSZ3cIPxINlHbiuP/v821FC3aOEuFiwCEg7zMILM9xYMl7HKGfj2wzz922pyyJ+YLBG5W7Fh8PYKrxot5N4XnAGT4Rr0DkxawAKa/jtmzCUxgfNvmYoOmjkhfPZ8zs6iQPP2Ma43dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372153; c=relaxed/simple;
	bh=F1VjdFSl9/atwZ3hE3R7ac4wdUgSa2oHodjWqqw69dI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ULaGmDCfP67UzhKKrVhS6AY6K5JqGQ2QYscbZvC0CHh2Q+OY9aew2UdBB/SYl+rgU7q5tEnzciawe9ETcMv8TxZEiK0parPW3IhDSNLxDYN+KkcDN8q5gd0pXxLAFJtyu7Tnk/3zTU1BJYUzV1FUYCn8bXqoyAAx0kolH8XXnpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=j4dK/xei; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=FgHtqNjb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="j4dK/xei";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FgHtqNjb"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jEbP3842265
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=ZjLBQtd7svl9wuiVQ5/yYYCt
	Te6o0rbws3eQ4NEqK+4=; b=j4dK/xeiOzAb+5QAa/E2Fq28tsoKLnCeLalYD6L6
	mSfppLO0hQVNqP7uOVQAZkeco4fdb+9zcxJ5B1RBzuCLsLqI9nPyBawp8OCIiTjQ
	reBwH8gh4WztHsfYWPxzHUvpD4SBtzzjaEzzoZASCz8FmSHeDJgXjIrzxBR02fqF
	LSQ8rJjrRD08Ejq0xnWdEzrr0WqHpbQXkOjekPzOA7eWqgtNo7FlR7tl1BG7bLsj
	fyi9vcDalCg3FHsQ/aUnrmeoHkFsm1cq/wNYxq/z4zbM14NB9RHPSatq7IgmECrz
	Ur4LZ38JD7GNQfMERrGTglVNT1p7d483x0ryEeVhd81XMw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9c5knw-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:49:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93a05d645acso390995785a.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 00:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789372150; x=1789976950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZjLBQtd7svl9wuiVQ5/yYYCtTe6o0rbws3eQ4NEqK+4=;
        b=FgHtqNjboUmmP75ipeYWdXrj/HrISfMk899Rw8FWVfb6s/wtk9g3lZMjJ/18F7fmxh
         J6MUmNUzPhdAhbMXcyCjPSDDfx8O/L3M00xq56t5Zv3n5MigvA3DGNxgJ/+UdY/btaaR
         CLn/5ysJ6HJJRa+ZE/tS0Yc92MlE4eDChmWkH6OifDlQC5//sheFOa8tDQQ3Y3RxI8ZR
         KvkRamPlp7mVLINLuT2oyMnrdnbNBjJ+1cS0icUb7CFwiYmZ3n0YbI/jyqKRopGu3d8U
         SQf1hVWnf6GbsOZJIwwy/+TlsGcI5PYnbrdB4g1zTnVdFmKIk39SwCTuvdbCcVsMmmnd
         rwAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372150; x=1789976950;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZjLBQtd7svl9wuiVQ5/yYYCtTe6o0rbws3eQ4NEqK+4=;
        b=P/N6CjBeAY6mAd2qNcPnaxdzXl4JDCSmStPdHr6m0yiBGj4dXibh4opw5EveLLqO1t
         VS4yq9b60KvOdPW+J/KqQUg/aqVwYkxWNvBCFO/MussgpL5DEWRDedbPmGGkOCI84CEd
         JuzfiqZDchXFt6OvgqoFfOLHQB5q4G04VSOBxs64KIPWw9ju5lG4K0u6RKCcItTl4Ogv
         zFO2vAbNZISfay98oSWNfzw6ZAdKvGp7DQq2L+Q7fHVp/pH7V+2fbGXYP4Wpzozn5X83
         9wWqPCp30BuArWpI537PdPHEaI8Wwgug563GrH6M8Iz5jj5iCkue4d7AiPK4qqZLtHSi
         pqjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzTr7fgN5labIl4c94gtnco77YdxdhBkdGbWZHSahudq9FuKegejYXBFZJ5KrS0bzyIvjtEPoRRkA==@vger.kernel.org
X-Gm-Message-State: AFuF++mt7eNRdVdxnS81X8sCPMieDjh32E/1xev/KawW2oJ0/tOyUtWf
	ovM43CXN8e1bBPnnf8tK6BFCeSQch8GkdxNCHjd6BHxnD5au/pLE1E3ZX323QqzKq+XW3DW1xdw
	xCzgowIdxRxD4K6YtOyCiZ02kfJWTCeOfht++z0TpQrKTT1ugFoRZbTLByRTXZQ==
X-Gm-Gg: AYBFou1vUhU4Os+djqaXuDFxl+wK62v5Q9OEMbkk19P8XC5GIjtga2dQH3i4vSW3xk8
	jpM1dmnhTbiTEa43Icc+LObMLDK/TjKhTo3aTpBiWCo52JkN2ju4L9yJYRGp72wOQMIlhkn0xpR
	SnyarmQFDGrKfXCK57U5e5uglGwuzYuv0hyNAwCteN/CV3nX84mhHDp3C+7WqOvXDYBDAuG0Q9f
	wlhlbETCPlGQ8YE04KhcXcVM5WqCGy93kP97R2WUc0zDzGCypiUkGZXHFQAYUQZlGSDFuono4YZ
	fPRMfCMilbk7T0xGyp+FRChC4hefqNey83QwAP7rmZT2OGbt+2P7eBbLKy0jrgooue4OwgpiXo5
	7JbaDNIMvGKSdpA==
X-Received: by 2002:a05:620a:6886:b0:939:9b1c:ea4c with SMTP id af79cd13be357-93a29975ae2mr193490485a.28.1789372150506;
        Mon, 14 Sep 2026 00:49:10 -0700 (PDT)
X-Received: by 2002:a05:620a:6886:b0:939:9b1c:ea4c with SMTP id af79cd13be357-93a29975ae2mr193487585a.28.1789372150065;
        Mon, 14 Sep 2026 00:49:10 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486eb2ecfc3sm24108231f8f.4.2026.09.14.00.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:49:09 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:49:07 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Maulik Shah <maulik.shah@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pmdomain: core: Fall back to node name for idle states
Message-ID: <algsevh27dlkxbqfwxogx4irhkxs5ps2itl22t2idupk4b34d3@zdh3kibxt22p>
References: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-pmdomain-idle-state-name-fallback-v1-1-e4242c409a0b@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: roZa2N4NQO28oiNXf7GZxqhEQgcU93PQ
X-Proofpoint-GUID: roZa2N4NQO28oiNXf7GZxqhEQgcU93PQ
X-Authority-Analysis: v=2.4 cv=c5Y+0h9l c=1 sm=1 tr=0 ts=6aa7a6f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=5kt61lt8hwMnmxBZRvwA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDExMCBTYWx0ZWRfX73UL1X72guRm
 CX1PCXLEf/T9LWoTzeP/G7+5yxE7EePAvTatA3cq2j/VxC/tGMByNd9ZfY6fXWXfuq+OERyVo26
 v2H6yx/5qFNC4TfR3tiN469aVlLf6aFb9ojyHaZnor+zwRVLAQej4UksKWZGIqBjTCOMEx8ZvO0
 3/WoJfGCjrWA7tZe5L8bNRJVX8QrFyFsxdifp/bDo3jlQW/4CK16Xf2Y5NrayL7T03Oumw8xjUR
 e00V+h41ig8B8K3wvhs6u8T4hb8mEHmqsd51Givx3dJrhbDxk7w6m+mHlmqTYA7itUVICbALNQa
 10aE1t0zQ2urF0OxGCfUaRlg3pj31xcvKRGd4I+aQS5SMwr8HOTQ1I3gEdoQOVAXMH5pxpmkXxH
 VGx6lO60EremD2CPCbYBfp26zJDevkGRaZtV5lJm1T10OTSixhiF+Y6MN6Qphj0//SAiOkDIgLN
 TMEZWwSUbAepxi2TcrA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDExMCBTYWx0ZWRfX7NSLDZ47xUiv
 MQ4SxsIuxPQuhk+7wi5zUSFkNSqefkZc5RAWWt7ZqtfELMaWJX7taoQ5LNYDOPluw9STpSWFxuh
 QkRzBnqwm07z/qMjUEEEoxgK0wPZslE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140110

On 26-09-14 12:24:25, Maulik Shah wrote:
> The dt_idle_states uses idle-state-name when available and when missing
> falls back to the node name. Do the same for domain-idle-states.
> 
> This lets pmdomain idle_states_desc debugfs show a name even when
> idle-state-name is omitted.
> 
> Signed-off-by: Maulik Shah <maulik.shah@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
