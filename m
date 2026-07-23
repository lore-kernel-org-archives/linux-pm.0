Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C68E43712F
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 10:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801013; cv=none; b=aKvNtykHPzTbwuI2AD3bhdnQAv7k1y8yo3Of2uDcB9mvp3GLfGDCY8c6ug631Gvi/uQX4wqBrur7aUScYsi/9s6jae/RZ0hcY+NMJxzB7vOYIveOEmYpWMQAaJTF+jhNwXlAmJl8vlv+dTIc1misE3SZ0uCZ/LC3hLggEyXEwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801013; c=relaxed/simple;
	bh=V8afFD2W1M6xvgYB6p4r45dfdu5hamisHl2AIG19+MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eEIlJj7byTJ89KLJynCtTFpUg8zqPG39O8ShX6qdCyviqD0fl7O8gPZPaivf33Z4Icr7BriRhZRb7b5ddPbC+H/Unhz9T3iPoZyufPr/+SfMZ0v0KJo/upbQjAmM6D0ES4F4j4K0nSK6uH+kglueLwg3kdL4ywGaBv1IyT3gdNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bN1SGZWZ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RsRcSe3Y; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bN1SGZWZ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RsRcSe3Y"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N8qWhF3390464
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 10:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8Ug7bLBpHjX45qP49mU8fjcs
	QGVMwERqU7kYczg+3I4=; b=bN1SGZWZtHqfxPzfnWJn8XsbpIVSBzFjK/U8LRb1
	IBLC+uduGtW+znDgG6mAZy/iXiUTW7RyKAmbdKOdgPNNPFl7ZGbfjNfftbqmKseF
	zTYOyDchPPxnsV5V2CZWz5N/VfrSa68+NYJ4Prml3/OfM4qfiC5GBjyx+GpuzFx+
	GTtge9eQtUzSG8PWv/2uI2K39lKFK0W3grrP4wo/75vt8NqDkKjlZ2qcYrJec6aH
	oYGm0nr4wLwnO1XbFdzOB6vpJkrzUPqkX+DuVUHPJKIczk3ZqYyIk3/TPXgZju7N
	jd8H/RVkGQsve6P0SxdCYUZ5HTijG2I98T+2ZhJRwbkdoA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fke0krrry-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 10:03:30 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38e54b6556aso612243a91.2
        for <linux-pm@vger.kernel.org>; Thu, 23 Jul 2026 03:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784801009; x=1785405809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Ug7bLBpHjX45qP49mU8fjcsQGVMwERqU7kYczg+3I4=;
        b=RsRcSe3YLQ52Wbzvg6Js3SCuwTKq82phpMXamuithHse+Yh1rKBqgqB6BTFz3253At
         klOcdHYng4EUs6fclKDOIUldpH2gZP55TkCI3r2hxpzNBbY4Tg0ZSxlF73h4gOkZANGr
         FRIxRqztblrtT/O4yo5GNsEV0L+wOhpD1EqCOQt4WoJ9yVytbkospGDxQadRmlukwr02
         182H/ZaeTXVrwW4wWfAEOJ5jDe84V1MJGdwlFwnapMPW2qT4XlWxFapRrgTvnPzjfpHi
         5KzaNEoSb21tMs5vO0bwWUfjYRSv0zXPUENfPAQlyygW13TUQBHxThWDreL/vri1LTNs
         fTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784801009; x=1785405809;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Ug7bLBpHjX45qP49mU8fjcsQGVMwERqU7kYczg+3I4=;
        b=KbhntxNftOPh40RlR7x4relHcm8Xz1v9GNvMoR1tapT6mzEoiI8iKc7CxRteeAiRCW
         6+YS5kcPLB+8VCQjDqvYUO0Z6eLBBHFxPhDvBRRYYGD3rRFBl1pDqZ2MUFVBKnITPd3b
         3UtJ8FrNmhH7R/VmWnYfm7eGhAZ+ecq0GfQJLyayEaCNbps8vavJHucC4SeU6DhIWI7y
         qBauxST+URGy8plSK2Zs+0dTUHa3B8qNd5k7xghiI6/uUWa9OLpfzQhnF5JTW0qjFOR9
         O7N5/w2X/0C7Nu/jpv5QwHzW91ZldVFPJBNh0uTatPfX56DU1krsWxU0ls7SSerCB1iT
         CUTA==
