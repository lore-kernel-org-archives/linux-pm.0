Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF243A453E;
	Tue, 24 Mar 2026 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774344178; cv=pass; b=dH/P+E0z1ko/6nYwkWkcvtI+c5hjsIJIoFZars58k09NiBXU9Nb4aUm/7JaWjBDj8EVvoAzg0yRUxgjZReXQohjP+SY6JIl+uGemYvtfU8k/PRIegNuxKNRaKYaBPVWxYEpFrpsPtJeKGfKbx/YPMf8b2FzS5A+bzPLldpw4S9U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774344178; c=relaxed/simple;
	bh=XMjQMvSLAPYoMJKsHhFABYEKFjYgbM14/9BIR23QQks=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dG+VTgeMaqe0Sba/6U6QA9IkRu8TBfjrzDnyFztNcSEYMyL8ZCHZnkS9YFwkQ5GwOpGWnPniFiy69PGw3IIhNLPLpSqYd9+htqXcJMs72fXGdgQ7wgVLmsJkxm0NVRDaaLi9X2lr5kyeH/dq52US1W4J9gcgeTzf+Jfv5DDlK8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b=Egrr7Ox/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=matthew.leach@collabora.com header.b="Egrr7Ox/"
ARC-Seal: i=1; a=rsa-sha256; t=1774344149; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nB6PbigBV0gHvbArjUfAi3MEzXfB/AZ/v0khH16LpGAzyakrR8mBZKumTOfjx88EUH85YOOnHW0WPTQgJBmc7h2yTpYWrORdnJzXwsC/vgZxzXy/eU0YrLEhhWlWfHa8KygiN0wD+Nh9PpInApuiLlVHbfbpeP0n/LlFFlD8Cuo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774344149; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=OG3L5SWRw6ozXi3QG/O75rfThacLjQgD1c0C5pb08jc=; 
	b=GVKPsAqzGvK2vijrzT8t1x4St0EO8Zzzy5RHb3keDosF75cgUJY/DT92NjT9iw3iVVJkEk1Flmsih4AY7DHZzGwoAfJX6BI/kxlo/17b3t0+9D0JEBFuKcoMqjCNg6WNCSrOKwqieEPCrid8h16/R9bopn7Bg8pkUf/E0J1yJeU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=matthew.leach@collabora.com;
	dmarc=pass header.from=<matthew.leach@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774344149;
	s=zohomail; d=collabora.com; i=matthew.leach@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=OG3L5SWRw6ozXi3QG/O75rfThacLjQgD1c0C5pb08jc=;
	b=Egrr7Ox/R1++YAYYTQM7059M70OAdUM86QeU2Fzb7lTmEwvhcxfSTb2qy7+8NVqi
	BqFnYdsMg9+NXq3TRNz2q/Vv2RVpjiM1ExIrP00e5N5i5FEu6qKP2o9aASKlXlpGCsm
	uxg9Z+nSZfKVOLn1YDtQSqGJ9szLonpVtDFRx4wk=
Received: by mx.zohomail.com with SMTPS id 1774344146821527.6913733658973;
	Tue, 24 Mar 2026 02:22:26 -0700 (PDT)
From: Matthew Leach <matthew.leach@collabora.com>
To: YoungJun Park <youngjun.park@lge.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,  Pavel Machek
 <pavel@kernel.org>,  Len Brown <lenb@kernel.org>,  Mario Limonciello
 <mario.limonciello@amd.com>,  linux-pm@vger.kernel.org,
  linux-kernel@vger.kernel.org,  kernel@collabora.com
Subject: Re: [PATCH] PM: hibernate: call preallocate_image after freeze prepare
In-Reply-To: <acFa5+ihROC9/0Va@yjaykim-PowerEdge-T330> (YoungJun Park's
	message of "Tue, 24 Mar 2026 00:23:19 +0900")
References: <20260321-hibernation-fixes-v1-1-5fe9637b6ff9@collabora.com>
	<acFa5+ihROC9/0Va@yjaykim-PowerEdge-T330>
User-Agent: mu4e 1.12.15; emacs 30.2
Date: Tue, 24 Mar 2026 09:22:23 +0000
Message-ID: <87ikalshtc.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ZohoMailClient: External

YoungJun Park <youngjun.park@lge.com> writes:

> On Sat, Mar 21, 2026 at 08:51:31AM +0000, Matthew Leach wrote:
>
> Hi Matthew,

Hi Youngjun,

Thanks for the review.

>> +     /* Preallocate image memory before shutting down devices. */
>> +     error = hibernate_preallocate_memory();
>
> The shrink_shmem_memory() below is also intended to run after
> dpm_prepare(), and the motivation is the same. Since
> hibernate_preallocate_memory() already does shrinking internally,
> how about pulling out the shrink-related parts and consolidating
> them together?

Agreed. I'll remove shrink_shmem_memory() completely since
hibernate_preallocate_memory() will have swapped out as many pages as is
required to construct the image in system RAM. There's no point doing
another reclaim.

>> +     if (error)
>> +             goto Thaw;
>
> Don't we need to call dpm_complete(PMSG_RECOVER) in this error path?

Yes, good catch.

Regards,
-- 
Matt
