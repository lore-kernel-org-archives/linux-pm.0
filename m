Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83753E7166
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534790; cv=none; b=YsvNq2wOSJmEqmy0WbtTvI1GRMov91+dcwGXxq8q14gIaMtr1T81a3fxzpZV0Pv/1PkxQb7Sk/wlP3szLfF5FfQt1A7RuC0IJNUEfV9cFV1Y53gZXbrlpUk1dGKslAyAT7y+acu+FlvUspdK1JP8AFEyToCCHqpvuJMvyBS5P54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534790; c=relaxed/simple;
	bh=J4a7upmFwO+cU/sHwsmNf67cBdZkLVJd4Qid6QJFvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L06MIhVV0TSEDJZOxDgJVO9H2dE1CuGAPlPBQDHZKoXn7y5KD2ecnT1RhGkWaVRxNX6xzpRl9LSkAsRw6TGwvPYh/Vurj9usXL01r3HAR+O7OTlzRDzBl7s8s0nIP8R3MW2E0UxKOMy2ALn5VBWatp68wAxQykRLO3FsgRUiPSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e812e2b31bso9283235ad.3
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 01:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534788; x=1792139588;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5SJdflHLsTV8n6Eka/t1oY8KzfLbWWcjpATxg+lrvcw=;
        b=d5SgKAGhl9VQQAbzZMwUs8esO60+KeyeoOzfjxzW+xhY3dJvtgrUtJGT3QIu9KrYEq
         UWfyUt9OjuFxYOFPNQXOYJPRIgs/4kOW7dZ12iEBn7S3WxIpxn//qRNy2Bj8VTjUG9R9
         5tUq6OUq+wVq0ThwMZfkz91YRuq+TbfHzoN+aKLGSUYQl6P/dB6GHcXL3NBMiBwbUKEu
         +TJPUcvG+PRBA2pMAm+2Dpje5MBwJzxWXX+lpJ+9WBOhkPYxdOm9mpKy2nFnCl00yuHo
         uq34jI6Fj1Awcn+c+xcbRWk9JoJcEetJwBG8l5padjesAJvphRQ47JZn0f+hSpNZEHqn
         dF3Q==
X-Forwarded-Encrypted: i=1; AKwUvBz0ubJI/5Nka6kecNYQZ67zjMQpYkF1qN8ow3kdNccxpEUspGkmma8pR8MO26iWlgBCno+QOE7vLg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLyZ21RaUDre/LOY88qMJtkTNTKi77lgiUz/WvuGXn+m0zP7+Hb
	81TO+yX1xhPPaIJXnSc3B+ykiSOppeTnX9TNtSup8r6o9ouB7SaXKsTzEdYIweSicUyqf5bdfXX
	golw42r3Jd4q0H+m+fmFxD+QnYj1u32EenFmI
X-Gm-Gg: AYBFou1ewjI4EJeBnYKu+6AgTTGX9czBPeA/YlFSbx4jIUG5jXBKAgQjPym1dy7uIKX
	B1qu7qK7m0HmuhWaX0f5I2O9EehQE80jD6rUpKDRSuSimkHMdVPpkT9rK2uOkX/v1qrLaTYS6DZ
	WRwPzRspg/SrIer8R8ipWkLAMPiTdAiOZPmaBtWdOTZ4eY7cf0l6gclQU6jOosUdNLuvNCv6h1K
	dTDtZ/z12nbYsTSs9wyu7AzClACqv35p68VOcMlNM2OEqs/z4sbcPPpIxx5yw9dhBKv9+FeeBF0
	k6DPe8SSDOuIla+ami1NZlrgThkjnmZnfje7cjatn91lfrxmf6sAZJirG5XUzlhZXWsj++gwY7b
	DKfuVQhc0WsEMEAj3buC2Oiar6zYs3r6BipvEBdLH
X-Received: by 2002:a17:903:32cd:b0:2e2:d7d6:6563 with SMTP id d9443c01a7336-2e842ce162fmr8538245ad.43.1791534787870;
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Received: from cavan.codon.org.uk (207-53-253-74.PUBLIC.monkeybrains.net. [207.53.253.74])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e841f88d23sm606575ad.22.2026.10.09.01.33.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 2332C12862DD; Fri, 09 Oct 2026 01:33:07 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:33:07 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 01/17] tpm: Define a kernel-owned TPM NV index that can't
 be modified by userland
Message-ID: <asimw1D5J0ZqM4i3@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-2-matthewg@nvidia.com>
 <asfDZiuFKCuuRysC@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfDZiuFKCuuRysC@kernel.org>

On Thu, Oct 08, 2026 at 07:23:02PM +0300, Jarkko Sakkinen wrote:

> > +static bool tpm2_dev_cmd_is_blocked(const u8 *buf, size_t bufsiz)
> 
> This function could have less generic name.
> 
> tpm2_dev_is_kernel_nv_change?
> 
> I'm not a huge fan of this name either but it does say quite clearly
> what the function does at least. Just a suggestion.

I left it that way on the assumption that it might get extended at some 
point - maybe that's not a big concern.
