Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9FA31326A
	for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774626268; cv=none; b=NpGY4IjAgLSCKrKw9e6Rd/ZEt1KpCO9Mhd+Eas8ivXjIdP/Y+mbUafqlwXNBh1f0SlfgyAzoLMdLY511IDwp6zQ6pr4JsMPqgtMPt0oYRvqLqcIjXk6b/iQ3oUYQC84MegFft1jUbU4a4i7F/NxDMn9AwtO/Qyv6OqPAkxbKQsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774626268; c=relaxed/simple;
	bh=P39BRN7Sh2CZmlMFqSC6/0b8PlNroAnbQYQ26b/k/Z8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SdIL7bQT3wJlmZqM1Bwp6Sg//txWWuVrkztxG6T8/lOlh+OXlrDOJ5+SbloCjcHVYwMwcJtzpJI9aSeAmG36vQhULOb7c1a1gteRXekw8hdxMg+szgNT663zkQ87FXGLBlql/3P6wN3s0jJJxb3jvRlZvi6Zwvduu29CVRVQpbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WX6TE85p; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AG82TW82; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WX6TE85p";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AG82TW82"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774626264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xo3+FMGXxrujtjtoyKZbBg5+fD0RN0d7dP/Sl3CYs+c=;
	b=WX6TE85pEi1S2fPiWG83yVIGo6V7p+Tbn0rBs3q9ezPufAdcX8wMb6STiAi3qiklgXUkVL
	JrdqskVUJC286RwOMav9e2RiQB2A9M4gYR53euHtEdCwwss3So84+D1gZXY00u7v2xN3wB
	eP8KSDFLa4sSjI+wUHtO2RueWRQY3S4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-XyPXeysvPQSpVdY7Y_vmEw-1; Fri, 27 Mar 2026 11:44:23 -0400
X-MC-Unique: XyPXeysvPQSpVdY7Y_vmEw-1
X-Mimecast-MFC-AGG-ID: XyPXeysvPQSpVdY7Y_vmEw_1774626262
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4853b5b0fafso31978055e9.3
        for <linux-pm@vger.kernel.org>; Fri, 27 Mar 2026 08:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774626261; x=1775231061; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xo3+FMGXxrujtjtoyKZbBg5+fD0RN0d7dP/Sl3CYs+c=;
        b=AG82TW82Rvol1Jn0MwxFQiKr5GZZfBgp1H7bLT2pOJowX6w1b+QozXf1prC0rby9g6
         0z7GZXovg0Yxr/z3og7b+WSvvLyBFoxFJppHegPuM7jdLxXpuN54zfH6PbE/Zjequ4Kn
         N4AnU+rHjKjcGrNobTba5wDYv+egGMdK2d2b4Ip+33uMqa2fWy6MqCXOHCtDgkZ/sdgB
         ZfM/a6iAU27MRwfwz/5wc+cDfJkncs1GY0eydbLywwXywePS9lT70zJJez7IAunTdHKE
         Y0yhU7Zx23AHuupM36Pjd7759TlYuWzGpyBHUxBnOE4f39nStWwlJuZ2x3EnSLAhGHFz
         MdsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774626261; x=1775231061;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xo3+FMGXxrujtjtoyKZbBg5+fD0RN0d7dP/Sl3CYs+c=;
        b=GXYoDW9O/BfoG7Zeqtuz79VCaAe7eaJ6yL4EJdIm0Eb7h+JnqNYYqdwQv63zALMO+k
         ZpbFE/UP75Noe3q6MjYjQW6GkRmlZnkKbaNibeV2+R4kf/SDF6ANaC+qR2bvTf0+pXrx
         0wWlQfRiT4lhfGkwa5gvWgw83oXvTuLoWJIth6E7cjAiy/rV829F3YLvS0SUS2cHL03H
         OSW9oR/3V4cjMt5Iojp4HPWeaQYHscHoYkgWZmEbscGz7sAUNAn60Jx/kGsBHEbt+weS
         qdWCCdwS0vD5jW5VsZPCw4oYAwlPqE+jFgxnIDVmJzY3ajiipefb8X8qYYreZl16IJGV
         JsZQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUD4/tStCswy+tTCqQERjiIfRhAki1LBXf66So+pmNsWisbibi4pj6d6mlshqUHBP9/KF1+erTow==@vger.kernel.org
