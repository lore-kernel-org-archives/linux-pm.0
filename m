Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6B32F7F1F
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788258659; cv=pass; b=PC5KBS58GrRvzQqwMvPrZXXrtDGDFeJRRAlQ24Y3iepEp6cz23JPEnyjkt/SlbF8FLPhtWuWEAd9zjZV86UOJpGiBc/CKp9VFC3tGlPPO5+9Tt/pxWxN0kYEAGgcQ5nQX9RsMnBd1EoEr9Y1NsTFHOZyxjb+8UMSj1wwny0sauY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788258659; c=relaxed/simple;
	bh=lWFns13aUQVRLJ9/uaF4B2fLPnX4BZA6Ycqj2XWx6wY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IFoJfh1J/vz8iU3Vjyu4obt2ONeobkD5ZQLrHkcDsXxNkGIyurFUqEJ/r8IaIeIUOV6J6W2pryCU2sSnpcjth+WINAiJpFsN1eM2X+Xj/3I+wDPEHmQKQae2/pTvLIv87yvCX34sYRWGHu3ubqr6/eNlTZm83MKSngslPxe4Ny0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L24pVZ/Z; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hoTlqhYG; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L24pVZ/Z";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hoTlqhYG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681AJlp91713243
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 10:30:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sowwmpfHMA8ttuNbDz0xs7pKP45hjGOLuw27e0GDTnM=; b=L24pVZ/ZqR3UqxGK
	/67Ss2CEWxRkdLC3ayiyFTGUoXWpcWN4OwFx0jrQtRXWn1FW9W5QfwLgb8KTD0k9
	VXA3inANCmxJRdNG1TdFzjqDC2lkfvvladRHjVG4IrE+z65E9aAnsEQTGw71IFRt
	Cth5Kl1JLNSIKsmyJW5tOWNTFgYA2eaAG7rmiTDyTpYah40uhNhRnI9nNlIapDXx
	tgGkDMaYbMwGfILTDIdpdgjsacyyIgftl8+InQ7uxVvbYahckUBUSTutJog97nUF
	ICuTYp4BAjDzqlVCXHjSMsyWarzJJVoGX2cpKxi1M91rxA81h4lNdrgCFXIrEQUf
	kNHixg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdndxa1ey-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 10:30:56 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38dc085b0a7so8746924a91.2
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 03:30:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788258656; cv=none;
        d=google.com; s=arc-20260327;
        b=TnLQPkTW1WREyqvwziFs/j8YZYo59a1RHpMQag6/SJpAfrLz/aVw/kNbgramRyGArj
         9oxUNkwN/4GPrhY0xwAFccyMZH729NVRaolbwwhV2QiATEjIMqkPEsX/7rGl4nJZ9UVd
         l4DOb0BZrGWL3HiNWrO+OYMxuXpdcXlAGfsUMXuk7o6ESuu44gDm5sSXna8yEU3bROJe
         TaDkdanQpSgqtSfTghvHSURfCjx5XX9T87N+Qwyo+p1zQaoU3w/34Uh0I8vrRFk76J2z
         WwLQXjvanX5fTrg0qxvFwcDCU3UyZQSryNr7tL8VkF0aDRr2bpuk+B8TrpjnDZEMEFH8
         yzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sowwmpfHMA8ttuNbDz0xs7pKP45hjGOLuw27e0GDTnM=;
        fh=4Zv/I3zr3mOzSh3P4gg3j75Gwx4/+sRsX6pC1fQK030=;
        b=kEbjxJuvir0jjfgWY68Hpcf9vNgpE00vFM5BPFNvhrbBo5F6DVpP4BJIkG7jhC0J9w
         KOCkcEvmkcWDEEtW1QIMa6ggN5b1V4cMY1NUW3je/SSTQC8jG8TVyMYIXvTDy38oZYbx
         2YPzZ5MIdGlTUOSFT0bIqcV8mN+50iH3wLuOS6bWO7Qd2vWbrz4fvSp39zGpECSCElpq
         SW2sTbcPq5DPQTFfd1oW7dIUq5CIGl2a0q1Ut/eXNq/zip2GxkgynbuDO6i1iSYQVQT3
         7CXqcoJUJEsnXz2h53PDai55IInVzhgMtQUDJ81amlLue+dyTTXLyVLv3eOlqje55Nol
         +6Qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788258656; x=1788863456; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sowwmpfHMA8ttuNbDz0xs7pKP45hjGOLuw27e0GDTnM=;
        b=hoTlqhYGdQskuuEWGypADPzH7VhUZIzfM1svYDCPeEG7CQ2Le9A8roqoU4RB+Nv2Xd
         pZOBGlIbsfT6XbvAjTNgBD/ULTxvWnfHH15qHNwcVjfiCmyrlQsT/w2ce3JEZkuK1SNH
         JIZImsILw7eKGiqhq+xJtJBZB2mkD4ddSUbpUC9vyvcISSh+WMWY7A5NwIrV9VDp5Uff
         UlFQcbMcluxexl9U7bI8jGgWfzptrMJuKMK5dAVGq0F7MRCVsAc1RbvjYCVuUtGn+1+s
         YdpNKSimMCw0vNPOde5762OG0r4wpj4ru8KKA6ZUscjdXihKHIdq8YV9suCZUZGw3rfs
         gh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788258656; x=1788863456;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sowwmpfHMA8ttuNbDz0xs7pKP45hjGOLuw27e0GDTnM=;
        b=HfeMI2Cac3NSql5tQvc6ypSLWttF7QZuHhnf4xLLqohlj2Pla/MILZGy3gR7/fftNi
         bCD8qydl7odJzkg1Z/3cqwhfrXLVwr7rkTCL043XXCgov0Xc/UHhzE4yLasVfk8y5w2E
         +CHFb4JXouzXzeBvHD5WBpuiO5mXEJjtA3qGiTJBMh6FwDUlxnHSR1ijZWu2cCd04I8m
         2ZP2M/wbkxru2WKB462nLuEuBQAf0hJvru9PIkt5A3P9NLO1apYP2whfljeHrWX2/zlA
         QXQ9ZeJo0xCJMSDXN4VkdpnGWzG59Uwg+avijdhwmwV+POTE5MA7epTBP0QqEjvK2zn5
         cvNw==
