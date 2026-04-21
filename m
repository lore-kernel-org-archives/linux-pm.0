Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78AECA5A
	for <linux-pm@vger.kernel.org>; Tue, 21 Apr 2026 00:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776730181; cv=pass; b=B+13vLto0qU5plgC4tpgajPlyKd2bULDyrxmVqb1RGDbyys6DvaC29z6mwosZbkPgz79FoPJG7XwkmQPcHuPJNXqBpi2EcYl+9ctLcrjXZQ/NUARzfVMS+bbZWJq8DGTC0A2nEJj6eJu/MIgQPaBYJaXx2j7qYB+Q/ZEEThUFgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776730181; c=relaxed/simple;
	bh=a0HFul5D60bfTxE+vE6dpuZFjDlwWlqd1BaPQu6lkMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eM86AXv72UgYeSGZ+TrhOkZdH/JEZFBNX0WmFVUbXzPXqG8dKIemJcTdwfiPT1vErfhenqOEWMnL+lc/WFOvWuHjgvm701Q4e1oJI3p+6jY2dabegd8GTpcjR48qBJ6Y74nVttOBr0lhdxA2pfVhXHAntUfd1Nnxm9x8TWdIZlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsU3Rm1p; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsU3Rm1p"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82fbdd60b64so892774b3a.3
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 17:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776730180; cv=none;
        d=google.com; s=arc-20240605;
        b=MzRSxw5ESZS2zrcPfF/29wRfs5bc9WmiNoh4UbkI7ryYWRoHyHYkTfenV/pmgrztA5
         v3y/ppRwsVgHux4fIKd5KaIsUdOeS9yvGln5S4TDf+VJ9gBwvQEd/j3qrv4JeUOQ8PfV
         hcQdAmIf8NTjPvuvdMAeXWoQXxk1v4msRvCG16TOngaINtA4vto7ykaGdOMmz3YS4RMr
         YUVnM3UAuaXUa6BrxWU/CRsd42tMgl5p3ck9tH4+FABECJ1jmPpZ5AR+94l483qu7mMJ
         LrrEgMzUk9jTCimzB8v0xIVbYvrnNzxE7vCeYgTFN98Z38hE/Y/GMVL27PGzWhGYa60a
         VERQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=a0HFul5D60bfTxE+vE6dpuZFjDlwWlqd1BaPQu6lkMk=;
        fh=brVR3gm3wCi67VW+ukNXtCyAEg/5Qgx+CwVUAApFv8w=;
        b=gdiuvWsmEUW5+a0lCkgaYWIOA4otY534sNiiCpjJEHZquRW50/g1qG6Q6uai/dUTKf
         Eus/UP/HfSLlKgt4BWHcsS0ypky7QoY0Q8dU897dxBr3Zl5AJATiGuDE42AhSZdUTTiR
         wIctyMp+ar0ZaWVRzCMkiVUgd2z1vBoYRV+ukLifNBj5UtOkK2cWUIm+HyFtuAfH/Gch
         wbsCMW6ieW+olLKqP8rcLL+WM1GJt0ULpXNhSyF9VAkHb1PlMfVvUbtcbzN7L3lJehdF
         dRcsadyFQBrwa1wR+tJrz5QtvCH+8XdSAcG2MCrFDnYocQy6Odo/A8ha7pbUn4dXD4Tl
         W/lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776730180; x=1777334980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a0HFul5D60bfTxE+vE6dpuZFjDlwWlqd1BaPQu6lkMk=;
        b=GsU3Rm1pCcIwUFihaAuKo23+A+mwPb4qn7qfBO+UVniXYnh1IX7t18TdV9bnhf1Lc3
         PSO2I+ZejcUpkCcgyFm2otdHK1puBHQ1qhi7F9mttSSWu1WwfbazZZK4IieSUHMi1z7V
         fDDpWGaG8+ObTaoQF2eUQqKKB/DMlqEE2wtOulxD1oY6i9M44X/vqzTfL8quuLdN5xgT
         kXnvNXyGpZHs18t3ddCjLJfzW0sT0j7WJbYJwQqn2jkdRlUr+sEM9l/KI/qor4M0GFJG
         Vo+n5CEw3acwOVXB/sqZTqpPjPJTmjA3irhYpGsG7MypeUH+ebNIjxXCOoCp6n4Ouqxv
         HpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776730180; x=1777334980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a0HFul5D60bfTxE+vE6dpuZFjDlwWlqd1BaPQu6lkMk=;
        b=h+noP3E25geWz/InCIk4mwJU1EhGvmxAGP9bqJA/7Dz/510Qo/HEerEQF8lUDscEw7
         Uti3LfK1qbNXDmcS2nMPOGYusM+eXaCDYfBpDdXpzuxMXvn9/tkkuaqxypDxVODSxHVe
         qEb53X01z0n32XIznenNsn0eRY5Nlt80t6Lrqkm+f7Nix9KEAIJX8bQCxJNJqMTbGHj+
         7HmO5ctOI86xPRamAbONhd/DkW6jrS8Zj8N7F2aDs5l4v2Qn9gZLey/NrCE7PpIutQ5p
         URf9B7CX8eoJnHrMyVMsASgBMU/uWAXg7DjS4Z4N3X9r2o2VipFKg503JhbhxMZ9KGx0
         FmAg==
