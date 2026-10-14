Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4372E7F25
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791986428; cv=none; b=FLSN4uuyf7sVxsFZ5ThDF6cjOnZp7SzaWAqKA9g5AAQRQRK2vZ5s5z8Hjz/AXG1QIaMPu7w46IYrSYJRfcAR5g79+k1t+c6Bv1zlX7+7TQYyImh3cIG8At7irUrJk8FBNGh2IxwKfwYIOMvxkqaJnPOg8kvmJurT7v/pfKOLy5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791986428; c=relaxed/simple;
	bh=Pxet30TRJQtNsCxEqkZUTERC6HZaIwRxrkW5u9k6X6A=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=KkDgEr9tn8Vc59nCNvLhK4bU5fbmeEfTWeDa2m7mXr5bowElyNACgVVZ/Pw32vVop6EO5y+8WaLwtIJGUlvDf3FeKkpARLvLXVMDG4BMlmlCKXZ5RcyuispRRDA+YfS6KqNzHfxxdmX+PNrN4bc0AIiy2acFZBK/NHxzGj1eqqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TM88gY/S; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CDXbxrKM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TM88gY/S";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CDXbxrKM"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69EAR25V466226
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:00:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=; b=TM88gY/SAkuivGf5
	+yFWFP4405hUK4+veo6xqA8dkTVtPOBN96tlIMpYl66yC4OPDWEYnoW3ostFzXvP
	/QxUnuWc0oekyclc2OdhCRsz5NQpn2pHquNClmYxC8hHJI53iRycdoczS1lXAgZI
	8cRopjdlyX11Dhc+gxJTAmnlJTHA6Cp3dhZGg3sFugbI8Bejo2l7JRCnRlhG7hqS
	9RwcaRNDYCak+N0+yJF/bsoqIDwaXOAOkS1j44CS8KXp7UpUAFQdwmw5tRig80oR
	UJTomABLqeBTPY0zH4J+6r43Lbga/EYLgEjqPjknpgEBuU59+4pW3FR+37AKi2Bi
	l2Re3Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80crssq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 14:00:19 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a3f673221so1273033885a.0
        for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 07:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791986418; x=1792591218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=CDXbxrKMNIAdXZ03dLl+KTIi/Y254jbAGd42kPLuII6veiB/By9Vn/UkLtAChuPlfX
         Y94DXCIUe9JjBjEDugbjUd83Y/t9f4L2dnfiOkUVHkiB0pXQd1FInOQu7oU+cn8Mgt07
         adJOZSoKY2VKdfLowtb2Zr+FjzmPpmVv53pR4VBsyDJmYVKEf3N8BzJ1oz6+z5jvuJbz
         E/8TUljvVT042Eq6OD3OBz7Xvxhica7JcYjexxXetCV/IdxtOhpTrYuqOvAHrCup7AVT
         o2XhsyAgJBl1ANr8LR6Je8LLJpR+nBZjAZQYjsWXfxEV5Pc4HNTQrJHEtIlLsy3b6Ivd
         GGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791986418; x=1792591218;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M45fNMyP5YyLBZ5igr+FxKq6/r20bqTD6HB21/sx/vg=;
        b=sPleVkQC+BoMN02Y0yx/yt+icm7n0cU3o9xC018D6qL9P/wCTfj3wSc3ueznOmyWco
         hmDYwYsfVOkjDYTS5Rbl+tw1rNJjcRXiiiMAlL65zl4Pq3osNmge98kXJJXpB9A3YPCD
         dJqAQ03mXFOqJ/AUlweLQ4SGc0qYGYVBjZYazm+n4BhEATz/vnbUzEZSmbFkc2VkMslC
         uc5Ni0qiSxGWFo8Tu8TfPD0w9nft5w3Pld41L8wqrYw7akcKUnHN8j9ouSJzYrvNEoW6
         GSSmF3quoXh8aAY9BIVLqwKzLrC1Jl5XJQ95cudwbRKjVZVfgx19zGCA3RJHlvJPLfCm
         ig0Q==
X-Forwarded-Encrypted: i=1; AKwUvBwRgrYSTsyToTv66WYklhd2AtxmoXHkdLTqxqEDeugYKtj31It+rccsg3/oJ/yhZ4bntif4hMfErg==@vger.kernel.org
X-Gm-Message-State: AFq9FYIms8y8HdDqIPRpLooVY0shfhH0cnKb/EyB6xWuGxy5VzNhzPkI
	RXJX81FM/y466M9RcMdYBukk+dqb+KL2M8r5eLpEH6ZTj4hDJJ/4Yc8DPxCKzsdb4/coPLBe7oL
	Hj+jsEfoCxlcY3r3IoqCnBa6/tR9rlVvsop3gluintqfjgDSPLtKxgoYfyjqNWQ==
X-Gm-Gg: AYBFou1PN/+QiguVIG8kXbjqIKxZKpWjt3k7SvGtwbQ6VjGqlgHYeg98YjKSuRXMk+N
	Sh+tW5mnMN/qc2qBhPg5tavdT0Hi7Lf5ufJ4BuTVvGIZEcxjNyF0aLAqDOMSj/PHQOeONZ1lI1N
	xW0VCuS+6lWF+8xDjUYmd28gYR5P/9ZeerJWZ9MlmuIu5BemKcuuiLnGTrflQTrqCFiDnmeU9C7
	6bZqbUdRsjG6OI+2Htkwv69HEe34jnOD88/91PbAvkIp6TH1MCfZXwJ6t2MWSy8+3cJ4HHo7NcN
	IjSouAAHFN2L4QMHxcbKbjtM37/vAird9IW8iSChDKvFjPfW5xp92pmTzOxMlZaX3zSaQGNWfJz
	sB+NLHrgeC+hom2B5OKxiJ/y/Unc5/wfAwQR8NLNrTenqZyOt3Mq38PXZAm7HdyWH733+cdExjO
	HQyl14uckwChd8T0VZDZbosap/J8fm5fNC/7X40GS3OKkCTO/ZVTwVThApaNZuK/5o+A==
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846063785a.26.1791986417315;
        Wed, 14 Oct 2026 07:00:17 -0700 (PDT)
