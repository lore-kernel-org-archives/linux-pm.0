Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399179;
	b=C3PPW+eQJ74jVrmP7dXGAMKbj3K/97480z55dKElpryy8IP26XEkwL0n+ugA0JFJTH1O
	 TIqWk9eHG1I6wulrkfKAfD5XIJuEnvxlFEeumDlDw2TDRohRMkdy0w/WlOj2oMYzonRIi
	 BBADsjdyY3boA9eztqxBN4RkPRXmGD8gGh/N2aGeo1WG5DsUy7ote5D//SJZO/LkwvmVv
	 Ad3JTEFh68tmpbXgETH6v7suJzREQAf6U697vZxAy4K83ZItxVve83RLOILfrDSg+YXlC
	 XYXOUFt0EImESRHEkFpIhCAiscX6CixJGWkccAjJ8pRJGpqtesRAlOAW+WjdxAyCucQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399179;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=dvghIzBw0O5GdRnMjzzOWphS3vZYatvIGIcTOmd8Jr8=;
	b=iztSIk9FcJzajT2SDybnCDiC72I0IjvWGWBV3kkJ13qL8tVjJp6I6U9/apIO2f6RHQR2
	 Pu18pCZFkIIDek/1Jy1U766zVgJmP8dQS+5K5blwhl3SxdFzQBd4t99ZdPatQNIL/D679
	 NMCkfsjWez2UrITk2rEl6o9HmJHDACX6AyGlQksMTdLIxujRQhnR6H++k64JIHJy/dEOV
	 SEoldoBSPdZB4/o+n7om6xzmd8UgXuj/vQ1692qFlSc2wBgyvDzWQxDMASaTbKKn8v9mS
	 DFckjube2PRP1qDsqHcT5Ln0N2BmNs5HG4POddz+OJdDbNtU+mvs/leN4iWBI1vmJmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LSli6rNd;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWTZbPGZ;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2AB606A332
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E2AB606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LSli6rNd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hWTZbPGZ
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAjqWQ300737
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:12:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dvghIzBw0O5GdRnMjzzOWphS
	3vZYatvIGIcTOmd8Jr8=; b=LSli6rNdgYS+dfKIOBHsyxhzbGY+sRAh53KFkuk0
	JVfWLVwQqupLGo0cDdvm2AeZ6eM/ktyhvJn2t5YuwxqKomWVaRskgqGFrN85U9+9
	mkqmejtkPkXQ+3adl4I/wtu5G3/t3qzOiHC3uRmi2GsumY3PJZ3sgYVGh7pk+GJm
	1svk4JL1JEWCJ+V7e0tKPZ3+k9YeQhhZlBrYbXTn6Q2F5XthaNBxgT46ZnYmBxV5
	6mNAdvHb1o2jdmpZmhPr/5SPaWPnYc+G5lmDi9r5lko2Seg6V7Oq+LNbSKMN55dC
	hnGdEcBGSQzbIVeYkTO8qHkVNZaX1qKXLKObZV6kDgMkOA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5m72e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:12:58 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-341eff9e381so6373127eec.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:12:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794399177; x=1795003977; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dvghIzBw0O5GdRnMjzzOWphS3vZYatvIGIcTOmd8Jr8=;
        b=hWTZbPGZZ+4cS+WNdjW4+w5jbh0aWJ9ezjl8tGxOBKmgvFcPfxsAnX+/3rth8R2gVg
         Q4VZq3vKerMoYYABZaZWN4xfmHUz27FPK7iL2EO06Av7bgODTbbdfdpnmXp9j/Fytc3F
         dAtoV8ckUNqR1+6wmDXxS+ByBA7ww4ALizktKaZ/cT5OWfvEkmzLkqUMCcQre1txBael
         RLyTgTlN/NDZjDVRXmJvi/KWGqSR4l+N5/MWRTd+GkS2n1Q79XYdcAM4OgzQJuZ3xzxK
         D9gsh73p+hJo/rBMWwSafxtjTos+7ovxjHzlLgzM1y+bhix91TbJ5IoRpUMczh8kfrg3
         HfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399177; x=1795003977;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dvghIzBw0O5GdRnMjzzOWphS3vZYatvIGIcTOmd8Jr8=;
        b=IY2UcREOJwapzYIrl7oSUGDkxNTGMyTC3hXVzN/EdKuqZrbiVJfkKUMqBbp9SWEbas
         UlD7SNN2216+/Foeu/UTebOyJqIjDqKgXjWSntZi1tQ9BZ4WQ//L4W0DKlZf2dMe80GM
         DjycrK86slQiKKQ98EEchpJCe7xepzyuQZTi3ZQFaOw2qsMRvmFmv3yqNwJP2zFyBdmf
         v1Q6kP5PzLXEIdCmXTDq0036DfiYynOUAMl29q9tHteOxjR05Zs9li/q5EoEMJmFJ39c
         WMayR84q80Zoak6wJALu5h1gYJpwVaNQF8Cf16hK6lOJ2i1Xz+6bBhBJMy3JZrz0z96R
         eRGQ==
X-Forwarded-Encrypted: i=1; AL+hErHAohu8du222dGrdLV1Z2u+Tw6/5DCCuXvJ/o3fT3BWq07tHeIcz36yXjHr17yQO2/Sc0fMwL2nIQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z+O/MUPoiPz2xICAO1lYvSliUEGogpzztdGHlsn7o/CE3DycxaA
	Kcn86dXO7ZVtAL43noCJjQ6tjomDI0I5gBCUnYcgzc7HJSPL9afnAhJEQKxIa31J41gJt44zDMO
	RQAfhxZkPnjt+UvIKnanraO6vbGVkJTw4BSPYb+VkSYumUBJWGCNV6kL94AMuJg==