X-Forwarded-Encrypted: i=1; AKwUvBzS6lWXVfI26xMSYs29MiVyAIthd5ZsH8NKQcVir8hg87HXlPJUJHyk3kK4j3PqD79pNCVfjrki1A==@vger.kernel.org
X-Gm-Message-State: AFuF++m25rMOQXXNZd6Re5/4Fubh/z4jFnS90s2t+ZMfpCry1BxNdJh5
	vsIGWnmbS28GGPBwOQYPuir9UEjQsTYSms75LvZz9EznhHckgVo7821Gy5mBnuWYqJJoYZhiU4V
	2Bia+UGWTilf1gEcVCdIn7xRaxPzkWff3pYTbfenN3Gwv39BCCow13KhOlP4yZuGe6D61fdDZkV
	PpG7Sek56CI7Ljpj8GOQsxXIxYh0ElNhGiNPQH
X-Gm-Gg: AYBFou3aWIneUr/iw62WbwI0vIWhzj7kq+DtOMEA+CKHucZU6KJLa45cotOpk8U0Hjl
	VAW/5KpjMGy99+WAQVGH1O6UchxvWqjRW3VnFMmnsNRIozqVw2r1q5t88db8QtsKIjh9yQt3gXq
	bue8HLX6Dcz+G08L768XW7eZjpzlSv6HDWaASVhey/IF42SA8QVio4QznMSQ==
X-Received: by 2002:a17:90b:388d:b0:38f:5869:387b with SMTP id 98e67ed59e1d1-396d0ed8eb2mr48338185a91.9.1788258654345;
        Tue, 01 Sep 2026 03:30:54 -0700 (PDT)
X-Received: by 2002:a17:90b:388d:b0:38f:5869:387b with SMTP id
 98e67ed59e1d1-396d0ed8eb2mr48338075a91.9.1788258653663; Tue, 01 Sep 2026
 03:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803-arm-psci-system_reset2-vendor-reboots-v24-0-889281373870@oss.qualcomm.com>
 <20260803-arm-psci-system_reset2-vendor-reboots-v24-4-889281373870@oss.qualcomm.com>
 <CAPx+jO9QE_KG8BbfnMLTebDpGDj7OSpPDtgc9uTBGZCDJeLu_w@mail.gmail.com>
 <CAMRc=Mezpj4A7o00C9hhs97kdA5Q+FZKTLRbDM+fR8qr0xCCqw@mail.gmail.com>
 <20260827125906.GJ770273@google.com> <CAMRc=MduBgkP4K3yabbDbZicWyb9WWqmF=yUqo+WHocE6hpiLQ@mail.gmail.com>
In-Reply-To: <CAMRc=MduBgkP4K3yabbDbZicWyb9WWqmF=yUqo+WHocE6hpiLQ@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 12:30:42 +0200
X-Gm-Features: AcwNN1UeB9u2F8V9KZ-ekpacU9KYz87Vz22k3R4eoK1r51ZtRDyRbVXuvUd2fmo
Message-ID: <CAPx+jO8XTr-C6gPRWA2t4TVCTdRQ8oquhrfv7vMmC1oV_DpcZA@mail.gmail.com>
Subject: Re: [PATCH v24 04/12] mfd: psci-mfd: Add PSCI MFD driver for
 cpuidle-psci-domain cell
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andy Yan <andy.yan@rock-chips.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, mfd@lists.linux.dev,
        Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: dgcuoOQumaZEZJLWJzSnRANJpTPs3gU5
