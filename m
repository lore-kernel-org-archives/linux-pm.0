Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409C030CD9E
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769170; cv=none; b=dJSPfVakxyXe6OsDyzCFcoJ1FmXVTq+qSbeThGJT/kZqj/cW1TTagZYI6f9MwmrEOuziBBtMdWgoBOXq/anZom0nPpDCJj+KR5wdSc8UzRy6GZZirxS98ynHayH3S2+XqA/68ffbFZIHWWuMB5mcKsz8ZwFZBvfDPUHEg1iYVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769170; c=relaxed/simple;
	bh=Cc7dj/sRhx7BFv/3UmS1z+1pGdS2VypC/st1bCdYeGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RC7xz2pKs3DjLHmBmz/uLrtZNzEhhvOQpSjmu9gWBGchogGXXmQ+r5u3tAoJPIgC8aUjN2+9Fd5MuWO9f+1BNpn6rhocuMvfga/WxsTNiZ64L/TMyG0+Vfz5HrYwXRWbj221qyRRqQ4XpGJwairXxafrIfOHOwih39FWrwv09hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RDS0Ibmp; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ExZnwcH4; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RDS0Ibmp";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ExZnwcH4"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68777M6a2838814
	for <linux-pm@vger.kernel.org>; Mon, 7 Sep 2026 08:19:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dhN42oEPCAxcCBPQS4z3rBBRj3rpOiaQuFNeu+Dnbpo=; b=RDS0Ibmp91GyCd1r
	INksPi7bdhi4Hd/CY84R+hzcyuQGil0Jxqg5NYeyC6B7eCWHd1wa08QriI0CwTWB
	3hyV1sX0TbQ07wNDzphI9gc3QOVmgtwW0Po4EUZxem8wGQCViQoQfhdomzCkBhQt
	+oVflQd9XEpt4die8hICjWwEcpyYafzXUWQsC6uwVcJe1A5srleAzbB0hmK3rhaC
	mjHjZVYUXyAl1aZ52/Sv5WWop2n1fsQlF99ljAxNsZT07aYfowMthN4agKZUluBK
	Ho4vn9e6+paYxucfp6vDXlWeMjCyNygqjvZed5+xiFDvBktyh/XZmrVOR4YEDYvD
	+EowYQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ggbuenwvf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 08:19:27 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-396901263b6so6109728a91.2
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 01:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788769166; x=1789373966; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dhN42oEPCAxcCBPQS4z3rBBRj3rpOiaQuFNeu+Dnbpo=;
        b=ExZnwcH43Jo/8jtzmMgvYvrQesxNcifoululqVaOUx+MVdd7anaV6bmTslvPNB6p9R
         FnLvtYNnbxAJdFlO5JPYXxI+s6atkT1lUZrNOmJXqPygVEhAX9a9Rf2LELLUtERSiQga
         EtBmdhXKMavmucxtfHHRzrdH/Ki0vCfCApc1oo8oTDM5uDWUvvngRuXM0CO6oD+gyycr
         W375YudxHd3J6SdvHJGYTVJL9CFRD1Qora90KC31CKIZQGCLEriYw+oyQo6M0euW5EOI
         w55s2KO9bvFMHhOoe25TI1MOOvMA7LxYbffNq+1gpCb+fDzlRRYBdOqP3tnafRDD9D8x
         P3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788769166; x=1789373966;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dhN42oEPCAxcCBPQS4z3rBBRj3rpOiaQuFNeu+Dnbpo=;
        b=OLq+YC+H1PQFxrlpEBeqr88yWhp6IBxhV17tRgsZOa/pVxROOBmSMOzL4ARIdLQNUd
         SYLBBdAPGYQu6F58DaoEH3pEDCVYIWpR4vCx1BzwKIOHu/yJTc9LEqyMCSWLJUX9BTC8
         vdFUwdGrh3veZoLa8EEA4BJ6mN7vKaBShNNj2IPu50g+WjBSu6TwDdeiiRJDaO/ENrku
         r0rdwyEQB6ubATJ08ENwuqYdsTgBfvYFPW8VN2WX9jsbN39VafJ8s1ckAS2vm7joc2Ld
         8Jipj/+8DAfddVMhgQ9F9h0kyBxcaIyJAOSPaVS7Vl/9C7ITEz4L2kFBWhOvg7c8j4bC
         m/Qw==
