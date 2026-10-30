Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793351297;
	b=MsejwutBC5gCueuf1SYhTunHEr3VL2DXmrw+xINiK1dyPvStCVW4pkKo3F1/nhj7qoQR
	 3lezYVVo+EAY4+Ly0nasUBGECJwr0F6xOdDuJRYoLgnakpSvgNSjzZDWY+tcPUeBl03Uv
	 zAOBkHH6EkHiBJ+iCgi9H2JrolU4/rjo+L+NOwqPCO632Y9oC8IMJ99yWTr2BPoF/g4lI
	 3KJLESi66Wtnj5PRP0kq5Mp4Saci67dtW2oS0Q0TXUGzHEnQwkaw5yfWDskoHHSfTOL//
	 8SCHW0Q/wSebqpA/+Ghkhgu6jB5YTzlfBZ6URxdftA2RpL7zetwFERmQsJVvgBJvaFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351297;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=1m4Wpp1H40EG28ghxN4iiP4fGlSbQfXytaT04yu47n0=;
	b=cLVrEWIx8n/oui/0ntnpJBnTBubTRPI9omJuT8g1dVwyoklGnM4KBdRyb9PXz/zW3Ern
	 ltvBswN9RGAVgXz0gFksNPA9T1g6t0cy02EQXx/zcz9XOPkRz5sHiVbatQei3Tg7cOppl
	 Q9LWjpd1Xe4qCDkN+TxtpE+agEcmi8mjtRFmU+4sV4iZbZs4e6pdzQnYxoKIzDpEUvypA
	 qNe7CkXX3MOBIHjnu8eWIQLmru1VcFPVdzrWTyK3Epl24PqpNP4619GTuYiZyjfs/vkYf
	 Yz8/jJDT94IinsoXlwc9B/RTVA07DvWhhUiYQ0+WjcezlS/+noFMT/ZikU6KE7TdSow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NrxmNSFp;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aJd6il8e;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D4E606A325
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 09:08:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D4E606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NrxmNSFp;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aJd6il8e
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69U8F9EH2374156
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 09:08:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1m4Wpp1H40EG28ghxN4iiP4fGlSbQfXytaT04yu47n0=; b=NrxmNSFp/6jYfrCQ
	W0SKdq0iENifrZ2kakeGMvw1r30bn2bhEUUQwcaZi2jMaXyRSn2KEeBlWXiMzxjg
	CMBUhqWeBJ7gWH4j57WlubsDcFq+euiYsN83xvZtB5sfGl2ybVJ97dTI4b6jz17k
	da8FVh3pzXFrhHJetTbyhyJS35azfqh+f6zDSnZEncEDEqZAn2vEmgz0PIMLDruB
	kKNaA9zygzwnNHXBm0A5EUVxACQUGDOCfxCjVfqUmpPgYFUFsLxGVKbSdoJ+wOnY
	cuwurmhTmVRUKG/+dcf/OF/kEdXmRSFxZZoBAv72JcBVCxd45lRF8JsxhA7ManHb
	Absefw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qj4xs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 09:08:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f32050e72so116330985a.1
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2026 02:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793351294; x=1793956094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1m4Wpp1H40EG28ghxN4iiP4fGlSbQfXytaT04yu47n0=;
        b=aJd6il8e6NzT11JJtFCQWc20+yhRPE8TcTdJsdVw9st9l0ek1hSCJt44f4j4vpoNcg
         U4u5ua+4PSXh62m9j7d7i9NRLP2DomR0mzlDaCfeMGu7SXNXqmKv88LDMvhBPFOs/wQP
         Vwue2g0M5gNfcuRWxANpYKYEpyTuqPo2V/NSia6CZ9w3cIratQDkR3jdPbbIl4i898vF
         d1nOqN8kSGj0GZ5o8HcRdE0LcE1fpbQ8BZW0d+Un0dz/uENw3fYFztrCvaBxVoEjGkQx
         JAjxhufc5tswuYAGNulyStMzhUkp1hin2KcnFjLZnQ9MUO/8bgl0EBTindkNXyJhUyg1
         HedQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351294; x=1793956094;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1m4Wpp1H40EG28ghxN4iiP4fGlSbQfXytaT04yu47n0=;
        b=cFTxk3RDTfCPdmcBMLyqqjw2cfEEXRL6firTjgAtdQDiB8WnQv/UsPQi1NRuxxV1iB
         dma/B64lOsTdh8cW0xWI9zejU0ON8DnLI628a/K3LArf8f04yoqC0+i5NAzOLJcAMQwH
         rBUkplxCJdPe1V/EMu9d1DfBY7/MUdoBk2NBsfn7Z/dLci+PJxZAzG4uONwPRZUrL0AU
         C1zahq03L1e5BkU1ljuOhn/y97yGMpfKb/CB0AHPb38o6TzkWdwxP1v4W2FpP5hGMLpd
         v2yBc2ChoYK0YRvchNOVA0R+YYioSU89EuI4r1d+Yx2j7uFxJzgK6BkxflnSQmd9TuWF
         Rl2w==
X-Forwarded-Encrypted: i=1; AKwUvBypaTxIbUFhjxIShDsemuFoHVePDBvPZlSSRW2+XNUeNHsIDI1AV6/IB8nY5eS5VQQysZUNCXZvJQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYJuLgaQ58UTcSD5SCwCRUkJjzsnd+Z5+eBnnQG/p0cIfEEQe76u
	6/O92yhZa0SuYNYPWg+M1WwSgZbZ6lzGEkeD3ScghskHj31GCypr+TeEuxK4YBfQI8dTZsU8AEX
	wW9QLrKa7t4aYS+PtGeujNEmcA8EqWOkgrbW/vThgul2jTL9vktZtDIfY8ACxQg==
