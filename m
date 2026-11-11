Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794399045;
	b=ri1IlkWVreXXBYR7NqAv3LrH3YlIT6GAq03vfCsLYUhhykOEnLcC0ft6czzwRx1/IZxj
	 7rVpPWsrfRnQiUUoetCmflEgoyepvjOx/PazWlmCOwxt9Ja2RWtwYkH/FFnuGw9QsL0Az
	 /vQRwT1iYzvgQL3V/CFWTvHvPVJmdOs1pquDIb/AgCY80piPNDGiQ7Ff4rcekR+sQJFui
	 cWPoHsBp+DpT7fidgVSfp5FmHktqR0hsuyXU68KM3/vkBvTIS5ps/4S8cajCpMHO1a0vM
	 qZ1Yw2Kf9XqffsR3M3o1ir57n7SAc5dkkkpeBlGOCsrB7/D9+EJ0HmaTLHPBYOCSi3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794399045;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=b++LVQW3MxBAHYI6B2X9YDdw0p9UtYRJwhL9UHx9t38=;
	b=0Lcz9ECKaR3BzvZL0Z9VHtTv/TivkoRqYc9vwqEWPjBwdE4wfNS87Am+x7LmH7xNaHMH
	 jI0PaGN4ebtEMEViRoJwxQ/jM3xBJCXhqCnB457G2qXg1LJpI6h3ms4oHoZSy8+NbnwaY
	 K21jgwQklworRmy5paeS8p9AWViAYxgDUA10LlrqVdSrTF5hWo90pMyB/Q1JAnGDj0FvQ
	 8ms38anvytRbthsMSfMOFLGnp6uPqMsvo2dv7vDDlb7yUKW0uf3VqQLw5QhI1rgjrEXzQ
	 o4WRrc0DAVBxA3ZdJu0fTqC8NRlfpAITdWrtg/t4fLGUoJVu77uZ8YHPRi7OAYcuIEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b="kY/cULp7";
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aEcrlyQK;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB98606A326
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:10:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB98606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=kY/cULp7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aEcrlyQK
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABAuU6B300688
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:10:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	b++LVQW3MxBAHYI6B2X9YDdw0p9UtYRJwhL9UHx9t38=; b=kY/cULp7Ee4wJ+TP
	JvPyLbLdGBGR7z4fhkLBMdUI6xUfB+yp26GOgbc8GgU3Qg/ZlHSyfmJ+3dyLXzlQ
	SrvUIZ3D5jthnV7s02nDyusNyZEp0CPzPrhNrtmVyBZYw06uS/Lh0QpvQ0VQLVXG
	ktLoAWAmEpVdhzLV+foODwbdNU6jtYBvpTvlhR88UQHVl1VIWoa5Xo9Xu+jnKgOV
	/FrPQJMYbtrv0apfr7X3uHjE361P7g1PomuBuJ7i+CaKjlxSAGYrauq/zi/p+0pn
	YhaNpEz/nVdXxiofnXAB0+eR/vlLlPjFEXQSMNyP3US8dAK75r6WLKLi2f/z/l7e
	6y7ZPw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hv7c5m6sa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 12:10:43 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3acc98e3b3cso2521622a91.3
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 04:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794399043; x=1795003843; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b++LVQW3MxBAHYI6B2X9YDdw0p9UtYRJwhL9UHx9t38=;
        b=aEcrlyQKaxStoYY72tAmcsHtBMr7l7xFZ7RporthV2rJ/UgXyZa1dMmJpc9uchkWhy
         12CWGlauE+Yhve/UZso9P2BXyX8/FaDhzd80NOhwUh1EMRb26Ei3uinqAHhriYYB5NuU
         C05oB8zDmlwrBlLFBc6SGbu0Zheq4gXBIiRuLjqmrevt0HhU/0NK7ECSWg+ye1qLtMXe
         Ox3V5YOcQnKWlxW2mnarNzHICeEZYxsACUVcMTqN6EKnccQdzGSw0QXoKEuFpzXL+Ljo
         KBGE68R4EQWJwzGetiREkfCQiY7l3owcsRtEJZrU5i0uEzBP8BgUty85XZvXwDWc7MA5
         YMWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794399043; x=1795003843;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=b++LVQW3MxBAHYI6B2X9YDdw0p9UtYRJwhL9UHx9t38=;
        b=DjVwW57GaoJGm2rStCzJWd1EaacM8dmCVxJamgpizbjc+b0W5HGf1846+GNyCrH15g
         aNNqZ21vYQVs2KTjeWLqI2f5lJcjU/guakMjrnsjVzGc9dftc9s2t+qpp9SNk6YL+y8J
         bLq2P8d5EgNcKA0VMekEb0Ki/4k+I0uUuuYbLrUeyp1RBszB+aZ/6J3dDYdPE2U5nKze
         jsxVGSWJs6F8Y1nA4g94X3CxPafbtkwYzFPYV6BtEOP3YKbJ83s5P75zZlT04kYZ2Fjl
         IIQtf/IvgXBxTpElGVhZnvGZTfJmkDVVuhBInEB47HHFzqnDbZdc8B7DSddNtdANRJ0e
         ZOgA==
