Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282438911B
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791644273; cv=none; b=HQZ2ghd+3I3li6Q+xJ6BA+AaOy1Uw+zhAZLwjoE3lnq4V9LEHVtmVgrbNRNXqua4G26xYYRCtWdllhsYMZRdlWNHvw+LkqsoShpI4hoeUh96fLkef+R8zmkmwAiHtgCeX6UNyqhSs5AK3aNU+SuG3+tXS00i76aUf98Eh3zNpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791644273; c=relaxed/simple;
	bh=k1CvlaaDcrOnjg24LRhTZ6lgjvgTD4u9ShDZhtMdy1s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GiNKwQkW6BVEZMsy5RQxg57shrnAFd3xKLI4wZzjKROksXXrQ73lWSPBtwTx4frlJHWePbs1pp7U8k9PkuRRUZAKFLCSXL5RxXJHMJ7mM/T09NLpOSr3zaKbwmsnZC5zCfRtC7TPyRaJ5yORrwSS+ygWUlA/u+prJ1Rfzb6E7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eJU5Sqqk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=bJg7Ztln; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eJU5Sqqk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bJg7Ztln"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69ACUWLM3959000
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:57:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/Kh5QG2Nv+X1HzcEjb5yjRQX9s4bFbGm7nM9x0aAKfI=; b=eJU5SqqkkzYTzN4R
	RTgt3AkuTE0sK5ZCxOCuFIcvF63yYaFW2O6J65YEvFFODPC7cC2R6NONvkFrhYae
	uPAuCvA9FpWFAqvAgKTY2ME/g8eVbXgaYaQZ5YAhGpZrBM3g50ZJ4ikj1DSkiVc9
	iUNA06foeyHtgYZfzSPVVKizUKZ7HkjiBMWjPmgte3Gao4vmEnLpBEcbqq0JGx4c
	OWA4Yvn8RYGEseJssN2oK7LcVHxeVOuN6iNWF4A+I8CbJQjt9Tat4P9QGG7CZi/g
	rk+t1SQyPqbRTeMdd3qm4qlloX+nYTij//EuuWUZbDyjoxLkOYnZy8yO7E87g8EI
	tUIXHQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7en9s2nd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:57:51 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cc359d9easo110722185a.3
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791644271; x=1792249071; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Kh5QG2Nv+X1HzcEjb5yjRQX9s4bFbGm7nM9x0aAKfI=;
        b=bJg7ZtlnUIUN5vgKpVuZ5Yt/+AKoTAcTFF+nIpCQFWj/1cRvGUDeu0aKojO+ItOJVS
         /2jgJ8Oy5sF9B5UDOIDDXjFNbyCzLcwT3peE5Nka64ucosb7ugUS0S4jHq0Vxo+kc+6n
         Qb55Dw2j80Tpn1okMvrNT+S1gm9TroFICr9SQatmos4nTiey9Hx6qocAzJyzgTYDB3hp
         RUh6ATZWlGmVcdl0XvsuXI6O4U1kKFNUlG30n4VLD+YNirdCwNkiJDzEAHXjIludaY4F
         NYGKjZvsjXS29CndXkiT+xWoaVFEoAvNEOeEnXxI4OS1rZar/eyCocyLN7YeoAYNqohx
         tceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791644271; x=1792249071;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Kh5QG2Nv+X1HzcEjb5yjRQX9s4bFbGm7nM9x0aAKfI=;
        b=zrg/y8DZfKobVCzpFimngYZKUPtZgl9aNxNwSQHbVTF+MYJzGUzBkG8S+fYC3SbhmS
         i/otusVS/BZBAuk8tjHGTxPXcgr1fZlxzpVmN8DBgVed3Axd5WGPNG4pZuH57q+FW5mR
         Dt6FwX+d9+y0FQjQ7T0UlPFjktZpUozz3vIs5HojZCnDXJgbt16wngWa1H/bTTi50168
         2ZegWY6iwlKHpCYtRd5rcDNHivC/Cc3VEnkGZyxj1NTOWO+heJKGVidccYUUTr0TyLq4
         INmQjv4dyL2TUCwuZH0juQgxEtQqFbPhWVVPVOv5UNV1BqetB5+bwbYKzYoXKdc8QOT8
         O/Nw==
