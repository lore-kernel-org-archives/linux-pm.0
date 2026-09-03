Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32361456289
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442536; cv=none; b=SYwKFWPwok6zEQ1sm6rbj8wkSJ7pYZnwRwYRHZmRbXdW4vjXF9aB02kuKSmSdFLvhuOi5o8GS9q0t3KkFHelY32f5yDftFiqXD1tpM1yBsWNO4FXZtXHZjs7bxBLYJuplG+Na7n8mI2PaUHiYTlF7t1cPWKrKVjsv355W4/tGGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442536; c=relaxed/simple;
	bh=EDyoKHuGKwkBHb1TRmNlIgq/E1jTMw2X0zz7N7Lh4Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1kt9I9i5oRakRrszZTTpBENL4coL6g13WHYzVjU1zFZXWGcO6zU3HzfdmgQSm4B4xpyw0Zds0O8j+IUYG37kC/TxQawop7rcsyMCbnMxywWSoMOPt9+Kd7FYXkGq4DdiFjHMiyUv8HA7qxotzCuH6FBCPdRv2dUk42ESMOM114=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BSvx4drq; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SzLS0rS1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSvx4drq";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SzLS0rS1"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683DAK83539065
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 13:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=/4DLlFsjYWfVj0wHcCsxEd1j
	3B+ydgKXEWS4cecbkdI=; b=BSvx4drqyq3Bq3EZ4Z+8Xo59dZXrCvjUqjwD9IMj
	GKSLHML9uKqAzyu8wp4/dQFI2bhcasK3BoCgGwGfQoUVyM0ov5m7pyRU7KURW1E7
	VSt8rohEmBBAOHNU/qSrgy7uB/SLE7dT6uxC2Bhvn8eEKgRFRgyhrdIZxooUgSfh
	OUicmKFSVi8lCCg39LYLpxPKVgQlRD3h9Ds/oHp3Yy8kvXawx+FdduzJ0EfQa1e5
	YDCotmLTrW2XSx10dsoLsJIpPJG2/WaSUx8+Ts7u+EUtlzaZE481Qy6rECF8keUP
	PRm6lhxggtoPcV/V4ZinCINUdJNnwZ4DskjLy99L7BuM/w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf6tx0sry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 13:35:21 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93917f4ccb4so330934685a.0
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 06:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788442520; x=1789047320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/4DLlFsjYWfVj0wHcCsxEd1j3B+ydgKXEWS4cecbkdI=;
        b=SzLS0rS19eempocLc2bm+9yQ9bRaVDvXl+PIzq/56uSjUFrHCxygEZQrYTUPBYGfjZ
         nDx3ErwqIQakv6CzfEaNhSLuF6pjRiw7xoNhLbOcKPL+BU3GlGuOd4BoaGU8Ft8AJohy
         +weNmED41+hphTFDTi2hz8RQhhK2ML95jUYsDDZZFvVNNISHAb3mzwCf/DXOYoR9pNTi
         R35NpdNR3P/BUOUnwvDhf6evn4u3UwlSsV7X4/rm+z4kOxKVn10aNkcXTNY92K9xeBcI
         ttqGmJAdQe/qATeguJxOCg/MQQ9j8FbSd8/eAgXODnrfXzY0Gehjvza8XPOvVpXEJWxx
         YnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788442520; x=1789047320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/4DLlFsjYWfVj0wHcCsxEd1j3B+ydgKXEWS4cecbkdI=;
        b=gu+D84LOWvrZoWa3pV1K6goHYB8FB6fyTHsMMUE9HkhkK8DFkIIWWNqq1a91Z8EUaZ
         UvgU0V8q3yFYHoSfZdC16RFWWv/Z8ltcxcirdfo/7VuYz9dXn6+cX/JTts/4LK75xX57
         3bsDzU9tdHaJI3HUO6zHCAflmUjPvMWvHcDYvJlhxLcxsKflL6mTLVwomNTS+zADK2RU
         foDB2ctsF558sDYP23mpTrNDv/apCJivIE/sTTf92Dcykg/BuohJMiRxge6JNigaX2Mf
         B2CBjeGpc2FsK4GIzeZ6/M16F0vjEq1dggu1O1lSPkErrPVQZI87CWS2eum+ZFIYSqfT
         e+Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzEb8Cq1bwJVt3ciOnLMwR/eX4WT/wX4758MD0x+KL0aL5fTyQYNidEDrQMUbTgcutyGT7yw7vZSg==@vger.kernel.org
