Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794302553;
	b=AtEjs+e07zjsyPPIdmNpCdVkv9Na/7OACc8fDdaY20QjihUJtl7t5FQrhCDGlpBBCwDW
	 13xZqOJ8k3//ebsb4t6rsflmioIVRQGIVJ5dnYLQhHcOBSdRqziOG/c4Kd3Stoc2/p0mA
	 xufF7Ty8d9LMS9EqkCHmNzzrm0NNogYMP6Jl1WTUOB3o0ITxsWMFrO9DuwfyCNBaKD3K5
	 rjF4XoV0GTNisd7X5jm2yNI53N2iQeoAHigpKG3nCwsDekjRxWEML6XcShq8v2Uz7vusd
	 5r3llZlEmXP8J0WJ4i5lZNn1SG5KH1n0U6zVXCxsZbc7cwPjyuGZ+4u17x3PyRvCLWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302553;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
	b=CFZ3I3mgkZfwddLUSL1Yz+M6mR7a5/Aaq7jdJ3YV8amoE0vJbLBhSDSn/47P+DF2b/+k
	 QFWfYOCi9Udo5HVZBav0qSgPzvgtxkLMA1dddmfbvs8KPLphQPEZSUf6AO8GnapZL85zv
	 SMKQHMTqoYeI8YV41RxhLlPDxScU9zsQMokeXxbaqi7cUuNiRs9h+iAOTGFoJ+MXDyMp9
	 fhnm0Fz6VFuTrH+zDEsXIIDZ/84CoE2fHR96rNrCodQGgwnp8zoP++3R2JxPVIQj+AhYH
	 J+M4aYwN3NZsFxo6j8xx6ulWwmnYdFnNUtOXIqIVviMadWDoUvIj6YEmO/1ldrtkjIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="TEH/lf6z";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24016606EEE4
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24016606EEE4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TEH/lf6z;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Icz1UF0o
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AA7lF3q2240837
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:22:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=; b=TEH/lf6ziK/UgIYd
	uc0AeWExH4ap+dhJha48zpFanrmUVquEziATbcTJvfSUXNvCTmGNORHwNU6BQEZR
	gq7Mw0UyQgIVlK3VIKAR9mCt5g7ay5aeJydPgyieZ3o2KzvXKDYbU/cwGfXtw2lc
	tODvs+qdhJ7XxoXfKAgBJcZCwZrlv8phRtO1/n5lSbvRDL06sUKUIPYKcavx1J9E
	mL41DhnIjwpXgrSTvkdHj3r1vWeXIW1jLgbY8s/cfE3H7dou+yb+k2rHLpwFEQ3q
	f263ZN8J3UJ4OZK3MSqsyYa5TOcLlFnYqwAwzumqX1v1r7GAcTp/LTdLflbndjsP
	YfAHiQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4huucp1a4e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 09:22:32 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93e92aad34aso472575085a.0
        for <linux-pm@vger.kernel.org>; Tue, 10 Nov 2026 01:22:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794302549; x=1794907349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=Icz1UF0oRH3yKlXDYLA4Jjllfgq8a4kz+nRwPkVVcQVE+rnFYEFPDPOkBXaOkoWd1m
         GfdtjYbVJjGlzytbPG793LOVIdw9HLoHAXQBeExxR9hJWMuGc8fnO7b9wbJO8HNtxqMN
         XQ3S6RsqWq+TeWwly8paPEzfPn8GcSniBUmbxTQFvnqI+P4SmqNebUonfE33CmThTSCT
         mUk9E4gYbhmkRRRhGB8uLtGZuG/wjWObJD9/JptvYC9Wy2fV4Nkjy/4DFEwDzEUz3E7B
         AGJZNPh2rsTnWwpGQ2ULqvF5cvwxJraMeQ5OWBGkaF9U/vVZP9lDwIdmjlFvGkA3sgIi
         mj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302549; x=1794907349;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dyJLGnAN0Zs8RZGOGLmLqiW3HvWV8l2pKhgf9B011Ec=;
        b=SjRtQ/coaxIu1lJa2OEYjKKdv+pJzfXD9Gpv7ZLkV5lka3Yl8hDhrpGsJCRtqHn9Ps
         iLvp1YIzEx1/kyw691jDqi1HbmeLr6NIkwtYcq0d7tY8Uja9+WcT2AhmF9iXybwCQWTk
         UhhWARempDr6UY3T0/svPT6wZ4UZGVO+AY89OIXXEmJYCLgZoKlXesGPcFobodThEd29
         QypYu3IZzxDvuppSH+qlHQU57RLJevVCMLhdolUqCzmV90HaZGbbjTLyJygN/1DHkj3I
         xaqbhPzuorYAdD3Btmb2xyrI7enrfbmsVINin0cgz78FbQwaDNdfOXDsAfgviu6g4b6g
         FH5w==
X-Forwarded-Encrypted: i=1; AL+hErGLr+OhcIN5efGvXio2vcUTkDp1dTIoQ0HHOKYNFGrCQf59tHwco1ySAGToUcIzDpwStlAo5tl2aA==@vger.kernel.org
X-Gm-Message-State: APuU4Z+z/zVfrzULumcTjpTA5695YY8rGzyH/aIAl4pd3izZuWigR9zk
	WzcSj/jfe17G1xCL56+mQP6GVV5fqBwrO8cX9O3Fz0LU01wlQXginuzg1F6vuR6OW5whluUetjY
	sJrzfLdVFHwNHo3NZtL5tqzXlZiVrmdaA0tpwT7gGhLxYAlVWN9H5YJ9HcKBH9A==