X-Proofpoint-ORIG-GUID: dgcuoOQumaZEZJLWJzSnRANJpTPs3gU5
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfX+N0DbAiLZlMN
 GhbIwH2pZNZ2IFkyzcWnEK8rtSqZRvGQ9FrQXVB5fDzpz2th7W4IdVjZYEQPlBEcvsYd5Ce5bJu
 Rwb0BgvYDWJdDqPIkSqGyj9+gxNWmsY=
X-Authority-Analysis: v=2.4 cv=U8eiy+ru c=1 sm=1 tr=0 ts=6a96a960 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=vprddorpQwRN7yjes_cA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA5MSBTYWx0ZWRfXwD1XBhuXHBqo
 ZXE6E6mrAK2kDyMfrwtJOKOEubgXKd5JmzcNmUTVilVXK2uoivgHfO9OsdOnfzoF9L6JDSQ5i7W
 TfcNtsx6kpOfIlgUtOZVFTgENqyphc4ZoelsFlldPfHlmRKXT1OVA2HTfPL/LsU8j49316OudL3
 3wq/j/zL80IKMWGGVAVPSk75+coDpZ2j4Og3zS2gv/3hDREfDqWzfVAclMnzn9yBA3MacnOy2Bs
 Q448uCmFzaGcdNIYZ8TnZcHSRJs5QUyiIQyYEtDwCRcXhHQRKXhWC14M5WcnK094rHJvd3scBTK
 KO81HADMQaLVNrAObMw0th5SRSwd/YsywvEi3yKx+tTspL7gGa3lRkcHcoapILS7CCJ/ttiGJf/
 HO5yRU5Z6pyT1yvMylOaUcYc7LHk81LIKjInAntddgcA8bggiaGUvNjlhpsIXABXR+1YUyEjdnY
 I17mamneqcJosj11dYQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_03,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010091

On Tue, Sep 1, 2026 at 10:12=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Thu, 27 Aug 2026 14:59:06 +0200, Lee Jones <lee@kernel.org> said:
> > On Wed, 26 Aug 2026, Bartosz Golaszewski wrote:
> >
> >> On Fri, 21 Aug 2026 14:59:49 +0200, Ulf Hansson
> >> <ulf.hansson@oss.qualcomm.com> said:
> >> > On Mon, Aug 3, 2026 at 11:45=E2=80=AFAM Shivendra Pratap
> >> > <shivendra.pratap@oss.qualcomm.com> wrote:
> >> >>
> >> >> PSCI has multiple kernel consumers, such as cpuidle-psci-domain.
> >> >> Currently, both the PSCI core driver and cpuidle-psci-domain bind
> >> >> directly to the same PSCI node "arm,psci-1.0". Additional consumers=
, if
> >> >> introduced, would also need to bind in the same way, leading to sev=
eral
> >> >> drivers attached to a single device node.
> >> >>
> >> >> Introduce a PSCI MFD driver that binds to "arm,psci-1.0" and regist=
ers
> >> >> PSCI child cells. As the first user, register cpuidle-psci-domain a=
s a
> >> >> child cell.
> >> >
> >> > I don't think PSCI should be modeled as an MFD device with childrens=
.
> >> >
> >> > Instead, this looks rather like a better fit for the auxiliary
> >> > bus/driver. Please consider using that instead.
> >> >
> >>
> >> Hi Uffe!
> >>
> >> Since I was the one to suggest MFD - would you mind providing more arg=
uments
> >> in favor of your preferred option?
> >>
> >> My reasoning for MFD was that it is indeed a device that provides mult=
iple
> >> functionalities, of which cpuidle is not really he main one even thoug=
h it's
> >> currently the only driver binding to this node.
> >>
> >> In any case, we'd need a "core" driver binding to the psci node and wi=
th
> >> multiple auxiliary devices with their own drivers, we'd end up reimple=
menting
> >> MFD.
> >
> > Ulf could be correct.
> >
> > MFD is usually reserved for real devices, whereas the aux is a little
> > more loose.  Please consider it as an option.
> >
>
> My point is: if you start registering auxiliary devices from a "core" pla=
tform
> driver based on real child OF nodes then you're basically re-implementing=
 MFD.
>
> At that point you're better off just using the existing MFD infrastructur=
e.

I think it's as Lee said. MFD is for real devices, while auxiliary is
more suited to split up functionality using multiple drivers.

Kind regards
Uffe
