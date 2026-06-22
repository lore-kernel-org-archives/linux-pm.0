Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37139060C
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115563; cv=none; b=eXXjbTKeyFrOjk93RWaAXb4UO4rNN/RfQ+PsR0/0nG2o9QHe9g7VILbdLx85GqNwOIiVNCxoXO+cu69f59D6NwwZYo0EetWzKTjkLRuLcb6unpFjj1da+CSLxgrgl7fPTPvaEySOXQcJItoBjC5Xo5Rc2fU7KjZBUL08O0TiBfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115563; c=relaxed/simple;
	bh=3WyWG7mlJmk4dTS9WKu8lTcjWQLyuU1B4DkfUKS3UPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VO9xe+k7wmvwBh5zVpVaECmYOBFw/OnxfV90iVG/9KzFvqErb5pKg/g+j8AbrtFKl9+JgznjcT5aPTZXl2BcN4SuPWCy8DrKq0iOVwe9RKLqGaGTz8a0U+hZPqVjjomfjTH9V4LaHiXXFo/Z4AyTDs8td4Pmk8d7wOfKPhi0wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cUJZMN8b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LdLFDeDo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cUJZMN8b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdLFDeDo"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59BxV3850431
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=; b=cUJZMN8bweLcdOP/
	mkdL1tUu8YH+jdj9Xg6gCtK4K5UG/DI6suSBe7dBGlBUdyUgMrgJeML4aD2WrGCK
	gx7Fp8w6la4QLXrKnXjHJRbl/Fqf8M1UVJnLeCG4+Kv65xZBD8LsSt2MsSFgE22s
	H4f+MA+yFXhPS7mUcjrxiDghbp5Zj5qG5zjnBpl1+6cA/ElFsne/C4Ft78uMf1ip
	PpA3vReL2d/x6hkWVKxZ48chi3ckCjgJAUhn9ADLEEfTEIIe9cdQw17EBPksMRwf
	Z/v1aCRSbZmpu1yq7UQ6gWgsPr0Jfh5jgS/igTpPmy9WPWuZ1eKkWXhu8Yer7mGt
	rO1RmA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewm58581j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:06:01 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-91598ab3a1aso519175385a.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 01:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782115560; x=1782720360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=;
        b=LdLFDeDosv8WEUolSNmk4sXC4J008urb/meBhPCyFArpaWmnKJQkXl3QdstMZQYfhI
         kT7nLjDYExcuUdwc5A5hnJYCrvlQnyG8xD9vlFydmHO6tH+qTimB/G3+s+SHnljewwAw
         W93v9j+5fCfC4CkEb2SVZX8tRJCrWjySVW3nzd6D4VyxlomoXCo7c6oFqIwOpuBR8lKr
         0wDgPmIGH77dsLE1dyecOUBsqSFhWvl3tssXMOqAzvxwXN4nr46PzuCgx2lMrr+wsRXt
         cxQjL4Knnu7qquEgilxyI1aVx6MsJ2vCUvfVF97EB6TVViRr+80gBnSZ3vN8+UxFqU9J
         wM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115560; x=1782720360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=63b8/Eyb31YE8fxcYSbZ/UmhGcOjsVSMSWNSmeAo0+o=;
        b=i+NO7jlgnRaZU3yPPOEBteDDNQykpIWQVa9/GEJyfZffSiYW6GVDLNmTMC1SeuUk/d
         Mv5qgVzdPdTKtdp7AFa1FxoQVPSHypaG63gHh8LNi7XH63h1GFDk5284Cux0jG9bK0vc
         1tjFqzpBb1WiDxeDL5rE7iFf+wiLNYMGsYT9rnymtV4dCaKp92a6CR8VwLhYaS1XY8pE
         ZIKAEW5TEJB4w1aJehd1W4Qlc9iNilCPqCIAOF7ijXiaXhIrThxIWQaV9Q5I0VvBjXWh
         FRktXDaU14CkjhblqiBj9MRM8vD2iLwVmvTKFX01EsantbGNGUJtAiEgcmWV2brTq5QZ
         U5bw==
X-Forwarded-Encrypted: i=1; AFNElJ9XQNkAOF8gTTMUdq+9ug3ZCn4DRm83kK8bnorsPk0XVj0HV00G4tBL1C4VEVu9NFCpDDYL6A7Ntw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzI3V/5LjxvKLC02io/Xfb4zSMuuATc5At/ngbrQwtOpVA1yW2m
	ng5isUv0YAIcfJbzwREMy+JT87zTmmJNzR38P1qGQUO4HEKRuH42EHz+nkf9zy/RHoPsBEeW/b4
	aO3v/4wtyyU68wWn0p19KSHKgKZ2JUd7BxNs4Pn5nwECZK3V25+N5DqO/99I1Tcjx2foCdvSi