X-Gm-Message-State: AFq9FYKbnJCRbJsP+u6EtpIgc9SyKUDxeGYUL8S3c1YLd4Vo3uYTO0LZ
	gty4Wa8EINeoJTD7Z3qFnZKawvz9z4OBWmmpryJ7K3mYA4od89uJ6vb5XKXuuHxI5kUWmjUKW4k
	iCLGd60PXEOw0JHiyYJ31SawlyE03dUl6vxucixN4ZglIIHHG6226R2TFIbL0A3Pt5uTyLA==
X-Gm-Gg: AYBFou06Js2jUilqxeCNR6xNlyqi5rFRY0nFTL8zRt/VNtDsC2dcYrKHHqaZQjpW8i6
	aGiDQDEoiDL9drg6SPvot/O4iCIP3Fb4U4eADns4vPDC4hgqnwngJ5Nl/SAafFZB9kAbyn0yEe8
	5f3rTX3NIL4b9AOrPIrR9XISGHQhO2PgFyrgx+JA2F0vpFDPRKUvqnYPJ4mqwzBDt+UwGddT+1Y
	437Fo8MtNkabyexJ8Mk8G/5XbiK3CDbjgPMBKBHyiMoKSj949SQ+Fi01iF343RftdX6hzAMlbjM
	2k+1voQXmTb3bINg8HEKR0g6xKV4bfwGm6/Ho+Ap3ZYAwdKnxd+gduP0w4aDhwli2lDte5KhuRX
	E7seUZqw8wLzbYcIy4aA=
X-Received: by 2002:a05:620a:4007:b0:93e:264:5ad3 with SMTP id af79cd13be357-93ebd25ac2amr840849185a.45.1791644270600;
        Sat, 10 Oct 2026 07:57:50 -0700 (PDT)
X-Received: by 2002:a05:620a:4007:b0:93e:264:5ad3 with SMTP id af79cd13be357-93ebd25ac2amr840846685a.45.1791644270070;
        Sat, 10 Oct 2026 07:57:50 -0700 (PDT)
