Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872283;
	b=jHxW+JF2eSvP7P4q73IYg/AEikuAf5TR58BmCFGN4R3vRpoaLvrrArrHfVfwppEAy7mK
	 jiTdqiScwVkbVJHAaGys/K27lXZr/Ua4kjxzDcibQUvqq4y4DeHakmlVBfAB4d4gI2Cb6
	 hjHJZzXLe0SfxQpSpv7sFE4tBKd6LBpfoK1j5sV5jYQe+CpWK3GTz8yXrfMmDD99A7uB5
	 e8r7Rxm96O8P8Scab6fVfYq0Pcci6hNyEEpvYNeIXo7eadv7/eGiBTlCkZ6fQO6gnbntX
	 sPWe4PXVg8pOFDojsrxRvhB+viULujuDpiEmyWNp18bd0AL/bPcFBR5VXNrjM50GguQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872283;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=x/eLa2byWWaXdmjGjkEBy/P0e0ItD5cnMhY22cUlXh8=;
	b=jE2z9S9q9T2GUekAe7qsvQer+zy7WQTeDNUzb66CyJCH+NAoUy0uIZp9iIlB2Wpu7v/s
	 Rv7x2CwlGOeALpYODCka0ivGr7Y33VARK9pVLLi359o8rd667z387VPUpPR/eL/lZK3nA
	 NAiyrOheV4dtegIkq1cl9nofNOlPtnGFqCy6I0mWzzEP9QnDGa5bDj1/nB6Mq7Bjsy9UE
	 POFNV06SHHIX1tmAGZfv6nF4VTBjClOHc1y9Vy9nUWZorGL1toW3Glw9/3ZDFcQzWgkAH
	 iPcdLmSovH2vmTiDpXH2l09eqCp83lWG9SLshZjUswlJoxy0Z65kKoelkqrljju7ivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PsutBHs1;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29289606A32C
	for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2026 09:51:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 29289606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PsutBHs1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793872282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x/eLa2byWWaXdmjGjkEBy/P0e0ItD5cnMhY22cUlXh8=;
	b=PsutBHs17KJQc/8Vnb5WWB8SuDAOI5Z/OIhXEHCAXZPPvvvJuFMkLVFTMWC/WD0sj0MGhD
	9vG1otnBEh2LFjsykMq71TrZkuZpE17/KaOzgTA7iiKwOndl5UOCvL+yVLHV3cMEpaTZ2l
	z0cYC3esIwWxWDToyj2QrFmxoyaEuE4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-hB79DzcyOt-MMEX_mGglcg-1; Thu,
 05 Nov 2026 04:51:18 -0500
X-MC-Unique: hB79DzcyOt-MMEX_mGglcg-1
X-Mimecast-MFC-AGG-ID: hB79DzcyOt-MMEX_mGglcg_1793872276
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5EEDC18004AD;
	Thu,  5 Nov 2026 09:51:15 +0000 (UTC)
Received: from jbenc-thinkpadp1gen4i.rmtcz.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 258AF1800347;
	Thu,  5 Nov 2026 09:51:08 +0000 (UTC)
Date: Thu, 5 Nov 2026 10:51:06 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Sumit Gupta <sumitg@nvidia.com>
Cc: <rafael@kernel.org>, <viresh.kumar@linaro.org>,
 <pierre.gondois@arm.com>, <ionela.voinescu@arm.com>,
 <zhenglifeng1@huawei.com>, <zhanjie9@hisilicon.com>, <corbet@lwn.net>,
 <skhan@linuxfoundation.org>, <rdunlap@infradead.org>,
 <mario.limonciello@amd.com>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
 <jonathanh@nvidia.com>, <vsethi@nvidia.com>, <ksitaraman@nvidia.com>,
 <sanjayc@nvidia.com>, <mochs@nvidia.com>, <bbasu@nvidia.com>
Subject: Re: [PATCH v5 1/2] cpufreq: CPPC: Set CPPC Enable register in
 cpu_init
Message-ID: <20261105105106.23238599@jbenc-thinkpadp1gen4i.rmtcz.csb>
In-Reply-To: <20260623080652.3353386-2-sumitg@nvidia.com>
References: <20260623080652.3353386-1-sumitg@nvidia.com>
	<20260623080652.3353386-2-sumitg@nvidia.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On Tue, 23 Jun 2026 13:36:51 +0530, Sumit Gupta wrote:
> As per ACPI 6.x s8.4.6.1.4 (CPPC Enable register):
>   "If supported by the platform, OSPM writes a one to this register
>    to enable CPPC on this processor. If not implemented, OSPM assumes
>    the platform always has CPPC enabled."
> 
> Call cppc_set_enable() at the start of cppc_cpufreq_cpu_init() so
> this is done for both OS-driven and autonomous CPPC control modes.
> Errors are logged but non-fatal as the register is optional.

Sumit, given this is a bug fix to the CPPC driver (e.g. NVIDIA GB10
doesn't enable CPPC without writing the register, keeping the CPUs
always at the lowest freq) and is largely unrelated to the autonomous
mode feature, could you please resubmit this as a standalone patch?

Thanks!

 Jiri

> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index f6cea0c54dd9..f7a47576717a 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -655,6 +655,14 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>  	caps = &cpu_data->perf_caps;
>  	policy->driver_data = cpu_data;
>  
> +	/*
> +	 * Enable CPPC for both OS-driven and autonomous modes.
> +	 * The Enable register is optional - some platforms may not support it
> +	 */
> +	ret = cppc_set_enable(cpu, true);
> +	if (ret && ret != -EOPNOTSUPP)
> +		pr_warn("Failed to enable CPPC for CPU%d (%d)\n", cpu, ret);
> +
>  	/*
>  	 * Set min to lowest nonlinear perf to avoid any efficiency penalty (see
>  	 * Section 8.4.7.1.1.5 of ACPI 6.1 spec)