X-Forwarded-Encrypted: i=1; AKwUvBxKmYAlsA+tick8PSVvkscAQq+dbgxnDaE3FHFLcxgaF0+7swCerheQYRoxNPj61q4+EEXwi00qsw==@vger.kernel.org
X-Gm-Message-State: AFuF++kNy8nZ/DBNIFx5jsiLtlSQzoCWkOaZS+IQuk5WBR1jCYGCjDa9
	Ka/LnT60bE4wvUSp7KI3HnJ8volXfCWu+YE6wRSah/pMe8EnH/S8dC39Nd1gC6+/1sM7wCJSFtn
	6GvyIdestV4WZZw5WBF6HeXV0eLg6wYsFJYJrS7Ma2a2MBJ6tgDOC8VFK1G5LCw==
X-Gm-Gg: AYBFou3k6Zp6odKg/VRf3lu22cR77KkvV9ehkQUMKkDN5WUgK4L1qLU4rx9OKVxqids
	gKkrEa4+38moax/LWwNpGYP2mZXomOnsyzvXBoYD2xV7mUF6fAWL//yNd3hhRWHrYEQFT9WebJW
	OXU8cEdrZPihUl0I2TZW8B8NsZjaG4Fug0G9aIcRjP+iBHqs09WjOqV9zJe5q3hxELoPZsmGtm8
	99jupLEp8H5iPKNxo1ae+xn3jUaBcpuIAj78B4Gam+atD0iCgnovCuUQWEcvzQK0TTuD0+lJlEq
	ve7U31+6i3mXqkbmtBnoBxHY34PC6rJbcqrHalmp/R2V2mUVoEI3FzQwI3LvX41XNzwIh+aajcO
	qASqqYawQzhnmpnunoBq/xgObJGXrQXZ84pGJnHOq6g==
X-Received: by 2002:a17:90a:d00e:b0:399:221d:63c0 with SMTP id 98e67ed59e1d1-39b262409e5mr34110686a91.25.1788769166434;
        Mon, 07 Sep 2026 01:19:26 -0700 (PDT)
X-Received: by 2002:a17:90a:d00e:b0:399:221d:63c0 with SMTP id 98e67ed59e1d1-39b262409e5mr34110638a91.25.1788769165936;
        Mon, 07 Sep 2026 01:19:25 -0700 (PDT)
Received: from [10.217.217.129] ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143240d86c3sm23134424c88.0.2026.09.07.01.19.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Sep 2026 01:19:25 -0700 (PDT)
Message-ID: <f58bd978-ca45-48b9-a928-45a2878fb54a@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 13:48:38 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] interconnect: qcom: x1e80100: enable QoS
 configuration
To: Marc Zyngier <maz@kernel.org>, Mostafa Saleh <smostafa@google.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio
 <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
References: <20260527-x1e80100_qos-v2-0-305c6539e6d2@oss.qualcomm.com>
 <20260527-x1e80100_qos-v2-2-305c6539e6d2@oss.qualcomm.com>
 <apgeBNSiP01YfNcs@google.com> <86ld9d4h4n.wl-maz@kernel.org>
Content-Language: en-US
From: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
In-Reply-To: <86ld9d4h4n.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfX22LtwbiMcNsy
 CARe0HelhQzpMDlhU9ekUx2isWXa7cr37uJJffIeGeCjhG4wkn4rYeb12dpJzXMHoRKSao6xe22
 um38jnmOZCz5Y2N1wiQk3dIGruH+7ABHk4JRTnpj0U4O7JtFs1MX8M1r1FsV7g+Sf4Xfj9jdggX
 4f/JMsukwlVNWyr+jLiwZ8DHnQMWE/lzB8VV9owldNV8vZ9VMJCp/ZAgTzGaLr4JMxxXNPu8mpS
 Y9g97UKb8M2y9vuWVYLBL/Aius0fu3iNm/eOnQ9/GyqIu8B3kaCN5Euk0Ye+n0bFr5ZAX0ZOLMU
 81iFx1SFmg7xSctDbuv/1AZn/d7Msp+PPEKlKZdwC+4ar3wHliURiM9o97hs7g3+RXyUvYcKQfS
 50Asqw+e6J1ANy+K0uf4GlLOL4gWRlP98mDbYTut2G+T+fvHnXoMUULDQkDHFjhon8/cJnG9DoK
 CvADXitx2ULlGGOqz8Q==
X-Authority-Analysis: v=2.4 cv=P8AKQCAu c=1 sm=1 tr=0 ts=6a9e738f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=EUspDBNiAAAA:8 a=Mjzv1QJRJk8zmdB66akA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: L2gdN8tP7JDK4fGAfQGFLHjl1xFUgHH9
X-Proofpoint-ORIG-GUID: L2gdN8tP7JDK4fGAfQGFLHjl1xFUgHH9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDA4OSBTYWx0ZWRfXz4et1UIvwIU9
 7OJvWVaF4TCUMBH292wirkctyOvw+U+7uPZGJe8ApzO53VeVEapOz426XmKMBIaz0LtxrTUTsG2
 zBJB/s5QQbnSD5Zj2cjiGOodDITBdU0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1011 adultscore=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609070089



