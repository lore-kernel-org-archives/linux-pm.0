Received: from mail-qv1-f100.google.com (mail-qv1-f100.google.com [209.85.219.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB963D6461
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 08:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534595; cv=none; b=BKvhcx/H30uhCdUk8ynnNvaolnL5GosjE2L392Rld964FSSlU4+PvRXe9bguOyn5r8upJmeplaidyu1OSHh40VmASeFrMpiGBrqVZNgtTJ1yqtgZaoIeno+MoE/ol7sot9y8BaDhX5a7y8ujEvRLHBcF43ahFKnpGOnRzaHNx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534595; c=relaxed/simple;
	bh=KdOxe03RJFJSOXfBnXYN+A603ShkIe/cWcsUKZ0d0NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9JbpOIJCRQcCy/MzefVeTtki1LunG5JoDIXzKpg/0WOXRzBKH0kv04s91x3bMcsLSrBxNs0/T+2B6jHXZiYcGGbk9xWlav+7Fbs/YsHbSv7AxEpJdlj9RXr8nd/sbHqj/0Lc4iaTxkdpeYrJtJJLg18ETleL4MHydIQn6HsnLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.219.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qv1-f100.google.com with SMTP id 6a1803df08f44-917ad52d7b6so62702096d6.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 01:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534592; x=1792139392;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cq8gQSDpD+5YFxqUsScItWyxOjZQR+1g4Dz/3bcOwAM=;
        b=fJCpQAjPN+ZOPiRNh34NbZZHGUxKfZdbkFnz7ob30WmTIrqboogngtHgcZbHK6Pgzx
         2QITNaop2/7/Dt2ho/gRvgnoBGJ0LGm01Ou3vibRHVS0JgufPmfJtvvDEc9DF6T/BFfN
         xPLcWmlaPHPqoZBlfawCZSWgFSllTuU4v98DpuQcPFMJesariPX/8zWKsivJbfSCvjdB
         AWeELB4SYi+4xRzqLFSjFBqO4fQ6CiD3xNfd+69vhWlf3nO2z3IvtPMQ9367C1oPi2f3
         oN/SFtvoKW20KItLhyBd6kQGOEMk68iHr2oKaaipUdyVxlOQU26H7tndyn1UveE95/7l
         jfaw==
X-Forwarded-Encrypted: i=1; AKwUvBzMPtDQdPWa+ZDq4+ATrx6cP6QEuWxlEYwIJppBGJ3BJxyKq+QA6goE4XsGQ+nuZBasdrS4AnX/GQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nrnCc+Ts6zJ6sg/9w99KIO2qFzpaAVrIDXSSjBPQigx4WP/S6z
	F+NNCh8xLP2EDaz5SJEBOk38sSWHU/2uGOhAtLtcQhaiQz3moa1c2lujeNAzVmifRQH59ums0/F
	iuqRtAgEBeoSCVM/8j2JsS5ZB89TUXTgrRPjB
X-Gm-Gg: AYBFou3uVjwTIAhRB4cNLgPecUtBJy2Q+SgCQsLBR77fUhF6UoAauesEMG01drZ/pHW
	13DIgpUiixuS5uowtCnUtHYJ+Hp254hB+rRJl23rd+vVkxK6YYAGh0odaAvxJp05OBFIHbY84R7
	hqEtAAVKLqTm4dP/ZMUNMAOtbhljl4MvtpA3O/94TkvWw0REu/KrQGcPU69OYi8x0GEU0jcKJYa
	TqEdlZhwz8hF+7xGv/NCalGzvLsy3GtBh7Cgcga+VQbpUATqlmQnLwwoLP4hu6tTSRcw8HTFFKE
	kiL4jtXnunGQSo1bWOQFJmb/UURKTzI41fKM0epktTm9XfQdhR3ceMK3PtbgT8zz1Z8Fq418KQE
	h87ZUefQA4hjrobwANB6+VE8ON73Rgj5lfDhJYM0v
X-Received: by 2002:a05:620a:471f:b0:93c:2c15:e510 with SMTP id af79cd13be357-93ebd2085ddmr144845685a.37.1791534592672;
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb9811a3csm31984285a.3.2026.10.09.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:29:52 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 72C7C12862CC; Fri, 09 Oct 2026 01:29:51 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:29:51 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 05/17] tpm: Add a kernel attestation key and signed audit
 digest retrieval
Message-ID: <asil_22hdNKBXH2p@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-6-matthewg@nvidia.com>
 <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5d1b69763362db8a681d00d3325dd673c4db08b.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 06:45:15PM +0200, James Bottomley wrote:

> Oof, there's a lot of duplication in here.  Basically you're creating a
> signing primary key (technically it's not an attestation key because
> they're supposed to be non-primary; this isn't a criticism because the
> only consumer is the machine owner who doesn't need to use privacy
> preserving AKs because they know all about the TPM in their own
> machine).  The primary generation routines that exist in tpm2-
> sessions.c:tpm2_create_primary() et al. already does most of this.  The
> only real current difference is that it creates an encryption key not a
> signing key, but that could have an additional bool argument
> (signing=true/encryption=false) rather than duplicating the entire
> routine set.

ACK, that's fair. I'll respin with that in mind.