X-Forwarded-Encrypted: i=1; AFNElJ+PFbIz8jkSP2YmqpxbLHM7zqOpXewH6CNOUlfPKiWFoC2UybjahdBJePxUv0okpXpdNFuIExy53w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/EJu5pE6uo/vKlrk1wdyXwljwVMFMancKNj7WdPQIS/4wb3uY
	fKbQfKBvbSvWYqTgUIlm85y/yhUxnRqiGayzlP5sEH6KquTOhwrWUviB6eW8tV1qCnoqRAFWZsv
	gJLZbQkd4WoKY3mkxVSFajA2achfAfig=
X-Gm-Gg: AeBDieuYOjvrkLvluF7pz0wPBXIGR3k77sXLkrafgfdEl4tTjFa6Zw4UKNhjKZzL985
	In2lBC6BcYGVd4vuSnumNqk+T0LzK7E/QL5j8KtTw3tou1BiOb9SwgYuwHblMe9Wts/B+tX7co1
	nwmMtPeKJsMgqj/eQiQV8xVWVRqFa2PsWKr37tegoqvgCSrZ9159dmvMDx9rZCvW6sIGP8IjPIU
	9om6wyuJbMNMOtN+ltSzqe+PEzSGwM5nArA1V28IJNFTVGGJsWrNDebfGvn4fsqDmSeBURpw2rs
	2C3xxs5doe0xb/3+r2SbzKN6x+G8NNpJEBCtHQ3PaqF6ZtbQ
X-Received: by 2002:a05:6a00:3397:b0:82f:2243:e448 with SMTP id
 d2e1a72fcca58-82f8c83048fmr16769074b3a.3.1776730180072; Mon, 20 Apr 2026
 17:09:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8V+aPrvteJF926uBROpmnOHeeDGmu2racZNFNy-NmJmDg@mail.gmail.com>
In-Reply-To: <CAKSQd8V+aPrvteJF926uBROpmnOHeeDGmu2racZNFNy-NmJmDg@mail.gmail.com>
From: Serhii Pievniev <spevnev16@gmail.com>
Date: Mon, 20 Apr 2026 20:09:28 -0400
X-Gm-Features: AQROBzB-Tq6vi7gsP3B1_OMD1vrfiZolQe-X_4PGg6XVkLMEfvG2aftNsclb6vs
Message-ID: <CAM_YkW42rH7JR0uv11eY1zxrJKm7TGH7862JPc35s6Zcb0oUAA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18] tools/power/turbostat: Fix microcode patch
 level output for AMD/Hygon
To: ludloff@gmail.com
Cc: Sasha Levin <sashal@kernel.org>, Len Brown <len.brown@intel.com>, lenb@kernel.org, 
	patryk.wlazlyn@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Intel prescribes a sequence of WRMSR(0x8B,0) + CPUID(1) + RDMSR.
>
> This goes back to the original P6, where the upper half of the
> BBL_CR_D3 L2 cache test register was abused to report the microcode
> revision, and CPUID was abused to actually load the revision into said
> MSR. Afaik the WRMSR(0x8B,0) is still required today.

The latest Intel SDM [1] confirms that CPUID(1) is still required and
WRMSR(0x8B, 0) is recommended.

> turbostat has the prescribed CPUID(1) =E2=80=93 by chance, a few lines ea=
rlier
> =E2=80=93 but it lacks the prescribed WRMSR(0x8B,0).
>
> Also, note that the prescribed Intel sequence is neither required for
> AMD, nor actually works for AMD =E2=80=93 there the MSR is read-only.

I agree that WRMSR should be added, however it is a separate issue and
should be addressed in a separate patch.

[1] https://cdrdv2-public.intel.com/916746/335592-091-sdm-vol-4.pdf
