Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793996211;
	b=VFuVxxY3ijRw/lvw6bx+ciBxDIZL0tniGdFtR+RVvqZ8NmmqjBqcAm/bt3dFhUqXzh68
	 LZorER+6vNVdQkxWPijv1Aad9jYzBBNtkIGkyncmtXQQQu72WWcLtTGWTCDNKAXFO8LQo
	 EAjiym91evTOyJhkE15hgLAkpgDfxPM7yo+PzvH2h2FIu0+OWzRMM0BTAVVltsBN96rUS
	 aw4475Uo1ExSivVjvbpKIr30eJ90NSF95HZhwBKyYwbf66j7juWIX5OnDdmJJG3rDolnX
	 NcwgfvnRwPNB5IpxwxcUjMW1zSBcnO6OOz1cVWW3wMt5Ja8GW7CDyQ33AoYAtTlK4Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793996211;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=R/6NtbUQa5rkUAX4civmd/KFyWhiZkN3OJg5FyiXEDE=;
	b=udSpgGpgXrhG7otoYbiDHca4LpxhRtsJEawasVCUdmWQ4I8vT41VjRjA7NpM9NB6tDo6
	 SOR5ch5A6D6TsqSzqsvDF59wXHEKEjiXX31k4l4DysEacovU6cnLl/mpDLOKoR2ssqI20
	 vUgD8V7Lo99epRom29Kt0nAkVoPd0gqQSTI9t/6j4a0TaLeZ/vqlE6P6xAvopjsmwplaR
	 evykHCOzUe5q83resvqPe+VKWDqfcQZyoUw+79Bk8bthPTDG7N0lvrfU2yZYI7AXCVXNg
	 UQJR0eArC0rpqvTVo9hnlmTAXtSpNtgXfwmLZ1M3545Kx1Jn+dCkoijZngw3ztmBMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BS+ME5yG;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E3B606A329
	for <linux-pm@vger.kernel.org>; Fri,  6 Nov 2026 20:16:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11E3B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BS+ME5yG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793996210;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R/6NtbUQa5rkUAX4civmd/KFyWhiZkN3OJg5FyiXEDE=;
	b=BS+ME5yGPtHaeOQaSQ6S5H45e6bcykKAEip/Zar9t/yWKm3iaP+spX/NnuT9ltKHYKnhQn
	/Q8ZoFR/5Ebgj8Zfn/KHJ/Ss33HHrcCUnQjR5wr2C3cjJCtHgAxEM2DVDUjnzaxk33BCEr
	2F6lWs82AnoJJCGTosabiEVgKtPxf6M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-362-fFPtTvuUO9euKw-Ve2lkUw-1; Fri,
 06 Nov 2026 15:16:46 -0500
X-MC-Unique: fFPtTvuUO9euKw-Ve2lkUw-1
X-Mimecast-MFC-AGG-ID: fFPtTvuUO9euKw-Ve2lkUw_1793996205
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F3A8618007E7;
	Fri,  6 Nov 2026 20:16:44 +0000 (UTC)
Received: from dechen-thinkpadp1gen8.rht.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8790E3920B;
	Fri,  6 Nov 2026 20:16:43 +0000 (UTC)
From: Dennis Chen <dechen@redhat.com>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powercap: intel_rapl: Expose package CPUs in associated_cpus
Date: Fri,  6 Nov 2026 15:16:42 -0500
Message-ID: <20261106201642.231167-1-dechen@redhat.com>
In-Reply-To: <d10e4235-dd25-40e6-b682-bf7530ab931d@linux.intel.com>
References: <d10e4235-dd25-40e6-b682-bf7530ab931d@linux.intel.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Hi Kuppuswamy,

On 11/6/2026 11:41 AM, Kuppuswamy Sathyanarayanan wrote:
> Is there a user of associated_cpus? Neither perf nor turbostat reads it
> today. The "any CPU in the package" support that turbostat needed comes
> from commit 7537bae8b6eb ("powercap: intel_rapl: Remove incorrect CPU
> check in PMU context") and from is_rp_pmu_cpu(). Your patch keeps both.
> 
> If there is no consumer, I would prefer a plain revert of 525e0064f3d8.
> It fixes the issue with a smaller diff and does not add new sysfs ABI.

There is no userspace consumer. My idea was to keep the flexibility for 
userspace tools mentioned in the original commit by exposing the full
set in associated_cpus.

In that case, I will send out a v2 as a revert of 525e0064f3d8.

> This has been in since v7.0, so please add Cc: stable@vger.kernel.org.

Will do.

Thanks for the review.

Best,
Dennis Chen

