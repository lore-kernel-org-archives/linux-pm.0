Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB543A80A
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 17:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282282; cv=pass; b=t6l7mHJuQo+pAFjT1rhIF8nS2FOuVHlPVUkbmJ5uIfrWnmg0rtLYaNH4Mn4CGWIHZ8dE0vV+fi7RI2tKwiK5Si0aV5jqvxxIUk6s0xyA7klERwXi0M1oeV45xK8rSLG3vleN1uMTpzr+5W6qedhGg5AhRT9GJadUfmR2pOn2ZLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282282; c=relaxed/simple;
	bh=d0cdEJI9/RswzkjbxjykcepGXr1VSGWZgZWnK4lfHUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qY87Tb+83byVBJxZhDRdj49sjfEVxnpljC0KoWteSSLaR2pF5lxvGYxUiSwqhlc6C/1eV6dvVUhUST3CyaT4KKevSiBmeELv1zgUzbpGl8Cfx3HVmcYM64YzNSYycmMieOlDUOCTjTYbudbYkfK/eFL39R1s8T1BhDVZPs0Xx/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwvv/oiq; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwvv/oiq"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4b383347fa6so855389b6e.0
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 10:04:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788282280; cv=none;
        d=google.com; s=arc-20260327;
        b=QKe7FoieaGMQNMbq8aMX35s9lLdmDjd7tLGLj+rNrevIdoVLNQVelURMNUg089BSnJ
         drp2FdzslhO8iOwRT/OQbiD8tK93PngsAWeabQCRkwuxTRu2p8RQnDzCVH0sBu+uN1FG
         DDJGo/8i4wBWCc0B0t9HsS+C0B8Zyf1j8K/TiXOfob86wD4ILjVkESjs6BT8hEb/1Ug8
         trbYMUGeavSe7Q8+MnC2Vr2vYY/fo0gMflahyU3OlHfESmnLHKEQR2vg3uyB6ZgPOCUe
         PS9rsX0XXUYz3DvV4H3oOU5MpgEadfVYDavMdoNpUYEcP3cKXzb0Fgty6iY5O34F+BZP
         7H+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        fh=lBNnKOb80Q1E0R0MR9J6kfTP0vYnTfRUZs7KiO7Wx0c=;
        b=UeFxzKUPb9nBxFWyTcruBBn5h/TYMvBEaxGOkGzZR2j8QC6KWYBV8Hotzy3tCgl9+x
         8U2AFpWFN0ez8NK8Kc2V10EUi0lDg4df2xmf6gTV3bXL0VI9iXvG5D2zzhArsTPjNZQR
         XATt5uEGpxfgiUS9TeIBFf/RwuLyQf0SmHLwZT7n1zc1xQgGxyLSZdl1uMZ3valmkh1A
         xywI7eEs9oU91cSo4qLX3y3q/wL6iYxIaMqv3xWGriqmBumCJNjDxOKwhxxPwQz1t2cP
         H44lOiwKR8Xk81NGASXdrAIfn3n+toaP82kQ/wmFAhNKPenDe0VsYprRi61IUlMcWMhg
         SGtA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788282280; x=1788887080; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        b=rwvv/oiqIjRz/IrkMYP+qzY/NjYS3kl/D9JfYWAkCE1dkt5ZlrdU9bRCP/vdOQWF9D
         sYbzaUuccnh9PYLKRF1JPp5qWKrWkmN6AccAZ83Q1z6nZJVoXp4lBov6GSiiuf8XkZX1
         n6kl6WFxNQDFd8/vB10l8y3pMk3UMeTdKSbhT2zZK9yOSxGsbfi061r7fZGEBe3cSsbr
         z/r/GyXokbhlcKXS7UdSQ7gdJiJr11b2mxF5jxW36gm7kpUIfB9NTcSlOLT+UKr3qXmS
         ROcwaMnOPRn/TuYEzk7GakKLLUuoCSCOnEoP+XKwre+gSoKbHekXT1kqLPgvEqo/QjvV
         +ToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788282280; x=1788887080;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=u0pyQF2KkMAZd1qn6FHRAPnrJYWT7vVvWkqtFaYE7kI=;
        b=BNk2dtq4Q/4cnUkxX1Y36ZcuOkYGEzhhq7qGkmsw6drqtccAkTiRH4f9xacsw76iyW
         eE+BXkR59nGQR69AA2wcRkX86vCJYHlvoG5gZI4AB5v1HkmYfab9CnzuETCca9fjZNAB
         V33f3CwkLOrSpu+XYpV7X7bvpHFPMHSXzDBjTdlQH9N357O39H0vQ6MzX0EQymFVbz7K
         PBPfulCjt1B8f1Slo/LUDkvZmyLMLw6h/Ev0OCdGBgzYMt8GPUYyjCpGvDdwPeNlDr04
         bMTq26MlAF+yRKH/c6Es9TcTAakm4g3pnpWU0akMOxmp1yqX7t2N8KLx15kea8TCUcvp
         5RdQ==
