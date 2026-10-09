Received: from mail-qt1-f228.google.com (mail-qt1-f228.google.com [209.85.160.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4FD3DD522
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791534664; cv=none; b=QvkpvgHTP9AWCkz5haocWyaRZf63mbSoGZms8yy/ZnkomQduml0mJ8aDakkPp+KR0VxQm7zaT71qO0h7JbX4Q5wL1bw11NF7tHNHCJRQ85fCqr4a/aEltukmY14bIiUKs28xd9bqT+BRlKAWqJk7HIRmcI58TRH/Ej6rXI0FYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791534664; c=relaxed/simple;
	bh=DIFxmRnwufPE43JRiH6E4AfHlHo9hVO52fExH+S+rK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bo3q9uVXfZRWxVWQyw8Xvw+5F79wmoh3WXpnCz65nVU0a/RzxD6PAjKOfuyxlLciLo0AUIg9jwWppJH1ieQczVvpSUDzMuRUFk8cDC518V1rDpTYHU7CzL3cFYtRprL75gbi1AiXTE4LGys3XbdeNmdzLbcswCcuKOuJZ9zdnRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.160.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-qt1-f228.google.com with SMTP id d75a77b69052e-53504882980so55343261cf.2
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791534662; x=1792139462;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bIf3Kb4v9Q13a/WyDvBX8cPlNPGYJMWyM06g7YQDej8=;
        b=fX0dqkvFfCc1FWRw96hZLkW6SDPumjM4ajX7VB3zecc0cqALMXKkmTmKP+H7GpAPUO
         2fGrCqnZBoLL1sPxieO1hLTJWQm9IKLCzC41ZyPVI27gM0ZC7qkF7JNsB+nv+/3DKt5N
         8iwSMSTmnRM2Wpx1AW5wFELGuhVrHm4JeTKzbd7sx2W1y1K8g42/gjbz0uo7QbV5nJ3F
         zsHa6kVel8b5ooxDohSr42IUYmB6rAAaVbabKGrXM2Rq+5jcO/3jNdX6rZR6EgJRE4us
         ng+ay6li7D02V5nOxwJh5PBfTsDAACUOnKaav7sVJaxlqHlzIL5Q8TOOLUts+ZufLVIp
         Q6Gg==
X-Forwarded-Encrypted: i=1; AKwUvBwVlhETy2dqitpGuFhBWhfeUDv7YJHm6/rSCLmV8m+a5LRqMi38kI5cgYDYyhk1E0wfPGzHriOvog==@vger.kernel.org
X-Gm-Message-State: AFuF++nIB7VUcL5WfIv9T2KgGDipG9Q1ogHEJWtKLUPSVMMMfga7uA+1
	l8QED+fqmXuZdsTlqNW9y2LP5ibrU0IlCWXx5wL+1IFWo7UccrQeqXEcCxiS3dgY0/NOL6xIBll
	HcHqoQDhw8UE5gXYXH8JnKZD47s3dHSyy03+et9cCouJ2CdnYslBd
X-Gm-Gg: AYBFou1ViFIBTWzP17lsjzTQyq6eUugJxnOoKN0dJTrjumjo93+tVj7FfpnrTgtEmth
	m9zo1chxvaSO7sP8YfNWN8UyfsDj+5AAicykSjcnPbsFNcT3pz7eez+JWN/vrFVdy7JFk39tKxu
	pPl7diqP+bcM+572G4q5pLDwEbnaaHpDuK/X9BUe4SSUnhIgWrC3J65kFRdHbhX3PF6CMB6eTSy
	+nE9WpAO7Rj2sF7Gf2/eZIcUJWVfGfanxMwRgKloy1xwhHBzI1kyH+qSPpvkryE0RzQ0k2RLAFV
	3VdPYOGM+WWvDNcwkbcDHQ86M7BK0UhpKUpAMgelQ1esb8nW0cSke6UG/EHmTo6bByS0T8VbGMw
	7W8E=
X-Received: by 2002:ac8:5a92:0:b0:533:340e:7483 with SMTP id d75a77b69052e-5359f488e55mr18513871cf.5.1791534662295;
        Fri, 09 Oct 2026 01:31:02 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-5359b7dcf1dsm79991cf.37.2026.10.09.01.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 01:31:02 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 1E60A12862D5; Fri, 09 Oct 2026 01:31:01 -0700 (PDT)
Date: Fri, 9 Oct 2026 01:31:01 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	James.Bottomley@hansenpartnership.com,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 17/17] PM: hibernate: Allow hibernation under lockdown
 with signed images
Message-ID: <asimRSqckPDUl0A8@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-18-matthewg@nvidia.com>
 <asfKpInP6j8DYA4-@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asfKpInP6j8DYA4-@kernel.org>

On Thu, Oct 08, 2026 at 07:53:56PM +0300, Jarkko Sakkinen wrote:

> I skimmed the rest of the patches but gave up for now given time and
> bandwidth, and also having quite loose grip to the changes until I
> run them (it's just complex patch set enough).
> 
> What kind of test environment you have in high-level, or could you
> give some rough guidelines for a test environment?
> 
> I'm thinking of setting up something with Buildroot, QEMU and swtpm
> perhaps.

Testing has been qemu + swtpm, with some scripts to build a toy 
initramfs to automatically do the testing. What would be the best way to 
share those with you?