On 9/7/2026 1:39 PM, Marc Zyngier wrote:
> On Wed, 02 Sep 2026 14:00:52 +0100,
> Mostafa Saleh <smostafa@google.com> wrote:
>>
>> On Wed, May 27, 2026 at 05:37:10AM +0000, Raviteja Laggyshetty wrote:
>>> Enable QoS configuration for master ports with predefined priority
>>> and urgency forwarding.
>>>
>>> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
>>
>> Testing with Linus's tree, this patch broke my Lenovo IdeaCenter Mini X
>> booting, the board resets very early during boot.
>> I see that the last patch (device tree) is missing from the tree, I
>> included it, but that doesn't fix it, disabling the driver also
>> doesn't help. I can boot again by reverting this patch.
>>
>> I have my own device tree as my device is Purwa based [1]
>>
>> [1] https://lore.kernel.org/all/20260429141815.827157-1-smostafa@google.com/
> 
> Same here. My Mini-X hard reboots after 2.45s in the kernel. Example
> from the serial console:

Is the Mini-X based on Purwa ? 

> 
> <quote>
> [    2.280289] VFIO - User Level meta-driver version: 0.3
> [    2.286872] usbcore: registered new interface driver usb-storage
> [    2.307218] i2c_dev: i2c /dev entries driver
> [    2.316386] efifb: probing for efifb
> [    2.320065] efifb: framebuffer at 0xe4800000, using 8100k, total 8100k
> [    2.326768] efifb: mode is 1920x1080x32, linelength=7680, pages=1
> [    2.333026] efifb: scrolling: redraw
> [    2.336704] efifb: Truecolor: size=8:8:8:8, shift=24:16:8:0
> [    2.346518] Console: switching to colour frame buffer device 240x67
> [    2.356787] fb0: EFI VGA frame buffer device
> [    2.361793] clocksource: arch_mmio_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
> [    2.372947] arch-timer-mmio 17800000.timer: mmio timer running at 19.20MHz (virt)
> [    2.380860] usbcore: registered new interface driver usbhid
> [    2.386577] usbhid: USB HID core driver
> [    2.391899] hw perfevents: enabled with armv8_pmuv3 PMU driver, 13 (0,80000fff) counters available
> [    2.403182] NET: Registered PF_INET6 protocol family
> [    2.408516] Segment Routing with IPv6
> [    2.412289] In-situ OAM (IOAM) with IPv6
> [    2.416326] NET: Registered PF_PACKET protocol family
> [    2.421533] 9pnet: Installing 9P2000 support
> [    2.425923] Key type dns_resolver registered
> [    2.430357] NET: Registered PF_VSOCK protocol family
> [    2.440369] registered taskstats version 1
> [    2.444633] Loading compiled-in X.509 certificates
> [    2.451480] Demotion targets for Node 0: null
> Format: Log Type - Time(microsec) - Message - Optional Info
> Log Type: B - Since Boot(Power On Reset),  D - Delta,  S - Statistic
> S - QC_IMAGE_VERSION_STRING=BOOT.MXF.2.4-00541-HAMOA-1
> S - IMAGE_VARIANT_STRING=SocHamoaWP
> S - OEM_IMAGE_VERSION_STRING=ip-10-195-202-30
> S - Boot Interface: SPI
> S - Secure Boot: On
> S - Boot Config @ 0x221c8600 = 0x00000001
> S - JTAG ID @ 0x221c8744 = 0x002ad0e1
> S - OEM ID @ 0x221c8700 = 0x00000040
> S - Serial Number @ 0x221c8610 = 0x00000460d5171bbb
> S - Feature Config Row 0 @ 0x221c21e0 = 0x0000000000000000
> S - Feature Config Row 1 @ 0x221c21e8 = 0x0000000000000000
> S - Core 0 Frequency, 1363 MHz
> S - PBL Patch Ver: 0
> S - PBL freq: 600 MHZ
> S - Cluster: 0, Core: 0
> </quote>
> 
> I'm also seeing spurious resets on my "X1E001DE Snapdragon Devkit for
> Windows" when doing large file transfers over the network (30GB+).
> With this patch reverted on top of 7.3-rc1, both machines are as solid
> as they were before it.
>
The current patch enable QoS for Hamoa SoC, which get programmed only during
driver probe. This shouldn't impact or cause any spurious resets once the 
device is booted up and probe is successful.
 

> It appears that the Surface Pro 12" is equally affected (IRC reports),
> so something is amiss with this particular patch.
> 
> 	M.
> 