X-Gm-Gg: AYBFou1zE1gA6HPfowHBIxFGQiqCPFh5J74hmbSgTSTBgVrUdLwk/oaUEb7WmbS48IX
	lI/R2drcJuU+m9lFrWrgsbaYwuVt9I0jBFrvaeU/HebqC0uxJQGAsVnclCBrS8IY6G75PnTLK+w
	ZPHm3ecuBQepnQfeK4ThGE/uW24sOAzyf7+NbgtUUYI017DmbiVUdmwYxCVvb6dOJC6Vzcw+hqV
	W0eCT4M8EfOrMtOtPBJ6qIx4gstavK0eOn44aozDdUG5CM5qcx22TCHnpzElRHCu3zNnwkHeJM+
	3D9r3GA72uWXZO6TXSKW3Yx69LuBTOFDN9c0wLgJLKodlo3MkaoJsu6rIcQobTMiYtenM2LbPtm
	D6YA7m4/+HgA7gPlYfHzoz/bnmdsbqYbel5kb9p7QFX3yhIUAqHnkuyhXkLruBTQYZXW5bXwY83
	QhDeJneHv5tu265TDuO/2RQmKlo/DfoDXAXTMP1N35K+Z9vyCXecz6m1f2uohW76s4
X-Received: by 2002:a05:7022:1706:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b3c03117e3mr1632724c88.24.1794399176894;
        Wed, 11 Nov 2026 04:12:56 -0800 (PST)
X-Received: by 2002:a05:7022:1706:b0:1b2:43ac:d3a3 with SMTP id a92af1059eb24-1b3c03117e3mr1632703c88.24.1794399176111;
        Wed, 11 Nov 2026 04:12:56 -0800 (PST)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b2eeffsm15887599c88.9.2026.11.11.04.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:12:55 -0800 (PST)
Date: Wed, 11 Nov 2026 17:42:49 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Jie Zhan <zhanjie9@hisilicon.com>,
        Pierre Gondois <pierre.gondois@arm.com>, linux-kernel@vger.kernel.org,
        driver-core@lists.linux.dev, linux-pm@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Oleg Keri <okerixx@gmail.com>
Subject: Re: [PATCH v3 1/2] arch_topology: seed capacity_freq_ref with
 highest available frequency
Message-ID: <avRbwew20G2fd0Eo@hu-anancv-blr.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-1-68de169498c7@oss.qualcomm.com>
 <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX7zORmDHiHp4J
 uWvGZxeR6bOa16dqOCGkWx/ArCr/mqkmRwG0imOda54ewXkRDuIjI7fy8TGH6JJIkuEQy94AHrW
 +FT/t1zdd5iekdsrvWJtrMSiGZR/LTlZoWzuEzNEpNb7qzLc4yQJ1QPEzOvTf0h7pUw99Yo0LDF
 nAF8FtAyD8ZIG9IpRhcMH6FIuUOLkI5r561ViVFPj0RDMMZyk6xaKhGxzXcvw7jfkVROqNlF6mR
 61ZMDYEK5UZMYdhgm7JbIRTrQfo119Yc5MRyCxPKHPA6TSX6/xjqbsFvVeUSJ81E5pf8hdPZIi8
 XpY0x56k4r5gzVZWU4CAZa0gNXrFw+E9jm1Jzs4beJd9moQIQ6sZbaB2ko2bqYmK5mHfQ+d0+Ns
 atdd85JCjr+wlb/Bpfxw2R/NjdqLGos0VGeDIPyamyogOT9p4rS5ApYzyhS7xUuygyLq3S1UXz0
 xYaqR4ecTIkw04Fy8Ag==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX10B8ADORvVta
 S25HdbrH7qOahyYXP7M7hufMpUQtXRK4nsFrndvS8SH3CQWvag6Yci1BJg6yT1EV2aSteDEtYLy
 r+hVRnnSjrpEaB2YaEe+zkZKY2D5CEs=
X-Proofpoint-ORIG-GUID: ux5aHG2HvK5yB-AAhCrB7nxuh7Fwupfu
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af45bca cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VdZ5ZUKuIB4TndN85GoA:9 a=CjuIK1q_8ugA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: ux5aHG2HvK5yB-AAhCrB7nxuh7Fwupfu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110048

Hi Zhongqiu,

On Sun, Oct 11, 2026 at 10:16:37PM +0800, Zhongqiu Han wrote:
> The current implementation looks correct and works well. That said, we
> might be able to optimize it with a simpler implementation as shown
> below:
> 
> +/**
> + * cpufreq_frequency_table_max - Get the highest frequency in a policy's
> table
> + * @policy: the &struct cpufreq_policy to inspect
> + *
> + * Boost entries (%CPUFREQ_BOOST_FREQ) are taken into account regardless of
> + * whether or not boost is currently enabled.
> + *
> + * Return: the highest valid frequency in @policy->freq_table, or 0 if
> there
> + * is no frequency table.
> + */
> +static inline unsigned int
> +cpufreq_frequency_table_max(const struct cpufreq_policy *policy)
> +{
> +	struct cpufreq_frequency_table *pos;
> +	unsigned int max_freq = 0;
> +
> +	if (!policy->freq_table)
> +		return 0;
> +
> +	cpufreq_for_each_valid_entry(pos, policy->freq_table)
> +		max_freq = max(max_freq, pos->frequency);
> +
> +	return max_freq;
> +}
> +
> 
> 
> >   static inline int cpufreq_table_count_valid_entries(const struct cpufreq_policy *policy)
> >   {
> >   	struct cpufreq_frequency_table *pos;

ack, I will try to further simply this with taking in your suggestions, thanks.

> Thx and BRs,
> Zhongqiu Han


Best,
Ananthu