X-Gm-Gg: AfdE7ckjFNsIrqtbg8w6YJSYc+HXezPmvbFGNr+a9Yscs/jt9FsF2Up1yP1C8J83cdU
	DmtRk8XFYf0rOfD33yrWumcllf0AmXHNUnvwFy/1bm3GQzbfw2JjQlOpf6U0bByMzSbAmvskkC8
	MJSaRxALg2DAIVNJPlF58tMW3alISikBhCq4uwYoIa9VJq8r9yk82Mu+o+juuj/DIHYFAhQAdpN
	Uqje7C+OSmXHXZwmz0fl4eoeFB8F9MAgGntoxGyWZL17tOp5Zi8C/6yiMFpRxWCXHQWZWardOu+
	rniNc+ia5Y26qr0v5l3K/Oz7mOE/W36/5sRGDb9WDSmaMnfD5FiTDXuSE582a5VvlSJqOTr+IQv
	OmqKi0D3uDt/4pw7etezHQsfDvBdrPpZ2oxj1vJg=
X-Received: by 2002:a05:620a:4483:b0:915:d322:c47b with SMTP id af79cd13be357-920d1611869mr1865546185a.13.1782115559934;
        Mon, 22 Jun 2026 01:05:59 -0700 (PDT)
X-Received: by 2002:a05:620a:4483:b0:915:d322:c47b with SMTP id af79cd13be357-920d1611869mr1865542085a.13.1782115559267;
        Mon, 22 Jun 2026 01:05:59 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24040371f8f.23.2026.06.22.01.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:05:58 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: [PATCH v2] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
Date: Mon, 22 Jun 2026 10:05:51 +0200
Message-ID: <178211554552.11059.10528035877623470920.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
References: <20260617143055.820096-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: FZwqaTSggWIPIp1k7LaPocTqoFujsgLa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX+7iPPB5n6YLl
 Cciwg8G+f4oW4F/tkN3LEQ9X5y99saqfrok7WQYf5Ao1ImK+rO06GAssNSLjMShQzWXpPANrLfG
 xTdOjnGs4rNIpQ4vLBq+0RWXEpThjKY=
X-Proofpoint-GUID: FZwqaTSggWIPIp1k7LaPocTqoFujsgLa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX5mmUE4F5JHh0
 RR0+naTYw7qt5ehreHUfc0QAJttiQEhObOxPZEAseSqqzSR9u3uw9GLDSCNljSKFAg++gFKVQeo
 7Y6IvgUgJ876kfNopuBUywjLsbDU/kQTwnalrLRhBL28S56kQWUYxvnVekFgt84j1VSUX0UO+9g
 Dhhes4AyD/GJeLKp/cRPfvUBpdJs0qGA2ywDnhh+QXkN57kcHqicv4jnniPN2VdJk5QWDwdGOQ7
 HVkLfNHuo1kY6CwT+qPwr7trTx/GqFU5zi6IqvgilZEvzi66zTzNs/alx94w9vc76J8oxxqc9IC
 fk8FRV8KApkXseMhYukjeaA/KKEZsgJwfzdqkFEGRayUOfRsG4227/fROQwU7YcjFERGRDO1g0u
 oAcb9ateRqOLC9UbqRenZIwRCYzPawkj1re/XMi1yfojv5L93qtz5V5Gt7OEscH2U3JtkrKWDes
 YXjkKV846igIN8k1mLw==
X-Authority-Analysis: v=2.4 cv=FOQrAeos c=1 sm=1 tr=0 ts=6a38ece9 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KhnnDi8VfUj6Ww44RVgA:9 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078


On Wed, 17 Jun 2026 20:00:55 +0530, Wei Deng wrote:
> Sort the entries in pwrseq_m2_pci_ids[] by device ID in ascending order:
> 0x1103 (WCN6855) before 0x1107 (WCN7850).
> 
> 

Applied, thanks!

[1/1] power: sequencing: pcie-m2: Sort PCI device IDs in ascending order
      https://git.kernel.org/brgl/c/251c8e86539aefa88980b3dccee7d8ae4974af06

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
