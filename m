Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990E2745E
	for <linux-pm@vger.kernel.org>; Fri, 24 Apr 2026 05:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777008771; cv=pass; b=GzVAziF81eKKBujhtPVE0NuaJ7PP+j05DFmddGMmG7jsxI035B73Jz+mY0G3gmG+VxNWvXJCwgdrEAfPd3dtvgHf+e8L5TUBcxgxqCoXkOTY86+x5+jXi0g+4j4fFiXIIUWeI8bKa78AzgoCP4esYkx0977mcaC0sDDLeRqH+4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777008771; c=relaxed/simple;
	bh=WeR454MIF6XD7WivrKik5WjQw4uaLEFSXdm3lgCCH+M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=JUGsnopYwG/pVDM5wb9USy3MUE9K6cf24Dc5B9cUMMlm539wq3uJ3DXiTaCtWo3LKlpFivZjSG9gDxiajSa+j/2zbMxAGun6hf3h8BPkcqqk0CXpW5NLOdnOS7pu6K0rGUydlmQNnLJGysYYEepT4ymlpdZZSAyvF/hkMb69H18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwmnBEVf; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwmnBEVf"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7982c3b7da9so74355857b3.1
        for <linux-pm@vger.kernel.org>; Thu, 23 Apr 2026 22:32:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777008769; cv=none;
        d=google.com; s=arc-20240605;
        b=hgszsYUUUFw567QP7hmSvFmAw0tDY/K4R9Gzu4mB6Py+yahr2GdyCAjN08OVim/weu
         kItfu0xGCU55J9bLga0hVDHA1A0MnVsoiHcku3/Ah40PNv9W+iXQr72I2OYzbcV4w42R
         UMzNFkGmXswpfvWueOpQmO2QW0KfcQHPS//xDlP/D1drdWJqktIYwK4gtoOuzIgENpTa
         RVIJP6nD8YWnzQl+U3pcZ4lXLM1EujtrAXhK+YFgLMqIvLJf+RT2EQezmGDnOiE2p6nI
         fLC0qcPXkIyN+hDiXwH6SDmBTYrCKfTwjEtTpGZZ3KdSIHA5P12O0IFzumYKXcFwGWYC
         cwiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        fh=/1fjWQDN5+rfxzHdS2uG78g/T3G5BbeOVkZJi97ETJ0=;
        b=FF+dfQzoT6GiTPotQnGuewcKtnzm5SfwC4PAZG0gghqdY8cUHg7fTY7QvEEYXn4OTx
         9MEVp6vXnGnkRyQngK9sQ+k0h5ua5w8NJfi59eahzLWC04MejIwmC+6FKgPugXs1pbR7
         Y2JGpwETNs4tgVW9q/TOexdzkbusiRYpDvZ0z7E4y/LaBxxHfPZW0q6WWVwhrk18kxcp
         A0M0LgrRiZRRSw1/hE3jvyHBj2xv4Py9Z345+TGQzDiPQtGucuMClxOmV/U0zzrNB6Gq
         Tr4HKQxEW8GsTiIn99AJTRu0m2hp/zd3wPRIgky3ssowOXbpXdo/lTSRIKcxrwU/IxmV
         y8sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777008769; x=1777613569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        b=rwmnBEVf7uRtUvdS8ToX0USskf3gXagrH/WJ6KN0/1nm8F3D1WwqiHm9wwCtVyupNv
         9hh60z//uPHKWhRuwgiBSeYae/E1df3OtWkK2WVPhStSo+FD76frtVPJX1B6qh9JgfUM
         oX7EqxYrIr65+kNlW1wXFAOZq9WN5s0SAT5Bdaz0vJ7Qar2z/CApbxQScO31HoEWXJFL
         qO0InWUY/O4S+F2983E+DtjCoT+kJDcMoxyumSAQPJwVqzPgF41fRiSbv2VXWVYxz9sx
         JqhV22Rf4v5BFeLMpoyhfRQ9bnzDM/yptuv8lw1adFoPYtMK8NrvIf/eOWStzlxaQ1m7
         ScOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777008769; x=1777613569;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aTWDo7tfrhFJ+mriWX1EXSAY360G5GQcYwGOoiyouIo=;
        b=PC2rSc3m3rWjsfcQA3DmarIdtqMzpEquGzRKfOBgdZKJZiKqioCNApd7Jh1bECqAiF
         damr0bWHV3puP2mH7+p20yEVbXmHxEw4XOWUqc9KcoLj7pOpg02Nbt9ThuezUo8uc9N8
         WfvjMjIPrcoGV5pRyFNLIVPxjGK0Bx7+/ImmK4dEdkm3FhfrF5WTTis9hVeWJ2yRIot+
         QqrfXtu1CexaCxD68cvQLdN9zVMm0qF+EXrXKmPLqqMGKblgWjEUQXxDHG4VxYdb0MYv
         ID39DvgRrdNFWQUHRbFjLTzt7g4StfqW4plxxvyGFKLm6qAzrwfKkE4GP3q02oejoH3G
         S0Ww==