X-Forwarded-Encrypted: i=1; AHgh+RoIbR6D9h5qldwxuuY85oBb5gOO4PRy73y4RHBFSv0DvfSoq+zFUSX2t8/oIqQf6M+Gs/zoQaJKPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ/NISRAUUCdhzBicdO88jFdmnt8HVNOAdhGf2LZutLVkdIJnK
	xKkLvCd+acDnM2KyqdvPFsesmYPBU78KQj4FnHIhTNvAiimN5ahiUi3wYOX2vNqb0NhHNC2Cs3+
	OeN7aLprMfv8ywDAwZDuOUoLlBbWwJBbGJF45sUWSwLHDcTx9PsQ1jTeAyslFNg==
X-Gm-Gg: AR+sD12RxNhBg2HnnLApdtGC+y2Op94UmtMpU6pdRNsWCzk2W9LQxlqVbl3P0/k8UuY
	D2UjshJe/ljyNxzjJgyQOkypEiFQZi06JsKcvT3gr/XXvdPNs2rQPjHUXac26Hc87Kt1PaoQzHz
	RibzC/wMCVWsYHdRfKF3H8ipv28e/xPKne4GhePhzjtluei/LqIjosFCxY3/dcgxbwEEWw/GDD7
	of4kCUx6E6Yl3YKwJtXX7fQ1YLmPnc5z/i9aFV7sngSdImX78xnoggCK09iBad/JhJunhkN3hSO
	YSWy1YW8uJeid9p6GgHXjGMGrf1SA3KZTdslv8Y2syM43LkLATfs5DtUxXlIcj8bVC6TXd0+oW5
	KLkQqbaOHXtQaQ1xzMzZruN9sNWGsb4PQmw==
X-Received: by 2002:a17:90b:1d52:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-38ec69575acmr2477435a91.7.1784801009207;
        Thu, 23 Jul 2026 03:03:29 -0700 (PDT)
X-Received: by 2002:a17:90b:1d52:b0:38e:75f3:ad4d with SMTP id 98e67ed59e1d1-38ec69575acmr2477359a91.7.1784801008638;
        Thu, 23 Jul 2026 03:03:28 -0700 (PDT)
Received: from hu-pkondeti-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13d130f42bbsm15811644c88.14.2026.07.23.03.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 03:03:28 -0700 (PDT)
Date: Thu, 23 Jul 2026 15:33:15 +0530
From: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Lee Jones <lee@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        mfd@lists.linux.dev, Srinivas Kandagatla <srini@kernel.org>
Subject: Re: [PATCH v23 02/13] power: reset: reboot-mode: Support up to 3
 magic values per mode
Message-ID: <3430f083-37c8-482d-8110-dd161ebcc269@quicinc.com>
References: <20260714-arm-psci-system_reset2-vendor-reboots-v23-0-e7453c548c21@oss.qualcomm.com>
 <20260714-arm-psci-system_reset2-vendor-reboots-v23-2-e7453c548c21@oss.qualcomm.com>
 <38115586-9913-4d6e-9447-e82aee811dd1@quicinc.com>
 <fac2633e-db28-494c-9b31-358ed6d0ce14@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fac2633e-db28-494c-9b31-358ed6d0ce14@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: td-xA77rOJVHQNruXJNyNwJGQTMzOsHa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5OCBTYWx0ZWRfX+0if0gU8C2dc
 OnskbiJzojG04JzzVCW5SMMGVhkWf2tLYEqa+SYr2h4HIafRM1LU9hoAWakirtXY3BRukKAt5xD
 OMWELesMRuErvF9vNzqp3PvLtQc/kW4=