X-Forwarded-Encrypted: i=1; AL+hErFls9woIA5oBm+1PznC2VnDDP/4o/+rNlnCn7ItbqwpILd5BqOf4cXh8BpzhHBzGhv+esH2sOuIYQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ab7C3Q6GtMNYO2vqcIM8nvSSCLB1QgMql/dNUtkpRFlEylg3M
	xPDgJ6M/4HygjOUV1BUfXw8iPgwf6O2pGsBvxnWm4epcs9N+b0kUjuEgU8Pa5EyYDAzExwsHTWe
	mInr9AtPLcTjFMG9M2pyRP1zG323OVHCbJtSAdcX1mbD8K6TEztJPpHejs21q+g==
X-Gm-Gg: AYBFou3iG50MOvX/BgmfFS3qRcfUbNOemQ2pL+5EDc8UjD6zXs1zWLn+JKiYAFKKdS3
	YIm204dIQcf44HrQuPQxHyNX40n6T7nm98Tuy17Ri9/y6S7QoqXbTBTCMG5AXRbS0oarQHiybMX
	G0pdbpvjF9g62BJRi1n8xCsf157yGT02uJO4jwbKtVS/1eyEHXtFsi4TAcnfja1Ou/18b9Qrz+Q
	qgKEMHG//wg6w8R6Ucqbc41Tmx+ZfNvaVOLx8uRDH2Rh40L2wHSuIAeWDIXVHppws6CJq4jlurp
	soqc9G+5sjY7xIbhixZACqWVE7QryQopBzwMJTxUg6bL1NtRyiB7x8mo2pfsJM0rVu5YGNqyZkn
	ehJvJ0N+aqTgpTEldDdhtJaRJyYi8PJjhLQZQXhXumr1lD+AysMV3HYFCybYpWgx1btchvtXXfJ
	JlB3nakM7nqPX7Cp/pB6Pdnlvn9LrggREC9L9NjO0veMXAwuu8YEYc520c3ooQDaA=
X-Received: by 2002:a17:90b:2f07:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b182f26e50mr2286504a91.28.1794399042887;
        Wed, 11 Nov 2026 04:10:42 -0800 (PST)
X-Received: by 2002:a17:90b:2f07:b0:3b0:a970:caad with SMTP id 98e67ed59e1d1-3b182f26e50mr2286473a91.28.1794399042327;
        Wed, 11 Nov 2026 04:10:42 -0800 (PST)
Received: from hu-anancv-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b17e0df70asm4460130a91.9.2026.11.11.04.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 04:10:41 -0800 (PST)
Date: Wed, 11 Nov 2026 17:40:35 +0530
From: Ananthu C V <ananthu.cv@oss.qualcomm.com>
To: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
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
Message-ID: <avRbO42GNlfMAbZ6@hu-anancv-blr.qualcomm.com>
References: <20260929-schedutil-boost-frequency-handling-v3-0-68de169498c7@oss.qualcomm.com>
 <20260929-schedutil-boost-frequency-handling-v3-1-68de169498c7@oss.qualcomm.com>
 <fbd7fe35-5e14-4589-a072-909e49a92e76@oss.qualcomm.com>
 <cfb79ffe-41b7-4e58-b3f5-fc9a28a4e413@arm.com>
 <77749e58-84d6-43c1-bd37-98d0046231a1@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <77749e58-84d6-43c1-bd37-98d0046231a1@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX92BKHStYgpkg
 PpHb8cI95FJ+anvIMjPkc9h7htsAjNwEcv2TxEVqYQBW0WWPRuODQIHO9ALgQ7lLgCXeGwGphdB
 f+ieKk7/wSN9jqt9hXIKRq5OSEzUdv0jrxI1KX5D1nTdws7cSFKtr6l2/wbB78HRxKVDD+D/Q2U
 w2lcQUHW3M8t9g5shmK1decYH+W1bjNnBaifY8ljUblVXxq60B8ZvVo85OXrgbS8+FV1oXWLdTt
 DCCTFmHbR6pFeujMP4rkv9RUw84RgrK75ilM0pvZCEms9R0soMpM4yiI3vz7XOTgGuB8w9dD7hP
 luLhiVLAlvzRibXquy1rKjMR5Uo5boRE8LXEHdQk+c0YF7zNcCLq+ku18vUjcsmReN1YlYwTgE6
 hv7o/q70y8wo5GUZ0cWl3UZOTMpERxbiJL3Q83nqLKFem9jPVoo01RHP5uif8ghjClZfItp9y+F
 dLINrW0G/LAqeQhVCNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA0OCBTYWx0ZWRfX1tbh5XfckPzh
 hKA48957VPmyjU7zknCV6D9hA52GtJB0EZRwG+z3STLfFKllEpagircLs2W22JP7zNnfU87kev8
 yDt/tRbk2T1W3tWo5xAaG8/KgYeLBSw=
