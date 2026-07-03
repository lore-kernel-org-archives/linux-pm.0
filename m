Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C75B2DB785
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 08:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783067444; cv=none; b=UX4WQzZd3saxmb5uo8C4s8LQIwtXZWeGa1o/lKx4+i7OHQFtTDViHNdcDRdl1KaKKKV9CwGzIv6SLTmG/bMlu9S7EDNilAyeM3YqjS2ZrssfbWLp0+VT7akg7NRdm5DYxKWEaakMfZ0Siei7rDBdH8C04Xy2SStDUfDwkpQ6j9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783067444; c=relaxed/simple;
	bh=vkOBJFJbc8ahCMf0KYx0lIWWOVbcyMJFfwTRFEwuDcw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tJ0jisTu0TWA+X1LlhXUFRt83A8cPUR+7kQjnDWoggZ8cqCNU3FqnCjF3qdLIDOHrMiEyqOFDXCzEKo4Y6y1/3KCEjkJ3GuW4q+kWpLSEvCuB/DthNdfjez1jzzT7iufVaWWGBg/rEYZKNj8mviKBfoG5QYab5INmfjoTViSOxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lenN6ra5; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LkcXeAKY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lenN6ra5";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LkcXeAKY"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6637ZgBC3410048
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 08:30:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IQzB05Le3t7BkZlqCUIOe2NWZsKrvDirZj8lWTmzDFI=; b=lenN6ra5NjvNgmWd
	P6u+RcmhBs2ddlHLmfmYGfkWuFx2K57HCwIgl6OT431lEGa5CMdBvL/dtaxmAlJq
	RuZaPyrKr3mY+BHHpgRJOahcD8J6bpOkIR0cwIrZ4ffAfeM4wkD3oi404zsGQASv
	nMNwVg5tOkaafYVTlefy2A942gwIzV02kpreHnvta5+Zvb5KjacTUk4Zc6Km2fl9
	5LhgKMbUI+hdZ59dKbvIN7aSKHzAXJlXLj8gFjH90ao//wKlgS/b6Urcv0iXDOIz
	UCBAFeCrRzXNvU2WezJLVe1VL124MAFfPvLCspMSJFSCh4pcNo81zPbyvzFjScJ6
	sRvr+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f68u306em-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:30:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-92e52306621so23421685a.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 01:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783067435; x=1783672235; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IQzB05Le3t7BkZlqCUIOe2NWZsKrvDirZj8lWTmzDFI=;
        b=LkcXeAKY6Is8pm6hXVRsebxCHRKgaw/AKcv+TaaUT0Evf4Fj1RLNUfZ+hy8j8CZBKq
         3ZzXZVRcI7nb+chICAc9S9C7r/i8aY/8J+wU+KvVf+3QmtK6G9DfJ5vEbOHE0qaV4lb5
         PH3rttLaU0xhZSOSdPJnm0e8HWPj8zBsT6w1Np+6qja+Fmt95yRg/glhZlgp8/qE9oBC
         xwY93/HghRS5iErzMK6aXNFb6T2bq+ZexfzaGzG3qA49N1xJBjNmpnGr8pg9TjYNTBvb
         DLU/a2LfeUTKMyDgZaLMmKH3At9CfhweDA3ndUlA5yQjHhnLlaG3KyoTA2+PTI5pvRH5
         fk4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783067435; x=1783672235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IQzB05Le3t7BkZlqCUIOe2NWZsKrvDirZj8lWTmzDFI=;
        b=CxhaO1ROZ+uu8GETpz0em/heY0KgtRuJml8bUaGq8G2JOioMS/vJ+jBSFFKjdxP70M
         AEqVsqFH3FdTsrHidIMr0Jjc7TN2+Ffyct0tSCrUGyW+x4cPcTdr/3eNuSmc3sMvhqqb
         DoibToPoZGER7BnI+G91fOi6jPe2iRMxaie1K37ZHGcnZlZztbufRl11QQZpfhkOuGEP
         s9Pn1TJVTkdt0nY9xqQ2+mnWY15bPXWnMcsvAhbQhyKIxgtCniPmLLPeVnIZF+RD4Z4V
         MEBQMCAprPkxCFaHz1eNTPeLDLu5df6QIh3rWsoC2sYFIZp0zWjrxFwyhJT5/ZMHdatb
         bHaw==
X-Forwarded-Encrypted: i=1; AFNElJ88iF4qKNCYk0sBOU3Zqk7Zta4w+DRkf2KZVmBrEv4sFERcjpKLm+AQrZ/dIakjPF8eS30WPM/n+w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/bPT3qVvgktONOfoZwDuxq4dNnVlwE9+dSin8l49VB/pMO0yR
	roaERVgzaeBCek/VOgNhTiP42LjpDlfL/6J4+fTUdkedPDTb25Ycn3YaMyIoqIaRHDWlqkOvalL
	eDpj3NzuCSIWUWM9BVQVu8gFVgHq4u1DwGYYG7eL6UAmapyjg8mfY2sajd+SWWw==