X-Gm-Gg: AYBFou3jsDCbOtdOvL+DPSAtbOvNvBwokFTDzjXHzN6LEGlFMpJOV63+LgPXwhVp4iC
	apyje87hW0ALBQaqdVn9hr4b3VHfcFIFA4aN3dIv6eg4KwcBdYyat8C5+Ka2hiGaZQo4m6qXVST
	Drv2daqaldAcFfaB0xfGC3arVf+cQM96JxhOcQux+/93G9Y702r85x0Z8Oy64jz28cpYZFdDa3h
	6nafPcq0l/4Lbn64fxcaUBi/K4fK1KjA6vl1Dsc7pBRQiqQtsWSsGslJFjkTrTV7gHOTd2l9mQ7
	41VxGD0OoRusOJ3UZHp6djOV0eoH3eGKOrogLf4DCg2NV0y8Ln07ob9d+9hVrBXHuHiqiFT89dU
	sKEFMmwPuqUdJh7AN9uWsU3dgVBA6sOV2ashQQd27TYbP9jBBanodfRgKIM5y3A9/JspF3P87Sc
	iHBJbaiWuSuA6jptMhd/hsetyB2b0FczIMMFI=
X-Received: by 2002:a05:620a:2709:b0:93f:571b:c72c with SMTP id af79cd13be357-944216b818bmr277396485a.46.1793351294038;
        Fri, 30 Oct 2026 02:08:14 -0700 (PDT)
X-Received: by 2002:a05:620a:2709:b0:93f:571b:c72c with SMTP id af79cd13be357-944216b818bmr277392185a.46.1793351293464;
        Fri, 30 Oct 2026 02:08:13 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7fbe:151a:486d:a2cc? ([2a05:6e02:1041:c10:7fbe:151a:486d:a2cc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78c10sm1958499f8f.25.2026.10.30.02.08.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 02:08:12 -0700 (PDT)
Message-ID: <62826ebf-d5cb-4a94-942f-76afa97b3e09@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 10:08:12 +0100
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
Subject: Re: [PATCH v4 0/6] powercap: Add generic hierarchy support and
 convert DTPM
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
To: rafael@kernel.org
Cc: Daniel Lezcano <daniel.lezcano@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>, Shuah Khan <shuah@kernel.org>,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kselftest@vger.kernel.org
References: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <cover.1793288783.git.daniel.lezcano@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=KsrYSmWN c=1 sm=1 tr=0 ts=6ae45e7e cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=h4SK1RYChiWzJ0aczLUA:9
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: --dUHVB5OS9qqNzSQQUcaYEAcBAmo4h6
X-Proofpoint-GUID: --dUHVB5OS9qqNzSQQUcaYEAcBAmo4h6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfX/8IQhzLxSFHB
 PWq1r3KVG5/F4gu0VD7GKqc/Tpdzzo76FkUTtAA7nG7p2FRNVrLonFUgu/5UF3YFThnfZ3HJakk
 RvhOmH/x0PscZpqIOEdIssyBMTxeJ2nRrIqLZSsOY8/CuUlDKRQMukXbP7K5dpx+hH0IwRfPWM9
 Zfwv1oS7VYjUgG2Nf2591J3pxr+iOkECnd9zs2AD2Xc92PqsmRw8NKHsc2/xlm9MeDyEKoAjqJL
 CyFuzP81OekIfNxxRtliCSWdNbsqyyYdeIXTCjbYLCqYtjRXGhxMkDnGjz+xxWHcbqF0OCw0N6Y
 RIE2+2P37dlk9IG0GmDSs0bloOHLTZEwKFIFiJKNkmSb97Y2WI0Gu76rKup23A5HxRYL/9Pb5iC
 1VogEEJSlrUkmxLuRvF1j019qRqsQ3QOtKkyIvf0wIh+4CnWrutDNRB41axeObX+FjgOipyfSAp
 9/kjJz271q+wHhKQ0/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDAzNiBTYWx0ZWRfX6UWfaS3BMYLS
 8k1nJd7RGK+UX9YIIVinr8NWg5A5qlJxtjgfZu3nfr7uNzHldxl5ku3u3lmRa1nD7rDnijaSmQI
 eP6AX6CyjE/QtsxhDzun+m/rBQMDxhQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300036


Hi,

On 10/29/26 17:56, Daniel Lezcano wrote:

[ ... ]

> Changes in v4 (since v3):
> - Rebase on v7.3.
> - Address the selftest issues reported by Sashiko:
>    - Add a kselftest config fragment requesting CONFIG_POWERCAP,
>      CONFIG_MODULES and CONFIG_MODULE_UNLOAD, guard the module build with
>      CONFIG_POWERCAP, and skip building when prerequisites or Module.symvers
>      are missing instead of failing at modpost.
>    - Resolve the kernel output directory and pass absolute O=,
>      KBUILD_OUTPUT and module-output paths to Kbuild so cleanup works when
>      a relative O= is inherited from the parent selftest make invocation.
>    - Keep the statically initialized mutex in permanent module data so its
>      lockdep key does not point into freed module init memory. Retain a
>      separate init-only description for the hierarchy duplication test.
>    - Return KSFT_SKIP when powercap sysfs support or the test module is
>      unavailable, while retaining failures for actual module-load errors.


Just a heads up to say the series passed sashiko

Thanks

   -- Daniel