X-Authority-Analysis: v=2.4 cv=S7DpBosP c=1 sm=1 tr=0 ts=6a61e6f2 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=SS_D-kt5JMbThxPhXzQA:9 a=CjuIK1q_8ugA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: td-xA77rOJVHQNruXJNyNwJGQTMzOsHa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5OCBTYWx0ZWRfXyAbmrg2FwAq3
 w6jYzI1Q/caqjmAYvitqkP3tRwWRZCB//QdNqp7FywZAigUp1xu0K4+L/OjuC9tdyP5XHLorX0l
 Foxash8OOrilYZcPElubv/MM+OI7O79QY0/jPEr9RZBfWd16HNgSGSsnWZ94e7Ho08rAUWTxyxU
 7Y8ux9F+tYlWtnwMccygg/4G/ccVROGFlbtpVUBzm4ut0XEgS1c3KCEQsV7nYxCzjCj7dDdAhmK
 5zVQpbWKgTu3dVxDqluBI2+EtOqgXTvYjxqjUvFGxxEtln5aTGUWphLH5GZL/m+H6wg68Y0392S
 0ptVsQDPC5gwqAGHPzfGV+yOeuqe5PQcGcz4m4tTo0hbNnUCNhcT2YtDqIWp4vGsEtoaO97BmmJ
 8GcYAvdfsJ7uJzHKUSKZV4rbYMCOOf4xCU7hxVTqtGDnIlCnjZcPR3m5PW37ZIhB5AgExGsJOs/
 XqkP83PhauKDMc+fb7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230098

On Wed, Jul 22, 2026 at 07:03:22PM +0530, Shivendra Pratap wrote:
> 
> 
> On 22-07-2026 15:20, Pavan Kondeti wrote:
> > On Tue, Jul 14, 2026 at 10:46:30PM +0530, Shivendra Pratap wrote:
> > > ARM PSCI vendor-specific resets, require a 32-bit reset_type and a 64-bit
> > > cookie as arguments. This cannot be implemented via the reboot-mode
> > > framework, which supports a single 32-bit argument as magic value.
> > > 
> > > Extend the reboot-mode framework to support up to three 32-bit arguments
> > > as magic, per reboot-mode.
> > > 
> > > Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
> > > ---
> > >   drivers/power/reset/nvmem-reboot-mode.c  | 10 ++++----
> > >   drivers/power/reset/qcom-pon.c           |  8 ++++---
> > >   drivers/power/reset/reboot-mode.c        | 41 +++++++++++++++++++++-----------
> > >   drivers/power/reset/syscon-reboot-mode.c |  8 ++++---
> > >   include/linux/reboot-mode.h              |  4 +++-
> > >   5 files changed, 46 insertions(+), 25 deletions(-)
> > > 
> > > diff --git a/drivers/power/reset/nvmem-reboot-mode.c b/drivers/power/reset/nvmem-reboot-mode.c
> > > index d260715fccf6..ac69b5f39fb4 100644
> > > --- a/drivers/power/reset/nvmem-reboot-mode.c
> > > +++ b/drivers/power/reset/nvmem-reboot-mode.c
> > > @@ -17,14 +17,16 @@ struct nvmem_reboot_mode {
> > >   	struct nvmem_cell *cell;
> > >   };
> > > -static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot,
> > > -				    unsigned int magic)
> > > +static int nvmem_reboot_mode_write(struct reboot_mode_driver *reboot, u32 *magic, int count)
> > >   {
> > >   	struct nvmem_reboot_mode *nvmem_rbm;
> > >   	size_t buf_len;
> > >   	void *buf;
> > >   	int ret;
> > > +	if (count != 1)
> > > +		return -EINVAL;
> > > +
> > 
> > The count can be different per mode. Because `struct mode_info` has
> > `count` member. This single `count` check across all modes may not be
> > useful.
> > 
> > Either drivers need to use count passed to them or drivers needs to
> > receive `struct mode_info` in the callabck.
> 
> will add a once more write function in reboot-mode to handle the multi-count
> support. If a driver implements it, the multi-count write function will be
> called. And no change in existing drivers.
> Does that address this concern?
> 
sounds good. it is just that `count` is not fixed for a given driver but
it is fixed per mode which needs to be handled or provison must be be
there to handle it.

Thanks,
Pavan
