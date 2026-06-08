Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF093C9897
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 14:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780928389; cv=none; b=O3phK/MMrsEDHBCaK8+qh9GiYNiRwizqWDQP7o/XYZy3HhKUvqoa/WNUx9mftNyjfb0PoXYqh3wewoeBk0NOOhVwmaADpSEdpQztbcdy5CG3AUWDdyE9LPZPPWGSKq9ie7Pu9ODH99aY+BNQNaAzXxjrB0+OTVIRu3A8uxnc/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780928389; c=relaxed/simple;
	bh=RCYy0IHiJIJ71s+W/69dtSzgpRWYhBpmknflCMoSQ7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BHYOmLfSoB32aIwH+lIaMRUwe6i+L2nfcn7M4EPDM8YJsH5Xv9Qqt6DW/J9TTuyLDXf6iU/rZK+4KRKcdmgSlozH/wvaDi44cFBXbc70eVCHiQ/RpX5ZSgzlCaQVFF1NnQwkOF/s9sPFCcYXKdIpdoFpHnqYdtPbw1xFD2kJpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k3N1gQtS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gnEc0q/E; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k3N1gQtS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gnEc0q/E"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 658Dkwhc3275384
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 14:19:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=; b=k3N1gQtSk6OnTdvm
	E3Xfi5uS1MXoIMj1wX3SgYwWlu2h1JuCd+0V7Om7+xRUpC1p5VZWoc70uaaLLQ1S
	dOSrfCWM/Ut+fDoDbd3fn6KLk7Covdz4ClO11shd6Dsq4rkzC31YIIs3qfo/zBWT
	scbGj8S+apvyyujS5UuhcIsvHZgDKE5iMS74v4LwZfujaAxw36lOhG+iOWd28buv
	utg13w5p2vIF4YRQ211eQuAo6639MX+DkrqiASUKtzQnXgUGdga2fJQi4q/exhCF
	MoRn0NNBTon5GdL16F+/99WYZLbxs8eE7GEoKiy3CW07kBIwr4G4K3CqKcjZpj7Q
	FIKssw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4enxx404h0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 14:19:47 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5a47c57219eso4605044e0c.3
        for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780928386; x=1781533186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=;
        b=gnEc0q/EJ+1Vp/L2aJ2iXTHxsf0d97IYT5cqjLy2WUZScMkwpBSXj2YqBrBjSmYPPq
         4SB2PBp0u1RIryn7GRROYMNB+FKpra+WJtpXu/iZQfs+fZhX3mYegR6qj2gk8551aI9c
         a8AgYIryQZlmvxq98poTZktBmWhT/JJDWUCHlUpH85iwTxIwcTXmHAxVOp6FLZjQebad
         MCVfktJW9W1thWqT04cGo7X1eQuNSD2Fx4HSRSE6ja6+W2YGn5ZXHADQaL5ZU4yVL7yT
         xk0ignjxlGjWkxjpr7DWGBASksk3MQ5b2jgF8DLN05PPkndqhNYGIDyszmBMB2WK1YbS
         5iiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780928386; x=1781533186;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T48n2DUWsXNrk3FetI/dF/Eg9NT15exAWsHm/kM8tw8=;
        b=VmwEDKKcOoNZNtu+0jEDdmeSHEyEOMHUFvm2tY2Z+/J4SnRgThIBHKV5TCdzFuiXhJ
         BzNKvn4Xe76VzCC+8wjBfTzlpmyVP7MiK4CFGigy77R9is+Q/xZqI7xueMEBqHvodl5S
         7X29DIexe3POL3+6TV3YpZjNKE93P+IpglsM1I0pNxJiJKFHGkmUaWKbWro2HwnOy3C3
         0YNaUmIcfxGH+ku5KKTMAZylAENRnqHabuqbMiN7U9hURS2k1ysWVgKNq8oSReq99B+i
         3IPy39kQIOH5PcnooWBztsN+4fjui3PW07tHQIT+osZrA5qCXO2K6iShUBSb3Vi5kApc
         6LGw==
X-Forwarded-Encrypted: i=1; AFNElJ/0rsOtkH3Rk/j1k8ebu3wlbnk0Uo6vWzPk9OoIAfBE1N3rtJRIx5ezVldiuRaYXi15aGyxjkjFIg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTNOKvaN2fRGhSkwgp1aseEIL5cpQB/KqPc3YLs0euxaSFfL7g
	S2MFAj886ewd/08+3E/cesESYjUkuBhdxgqtJhuysNUkr+e+W6WCpopO3kX8vADLn/Da/mCfNrJ
	pVkHipNDpOoZTmho3QfFyCWAFVV1TH68ByuVyJnaClBgcaP5SWkPKpD34KmSEDw==
