Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7898B3AC0FC
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025546; cv=none; b=bsd++1sibza7T/zKP89FFZUxT8VfZKzg054nOLXBBJcRgcjHD09fithNjECvUvTlpmhe61qGt1QsyBMZ3ybGbQ92KmJBC3DSUxmP7+4+mjKnYVB8GUT1EJLOdYi+7FYrVXWNtwEGVhsPvHtWCkurn4V2FYBzSWye1QRwnpp9dsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025546; c=relaxed/simple;
	bh=YwG3ShPeEoDdW/VvtVBJ93NMcAnPV4JbQbuTOD40zKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SMuNNIdD1gAAtGDT2vpKraWOGCP7Kk+llXY/pyukRugpCCTwxc3QNLPXHcurLf2hQXt01lXfEYZS+GX7h6Du78qCk766w48f/yweQ+yvi5DsJuhPtz31tl7odDE/baOWij6FeHsXR0rGjH7N9P7YHKHdl1O8iGVN8WqQT+4hvVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KkTKHuXW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Bf76F/Ni; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KkTKHuXW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Bf76F/Ni"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GiLX1108229
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=poC52eCWfGjTRuyFHqnXPZmO
	tWy55VBXZIWXrPhthEQ=; b=KkTKHuXWfu99YB5ufLTwRvjc6+Y6GFSWIW+6zY4d
	pXW9tEU6P0qArWNSdla/Vfpk0TfdA5+5wdZxcWn2kWK5jtowGBaov4Nou4kxoM9j
	kMYIaAwv30HrRpWfolHUDvI/L4wUSHjZuG9WsF3fQoNUXvnpgxZZ2wq2Ps/1hWen
	eqO+XJ9BDW65bccb/i4B9UdQV+mDJ+vXM7IAuOtI8101mE2v9FgNgSkAwHNphnEi
	5wEpbzxbxd8NJfyzi/lPD7+uNLQm8JLMMRrI0cqrY3cFQSWZfQC0UNlxoB83Cpjs
	+hRNdbZbE1qeeHJndX6zuNOVnvmF67dAFEqJuLfnHS9ePQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyham5k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:32:24 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-934956beec8so979789385a.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025544; x=1789630344; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=poC52eCWfGjTRuyFHqnXPZmOtWy55VBXZIWXrPhthEQ=;
        b=Bf76F/NiSp8x33eSjaiLCt+IIK+Q+VyD6TtMsR2HH6T9jAWSSycDWM/xbwRGwHop85
         yqcyTx2NRDJh40McpVnE7wC5kPpJW4dim67g637DEhMMZ3cj1sV8e9qTx8n+WgGDQ4kb
         VI/MiB418xO8RvfeZIaM+cOMaAfRkt3mHl6DSf3oiOe19TKOY3QHUdJPiePuyloSIWPs
         BQlmfjiubPj5QNyBo73NXdOiJYnw55ZDye4kj0SDCqKC5u7yQAYjKFeinl+0qx5wamZC
         niKLovHvwPkaHHVy01kbGtV5Av2bQ5v5Ha/JERoZ97GiMdehiFd+E8+L2aOjiSti3Nl6
         yk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025544; x=1789630344;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=poC52eCWfGjTRuyFHqnXPZmOtWy55VBXZIWXrPhthEQ=;
        b=kyerrP3Iap1GHHRWEf0fUlHfj9n/pYr9a2ksdTH9myomeaJQYoj6A1R439Cwll85yM
         yhbijBdkpaMnA+ZWFljXI4RFfYIOlBEY9ibbp9dNffD/HFZZ1jm93FWCcRUwgyU0bmuF
         y+XZQGId5iWHow/xOdvAnZ8jToeM5gv/8Xxcip4Jupk8yKj40fTaCS6WEPP2SeEVudcn
         O4al0xpJXyHbfB6Licx8u+nlktJyzugKrsKe6YXaH9Mp7j/W/1BKJroZQ+qEOtR1WxaV
         oOn3Ro8y8if0kOhhTEwbMW+cUWp4P+dVnGxhYhs9ukebWFG4cEBOhiQMHx1/QcoB9b7v
         YQTA==