X-Gm-Message-State: AOJu0YxLIr1ir81KEGK4zs2OTJhv8WYybXuAePehxvL+lRXe2JTPqr5Y
	7NPWG/wwKKE+3ljIFfSIAJw95/PZxwQGHNiL1aGLAQ4AjL/up6EfVLx66BZbhFuI+XusX3lqfT4
	PW3upmIVHKuG+a30PFjm4bjG3N4qzc1g=
X-Gm-Gg: AeBDiev5mv3pEw8CTVZXzdIKUaWF0ca7x427zbm1mtNkpBB6WFo1yG2iZ2TiAaBGJOc
	WF/aMEPNiXvhlWjhQvrCZED2wulk39M+a0+9tY9t08/1BUyZAuUZAhG2aPQOUDif7HMRy0f5um6
	VH0pH1Ly5DDiIeeQSo1aUHfr2FY3py4IjbrZOdoeHrVzmHtZGI8DQzNtJt3pl440F1BmCNsIjop
	Djq+Yf9TbNMaqzNe7Nk5+J4Ep7ectDXhZqNzJvEXNE7MDfj+Ndx9hI+ArNl46aXI3iz61ZbKZWu
	hFSPmcGWMsDycAT11CC0
X-Received: by 2002:a05:690c:f06:b0:7ba:e1dc:1b3f with SMTP id
 00721157ae682-7bae1dc26a7mr239188277b3.25.1777008769560; Thu, 23 Apr 2026
 22:32:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ginger <ginger.jzllee@gmail.com>
Date: Fri, 24 Apr 2026 13:32:39 +0800
X-Gm-Features: AQROBzAftKukUZO5qXsKq3OfljKiCLNFqNzHrr6GoKnbrnXrbHqj9W5ZAtNDkkY
Message-ID: <CAGp+u1ZRvs6UJDRu1041mO93DsQvM1dkZ0CZRfEEsVBAVPvKig@mail.gmail.com>
Subject: [bug report] Potential deadlock bug in 'drivers/thermal/ti-soc-thermal/ti-bandgap.c',
 between 'ti_bandgap_write_counter()' and 'ti_bandgap_talert_irq_handler()'
To: edubezval@gmail.com, j-keerthy@ti.com
Cc: linux-pm@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear Linux kernel maintainers,

My research-based static analyzer found a potential deadlock bug
within the 'drivers/thermal/ti-soc-thermal' subsystem, more
specifically, in 'drivers/thermal/ti-soc-thermal/ti-bandgap.c'.
This deadlock potentially occurs with the involvement of hard irq.

Kernel version: long-term kernel v6.18.9

Potential concurrent triggering executions:
T0:
ti_bandgap_talert_irq_handler [t1]
        --> spin_lock(&bgp->lock); [t2]

T1:
ti_bandgap_write_counter
    --> spin_lock(&bgp->lock); [t0]

T1 does not disable hardware irqs in acquiring the spin lock. If T0
(i.e., the hard irq context) occurs after T1 acquires the lock and
both happen within the same CPU, then T0 will not proceed because it
cannot hold the spin lock that has already been possessed by T1, yet
T1
cannot proceed because the hard irq runs disables preempts.

Thank you for your time and consideration.

Best regards,
Ginger
