Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C673A9017
	for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 20:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782504851; cv=none; b=W9M4WaAJcpBE06UEt9guhVrAtAXfvAxM7TeLZf8NWcuog0APSoHqk7Yfe+M+eTHjTnNeqhl/Vk26zdF7jE+e/L8kj3xFxA1C3VfW1WY49KEdL6ljMfIiKD+dPKp/6BjTLP2tkNqSJPmM6XMZbs3/+8DVEH3GoG3wAffyb/XH07Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782504851; c=relaxed/simple;
	bh=ub1rJsYjCUfWZbpz+fdEyhZesTUIsLwSS17waNUOJFA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dW+QfoG9v4KwmRFNoYV6+YgNFgGcmknt/kr4trw3BKm71CmRh/P+tIKZjDcu2fxStn3B24na7G9mMIq+0JhrItevhJNXOUZLUhYuuXcKNCOIPEiAJllV12sXtg15ljCAA8iXr6FEA8b960gP1vfIOvdyK93VDmVBzt3rA+SIxcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NsCHqiiZ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NsCHqiiZ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8423f236418so676777b3a.1
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 13:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1782504849; x=1783109649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2F4Y1yCJTmWoAxT+0o/PcRIpQzTLR5O2f+f5Ok21rXY=;
        b=NsCHqiiZAnnLnYwNZ3iA/0OKDzQwBkuRqvPHHRowlyRuiECvqNm2/sPw2CRqWlLzud
         rUgHn1qYkkuieRGrMdsB0Ods/f8zNYxhjvoRDX+/HAQi+4qTcPuwqN5kgHz3GBKju0NO
         Kux2O6/FGJxUeMiV90ZmT1eMRc3+JAuL2u7Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782504849; x=1783109649;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F4Y1yCJTmWoAxT+0o/PcRIpQzTLR5O2f+f5Ok21rXY=;
        b=f4S6warqjYM5YIPSUNGdQYOIlAH4P6wH2zfme7Hpc+FuEkDA7+XpMIkr9IOpdv4A50
         ZWaDuwzT6fKPBe3gbdvoHeybPfNjR8nyFiw50O10TDa/w0wdhwOy6XW5vb6ha/J8J0l0
         lqq8a+hXUWadHQGDlnTzPGf5BLDfZkZk8qrQWYjOOr2PEKFDiiiAhhZFfzIH398BF8OB
         JPSec40prB+e9NIgsiQGMKIIAexEvjVwAZVJG037CxjapsetQCdBYbKxLtPzFFcpQatp
         MZRobbvE4T1Fep2yMasP8q9oAHJJBnNaCmCBoncYByODIYZzOqUzejz/kbmaOpbsBC7n
         50Ag==
X-Forwarded-Encrypted: i=1; AFNElJ8skKK35Nv+2VEp5BQ0NPRwviFkT4g+vc0bF5pqPKOPj4bWXbwXWN+/0+YD8rqZyw2AeWmfJTrhhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1if5CM9Ez1MnhFKyaSqWOkmtmsT+JDLsy0RoNUMsTEWj1/X1
	5wvgWY0VSkL0/Iy6C8DfVyqTPm4nMdvptRS1Bz0SiyLapu8g0e3cdbTKfhQ/4RuhQDj6C/abazx
	VagkU
X-Gm-Gg: AfdE7ckXVeD8V0txmJfLhvPeXGbIQQINyCqdeqbikTfzT6ViO9hhBfE77fDi+dHMaE8
	Sohn8syVJHw8gEowUAfUOpZKrnwBthGO7n+LgfoutwJardPKEa7DaHbV82ZpEGCD6A/XtmH1ETp
	xavOzRk+VrHUHQ+14fE2bS9UALmMAUPYLnjHKMBxeHiN4twbGWFDuy36ObwMjZoG/CIfZ7nbsmi
	PLscWzsbEQANpWNELH5miKmCKbfVwvm64B/z3R2SpcKe6iWRDJ01xSsArYelIWWtgtPySFWtSir
	NNZXhgtfl2alrxV3DBRjxHLv51GwNAeLdu/k1VZ68t0qxyEv4jkPX9Zg+3KG2RYY2NCzDfsNIMr
	3d8OwD1kobYGwBBL39nUOdiZvCIkiScyBuOQ2ahcajLzpNoAICu7DNBkN+VtZydK4QNIXditfle
	6/DrWCRwHkvp2DBd3QqDKk5Tqh8UsL/PyE7r4xY0X45ugE4uKmXYGgRPS+PJ6FwwVbEA==
X-Received: by 2002:a05:6a00:1c90:b0:845:390f:f4cd with SMTP id d2e1a72fcca58-845b3bc68aemr8851425b3a.30.1782504849406;
        Fri, 26 Jun 2026 13:14:09 -0700 (PDT)
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com. [209.85.210.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-845a3fec0f7sm7211521b3a.22.2026.06.26.13.14.07
        for <linux-pm@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 13:14:08 -0700 (PDT)
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-845c92bc464so736284b3a.2
        for <linux-pm@vger.kernel.org>; Fri, 26 Jun 2026 13:14:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9FmK4RPl84okm9lvfW0/LlgMU+yLfnhUJmyasKAsl+UMBQ+5F+oIHEt4vsqT7040z0ARHmyn+o6Q==@vger.kernel.org
X-Received: by 2002:a05:6a00:1bc6:b0:842:5c90:736b with SMTP id
 d2e1a72fcca58-845b3b8e325mr8466942b3a.29.1782504847416; Fri, 26 Jun 2026
 13:14:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0juZ6YJVALVEi1s_O0qgcr_o880TJbRHXWsd-Drb-sUXQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 26 Jun 2026 13:13:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
X-Gm-Features: AVVi8CfFw2XgHmHaPns9ZxnG8dwQnTbmgexO32t8DbAm-v2T5HHx0LUFCS4Hwrg
Message-ID: <CAHk-=wjS6CuKne+v6t3J=ppXTJj7dwRE0FiuXjT_O_wBiW0yVw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI support fixes and cleanups for 7.2-rc1
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jun 2026 at 10:54, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Unbreak ACPICA tools builds after switching over to using
>    strscpy_pad() that is kernel-specific (Rafael Wysocki)

Ugh, honestly, this is disgusting.

I've pulled this, but this file is not in some kind of "tools"
directory, so the fact that it then also gets compiled in user space
should be treated as a user space problem.

I had to really scratch my head how it's even build by user space at
all, and it's due to absolutely disgusting code in

    tools/power/acpi/tools/acpidump/Makefile

that uses a vpath thing to find that C file for that tool build.

That's just crazy.

But the fix is *still* not to add horrendous "let's use strncpy() when
not built for the kernel" in code that looks and acts like kernel
code. None of the other acpica code does that.

How about just adding a trivial strncpy_pad() to
<acpi/platform/acenv.h> or something. A place that already knows about
the whole "I'm building the app side" now.

Hmm?

             Linus