X-Forwarded-Encrypted: i=1; AKwUvBxslpwQe1VQ0YgcYH/X8M5nAFt1QDxMLuXcCaKdz+YH/00KzTc3rs1AEbe1OWl19DBXGy8dPMOZZA==@vger.kernel.org
X-Gm-Message-State: AFuF++nbPusqcH46j9/lz8KWTNzPJqpu2I0L5IiBwKSy5RtU88jqAL+r
	vj/Tbh2nvA8iJAhFqypJgx3jfVvClwXDu8vLsi/3T7/0Y3pxTxKK+W7qrSRa7Ml9x1W9zgYEtM5
	WuK6rE/1qmWMeGwAMR3Mzn/hRXPcSg/eIJ/dOziQ6BRpuNvQ+1mVFIRUxFLvcxg==
X-Gm-Gg: AYBFou1qaCSG77G/W9I5xV6T6ZQ9T6iV0i1buU6WeLaBCWVXaFYWRB+8I3FyEIS+rqp
	OPkwRcTjW5U7OZ1cw6S7rQvwXhjuEWoGKheeXccUlQPDE6VkBVccusjNON/TLyEdoudo4wTcV49
	l3JVvJ0k0MY5ayfqT93TxC67faCCHkkp4cuyyYrbPNpDMfd5tks18JD8OyiypTG5+HncDDel2Ha
	mP+po7wXsm8JmtTsrq8jF8ZEojw/5IDQboJxF50TKK4x/a4WZVouPwhoNe+tzmIYQuarKgtj+2U
	0WgXKd/CCMn6pbPeXeyob2Vn/W1hMwEjp/e0QYVBq4jg5v41kLGsKrFhsYCzGHPg7bH2AVz82rt
	5UMP4S9eUihze
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id af79cd13be357-939c9e9e6d3mr1215264085a.30.1789025543715;
        Thu, 10 Sep 2026 00:32:23 -0700 (PDT)
X-Received: by 2002:a05:620a:3186:b0:939:c9e9:81a3 with SMTP id af79cd13be357-939c9e9e6d3mr1215259585a.30.1789025543213;
        Thu, 10 Sep 2026 00:32:23 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm249206745e9.4.2026.09.10.00.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:32:21 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:32:20 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 6/6] interconnect: qcom: msm8976: Configure auxiliary GPU
 QoS port
Message-ID: <lhle6hy3ewf6tahr3ynmvrzlgai55n2rngy25vhqaawj7jsmt4@znu23yqxfn5v>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-6-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-6-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfX/eOhCTuAy6YH
 1gqpYnuVGpGTG7vP49oVsr4bxYTKa8pDPecOKM0b5aazAF6eiNMR/rxeA2V26nZQKKDyi12DDqk
 N5Ak4LRHE+MnGH+64hiDXt6VIoB8bfQGPt7Axr3X9m9QjxkgBnckZ790GZ424PbqM+Ptpd2WZ0Y
 dTV2VcWQRZm7neFr1mCq5VxAY1FCXe6b3W4+1n4UuYBrERZnfEW67LyfKpiMmdQW45Ex8T/7JEl
 G/4CJls/tfddeC1AbCAAey/GqApiqbr2ps3I8y0znfgDugVjjKqicYn3zQ+PsxCkGN92Ny8lSdW
 7wN+d76CSwl7pHIEhD0DYreuc96YIJKqd6AgF4KpO5pUOWdYHHLmWOE+KXhcxPhInLjC5eErj9s
 65VGGfNk826ib0OdBE7tH7aOyVf9e2q1T8AyibjVt7AQCYVz1NEuy4axGrCDp5xDRwk4IpekcPh
 XTkHH2yoO6Tt0UiLwIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MSBTYWx0ZWRfXw3GidFsamlWZ
 LZ5mdJ30CTRDrD+MwslVPWOv2Slla6DJ14S+PLVEKsFivi8zoBc+mLwDMaqKgQLe+rNxUZIhWYM
 Ny/EPihS6HKj+994OdjLIvl4CJCcrfk=
X-Authority-Analysis: v=2.4 cv=YKgKWhGx c=1 sm=1 tr=0 ts=6aa25d08 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=jW8lGn9s46bW74Nh9CgA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: wcU7la3Q0KbfUrZNPOzEuVFV9sTDeXio
X-Proofpoint-GUID: wcU7la3Q0KbfUrZNPOzEuVFV9sTDeXio
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 adultscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100081

On 26-09-09 18:41:59, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Enable the secondary QoS port used by the MSM8976 GPU node.
> 
> Assisted-by: LLM
> Fixes: 6e3ea1f36b10 ("interconnect: qcom: Add MSM8976 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