X-Gm-Message-State: AOJu0YxCg0+1e1ymI+qEP0FgLCex/a/nKzKNlVQE1DKo6R8fyg4kSSKi
	jTRq9Ta8BhnFe8Ma5ywzJ8eChGLjFq2xP4V2q6i4rIut/yGSLW+8mO6GBy0Hej/8BCzsLnSRckY
	/IlXhzIBHHLAGhQfOPRWgoz9B3DpXbAlhlwG84n6g3/SWHVWqDrm10SuXgUFhRtznTvdZ
X-Gm-Gg: ATEYQzxfME4VYob0xatrWzYZxVCCKvsnjdGjjQuNQt1wv0vLVQFrjrhKgB+GpT9JKu2
	AJq7p4tAdai0YSjtJ4mP9TzPv6EdzR/IUWuet1Dqxx8i45OukU9QnSCa+XwH1FcaU/yC7o0aiLQ
	pfgJ6+gnqfxowSR54DqjH/YMTamxe1+pPIWOijI/bF5hD/oUofj3OufLG2P9P0SVsQ/Jb/g8Z6H
	2MimozwSLdXuL0DAc1Ab7SfxLL2Z34XtX7KjLsdCN5vvVI2a1P/9RbOYcegEIOWd1TKm7BPHzu5
	nMGm0iylfO4pCRmS/6wvZJZiTgN2M9O6V2s27vp7+bZioAlNSvNgxqqkb2O4kICtTVUL9aO50xw
	YUNCPiTsAm52TzNESnPw8CuvBv3IwJdYJeRqRtZAMhTEOGhSQ5bKHnTirlbrTUE3KZBOfvXKP9t
	dM4NoRhr0=
X-Received: by 2002:a05:600d:d:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-48727ecf3edmr41346995e9.26.1774626261513;
        Fri, 27 Mar 2026 08:44:21 -0700 (PDT)
X-Received: by 2002:a05:600d:d:b0:485:40a4:364 with SMTP id 5b1f17b1804b1-48727ecf3edmr41346615e9.26.1774626261105;
        Fri, 27 Mar 2026 08:44:21 -0700 (PDT)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-135-146.abo.bbox.fr. [213.44.135.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48722c9f0afsm178875865e9.10.2026.03.27.08.44.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 08:44:20 -0700 (PDT)
From: Valentin Schneider <vschneid@redhat.com>
To: Christian Loehle <christian.loehle@arm.com>, arighi@nvidia.com
Cc: peterz@infradead.org, vincent.guittot@linaro.org,
 dietmar.eggemann@arm.com, valentin.schneider@arm.com, mingo@redhat.com,
 rostedt@goodmis.org, segall@google.com, mgorman@suse.de,
 catalin.marinas@arm.com, will@kernel.org, sudeep.holla@arm.com,
 rafael@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 juri.lelli@redhat.com, kobak@nvidia.com, fabecassis@nvidia.com, Christian
 Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 3/3] arm64/sched: Enable CPPC-based asympacking
In-Reply-To: <20260325181314.3875909-4-christian.loehle@arm.com>
References: <20260325181314.3875909-1-christian.loehle@arm.com>
 <20260325181314.3875909-4-christian.loehle@arm.com>
Date: Fri, 27 Mar 2026 16:44:19 +0100
Message-ID: <xhsmhy0jdffak.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 25/03/26 18:13, Christian Loehle wrote:
> @@ -1753,7 +1760,7 @@ static inline int topology_arch_sched_asym_flags(void)
>  #ifdef CONFIG_SCHED_SMT
>  int cpu_smt_flags(void)
>  {
> -	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
> +	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC | arch_sched_asym_flags();
>  }
>  
>  const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
> @@ -1765,7 +1772,7 @@ const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cp
>  #ifdef CONFIG_SCHED_CLUSTER
>  int cpu_cluster_flags(void)
>  {
> -	return SD_CLUSTER | SD_SHARE_LLC;
> +	return SD_CLUSTER | SD_SHARE_LLC | arch_sched_asym_flags();
>  }
>  
>  const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
> @@ -1777,7 +1784,7 @@ const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cp
>  #ifdef CONFIG_SCHED_MC
>  int cpu_core_flags(void)
>  {
> -	return SD_SHARE_LLC;
> +	return SD_SHARE_LLC | arch_sched_asym_flags();
>  }
>

So while the binning problem applies to more than one architecture, I'm not
sure we want this to be generally applied to all topology levels. This is
/technically/ not a problem since even if a topology level has
SD_ASYM_PACKING, all CPUs at that level can have the same priority, but
in that case it's a bit wasteful.

I don't have any better ideas ATM to keep this arch-specific via
set_sched_topology(), like how x86 and powerpc handle asym packing.

