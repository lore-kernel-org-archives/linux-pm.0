Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41935AC20
	for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 21:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776719006; cv=pass; b=BmKD5ZdLfudMtvkbLjwwH+EbZms7SRs6cfM6a/zwVKzwQF4rEbFKwHJDrCwQubBpKdC6U/kHp+fXnr1Y+ipToUotwFIxE740/4ixIIWsTfTluZHUsnZ7LAlaziY+a/sRjrVMmrGJhMB74U+Pqnj4fnFT7YJB1HfVHphkmWl8vV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776719006; c=relaxed/simple;
	bh=G+Xvp+a/TZ4/nQd8iELu3XlqZ6Mkqqu3tPWQ0K2mZtk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ll2gWa754IN2m+gnQ68YAkEAg8yzewlIbXR47xI1CWcxf9ehOlutC+3KbP+vw0Z2BO+RcT3wOUkDdHfEIfBPcL4dX6sL92o0zTjnwTGPGHwnIjoAvzh/ui2ShtCJpw5dTz2nfHDA0wzUjUEiXvW2wuvvArx5sXD9btEXU6zsl2I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L51Nm82d; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L51Nm82d"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c3e2cf3c0so625495466b.1
        for <linux-pm@vger.kernel.org>; Mon, 20 Apr 2026 14:03:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776719003; cv=none;
        d=google.com; s=arc-20240605;
        b=QmVugPCkYQEI0pKbMX68cgK7hDODHmoMThQWGVSilBitRD3zLyjqIgE81TnPZSnj92
         XA7ujvWywuJnmnojD//0hkqjRbTEsW3cTuk0avVI3QSBtYrvmIIFSaEfSFj4s2r3f0bX
         /LF12bcYZ6DljIUi5zCvY36YabSGHGO7dKekCwGc7xWU1q8HmVuye8h0NheAERePfoFe
         kf++eotqqt/U74okJr2/d2DqfPqBsXoXwAAKUkqjPcTz5BhfIzPQB81lrEEjsubUeEh7
         jPfCYYdJMGKadvgMXpefQVHTzGi0+LTnwxkEDGE0sMiPRJ8oq1/gJiXrKUE78JkpDIU7
         KQaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:dkim-signature;
        bh=G+Xvp+a/TZ4/nQd8iELu3XlqZ6Mkqqu3tPWQ0K2mZtk=;
        fh=4oVRGepxErUo41FCL/zsIw4pl7mBtAQCMfBHc1+1DMI=;
        b=f/e6Tmr0BOqsZ49/kGiOwg+1Qr/TgJby2s0nTOURjP6yCno4UjkkVOG8pJvkkTare3
         GvvOF47+qeLQsM1uHFW41giOsdw8HRWOHDKfFjqtbP/8Bg9Onbf2MA9uMUYQR/7adTNN
         k3+d9bzSdUmbbrupt/LFjTHikHygXBe+KkU7YxyDgMi8psa9PqnZ7zXD1ZaL9X0wQ9l5
         62FWVFvXVoVt3nY3qpYdM1GJDlHQv2UykGKZ9jo8999B0oW3BzDK5hoBe+kcr4sajths
         KBfd3GPCtIKpzg8HC06AIdKq603xe2/SoxkDMoCPkgwpkk7RFKRgYYIIfPMCHHbcS4rc
         IigQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776719003; x=1777323803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G+Xvp+a/TZ4/nQd8iELu3XlqZ6Mkqqu3tPWQ0K2mZtk=;
        b=L51Nm82dKHvAs2NaQdW1yXkilDq31fIZ7ZlT2IzwPDpkSTq118LEqTcPPlhh2rVgdY
         92I5qkO01j2mzburzo71cY8JFifGcK6blv0kCjbxHSPC4U0hjNtOU8VlsMzoJoimRYjQ
         w2g1342TYiHzVXseIK5MYKWQTN6MdrVTsUkDrMvD8i6QuaueXUczZlN8arsH3wGjx/u/
         dPChZsHDAp6pvPiqIR4x1AZXRZupf1Q+xHA/Mjm8T878qmZDxAvH6XRkhwUIkZ/pwboF
         0d9pJ460kXK//EPML4tiMsEyaURZmrekYhIZsg7aFcCTqKQkL4A+DbmQQ6qAmTcGxeY1
         DV5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776719003; x=1777323803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=G+Xvp+a/TZ4/nQd8iELu3XlqZ6Mkqqu3tPWQ0K2mZtk=;
        b=nEsw/6ZnR33adhco0KvvPCaUmZDhuJTUiAgsJfJOnhD09EVxSbNois0PSaZsgDN8is
         Qel22iePm+1jbfAlnN/uWt1EU/lKZ5dTqBR/M4rvv3wnLx9N8x+N+VFRPAM8oXVYM8Vf
         gLltpyNDy8GWQfZZMOF0exUgN7T2WrbkBJwTQ6ZvHhTmKtREWdSsZ82uVtwrjtdS4YGX
         cXtb8LURfJ23UPz0TWqONniRSvPzJ3/9KlpnPLQNs3FR4dCWq4VtCDysP5uzEatOALq+
         9PVV7eTJyrjIR7WNTd7uwFAw4k+/zsSTCjNNdfiWXP5xLL9LMVPWIUPaPJyyKidsYiFL
         9fnA==