Received: from [192.168.10.46] ([37.167.89.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9acee65sm9641341f8f.49.2026.10.10.07.57.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Oct 2026 07:57:49 -0700 (PDT)
Message-ID: <8e6ddfa3-d94a-4449-b2de-032ca8677d1f@oss.qualcomm.com>
Date: Sat, 10 Oct 2026 16:57:48 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/6] powercap: Add generic zone hierarchy creation
 helpers
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: linux-pm@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260923143416.3713485-1-daniel.lezcano@oss.qualcomm.com>
 <20260923143416.3713485-2-daniel.lezcano@oss.qualcomm.com>
 <CAJZ5v0jikgt4wYS1MJqTBMKBaw=qeuGyD58ArQCoRpZNPZMSSQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAJZ5v0jikgt4wYS1MJqTBMKBaw=qeuGyD58ArQCoRpZNPZMSSQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Woe+otfv c=1 sm=1 tr=0 ts=6aca526f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=TGF/BEJusA2u3N3mnVMyRQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=oA7mVUY5bsbhFdn8sccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: hGvOFrZpfQRVS1uk4vhy0uPq1mxfp1RU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA1OSBTYWx0ZWRfX/PWzH5RPsoKc
 g5IByRVGpzMqciLBk6Ck4CuPYGS5OKT/X6CXIB/Iq9XRsvfomdmyfpZBADc4K7zwFGIHgmLWzya
 bBc5ZYmOFPkHPTyBwMelHG+ZoffrXjbUGa+auNvAwhzYLhdNYxZ8ph5dJmK50UoBsjOpDab44mj
 snlBime6mAnYtMLlk8E6CdmPb+M0MWNA0xavsBuSq/FDR/JIdyFllNKYi+BDVXY33G1/n7ILX3K
 sNExUqxLbR6mXJb+xkp5lfj/VREAlMeqFZKs8t5JNjoJWu9J2SWKnos02rCZjsFLDeGyYLo0gt/
 7Tzj1T091LDwJfxI/WRYlwW0a4MwHQDhwX6BsQS/YnrmGtvpLqSMyswSnQbegpfT8KEDk54RpEh
 6MEwwr9SnFQaAt+mzFTOun/A86XlEys177vw/gXkzsDZFNV0tQVfMwkg6X4sWKkM2NU4tvioFXX
 M9HhMEfiS2NQ5Viecjw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA1OSBTYWx0ZWRfX1LfLQXY9dqzR
 hlIBC25WlfvssTMxzPOjOlfluqRfew/R1Fn9YiWgWqF1UPqt4vfjuVuRf/JfalwMOlPNPAu7atC
 d+AXt6mWIvzBOnCjhoIz09tFSQCev54=
X-Proofpoint-ORIG-GUID: hGvOFrZpfQRVS1uk4vhy0uPq1mxfp1RU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100059


Hi Rafael,

On 9/29/26 20:02, Rafael J. Wysocki (Intel) wrote:
> On Wed, Sep 23, 2026 at 4:34 PM Daniel Lezcano
> <daniel.lezcano@oss.qualcomm.com> wrote:
>>
>> Powercap controllers may need to create several powercap zones organized
>> as a hierarchy. At present, each controller has to open-code the
>> hierarchy traversal, parent lookup, error rollback and reverse-order
>> destruction.
>>
>> Introduce struct powercap_hierarchy to describe a powercap
>> hierarchy. Each node contains its name, parent, backend-specific data
>> and the powercap zone created for it.
>>
>> For example, the following description:
>>
>>    static struct powercap_node nodes[] = {
>>            { .name = "package" },
>>            { .name = "cpu", .parent = &nodes[0] },
>>            { .name = "gpu", .parent = &nodes[0] },
>>    };
>>
>>    static struct powercap_hierarchy hierarchy = {
>>            .nodes = nodes,
>>            .nr_nodes = ARRAY_SIZE(nodes),
>>    };
>>
>> creates the following hierarchy:
>>
>>    package
>>    |-- cpu
>>    `-- gpu
> 
> I gather that this works, but TBH it doesn't look particularly nice,
> especially because of the way in which indices need to be used in it.
> 
> If a few extra bytes can be sacrificed for storing extra pointers,
> something like this can be done instead:
> 
> struct powercap_node {
>      const char *name;
>      struct powercap_node *parent_node;
>      struct powercap_zone *pcap_zone;
>      void *data;
>      unsigned int nr_subnodes;
>      struct powercap_node *subnodes[];
> };
> 
> struct powercap_node cpu_node = {
>      .name = "cpu",
> };
 >
> struct powercap_node gpu_node = {
>      .name = "gpu",
> };
> 
> struct powercap_node package_node = {
>      .name = "package",
>      .nr_subnodes = ARRAY_SIZE(package_node.subnodes),
>      .subnodes[] = { &cpu_node, &gpu_node };
> };


There is another aspect worth considering: the symmetry with the 
existing powercap zone API.

powercap_register_zone() expresses the hierarchy through a parent 
pointer rather than an explicit list of children. The proposed flat 
representation follows the same model, where each node references its 
parent. This is consistent with how powercap zones are registered: a 
zone is attached to an existing parent, without requiring the parent to 
know about its children.

Your suggestion reverses that relationship in the hierarchy description, 
requiring the creation helper to reconstruct the parent pointers during 
traversal. While this works, it introduces a different representation of 
the same hierarchy and makes the description less closely aligned with 
the underlying powercap API.

The parent-based approach also has the advantage that each node can be 
described independently of its siblings. Adding or removing a node only 
requires changing its own entry, without updating the parent's list of 
children or child count. This becomes particularly useful for drivers 
supporting multiple platforms with different topologies, where a single 
array per platform keeps the descriptions compact and easy to maintain.

Moreover, the parent pointer directly represents the relationship needed 
by the registration callback. The hierarchy helper only needs to resolve 
the parent's registered zone and pass it to the callback, without 
maintaining an explicit child list.

I agree that referencing parents through array indices is not 
particularly elegant and that the ordering constraint is a limitation of 
the current implementation. However, these are traversal and 
representation details that could be improved independently, without 
necessarily changing the parent-based model.

For these reasons, I think preserving the symmetry with the existing 
powercap API, along with the simplicity and scalability of platform 
descriptions, is worth considering.

[ ... ]
