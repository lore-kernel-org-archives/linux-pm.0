Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DECB3451B5
	for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 21:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791667230; cv=none; b=gA/Bnw6CO2Db7Iti9gMVn876y3BZgjzG5Xa2QOCn1jsrXp9un6UsPiCyxMTSygkMZwd4ljUdXgTB8XTBmS355fZSalW3ZsUE4HC57e7RtkPahrfl8NNF9NlH6C8LmjMOnNnt70UY4IKOGOktZi2inmrsqYDQctNUN0Wq0tzqW6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791667230; c=relaxed/simple;
	bh=l2Rg6OHGxNhrquADY2PNe8wejzKKsSn3puAVABR9uw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fshiUCzqrDpJ8L0tuzIlsKMr9cWMTykWb7kRgm2arj21pG3WdwNHLh7Rx/RFPeC61wsKnGEpO4Tn072vXAq6sqhYwyAAG2++JZDtKmpc7m9MecqIGEldyMyCUwWSWPA8uUTnorHK6eP1/ZIwRs353QHC3JqjZVZSzwAgzenzS+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org; spf=pass smtp.mailfrom=cavan.codon.org.uk; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=srcf.ucam.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cavan.codon.org.uk
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-38759bcd877so430284a91.2
        for <linux-pm@vger.kernel.org>; Sat, 10 Oct 2026 14:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791667229; x=1792272029;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FpfqyCSTiDIx8bI640+p9clkC+s+ooT/bqQ5SHe1jVs=;
        b=onCoJcJpIV+e8kfnc5ArB37fLCF0nOGheV6hWWdj83NmFHiSXTIE1IVjRcBTYh1jRK
         quZ6DSB87NC4VP56KMAwyddyH3l8pncPI/drQJJcDLsPFToYyt5nKqII+kPgcAMcD45P
         pu5vPG54+B6z8Q6iiVMCjBEB7gNZv6qPYn6+grAGG5KeDGVU4HS3L4DiolTI+cvP0tC+
         pYpQkYDAnhTjGRTCiHlmj4zXsKzEzImxYSvMxLHI+zVUYCS+5YKZXNOwKdlAvKe68um/
         0KlybpEqHFdtqGAsDCiJlWEHPSdp0CwbbpMaeFHBppkBOOoXv5hDSxHS1UJHxZIqV2Mo
         50kw==
X-Forwarded-Encrypted: i=1; AKwUvBx2hPaiUX5QJdOSiGH13ziN5y3XiYYdsIhpsJXQVidfIbe1FNP0mlX9Na9KyqIk5hQJCoHLK1ubXQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYKOCeOkeEAuvTs1mrXh/bsA1HVxBtkQLFEj5WiXePEhp62EglXx
	EQWRcwfsT98op8BGaCZudpvaS8PY3eg9F4U8w+DEFUOaTBiUz8FXDbIM3E4g7qBJxpoSfQpfzJc
	eNKNj6ePM0RLLsy3dBwo3SJCLhqmrvUGly4jwPvW8iIXgwg8PhEK6
X-Gm-Gg: AYBFou1AY2y8oRv7hJQUX7BIURKeLdbSlLe+t1JNuV006RxXArvtNx72iS8uTildsym
	75mHsdS/cWd77qZKfiW8uHRpWg0OiEOM4qVCl3YkujnJu1LphzvbqfXAkVEAbkQNp2WA8HVlJFX
	lg62mJlfqXfkPoFuPOHhGoyNjAltN6fAnOq7Nf30ZTHV/84i19wrJQgoYRXejNLw+6agCQmePcG
	4hSN0P4pKxqhwaxWQGywClWGrE/HYNCdOUu5SB18OVWZ9KAiUxirxbNF+ba/YXnFU91r3QCdzge
	nDboJpT1LZbgPzOmZfBObpe4S+if2/8ErmpSxWUo3jSF6ddiKq9DSmdvYZfUnVZmm4TVmuwNMJB
	tH5M=
X-Received: by 2002:a17:90b:3d89:b0:3ab:c6d:2bf9 with SMTP id 98e67ed59e1d1-3ab3afdaaacmr5631535a91.57.1791667228755;
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Received: from cavan.codon.org.uk ([2607:f598:b99a:160:8a88:88ff:fe88:8788])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab3780a473sm3281598a91.4.2026.10.10.14.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
X-Relaying-Domain: codon.org.uk
Received: by cavan.codon.org.uk (Postfix, from userid 1000)
	id 0568D1287ADC; Sat, 10 Oct 2026 14:20:28 -0700 (PDT)
Date: Sat, 10 Oct 2026 14:20:28 -0700
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Matthew Garrett <matthewg@nvidia.com>, keyrings@vger.kernel.org,
	linux-integrity@vger.kernel.org, rafael@kernel.org,
	linux-pm@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH 13/17] tpm: Add verification of kernel signing key
 provenance
Message-ID: <asqsHMX1YUUDdy75@srcf.ucam.org>
References: <20261008132532.1155166-1-matthewg@nvidia.com>
 <20261008132532.1155166-14-matthewg@nvidia.com>
 <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeedde06c51910afe5231d9f359bb8767c01b5bd.camel@HansenPartnership.com>

On Sat, Oct 10, 2026 at 11:42:58AM +0200, James Bottomley wrote:

> This does strike me as very elaborate, especially the ephemeral key
> bit; would you countenance a simplification?  Since all you want is
> proof that the hibernate image hash matches the one the creating kernel
> made, you could simply create your kernel only NV index as a PCR and
> measure the hash directly to that.  Since user space is barred from
> writing, all you need is an audit of the measurement going into the NV
> register (indeed, it could be an ordinary NV index you simply write the
> hash value to), coupled with a read of PCR 5.  Then your audit log
> directly verifies the hibernate image hash and you don't have to bother
> with the ephemeral keys.

Just to be clear, "ephemeral keys" here refers to the ephemeral signing 
keys and not the generated AK, right? I /think/ that would work, but let 
me ponder that some more.
