Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B49746D544
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158111; cv=none; b=gAjl5WR06SWj4eN+N1SJFfZCPquhkOWcDFo1oZjlHPWqhyHx25/RJXBviyEyPzs+AiYxwwbBw1tIhYKpmOrepZ/BufG7g62LKpzlG6LHMYtt5E3yIxSIHzKg0rsvDAA1GzwptgTEvwLMlOaYen4taV6i3M82/EO6nSZeKYNA8sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158111; c=relaxed/simple;
	bh=/zR8X6sWq9nDJwlulrdRxs4JEZClf9bzUIbyy6aGuMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfn+ADbEPuP75IOi5fd8l7tmKi4mTh4BBaDnghFMcucZdJIsVOw3MfXpFdEq0dxPvb+5CgVA5ooE+wuTQclWgE7aVauWX9P8uUNSrHCBV+Pjkng19Zu++sHZmDO9TxebgkB7ZcOWdFXZfZHLa24bt4Sa9JQ29shY9qZG1ho4pOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=QMJa48YV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PdyI3gcf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="QMJa48YV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PdyI3gcf"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GAAT4N3069379
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=; b=QMJa48YVEcz4cPgI
	11UqulUYYo5Bi3mi2qAw5JB7asvNfzBrmcf/eIk3pghjWlWzYkbs/Eb6YvYzzk0w
	Y5Q4BtnMFqIuk9yAKmpDkdAOsFy7Jyz5a2B9Psn5NW3pxGZCakFrggMinsHiJDvi
	vTz4P7YDQD0ytBudc+F3c/J1cXkGYcTsg/mBqb+dzqnT0s/gegmPo7XFp5wqlcIb
	ytMOG2ijjrzMlcbJtR2leQABtlUJhvTQg7zqTxPBbDBp0fWcVXF9l7fozm/NQSZ7
	M6g5701lLv3R5NmOxvPalCrmppV8O99WEK6vxmsKrzMr6EU5yl3qfOcUAaRYqwmL
	8zBxWg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hba262hjv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:41:49 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91792488228so138378926d6.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 06:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792158108; x=1792762908; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=;
        b=PdyI3gcffOZxlXP50kTuI/UWjJS4ES4Tp+2hFfaofhWhwN0NkTPcUCxWqGeSp4A7Vr
         CPiMq6oOe7FiQKQgd/6Kj8OevDakOW0ySdsvGwFhQcncaBp70txxHmwp57A/ViS7uGQV
         qwvDryrOO9gAeoN5Oo1o0CyX/EuNS7UyOtrNBvSF8QL1VheiU040jJ1Qkrjrc72OinII
         uvZYeY5XKcTpdLwfrl6X2/hDiKGrx/t+iue1IIuJS3i24DNNKH/D0Qrx4Ql0zrl/yivH
         HfAWC6zuGdvTHqxBoVN2XoGCgbMkPfSne8cgolwwDva3Do5ztmZSzQ0R7BBcVx4CG+h/
         AiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158108; x=1792762908;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LLW0dwvOxGWpHegS5C7HG/kvWUkdwyRzWYnnzVJQotc=;
        b=tZH7+fUaxkCO/+t60kwIBmFwwTEpvavfeN20mLyHbrJcAlG2dGleRJuS2FccXh1kEf
         nklfoIq7dMRdc3Q6nJI063M2ZemBhKNBexvv3PJ7oSBq/doQU1eU+ODfachj3Qg+lbnj
         jPKFJOw1JaO5pGgoUadadUmyKP31w/yJmnLvy5NNen87NR4jOHGdp9RjrBK5JZmQfKmd
         KlOiTGK7HrPLdFi/Nfy4pv9OxZu6H1q8BBAKy5YjYS/TyB2Lpx/XM2TaLW4dUnNnWNs3
         fqPSBPZ1q4btnDLhrB6C1UXOBaI3ft8WCTV0HsIvYhHskuIR4dtQbR+ROhb/g7JJRVaL
         Ne1w==
X-Forwarded-Encrypted: i=1; AKwUvByd/McbPWnal9MgPdE4OhJL0ePf0yDMHPBTB9lbYjBoTeUGO+3DPPm+1snYvvCV/h+h7bWtKXbWbw==@vger.kernel.org
X-Gm-Message-State: AFq9FYJYPJ470IZK+UQwiUE40M5kxS4sciywSjlP0Ds9XY9opduWwv2z
	o1wSVK4sgSfGnGMKJ5boSyjTFK1c0DR922Q+9LLBXeZ98z7Hqllg52zQnCYAPkozD+ewommud1X
	GRJVmKBCedIxo6zY8ES5UweDueQmHeaeBeMAczMrHmCeAry9X/cQNLzI5sa/7ew==
