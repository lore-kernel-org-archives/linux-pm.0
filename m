Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC263F929B
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 09:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922494; cv=none; b=c7FKHA7ECnhAc03pMB2RAW0MOvE5Xi6o/bWITir2P7UcglYlyOBoyEXsdf9hNrx3Hb4ZniFc86mYQmoYv8q9EZNY6qRcxl3UKElsXqV94SEyk/oVkPppr9/pNUuxe8FQloe1TQDleluXv7wI8Pm9qc/k1rBBQH0/zzwl13/zS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922494; c=relaxed/simple;
	bh=dV6g+gIuky6zMstwQNkcrOGQkQ/MIr5qyWCvKwM2YDs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XK/lARRuFf1M55K6oCDX4RY4aSV2ypz25C05uyYeT7hKcierPNMT4/4Syzy0DRCE3QSODfpatMNDvCpqrHOo+x3n9bLReT6jz7nZ9iX4sZ9mjFXaXFIjuUfC+Yut99aRUctXlaFrgfhjiBQecwHx8FVjE1VKI9jmYYqW0DLlpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Vc16W7Ib; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=dRsz8FXc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Vc16W7Ib";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dRsz8FXc"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6758deO42669688
	for <linux-pm@vger.kernel.org>; Wed, 5 Aug 2026 09:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	R844a+nE9SMqvOZgkc4r1dVB3L2gr8OvOjIy5HHKmno=; b=Vc16W7IbevsVQAX5
	JizULoemvZfytYummiktERpTzaARzqCR9d1yrtO3dTiHIzYwm6vexhQ3GrtT9KXC
	NiqFjs89jK0E3n7YVG4NbwTbTbplUFozR5m3L0MSLf/wLbyJv5bysncrV8ASmNlw
	990IhG55uIfDt2UaB5JUUF3Ucd6NrKXVWbkMwJVODjroKMpl20rb7kq8bnKR3ich
	Npa+rd8pWcWwORcmhokFzh/zopMYU1L/RDgL2UCg1XkkH3SDJ6cptpUwLKK80Hhb
	VgeTFm5pEwp8c0gzreY6FVEaFCig6t7VPcrXwBGW8W6dbjpp7C8o2XeiK3FFnrjn
	la/ktQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fum3qbw3w-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 09:34:51 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cd01a14e81so11645235ad.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 02:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785922491; x=1786527291; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R844a+nE9SMqvOZgkc4r1dVB3L2gr8OvOjIy5HHKmno=;
        b=dRsz8FXcXKdhDd0AJzSSofUyXsi6I0ekOoq5NvL47Nnz3VlaTDX9QNY8p4YjxPM/L/
         uBPIsI4JDttD/dWvR4fcK+bg4E0TBe8xUyaLFkzRuWlgRSeEEVratet2VhWEjaTOymil
         opaVhnZP2jlJiEFmIQfBTVv+/fCNStcmOUv173BpHphzP8iMSQoiXjJJXPpjDhr0KxFb
         3IyFZ9ZL0Em+wEf3MiFMiJCJJ3WUKUOkCizmlc8f/bxw+vAqTXzPWlK4ZmFInFx4Pb7P
         Noaq+/z7V5uDalW7q3yW7nEztw/EfOHBbdAThdYGVh1NyR8Ua0eUjhWlagNTdrz5kf8U
         KwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785922491; x=1786527291;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R844a+nE9SMqvOZgkc4r1dVB3L2gr8OvOjIy5HHKmno=;
        b=Cs4CR9iiUGlMtu2VrmDn6SA/Z+AQHfG5F5bV1E7lVfkg+Od3K/FHMEE4Vey5AzeIXF
         wlvNEfUIHRGFHG5ozwpd3HGdtjkpfoI7L3zaWOyzAkp92HlQlkkB6OoJ4l1Q3Utb1q2A
         0n53wngIZqciM7bFzYaPZeoFYRqXsqsEK1U17G8A3vZf4XFoYYS0AyYqz+zYYeNpvnps
         A9znswPPykG4eII7Bimt4MOGKWW2+eJFHalghN5iTlGuSpQ4DRtWJRBXU20tjhxOs14n
         BUkeAF6h13CHFUFrry+pm0fCKlSLwNdMJSeo/+ahuDUr+J74dZxpbZvzyjMKJVV0G3iP
         eKZA==
X-Forwarded-Encrypted: i=1; AHgh+RoKbPg52aM4YRAQy/6Z+f3PoBkzUnd4daiNA2AKZbHaAYHqWdXS7pf7dEzOiRX1v8kBD+lRXlvC6A==@vger.kernel.org
X-Gm-Message-State: AOJu0YxVWhQk6cvch/J4Xo3IXBT/PsA3qjVfG2NTrBVs55RJPH3PVzf9
	78Tn+quWdGyDBhCORWkRBlMTywSQzR6a5WtiOmwl0d/4FAGc85/kV3ipVfZ9Rxt1F16bOgBXw5C
	S9oIchOPVc8Lwgqkdnjg/J9o6WS8a815hZZhWB/IC8h1aOU7Z4HZ6YYN46IDc