X-Gm-Message-State: AFuF++khNqPQopA6TsRZCbS9GKkqKquYcJr8UHfkvKDyieqg86FyiLOX
	UqpcQaMuXNRB3AHiXQq9PhLjNfwD4wxuQBLqmhK0JmzncPL9imqiuHFtO9ReqhikzcC7r7t5SFC
	qKyF2M3eFglSoRWzOASIAjXUr4FJIB3poQVI72ZJRieAezSYqNlBX7iKXc4SzHw==
X-Gm-Gg: AYBFou1sjcEqeWE+gh3rIuunDYEO7A4ACSXSOwkfOxVKSl/FknhXKCRr1vKG2Ouc/Wg
	TH5rUl9lrwnmS1nmkRt686BaDj+9DRtt0H/V3VvbutlickmqMGSdj5Me4OmuOq2+/Ro1c9zmbq4
	NxQdie1oIZQmyCEyzy55AyVqi+RnF9edpf6NvjMJ0PavjQw6e1ADpwPNcCJxSC6ujFe26X5SkCZ
	85CYTlC94pzX51ic7z2lXRYF+4y42Dil4z0TIPYQ4TD+36SEfYGQW0GB3XkeZyALqKb16mW0SAU
	KlXEJWD3jDO6ItY7yOJBu4WbxEKG3MqTEUofmTJxY1yRLvlZw7/bUC1+TukR+x+qqgF6HeyKNTj
	MS8/WY+WqsqgK
X-Received: by 2002:a05:620a:4620:b0:939:46d2:9673 with SMTP id af79cd13be357-93960ccf23dmr1194050985a.1.1788442520353;
        Thu, 03 Sep 2026 06:35:20 -0700 (PDT)
X-Received: by 2002:a05:620a:4620:b0:939:46d2:9673 with SMTP id af79cd13be357-93960ccf23dmr1194044185a.1.1788442519793;
        Thu, 03 Sep 2026 06:35:19 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce591f846sm57380275e9.1.2026.09.03.06.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 06:35:18 -0700 (PDT)
Date: Thu, 3 Sep 2026 16:35:17 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Magnus Damm <magnus.damm@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] pmdomain: renesas: rcar: Make area arrays const
Message-ID: <zldqedy4deednmec22sp4thap3fzyfyl5ldfgut72wfemoyhrj@lh2g7l5yvj6b>
References: <fbe8b4a4d90f0b555285cfb4ed18b6a2afc38b74.1788436280.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbe8b4a4d90f0b555285cfb4ed18b6a2afc38b74.1788436280.git.geert+renesas@glider.be>
X-Proofpoint-GUID: 6UHRu5vhceO6cbvPFppEwEnMJWAqpMcl
X-Authority-Analysis: v=2.4 cv=TqjWQjXh c=1 sm=1 tr=0 ts=6a997799 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=Ue1xspChCpTziZYzp1sA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: 6UHRu5vhceO6cbvPFppEwEnMJWAqpMcl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDExOCBTYWx0ZWRfX2n/gXvc0t7Re
 LQnItyLmfF/B3D6dYQcHP5SMTpjVy1uTcp4ksmaQvTpys1tRcsJcyAc+H65I9oFeEzDepxTlYEx
 WqTNkc43fZr+XfFyA5uLH5RDXdpDOqmJ1feKUY8RzrRIeWv8/XXsgGZr7a0kQzIlwo+KiwnKaSb
 gjJkfbcRLTFCekcq+IBslipAAuCAWlkKUKUUYbTJncDc/L9FpbSjM4kmjye5ge3HrwAq4Ilgtet
 CgV2vDHb3DXahxCHKuU000BxLv3GxPYYi+V7Jzw0eGDTlhnKaJGjo6ZNyL7leB8L7BfQ7EvfLbJ
 otoEscT2oJ9kANOvPP4Hpelcqydg5QXnetwtik1/4gbeXayQhkB/RZfCy4zzpF+PDwqvgUhNH/D
 co45NXFl4x2ITvMqCpQlQg5J85EaI+Dsx/ezAqzIHgPzRLQV65kp427hOIKoK3kZa1w9i3cCB+Y
 dA5tjHN9QX9hAesyiHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDExOCBTYWx0ZWRfX8p+zM/cjdd4c
 +cDFQeixqrzWmHWgeMWQCH/TMItLLFSBDLSIr8iAzffk11P4z++lTk3RbCUNJvJ2KFIyGpMsHKa
 U/+XY+MMjICo7/xMWNvdSyRFTLrxgT0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030118

On 26-09-03 13:56:56, Geert Uytterhoeven wrote:
> Arrays of rcar_sysc_area and rcar_gen4_sysc_area items can be const,
> unless they are modified by quirk handling.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
