Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788451;
	b=d0ZaHhQNom57ed8yH272y2kggTzp/83AbT0EsMlrGvelH2U0QVQpjAdyu3m3YkEB5pig
	 KLkI98xY86X5c3JmhWXzNtziFRDsiiMp9oTn/q9wJyP83cnsczsj7W8qO5JfzZDQq71Ig
	 KAN4fiQ+VU24prjxiJYqp/YJTqMobCVO0tfgtDiclMyTJf+gS+u8CiQ8Sdg8DV9xHDPIS
	 /qkS9GcdDMlyJwUsqrH3K0X6N80zh/j4/lSn420j+xUBolOmQhiRXm8xfBD8BA+frOgmF
	 qr0oNuvEmU5d0xF5fLbj9tyywjvI2TFO6/G20roY0cv6gCcYU42JXoZZ2vnx7Bripdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788451;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
	b=xhLF1VzTYIHwiMti1yNlEQC4mipH5sHjbz7a1nUZ2Mm2LL1Av8vzywfBrvQf13QFPpDe
	 ImvGZwrrO+ZfChsyg5YsglT7EsnLsW6yn856g/tVsb+e2v1SoLvKP5+6iXNKqa7fHV96B
	 JapMlDfLXPXiSwhqfERyYl6C0a7jF4FrvGt9ehOkw+t/2caaJARjh7q7YSLjv6YNd1P3i
	 Tnw6QbrJ4CG6h8q15dCvKmfJ+Mf0kYZXUl/N2IvVCo8bExWYF09MtUaKqZsyUXWPuaUny
	 21fAHdantS97e8NOA+ZT2SelnukJlLsz1QRWgG4q0Oy18PUDtkgl9Fr95236wVb1xYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMe7A6H7;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xnv3NMK9;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34AE606A338
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:07:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E34AE606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=bMe7A6H7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Xnv3NMK9
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE1MFF1790973
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=; b=bMe7A6H7rINkNX6B
	tJyA9vfBd9gPTs1oO/dYBnZpI3HzGyk7uzG12g2E88LZkqyOjF+LQiFT2XHonoe2
	zNkZnVcZxmGmWfXAgNOH5iTo7w/m5scnVAqaPbLWGXoSUxYoKL+smb2QWB6c05m7
	GD7Tu1rnekQv4hKH9gO06IDsoFiX9WN6OKmKrWD9kiRJfbVeYAqpcrQqR6Qp6Z62
	BDxYiLfTLKvNCTiWYZFe3oGrmfM6x/ef59MjmJshz8mCBFx061w1XR6iou0D7G5w
	HyBBSR+3St9M9O4cItvHhIkz79YUml+ZeRma1O+wPVpool7OBLn9QOJ9gKxu4kiA
	usJXlw==
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com [209.85.161.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j6ru3autq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 14:07:29 +0000 (GMT)
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-71ac732da3eso195707eaf.0
        for <linux-pm@vger.kernel.org>; Fri, 27 Nov 2026 06:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1795788448; x=1796393248; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
        b=Xnv3NMK9Eiil9yGrafgxmdi3RhQ70D0RVMepl94sRnyPL296QYn5DXXgrf8Lu8g8ee
         qJHsWOCNUb6MWl0NLNjB1DTyGtUZsEoT/cr2Bd+01uOW0I8ZF5ux+tTpBXPuS/5eMgHo
         qZv2V9UMJbMu5JKJeDrv4aAHboXQxCBsVhKevoek1NG5UXgitayd+RikhAXfv/1HnIvR
         QeHKcmLNLozsxfjLkf1iEg/xw8cNtba6j4uklUkDNaXSbtuedBnScQESaLSDwYffVmZv
         L6ym6yPX5NGWKV33s0Ux+RETCFMETHxOiJoXVUQB0tRH6xolpyJPdjtZ8ixvLehNeKHw
         Mmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795788448; x=1796393248;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YfbNWHn/IWj+x0bqlZdsPj/C6tp7qzwGnV511Fr7BTo=;
        b=tMZ/CLXWT8njla2oM/hCHu4LtK6MFRmXwJzzQoD0r+zilvzbM5aMymCYHBfFThtWlL
         Izr+gIYSSAjaCXa2Kum79WY5bjoYL0vQ1EQrHPk/hdar2smVpfacZ4w9kpxwvLqGEA4P
         9gU5vDongubn0HZ9nki3+NZnbcTJ+8c1hy6iXCtdE04DbiwhjsX83sqA9zKGm2VfsRpb
         8+cdBDwP58f/VstgfGhc9CsW08wUqWEsfubYEmWIQZ+Ae1Z4KAF/74pRtByIlVwOnZB1
         0Rm79XGoLDnlDMkaLiBTs2R1ycyzlQRkI+TmqHpecARdPI2k1/CxFw1qFYoWmvuSV0tA
         OVTg==
X-Forwarded-Encrypted: i=1; AL+hErGp/z5+YSaACcr7UoA4Hm6EE6gl47FxVXUhQdTMvCUW/5pU7tGb+vGGbZ45MG8jCVPNWl3gQOuL/A==@vger.kernel.org
X-Gm-Message-State: APuU4Z/YO0ZN0gyWaCLR4JGSeYCLw0ej4wgcsy+IKTiL33wn0gkVH4LM
	MfZsd/t1m8x1llZ67dyz2GVVyhszvBrkBHRAYpErGK5Gf+5Jn5hFmEANCjoHc3TTAzX//wzv4na
	p5WZnJDZJo6BzQoQWOVnRX1F/Rlb9OtmMBfrQtSyV3VehGhSqNUD0ioXwVABcog==
X-Gm-Gg: AZFdTZcaaNEcyrqUK1dfxlhdgVlsVqb+9EgCsR4fhfCApdQNyGOKbcY9aTSVPG6eGxW
	vPrEOXcRNNg967Jb0b6ypCPljbo/8Nea7pNokVteF08lDQDqWTFc/7WLzQLaIoP0SvRUrKkqIgp
	3EFs5pW4HKKD6W4zwPg+l/Q8CUIMdoZ7Cc/kGghJ//4usZvUVNV91fCPIwUBlbynt2jzifx3XWB
	qMCJeK6N9uu7QXV/xhfiCFxkaH2gMysmL7G19HtPhj3und22Xkhkg2tQCdOnRP38SYVFoM2Rfla
	f5hmbUE1kUJBR90WdkUev16eVxtIWMf4DMcoh2JoNRIh3pcwLBA2CZoIPdAwUj5S47uAIxMRKVn
	yO28VoO5PnFagZyGcwqBaEOMwDsP6cPVMowiwzfs7PvmjHw02CTW9aMWYwcoQK7rr2glvFjo=
X-Received: by 2002:a05:6820:c0db:10b0:6d9:f62c:2698 with SMTP id 006d021491bc7-71b392f5007mr22283700eaf.1.1795788448195;
        Fri, 27 Nov 2026 06:07:28 -0800 (PST)
X-Received: by 2002:a05:6820:c0db:10b0:6d9:f62c:2698 with SMTP id 006d021491bc7-71b392f5007mr22283631eaf.1.1795788447720;
        Fri, 27 Nov 2026 06:07:27 -0800 (PST)
Received: from [192.168.226.72] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0776edsm6211739e87.73.2026.11.27.06.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 06:07:26 -0800 (PST)
Message-ID: <da7b034f-d1e5-4e37-bdf2-22364d5c045c@oss.qualcomm.com>
Date: Fri, 27 Nov 2026 15:07:20 +0100
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: Add initial Halliday dtsi
To: Stanislav Aleksandrov <lightofmysoul@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Thomas Gleixner <tglx@kernel.org>, Radu Rendec <radu@rendec.net>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>,
        Stanley Jhu <stanleyjhu@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
        Ulf Hansson <ulfh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-pm@vger.kernel.org
References: <20261125-halliday-dts-v3-0-5c8311c0b70b@gmail.com>
 <20261125-halliday-dts-v3-13-5c8311c0b70b@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261125-halliday-dts-v3-13-5c8311c0b70b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cOF1IVeN c=1 sm=1 tr=0 ts=6b098ea1 cx=c_pps
 a=lkkFf9KBb43tY3aOjL++dA==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=pIfNyjNAQl_vEFP8Sf4A:9 a=QEXdDO2ut3YA:10
 a=k4UEASGLJojhI9HsvVT1:22
X-Proofpoint-GUID: YPleUby9Y58NBJGqire0uvqVkQvJUTre
X-Proofpoint-ORIG-GUID: YPleUby9Y58NBJGqire0uvqVkQvJUTre
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX6M4imsX6Qkc4
 dXv/9ZpoQVaymbsVxYeS4TxXMxv/Jo98wCLASGBO+jkQfMSkOuseAojkpvVnFa7up8jmbPchxva
 0zZj9/G9CFIiKHlpfSyVm+d13bdfg1j3KAeI1JE1LNLpLcWv9e/qJ8o6993Fyz/TyrRUp/xDErk
 sUIIRAb0MFOtkiox3kmLhQPtoRl3LSejiJjjmpYPF2hIyYwCkpAAKkacms9JvhIhKSDoLSKmdxX
 2dHz4UIgOb3oEDqQ2T1t4CMibWapoHoiuSyEkczi5xjf9q+Wl6F1rsNMiPYBfuEVg6jIT9L7j8P
 B+24JHgRyCdx5kZcN839ucFBLxgfOrxxmXgO0Y/ln1iGxES4IHNb4uU2EgJ7foMGpt3DNmCgifF
 Cq/oPcxOBhxF3M/y7VK+Y00DtdPguRzjxR3R03cpJOvMLO600DJ5SC7d4mrT5SKUUqGB0jmu6Ik
 5u/W52kebahj7TJqbxA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfXxxg37tCGGAaB
 yQjEyjWkowFmJx7DZSiOzjAPp5oa0SOs2Yh1tTzIfDbgjINYllJrR8V89kDAW08ueT5MpW4PKHk
 2jPH855gW3mgBx6xGBlXx/nS+sTnVBs=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

On 11/25/26 4:43 AM, Stanislav Aleksandrov wrote:
> Add the device tree for the Qualcomm Halliday SoC
> (SXR2250P / Snapdragon XR2+ Gen 2).
> 
> It describes the CPUs with their idle states, cpufreq and OPP tables,
> the GIC and the PDC, the timers, SCM, SMEM, RPMh with its clocks, power
> domains and interconnects, TLMM, GCC, SPMI, the apps SMMU, USB, UFS
> with ICE, TSENS with the thermal zones and the PMU.
> 
> Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
