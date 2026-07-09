Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6AD23E95A4
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 08:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584784; cv=none; b=qAWVHpGoEHeZFYRRU+nqDmZsZkEfQOYlEkO7pnAEbMRlwMsO4447YcNsEVeH+48z3gls035R1TLeXKgovRaTzgVEW29z3PbYML8CxlJ3SlmHKDn46HkGiFXZJMd2UzdJ3LNUZxMzKsyPiQVTsB1aeswJRItVS/UZ9608tF1BxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584784; c=relaxed/simple;
	bh=sw4ZYQUkSTfi2fUJscACJ/CQoJQ5XIsAIE9CStuEUTY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R5tHbtauw8VOiXJp3ejptS5csOdY7p1CjzU4F3zoVwkrmUyy/0dldVsXLzVxfYi3YYrRyYI9O3ghYwovnAdfSIOl8NFp9RjyNoLajHc2FBkk1FhUDBKydZD4IJVMvhCM21XfO63jrAZaiKtSCvlvhnYYcYQfgl1G0DsAENCESIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R20WDevu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwniuEWH; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R20WDevu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwniuEWH"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66960G5n887939
	for <linux-pm@vger.kernel.org>; Thu, 9 Jul 2026 08:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=b1d7ZhWs9f1
	sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=; b=R20WDevuhVIFqzclgrOp2Phy05C
	m1JVaAb/UgDNQdE5wCtzUBSXIqB/B1xmONzdPUBNSQ89ehj685Lv5gSStfmtQHl1
	dx85KmaDa8KDzv6I+6xXQBqEgOzN7SGTdAVWexjsgNRafanLQTPH7EPl9NOVZjcx
	0ZacKNr6GIUg++8T2RaLlvgQul6iFIpqNQ2LcLWF65nUzt3JWdxNaonaTxzJjBT/
	5JNCdx6zIu0XmJ4LAAop0av6v8zR7fiYSgK7Iu0rYt7ap1Zsy7saoyzBbQ/2izVS
	P6j43w1q/XN4DV7KbFQTc9nwsfYSlh87yEj4cpjXrRfA+QwslMJH5HxmA2A==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9rq33g1w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 08:13:01 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3811343bd68so443990a91.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783584781; x=1784189581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1d7ZhWs9f1sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=;
        b=iwniuEWHOLXfGIH4WEvjEqTGBJkbvqMFVAhbAN657xFZh8JgFrmjAom/sUy9rdlc0k
         njnVe+VB0ptEYnnaJ15jlCz7xu5IoBDzC+iD2ST8tvHsbQ3n0lBlGW2XQ3ErdsnQyiMe
         8LMyghzHZG1QLVsPtxXdAKeQUHng0a7U5w0qN5W+17iMF08nT0NQc9qPw3oKNOx+AriE
         r6KJQSG6euJWmqokcV+0oawXqKs1zg7zVG9P1P/lFFjHmA65Rj3oI/i3bYM2N9K9DuXi
         TpFeNcqAL/u9UUwjHwNeBVtMYkBVPNH10l99G214Sq+lD0vRqsrjhSy+wK6WWXxGR22E
         93fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783584781; x=1784189581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1d7ZhWs9f1sgfVpFc0YAcv2UrqZgyUhnYNnbfueP+Q=;
        b=mYKs10o1BJSZ+bLu/IxbrSXybC11eV+7wjFugj8CXYXKr3pfm+TbTgmD4GMCb43SVF
         ytRH7BJVfNKF/2Ke39vFPT1Iu+itGns6Ic2pOHjwz2nEwrwv1msyWsNZs8F2iIE9NJp0
         huk+ByilxxxVkOAr7cJ6np5YQj3b7NmqVyxo31XUIsyQF3pIrcAQ26u4rouyFKns4GcD
         z5G1lVYukmvAQpHppk35HOYJRuJmCYIiBbS9fTW8jehww0imRIMr0wq7jeBTRhux35HG
         yjEXsvOr9nv2U7s/WHLMVJoR2xSxStmdODQ1ppVZZbsJpRHcHZ+JGEYmvl5gMnj4Ohic
         Tqng==