X-Forwarded-Encrypted: i=1; AFNElJ+pKLXclpK3oAsOeE5gND7R1igvhzi6bzJPi+vo45D2UyiUWXgkFJPjpqk0EVazREhpGDNOd99L1A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk4RsfSH50JiCLo0BrrdNKUxiicZPtxx170K+mIiZIQa3UEzot
	ScumhET2tAOMaxPA6UxQ965vxjLryWgKtPKfAX1rkq52fL2dDGvzILZ3CGMnDdBGCl+HfBaJ26M
	eO4LCEhGAy094qs/WDsCdTeI6Q64x4Mg=
X-Gm-Gg: AeBDietJ8Tg24AeodYo6xjIDF2nHkTVgaXcPpo6Z+MR7sUE8kO4fPwuoxdWALa7/gus
	+QSKAWAifNsowNpikSLl6dZPpad55frSELfXy6R4KVTFJyQNmrtVcri03Qs0T9xMXAqRfkdGNZf
	b+/JPXCCnRARymL/uEIhFSyTObTep7zHOT0OVr86zwzjqD59Z/NLQ9mndURkRCQDgUBhxiLngU3
	gT3nRBEgFm06Fa/k1dkVkT+hPbl2G0K/uBnmM81C27bGxYU7lu6wjvW682EfwPmWyoVkwdRMW5X
	MN+vMx10Y98fA7hnPg==
X-Received: by 2002:a17:907:26cc:b0:b9c:6ef1:ed13 with SMTP id
 a640c23a62f3a-ba41a0474c8mr694617566b.31.1776719002889; Mon, 20 Apr 2026
 14:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Mon, 20 Apr 2026 23:03:10 +0200
X-Gm-Features: AQROBzBmitKPBBRR9vT96Xo5YJQ56v1pydkkyPnqPy_bIB0fXW3VCRHeYSipQ8Q
Message-ID: <CAKSQd8V+aPrvteJF926uBROpmnOHeeDGmu2racZNFNy-NmJmDg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.18] tools/power/turbostat: Fix microcode patch
 level output for AMD/Hygon
To: Sasha Levin <sashal@kernel.org>
Cc: Serhii Pievniev <spevnev16@gmail.com>, Len Brown <len.brown@intel.com>, lenb@kernel.org, 
	patryk.wlazlyn@linux.intel.com, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> + if (get_msr(sched_getcpu(), MSR_IA32_UCODE_REV, &ucode_patch)) {

Intel prescribes a sequence of WRMSR(0x8B,0) + CPUID(1) + RDMSR.

This goes back to the original P6, where the upper half of the
BBL_CR_D3 L2 cache test register was abused to report the microcode
revision, and CPUID was abused to actually load the revision into said
MSR. Afaik the WRMSR(0x8B,0) is still required today.

turbostat has the prescribed CPUID(1) =E2=80=93 by chance, a few lines earl=
ier
=E2=80=93 but it lacks the prescribed WRMSR(0x8B,0).

Also, note that the prescribed Intel sequence is neither required for
AMD, nor actually works for AMD =E2=80=93 there the MSR is read-only.

--
C.