X-Gm-Message-State: AFuF++niXjENT0brRz3X3uKhHFnP2+e/8CThuUTguOQRWrR66dt/p+KX
	6suXixpTf6TviCY3OvCy3TS9p9Qvru77Impr+XfzmUs682rxkI5B3xNN9JayVMdBnUbsXLyNmfO
	X87PWxXcvCDkidWgp9+P1+hH8jqaqOdU=
X-Gm-Gg: AR+sD10ZZK8VNkzXEHuLn3C5pQb9L4SOeWE7z5RbC9a2Jigft1wPhhY15WGa4hZhCfJ
	PxxkG397lWZHIzCY01yqoMjoYpbQwYCKuBzpBQNXCid3ezEu0HhM6J3Bl2yV9k6xp5YfRexnH+Y
	HS4ONSIqKqDAMPnHBb+2ly+SjzavURtm+e29yEA5cGkSkQhXzDM9nQfaXH0tj0es2EXPYpT0prZ
	hI6+JMocKgz9Ma4+l8i3GxsZalfyzJW1dArZUD492NEnx73t43Oi7BKMxW3NG1sSqz3EgZWwrq8
	gH5uzMWpjc9jgn9aiJK9W7V1auJrRuChXcd5MfoIz+s19zEcXhZSYa2sUlaBlIA6TiJcJ8jIf0N
	hYlFEILdV/lN/MKq1wWZSajQvsFDBY6wsNw==
X-Received: by 2002:a05:6808:4f08:b0:4a3:cea7:4ab6 with SMTP id
 5614622812f47-4b5befda1b3mr4924582b6e.10.1788282279853; Tue, 01 Sep 2026
 10:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901145156.3177187-1-mauriziocasciano7@gmail.com> <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
In-Reply-To: <c9cf1a69-9136-4f64-b223-aa038520a0a9@kernel.org>
From: Maurizio Casciano <mauriziocasciano7@gmail.com>
Date: Tue, 1 Sep 2026 19:04:28 +0200
X-Gm-Features: AcwNN1UE6ze19kP9LilT_aCzQNaCwiaSO9Pp-1Fdq20zkQWrRN7Eq-cc3-82AVo
Message-ID: <CAO7O_xi-BYfGb428q1TO4ERp059-BOq78PZR5Ad-bs1ikVkmZQ@mail.gmail.com>
Subject: Re: [PATCH] power: supply: core: Honor supplied-from with CONFIG_OF=y
To: Hans de Goede <hansg@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Hans,

Thank you for the review.

I agree that firmware-node references should retain priority over the
legacy name-based mechanism. The "supplied-from" property should only be
used as a fallback when no "power-supplies" references are present,
including the case where the consumer has no firmware node.

For v2 I will preserve the existing order as follows:

1. honor an explicitly pre-populated supplied_from list;
2. resolve "power-supplies" firmware-node references when present;
3. fall back to the name-based "supplied-from" property only when no
   references were specified.

Errors while resolving specified references, including -EPROBE_DEFER,
will still be propagated rather than triggering the fallback.

I will wait for Sebastian's opinion before posting v2.

Regards,
Maurizio