X-Forwarded-Encrypted: i=1; AHgh+RrpE8MxxBy2LCi0ZKTqv+sPFmSOU840ILEdutzQ55J4udwVq7oCPHEceNC61BFFYR1b7fEzgyIE/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBYuhHR85B950zYBMX1eD4sTL+gnP/cik4+72aaWMRsQPA8How
	qETnyIjpT34wAWU0ij6XXR3CK5z51pMRrTwpDG111THSP7diYon/ILeuPVLbpdj+MwXN0WgVjdj
	NKiQfKCKTUGWRe1+7BKVOccSkyGpYusqyelt4p6GzGJCSZYHNWpHv3JPeqLsF5Q==
X-Gm-Gg: AfdE7cnT1TOO0Nr4LzoXPN0amH6wT557b8CzXU1WMYwf4KqLDVOweXzAFkkgGpnH0Xg
	1pWMu6MJQi9M6VOA+3Y/ILduT5V6Ig2aCqhhPWv25+8STYlQbp4g4ZFwV013MxCvhuIO21sdHDn
	RltDhqDqTZWMhxBpI8eJTz2iesgjCbu8Gz0wfKqv5XyK1Lobc46nBRB9rV/tnIGGQLhPiKA3zxQ
	dcHoCsxU9JDk28YXrwgg3cq5DKwVKt08hTdP+R1LHSUsaulko4hSfGpfyezUVAae4CRnqpEJa5i
	lrYw+D7IjuqQuFkgk5C+EUo7xm7DRFtMHjUr9eKfPgDcKvT5DFEu1o2TOxDse3YY6+DN3VewNWK
	rH/7DaQbRX5M39grCCFm5iT3vf8ncsYe/r1QUovkGWOOgq5N8TAnVUyTiy2okzw==
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id 98e67ed59e1d1-38a1f1de21emr2603832a91.1.1783584780869;
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0c:b0:381:abcc:c8d8 with SMTP id 98e67ed59e1d1-38a1f1de21emr2603808a91.1.1783584780378;
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a5506b48bsm774740a91.1.2026.07.09.01.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 01:13:00 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: dmitry.baryshkov@oss.qualcomm.com
Cc: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mani@kernel.org,
        brgl@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
Date: Thu,  9 Jul 2026 13:42:54 +0530
Message-Id: <20260709081254.422145-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <vpsczyjw3ew4lhjwy6edzjomryna7ygyamgr5idw2aiq7al2lh@64to3cet3ufz>
References: <vpsczyjw3ew4lhjwy6edzjomryna7ygyamgr5idw2aiq7al2lh@64to3cet3ufz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nVSDHio5zzPsDKuJx8f8KixS1wdSMb55
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX4z1AWt81YzwS
 0kzMFPi8GSMjxQf+Sd5oUvrLl+Yo1YOriGmpnSDJxz+MeHmCQ/6yTM4mqdNx/7B3ZjvumlXbOj7
 hIaXslbRllHr5cRv6wUa/QEpgDXlhYWmRQucZCNKzH3RbWnMuAGhPO5NFjmr06LivIdInlKTKi6
 7R6x/pKCO1N5ZoV4My3/WY+ILGgV7czawU9KWJpO5qkzIN2Z++FLHhyzDUoJFNRU0P9tQPIHd5B
 ZOhWB4ieKxDz3DWcNLFzA8NbE6T+wHRaIMHrnNuFWVxO0yEVUnVtQy7WXEQmNH/07bBgJb3/XOT
 gO6XO57KfdqQIccbq+Z1NuGRLL2d++rR3ThxhL0gt1fw0OTDRfSZvm6iwEl/yij2ZX7Pb/DzB4J
 Unl5+3ZavqpDR0QMwKRWuWaTvwxC3v+mj/9LD1HP07Isw8jgPT6HAcgDjKkTwZPKHclLir61WcF
 Gbr9nXlYzAV7DbG/3aQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA3NyBTYWx0ZWRfX5VtTKBxeU4Sr
 lp6N8xmx9vxgJJ9IX0H8fXalWgpDCXw4P9fngfVl43ibhghp1jzpi5FdUjTR69vnor5NH3MdGbL
 WdQoG7aoeEAELzUek7Oe7VLYUQENIz8=
X-Authority-Analysis: v=2.4 cv=PYPPQChd c=1 sm=1 tr=0 ts=6a4f580d cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=eHU-EKddRagIODziGN8A:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: nVSDHio5zzPsDKuJx8f8KixS1wdSMb55
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607090077

On Thu, 9 Jul 2026, Dmitry Baryshkov wrote:
> Separate, unrelated change?

Agreed, will split it into a separate commit in v2.

-- 
Best Regards,
Wei Deng