X-Gm-Gg: AfdE7cm9zQkf3wG1zdFhXI7tnImfBinv6Q3J8xJfbkHcQ/MP5W1xkjIfHnFqBvr8WHY
	/KmQRCqZjvUCfynU5OjXVVCz0Fj6923AMaS3tHnGa5kAkifnaYb+dw7w6vMaOChx4F3Ors0V+pM
	SCKRMPyvAWKwqb98cjhmTpdUNL23Fpi/ZMtiI7BbP5esdQLSQ/Vo9RtsYo6fsHe3+yYY7eXM/hv
	UGRR2jj/N8bGyt/q+tBgyIG2SzEuUjF4S2YntjudSCFFZDzOpjThBfyzzyr9EEh+/KZiqHvZlu2
	GY5JnwzZ+KNZ5ITS1PEvgAbUPnN+B5TDQ4SZX4bunmhfOTr88iw/SVstOOoO/NJinKDZNfpY8mG
	PdyDQQlJHMNhsfOTa3GP3ntQcKULtnCT7aFdNvmE=
X-Received: by 2002:a05:620a:4711:b0:92a:dcf5:ba5b with SMTP id af79cd13be357-92e781d35e8mr1242533785a.14.1783067435216;
        Fri, 03 Jul 2026 01:30:35 -0700 (PDT)
X-Received: by 2002:a05:620a:4711:b0:92a:dcf5:ba5b with SMTP id af79cd13be357-92e781d35e8mr1242528385a.14.1783067434660;
        Fri, 03 Jul 2026 01:30:34 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b934:1281:e054:26d2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-477de3dcf59sm16287808f8f.34.2026.07.03.01.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 01:30:27 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pci@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v2 2/4] power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
Date: Fri,  3 Jul 2026 10:30:24 +0200
Message-ID: <178306742016.7902.6406831777462016236.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com> <20260702-monza-wireless-v2-2-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7U-HLreHGKQ_BWK-ONfNaSPOVF2hS6lr
X-Proofpoint-ORIG-GUID: 7U-HLreHGKQ_BWK-ONfNaSPOVF2hS6lr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MCBTYWx0ZWRfXy8K4M0svjubm
 SuEvhDT4PIPpYQhiHUKyerUL1ZWted7l0135xFalzBoprigKQIOzKsRfoncAH0i4itrrr3n4tw7
 +n9b+By+Ly8yxxBxcmL1N1zUCCR7rHM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MCBTYWx0ZWRfX6rprYkIK3jFz
 NPlCj1e6Ze6pKck5HYKd6JTll+15OuiDFrtHIRUAjbIPGdYV6IL0rD0+G0u4kXw9PHLZUjbI2jQ
 gYdBztuOqNXPJOBK141BIc+l3vV5/uUeNJk5o5lUMaTazWhjOhhUbp+fcRoqQZ+78ODMmyXvilv
 lBHEHi9ncWTw1APiIrftXuUd826vFGZbugimbattrRfAmneJ/HuyZ0XXBPYcBNLS+QWj1bw9Bk1
 c1x3sj63hk/6tnyEIFUJ/Ch+h+Y6GLMPUGds1Q4NOqCp/iV366+GHsVQAyiBt7IFeR92BJW6l8E
 LDTyNH+fS+yT9ywrUsLzyyeJv4yiBpFWzXB024l9GVaALkJCsooCayLzWI59ocuTdrHCxaho81o
 DmPM1I1OOLoaXVGNGrjzzNSQd5Mu3amhBiDPoYv5F63NmOh7nOwduzQsgO07zydlCLilP6+NYjU
 YrLeLDyzb2bWDzuFEgQ==
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a47732c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=aaTFUzO4qDWa5CizT70A:9 a=QEXdDO2ut3YA:10 a=zgiPjhLxNE0A:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607030080


On Thu, 02 Jul 2026 12:46:14 +0200, Loic Poulain wrote:
> Add PCI IDs for Qualcomm QCA2066/QCNFA765 to the M.2 serdev ID table,
> mapping it to the qcom,qca2066-bt compatible string.
> 
> The Subsystem Vendor ID (SVID) 0x0108 distinguishes the QCA2066 from
> the WCN6855.
> 
> This allows the pwrseq-pcie-m2 driver to automatically create the
> Bluetooth serdev device when a QCA2066-based M.2 card is enumerated.
> 
> [...]

Applied, thanks!

[2/4] power: sequencing: pcie-m2: Add QCA2066 (QCNFA765) BT serdev ID
      https://git.kernel.org/brgl/c/1656f4f2eb45d9f18515ac00657a2494719fa065

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
