Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BF83DD522
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534694; cv=none; b=IwQdOrPM080LFUmjJp2QmEbgvzwmtT7c2gaBREJmHJy5MKvgtT4YJ9fhbHp51cKkJN6adBD4VUeSWN6QlrLwFnzRfzMT9Jf+uWnzBodoeLckB57EnaK0Y0360xVba0xDZjbMoAtjcf0QWz+GL6vQqYH9m2xRcH4L/eK5MzHh1Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534694; c=relaxed/simple;
	bh=WATkgCQ/kmtG5HulqnoTUl0JCJKYR2K92PtDB5Opiv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3WU1HnJz/MBc/It1a2k2cFAiIf3mW20aLpMv/brF8p/gPc46uxNsbgZxFk1ZMO8kPS8Gx97/NzZ4RNo/fTecp1gVNgvZT2Lq+VpA2bmRRa0ATdPuY44ZYQQ4hW8sJuz85yi2bdlVVMhGu/GweK7hS+erjc7FeSr6oD3NLScjTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-93e706a6ba9so471558385a.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 01:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534692; x=1792139492;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+Ti0O2O4lnX/hVbcn12QwKSuhI8bbGy+WYpeuSvKe4=;
        b=SpHj615UEsGukjx2G6yLydV8SIeuTEKpIsOwULFSNVQQw52Ydps+BIInqDnqRNxBi/
         8nMi2Vt4ckcE4YgOsvqgoH2qa0XgiatG+AdjiEcQ3EvCcyJmLLzcQ4LmB0l8gkIhWtbj
         VkQxbi9HpaUgs33pVJG2T1VnBc9NzuDeiDep7S0zEfHAEmw4HqHlHcBU0mDcwoMWSAMR
         4FFL89TLIVKp5HCxk9oAO3+lk1atIHwjrLSqixpfpGaVi0kmGYnT6NS14FL0WrVo3jRp
         ZJfskJdrUkvnZ0wxIEc0R9GcJ6WwJnNzsjwsrSlZ35OJZy0f14BwQDs0Yr78uEenWEdh
         7gnw==
X-Forwarded-Encrypted: i=1; AKwUvBz+/kcHBFB/836TYnKcNUwyvnKsCn9ykS5SxItYcLrAHirNRA8Xw+Y2wQ/lTBkMxHw8dIr3lIQNpA==@vger.kernel.org
X-Gm-Message-State: AFuF++kssA6jhlkZzZtOx6nWP7NidEY2sBU954KwhOkhUnvkf59IncIS
	RydFSoM6o/UpsRstqjtYc2owCHzU3vGesx4b3XJxId5IvSi64wehcYl9FhjAbjShcyAvZZAg/kv
	VVO6SelsR0kOPCnQtIjBvJ+sbstfFlHWwgeQiAm8vYnhOU6n4x+X6
X-Gm-Gg: AYBFou0cSwWKI7+GB28B45X7YhucMxjZ6lJz4HAIvn7cbFoHsINP0p5xxrqu5mZqL/4
	K04rmwvRXC6aLeymMTpclc7k8SOCAySAJO5LTY+jkUFM27eY1thYLW2E5CPSzm0PS7kfNog21w1
	JNCadW8I0zCWlat28UbxiH60lc/1RzccOiWWBseuJnUjaLHN/vIvpiMVYoa/nWvIBuUD7KbTKWi
	jrjtE4lwmUNSgVCvir4r/KoCRtAUzm7S6z4dF19GuzeakQ1l/16uSDQMB8YKrv0tfaLSHLgpsZT
	a6A5yCVRCBzPNkShd3mxHxefYjkRT3E8wr8+0atJLeyzfISuDTHlAvovmQJoN/5UFcLBvMQqBk6
	WaO0=
X-Received: by 2002:a05:620a:4013:b0:937:27fb:96f8 with SMTP id af79cd13be357-93ebd25c85bmr177526785a.41.1791534692184;
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id af79cd13be357-93eb986adf7sm29407285a.9.2026.10.09.01.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:31:32 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id D784A12862D5; Fri, 09 Oct 2026 01:31:30 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:31:30 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 11/17] tpm: Add kernel signing key creation with audited
 provenance
Message-ID: <asimYsZxxGvPAFiZ@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-12-matthewg@nvidia.com>
 <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd131221bca29b5f8ba348adadf1e3930a5b57fe.camel@HansenPartnership.com>

On Thu, Oct 08, 2026 at 07:00:28PM +0200, James Bottomley wrote:
> On Thu, 2026-10-08 at 06:20 -0700, Matthew Garrett wrote:
> > Add tpm2_kernel_key_create(), which creates an ECDSA P-256 signing
> > key for the kernel along with evidence that the kernel, rather than
> > userspace, created it. The key is created with TPM2_CreateLoaded
>  
> I don't think you want to do this.  TPM2_CreateLoaded was added in spec
> version 1.38.  A lot of current TPMs on the market today have spec
> versions lower than this and would reject the command (The spec version
> of the Nuvoton in my Dell XPS-13 is 1.16). Since it's really just a
> shorthand for TPM2_Create followed by TPM2_Load, you can simply do that
> instead, which would save us from a load of complaints about this not
> working.

This is what I get for working to the spec instead of reality. Thanks, 
I'll split that up.