X-Gm-Gg: Acq92OHOt8DdBD7gkxxUbG7C3H2et0nX2VxzyR2zGO7UenbDdHkauBek6rCIA2761YV
	GQxuEIiQX13syogf99NwFe9RfRD7uftDEWhYzD+upnfqB0F5X4FO0P7cuHwu/JA9jfe4almtb0S
	ijbrc8/u3cbAzCI4ANWU7zElEp2REiP4Xp+lGG7fCBF7M/9BAKzUTQ2BVpGdDTmxmPXdNra9Snl
	lAzRshPqbSa8MyzozofnJeqez9rrrqYws8otfDBcsYp7VK8j+jL0/mCuuueTJC6m/YERWUftNU6
	YVNa8/Pw/NbuLSh4fslEbdING3Izv7luQ4KeQXmN0tCXP4CrmtYaYIJDaUfMA7egEeVMIQWtGmF
	ezaoOnOpJsuuMxFL3w8YzC4ckK9vVfxcBnQzk5EdPljANP/4KouIJ5Ple70c=
X-Received: by 2002:a05:6122:1796:b0:5a0:c38e:6199 with SMTP id 71dfb90a1353d-5ac4ca5ce4amr7610856e0c.1.1780928385972;
        Mon, 08 Jun 2026 07:19:45 -0700 (PDT)
X-Received: by 2002:a05:6122:1796:b0:5a0:c38e:6199 with SMTP id 71dfb90a1353d-5ac4ca5ce4amr7610799e0c.1.1780928385554;
        Mon, 08 Jun 2026 07:19:45 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:4904:8660:26f:8b6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3c15cesm397599425e9.5.2026.06.08.07.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 07:19:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Wei Deng <wei.deng@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_chezhou@quicinc.com,
        cheng.jiang@oss.qualcomm.com, shuai.zhang@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, xiuzhuo.shang@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com
Subject: Re: (subset) [PATCH 0/2] Enable WCN6855 Bluetooth on lemans-evk via PCIe M.2 Key E connector
Date: Mon,  8 Jun 2026 16:19:42 +0200
Message-ID: <178092837981.163118.4463258851423326572.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
References: <20260608091702.3797437-1-wei.deng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cverVV4i c=1 sm=1 tr=0 ts=6a26cf83 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KxFyB6w1bcBEixo3GQYA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: aSgvMjvFLb5o7AUpz00GO7RRrNZFWuD9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDEzNiBTYWx0ZWRfX3oHDZxR7G5Cy
 W+AO4f1WYaVWfTs7MoCzFqJTe6sUNK6YxG5s5GxV/2tKMl+mNfLJeaZdMiSCXhtnXYVZw61An9o
 IGp5RlLTFDKgNSKSWGCGSDsNcWJ+KJuczHRsAn4P60scP3v9OQEoKONtoKqSzTAPQbBEQIOxiz5
 ddJCF9SIuh4t0uGio5PL+SI5Cf6/oFHStiooeM8axO6ZZhNokhCQOh+m7EyndVspmxxr3EDO7Lz
 lbGhqJenrvQUxTqoTBmapa5GKYjaW8H340uzTKGKb9DgxSbTOUz1B5DUzaW66euRKG54IXAFGfy
 P7XPym09I2Rr2GT3WrYh1h9Nw4R4hkH6OTaG9j97E/KGP4pUhktQtyOGl3ufZ6RASeSYZEZ+zJs
 4bhhfIimt0/OF2nWWMFy42PTS7e5jVKgS1ALe1rySUZrYZCoi5LErlDxSoHdw0nHkELgLgbwGHH
 vx4S4GK7rEob6GIoaQg==
X-Proofpoint-GUID: aSgvMjvFLb5o7AUpz00GO7RRrNZFWuD9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080136


On Mon, 08 Jun 2026 14:47:00 +0530, Wei Deng wrote:
> This series enables WCN6855 Bluetooth on the lemans EVK through the
> PCIe M.2 Key E connector + pwrseq-pcie-m2 path.
> 
> It depends on the "Fixes/improvements for the PCI M.2 power sequencing
> driver" series (V3):
> 
>   https://lore.kernel.org/r/20260519-pwrseq-m2-bt-v3-0-b39dc2ae3966@oss.qualcomm.com
> 
> [...]

Applied, thanks!

[1/2] power: sequencing: pcie-m2: Add PCI ID 0x1103 for WCN6855 Bluetooth
      https://git.kernel.org/brgl/c/bde2202a2fffd3137df9a0b4b8ffd8a44ef316f6

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