X-Gm-Gg: AR+sD129Ykibc5CGhOfNxXP97iJzh1/3eyg1QJVK1pfPIQMrdsXzrYP2nd76dLH4Thh
	SecOEk5vwnlOi8gYWkRyIBI3QxXwbw/RXuO1cjZ2pIUSQp0+mZNxGSChQaEOF5pk8XyUyOHkj0v
	1pM/h6G9U7clCNKVvnxXzHW1DjL+mbcmng0WTVsnMsbhlQSybtPAoNYd+T66rImdEqXBd4j508L
	/V5VC8yjTbyq2OhJILQvQ4kHc18V2v/eT2MxTuUnMHZS7UHqvro4jjpBUQEvM/143HELOlYUrWH
	vyH/MC4ZfD82Gc1Huv5QGUwv/rjJRNbUw54rPkAiso2fiFrn0YveLbx4FdUWqVoBiu4bK6FOmPa
	P/CHiUmlXje7WImetDD+qoIqAoRjQWmo=
X-Received: by 2002:a17:902:d48b:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2d0ca78de48mr51423265ad.17.1785922490797;
        Wed, 05 Aug 2026 02:34:50 -0700 (PDT)
X-Received: by 2002:a17:902:d48b:b0:2c9:cf62:6f61 with SMTP id d9443c01a7336-2d0ca78de48mr51422845ad.17.1785922490288;
        Wed, 05 Aug 2026 02:34:50 -0700 (PDT)
Received: from [10.92.205.160] ([202.46.23.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0a9da7748sm16109445ad.0.2026.08.05.02.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2026 02:34:49 -0700 (PDT)
Message-ID: <b8813d68-dcf2-4836-acd5-4ada63c20f51@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 15:04:42 +0530
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 0/6] Introduce the Power State Change Reasons
 Recording (PSCRR) framework
To: Oleksij Rempel <o.rempel@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        linux-pm@vger.kernel.org,
        =?UTF-8?Q?S=C3=B8ren_Andersen?= <san@skov.dk>,
        Guenter Roeck <groeck@chromium.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>, Kees Cook <kees@kernel.org>,
        Francesco Valla <francesco@valla.it>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        chrome-platform@lists.linux.dev
References: <20260731095959.296056-1-o.rempel@pengutronix.de>
Content-Language: en-US
From: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
In-Reply-To: <20260731095959.296056-1-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA3NSBTYWx0ZWRfX9ezZy+w4Un8H
 SudzN/tWIANXFeh1Bn2R4Y+S2Wb/2OHT+9gdDA/94uPSo3ViJFZXU/ntIxT5rx6lGwRH5Mdf969
 GXr3AX5y8OmSRpWisod+RPMK0jAlngezHrYD6PGImpEn1RmuwGpBBY6y5lkYIc5k07jDfDiwz4S
 UonvFqqSKUdHIMXc2OEKrgCPNhi0HeeCBSJXXCaoWFZUFE2vNSqwKGe0hg5oXMgf8N5V87LTVdE
 2MYkDFmqMAU4gZqlweqMcra/d31e3Mlu+UdG7S5iunAZZR0hsv4JJ1If7Xj8URk3qs+F2R0Hwlk
 PWPM3bPRWYEjRUQLAAKKdAsS7AZt7XGvEdC/hdQ+MOxlrNHiFbeZXUoo3UU8mDLsnBZSQrzRha3
 44t54of460swZ5LDL7+JWBe/954ikDjwta9ATiBwclycCiGje6Zzge2EswFjSp7kPLqeEeHWxMG
 jXcRezntOnGyf7hNykA==
X-Proofpoint-GUID: KEsa3nPgxz2uNnrBHah3iskY3mmIj2yx
X-Authority-Analysis: v=2.4 cv=LsiiDHdc c=1 sm=1 tr=0 ts=6a7303bb cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=j4ogTh8yFefVWWEFDRgCtg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=M1_pdOmx35iQhsToLGUA:9 a=QEXdDO2ut3YA:10 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: KEsa3nPgxz2uNnrBHah3iskY3mmIj2yx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA3NSBTYWx0ZWRfX21zWAud6gSVb
 IyW3s9+ECtB8Z9WTq2pz3W7rSmBry4uuuRLCiSWZXBJZd7Kd2ALQmBunmKy3HbK80RCe5Xs0Ec7
 HOT0y+GwmsRKJHLp6QN9xrxXRPzJy8Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_03,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050075

Hi Oleksij,

On 31-Jul-26 3:29 PM, Oleksij Rempel wrote:
> changes v12:
> - Drop all provider drivers and their tests; post the framework alone. The
>    NVMEM-cell binding a recorder needs to pick its storage is still
>    deadlocked, and several projects already need the framework - so unblock
>    the core now and let the providers (NVMEM, PMIC, ...) follow separately.
> - Rework into a multi-provider design (per-provider /sys/kernel/pscrr/
>    directories); add reason tokens and a built-in /chosen/reset-source
>    provider.
> 

When do you plan to post the provider series (NVMEM, PMIC, etc.) 
separately to the mailing list?

Thanks
Faruque Ansari