X-Gm-Gg: AYBFou2bEENIK6As+LdKNGjyKlb9GUsOyFmSBGrtOaRfbgLFsqaQpmJTvlNCe8WdPlp
	KJRSS6Im7KovB0xFIHt/K+tsEMvCMXoiyBB2QP9RBHlQd6RehWaTV8/u1D4xqQKbb+MIimuewVc
	d803xQuOpSy1iC14eZ5LG/Lf8ImYCbe4jHfWHbyWMDzEo5XAIZKK4qAV1spTTRi6sImmMFkl38i
	tN7cxYbrR+Uanx+03dAJgi4NK4CnpWMDgCSkZrl2EzRbGosQwdeD8VdON8ZRj12N6cRdeNeC1tW
	ce42u8I64THv30LC8Ag/4tN4X6cc+vjLhhEFw/zC1zl9AtUZWUP/h2Nxb0GcO1GCGgZ+bBW/Vr+
	3UkDBX0TH2ji8Ltr6RKCtiUjM6oQcYdSDF+aJbnoU7/Or5ArBifstWUYWptmYnVq/f3txLumxQv
	Q9OWvvsMP7DuKnUMQKKbl62WZPY4kiIxa3r8Ub0R5oP1huF0LtnD/FpqH5ng8a6A==
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318964585a.56.1794302549338;
        Tue, 10 Nov 2026 01:22:29 -0800 (PST)
X-Received: by 2002:a05:620a:4514:b0:947:1d0a:c89c with SMTP id af79cd13be357-9479f326c22mr318962485a.56.1794302548873;
        Tue, 10 Nov 2026 01:22:28 -0800 (PST)
Received: from brgl-qcom.home (2a01cb1d00dc7e0089167b9b97a26c96.ipv6.abo.wanadoo.fr. [2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba01ff3428sm60703515e9.15.2026.11.10.01.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 01:22:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] power: sequencing: fix use-after-free in pwrseq-pcie-m2
Date: Tue, 10 Nov 2026 10:22:25 +0100
Message-ID: <179430254421.7208.10083406967609133170.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
References: <20261105-pwrseq-pcie-m2-uaf-v2-0-3e1dd415af9a@oss.qualcomm.com>
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
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: qRyHWU-Fn6MtREK_PbXnQmfJ5V9Y9ENk
X-Authority-Analysis: v=2.4 cv=U4oHnuru c=1 sm=1 tr=0 ts=6af2e258 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=mVFbF14yMUIBM6kXvQ4A:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfXza/XUgPguanV
 9hu+PhyiGqJI06aqQoy6vIAJSazX8WQHGkKusP6Li5/lsrsohDVn2y8YfdCtNqSnYMcsKiGslC4
 GhwTLsHrSNO3aMzvXBhOsRLroJMxE7iQo1yYk65qXJkNJc+k7SyRFlsN2YQDcz5giAXx9Wh9xwK
 jUeIGQxr4ian7TkUvpJ5e7aWHJOGg1dPQNguM2zvk34q1u5MmerpmTn++KSXwBXtDOJpClfXqJ7
 KFlxvkBcWuUjQvn31PEDNMc7+DktAKOEPYFXywxQyjtOExQjHyidA0CDApREyWQeFHhH0b4+1Lh
 uhXBc/35iOmVJIhpk3TdFHjU37opgxkM1p8VY2s51T3CQ82wuqKlFtpd1VFYwcSd39U9NGbN86V
 q5EZXGOQIBdexBTQzYcKDY/DF6neNq7O437Uqvy+u9oUVEBSkLqtTnJxzk2nsMPGRhxn8Ck0bsI
 2LBICL3UHEuzBhh07Dg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAzNyBTYWx0ZWRfX2xqMaXC2kqlo
 2ONoBkaSV0CwyI30EvMeAUtgHKeK4UbhZWAIW3zxvXbG0Zo0htwRP5cTpZezpMlICvww2qbYpCe
 GZ+m8R+rQ8b6NhFMN+BHI7Iulekd9VA=
X-Proofpoint-GUID: qRyHWU-Fn6MtREK_PbXnQmfJ5V9Y9ENk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-10_03,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100037


On Thu, 05 Nov 2026 09:28:34 +0100, Bartosz Golaszewski wrote:
> This fixes a use-after-free bug reported by sashiko and then cleans up
> the error path in probe() by switching to using devm_mutex_init() and
> dropping the remaining goto labels.
> 
> 

Applied, thanks!

[1/2] power: sequencing: pcie-m2: fix use-after-free in pwrseq_pcie_m2_vregs_enable()
      https://git.kernel.org/brgl/c/cd5f26ed96604b18e4235052525abe6b4ba505d6
[2/2] power: sequencing: pcie-m2: use devm_mutex_init()
      https://git.kernel.org/brgl/c/e551848a3a80aa2e2aab5bcd8f022c594b14eac9

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