X-Gm-Gg: AYBFou2ZzryYviwmqwYX+CH55A6shFCOOYaSv+IL4TTFEenVKB6jxsW4lwvSbBCzAWM
	UDjMmxcwufhuf5b4WAxpqhFqOV28ccSdN/ocG65qPBLi8/9ddtGACGqrBudWGSH/fTHEOHj/Ppk
	Ui/uR1oaTHjnySEYAYC2Ud0tOEJ5PX8vDxemFFnwgAVHJ3vDf78LIQutjTSSpHt7L/BzNy2bBaP
	7iZfH4ZHlPN/yErT1f+cPJhAnIrR4mjnRWWINvlsyQe9TC3yo3LHY0GZifJEl3GbV98s0gSXQiN
	7Pu55yXmSfoSBHzexRRZYOb/ABN+0egM6z7XJRAEAp1LZN2WkG8Q3P5ICk8BWPMdI6jnhaHxheT
	HHR2RpwE0CJOJGpPFfAijQlvJp1E=
X-Received: by 2002:a05:620a:29d5:b0:93e:920c:bf9a with SMTP id af79cd13be357-93ebd1e011bmr3417416685a.13.1792158108252;
        Fri, 16 Oct 2026 06:41:48 -0700 (PDT)
X-Received: by 2002:a05:620a:29d5:b0:93e:920c:bf9a with SMTP id af79cd13be357-93ebd1e011bmr3417410885a.13.1792158107616;
        Fri, 16 Oct 2026 06:41:47 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8d1esm5486672f8f.39.2026.10.16.06.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:41:46 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>, Val Packett <val@packett.cool>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
Date: Fri, 16 Oct 2026 15:41:44 +0200
Message-ID: <179215810170.58960.8245836334838240026.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261016051745.577777-1-val@packett.cool>
References: <20261016051745.577777-1-val@packett.cool>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bsHZl0ai c=1 sm=1 tr=0 ts=6ad2299d cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=Ac9oEOQn9GJuJuDrb4UA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfX/QsAJodvehAu
 Ze4cxxJAWFKDqaj88r8QP0lTp8hJg1yS3hUsK7o/relRn+ovu1m6VfZmL2NPQKHZLE1oGSaTv1C
 dV7JE2fpHC38lM44G4j8b7YfYnDxiAQvRIsEVvnm2V9WZUDfhRFbzTyc/I9AcgzOPLsllTJ9CGN
 yWUfHR/3ShZBGgbkV3Ng2tLU0wt+IO4MHKVZr7sZPDN2Q2iH5xNdtHYO5BUdc1Y5x0XEwnOsYyY
 JvbqFwl/4snlNOOHvoGgQbWCFIIJP8qUC9O9x1KRweQlObKjsvfjMS7ecalEhqrUTN0tcYXDQJT
 FeY81CiUX45u7LSMCPb9xzQFC0rkStMQvVg9iu21SP+DEqXPZvDwaDUfIfzU9ec3TRCaQJDCFOZ
 kRx5JTrnaM6FXfcPCgOj2bb0TwFrzGTivmBvnvZFQFWF8bWwyM/+lK12nK5RMxbaGUmY0cMpSTZ
 E0wEk+C4GhUBMcuSsEw==
X-Proofpoint-ORIG-GUID: MOlZVYSlV2H9M0YBW_GBxjT9OOy3W1aQ
X-Proofpoint-GUID: MOlZVYSlV2H9M0YBW_GBxjT9OOy3W1aQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfX+vJseHSA9IPx
 +HrTN3mqJd46S+1g2nCcBD+WcDG223HYdXpZfE8UAWLAw/yYfH1q6D9RXXsG55XBiMlceEsfhg0
 kbm42H9Km34EZS2ysXF0kYVKuDoPbM0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160054


On Fri, 16 Oct 2026 02:13:35 -0300, Val Packett wrote:
> Add a new device match for the PCI subdev id found on the Dell
> Latitude 7455 laptop.
> 
> 

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Add Foxconn WCN7850 subsystem PCI ID
      https://git.kernel.org/brgl/c/eadea156f11b2c9a780b60c1699c2da145c9d1f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