X-Proofpoint-ORIG-GUID: hWXc84QZEtsyO1gVuUEu9PL2aekbGFKC
X-Authority-Analysis: v=2.4 cv=eq9KXYpX c=1 sm=1 tr=0 ts=6af45b43 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=8nJEP1OIZ-IA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=BJpuNRGIkIodYMgpjU0A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: hWXc84QZEtsyO1gVuUEu9PL2aekbGFKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_02,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110048

Hi Zhongiu and Dietmar,

On Tue, Oct 13, 2026 at 07:28:31PM +0800, Zhongqiu Han wrote:
> On 10/13/2026 2:45 AM, Dietmar Eggemann wrote:
> > On 11.10.26 16:16, Zhongqiu Han wrote:
> > > On 9/29/2026 7:38 PM, Ananthu C V wrote:
> > 
> > [...]
> > 
> > > Besides, could you comment patch v2 Dietmar's comments? It seems that
> > > patch 1/2 exposes a pre-existing ordering issue. On DT systems,
> > > cpu_scale is normalized only from the CPUFREQ_CREATE_POLICY notification
> > > of the last policy, so the cpufreq pressure of every other policy is
> > > computed in cpufreq_init_policy() from the raw, not yet normalized,
> > > capacity, and stays cached until the next cpufreq_set_policy() for that
> > > policy. So far this was harmless because capacity_freq_ref == policy-
> > > > max at boot, so the pressure was 0 regardless of the capacity. With
> > > 1/2, capacity_freq_ref covers the boost frequencies while boost is
> > > disabled at boot, so policy->max < capacity_freq_ref becomes the common
> > > case and the stale value becomes visible (102 vs 79 on Juno R0, as
> > > reported by Dietmar). Perhaps the limits of all policies could be
> > > refreshed once from parsing_done_workfn(), after the capacities have
> > > been normalized?
> > > 
> > > --- a/drivers/base/arch_topology.c
> > > +++ b/drivers/base/arch_topology.c
> > > @@ -454,9 +454,27 @@ core_initcall(register_cpufreq_notifier);
> > > 
> > >   static void parsing_done_workfn(struct work_struct *work)
> > >   {
> > > +    int cpu;
> > > +
> > >       cpufreq_unregister_notifier(&init_cpu_capacity_notifier,
> > >                        CPUFREQ_POLICY_NOTIFIER);
> > >       free_cpumask_var(cpus_to_visit);
> > > +
> > > +    /*
> > > +     * The cpufreq pressure of all policies but the last one has been
> > > +     * computed before topology_normalize_cpu_scale(), so refresh it now
> > > +     * that cpu_scale is final.
> > > +     */
> > > +    for_each_possible_cpu(cpu) {
> > > +        struct cpufreq_policy *policy __free(put_cpufreq_policy) =
> > > +            cpufreq_cpu_get(cpu);
> > > +
> > > +        if (!policy || cpu != policy->cpu)
> > > +            continue;
> > > +
> > > +        guard(cpufreq_policy_write)(policy);
> > > +        refresh_frequency_limits(policy);
> > > +    }
> > Yes, IMHO, something like this is needed.
> 
> Thanks for the test verification and the discussion.

Thanks to both of you for the discussion and suggestions. I am noticing similar
pressure update related patterns on glymur as well, so the discovery is very
valid, thanks for that. I will take in your suggestions and include patches to
fix the pressure scenario in the next revision.

> --
> Thx and BRs,
> Zhongqiu Han

Best,
Ananthu