X-Received: by 2002:a05:620a:460d:b0:93e:4ede:8976 with SMTP id af79cd13be357-93ebd224c25mr2846046985a.26.1791986416149;
        Wed, 14 Oct 2026 07:00:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3b3836547bsm73203366b.13.2026.10.14.07.00.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Oct 2026 07:00:15 -0700 (PDT)
Message-ID: <a8d28d1a-5bc4-49a2-8437-18d1ae9d4f51@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 16:00:14 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: johannes.goede@oss.qualcomm.com
Subject: Re: [PATCH] ACPI: battery: Re-read battery information in the
 complete callback
To: =?UTF-8?Q?Ali_Ahmet_Memi=C5=9F?= <aliamemis@disroot.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Armin Wolf <W_Armin@gmx.de>, Charis Stratakis <c.stratakis@proton.me>,
        linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org,
        regressions@lists.linux.dev, Mark Pearson <mpearson-lenovo@squebb.ca>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <37N_jFulf7n-Z55NfKfE71C_wVPxYvZ0xD_iRUg2fXu7TypDiF5PStQ6siSfVBih6fThg5WoPes8U5ZQpfVm_teMFcUGXFxz2DdMbfSWuws=@proton.me>
 <20261012225141.13683-1-aliamemis@disroot.org>
 <fb993dd3-ee56-4e3d-aa16-573f011518f1@oss.qualcomm.com>
 <CAJZ5v0gS4agVUkCO6M=VW4Wi2y1-s+k23bpzmX9aAZ0Rsv4z9Q@mail.gmail.com>
 <044e9df4-1399-4ceb-80f8-f7cfe031d04f@oss.qualcomm.com>
 <CAJZ5v0isCM3K3U6HSdDnvXzBX41AgQMFYxqLx3KvMA0W_91-ew@mail.gmail.com>
 <20261013210609.8117-1-aliamemis@disroot.org>
 <ab5c5ae1-1bfd-4fe4-adef-fb64b5b3dfbb@oss.qualcomm.com>
 <20261014133218.94357-1-aliamemis@disroot.org>
Content-Language: en-US, nl
In-Reply-To: <20261014133218.94357-1-aliamemis@disroot.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfX0BPfekDz2Hm7
 d0FPPxL1UwlcCcrsfZpv/c+jz2CuTwKFFmIR+yI4Eeb4f+kJwHcUASMLgibwtNuyp9dCKbCnKNm
 u1b/iTotEj+i0H5RTJeW/k9pZ7CmHxE=
X-Proofpoint-GUID: oCp3oWos9ITN1j8OB8s6zHyJ6Gz1WRPW
X-Proofpoint-ORIG-GUID: oCp3oWos9ITN1j8OB8s6zHyJ6Gz1WRPW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA1NSBTYWx0ZWRfXwxj9Q6wA9pCk
 b8/ctlsIf6Q2BS5wv1QYNZWai9+Em7y1a1SSUrNH6K/PZz/T0mqna0mUvTFEygyKZpM7jdTvGwt
 qk4giehPL/VcS//IpnMBpEH5f/Pr/tAWfMejcsLV0TjhezuNr2QXHcu7mQks66DffJJkNuOFv00
 ZqdR3xvRzFSY63C7v/EGHaKVx5xB2Qx8UonlaxweGaaXqFIIusz209V2zOEbRyVfGfw2NVQGMdg
 v7BrG7PSoguSl/BIUHK+PRvRn9mFaDbIfyDlDx7k+DyxiIPt1oCPP/SQefSiwfHz8J8TOkCpqjD
 pt6+pk03VD+BWn8QRG6QV1PRemi8q0JMQE9yyyj/JT93ArZcFRf2n6GW2xCT08DEprDR6VPsNZE
 dbZY4Mz469rhUyIC4Lb+dK1G0h9X0HU0O2aLuLlJxjplpaep4IPovS2qa0opyvGLHQn1O7Ek0Xa
 KnR+yHrA9Z8Vk3H6NCA==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acf8af3 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=LpNgXrTXAAAA:8 a=EUspDBNiAAAA:8 a=uisTf_hR4FytVPXRX4QA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22 a=LqOpv0_-CX5VL_7kjZO3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140055

Hi,

On 14-Oct-26 15:32, Ali Ahmet Memiş wrote:
> On Wed, Oct 14, 2026 at 12:01:55PM +0200, johannes.goede@oss.qualcomm.com wrote:
>> Can you post a patch series for the code you've for this now ?
> 
> Posted: https://lore.kernel.org/all/20261014132703.93355-1-aliamemis@disroot.org/
> 
>> Note I guess you're using LLM to help you with this, that is fine,
>> but can you please manually shorten the commit messages of the patches
>> a bit if they were written by LLM?
> 
> No LLM used here, I just thought the race needed some explanation.  

That is fair, sometimes it can be hard to find the balance between
including enough information and keeping things short and sweet.

> I kept the series short.

Much appreciated, thx.

Regards,

Hans



