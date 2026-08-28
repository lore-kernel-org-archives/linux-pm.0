Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E76B5B5AB
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 05:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896061; cv=pass; b=heJNFtEK/Z8P4UWl9uo7Jq0qHzEWWOmq45jNI4dNb/4vWyI0Oitfs12IfP0B+gO9VcVjtYDgR/GsmAcDGCCrXcUnuSil9A1XrBpNn8wRHWTpe9sDsTTeRMLL/22IYfkuxXyV1EETQEYFmAJgK+TcXKXZj4tx8Pch0T/l3JM3Y20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896061; c=relaxed/simple;
	bh=DJsTYJIcYnU7vioWdYNKnIvZWxhAdOa6rfODFDd/5vs=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=d6vsgYCgW8V7RGH3hLZbzvfinLZ5CqhFK2fWKmvwRV/7dg4l7SeytylTaKpUq0rXwO4qU4q1b56253t0qiol4ACPKV10x9PZUZRURHFM7yRuejbkCgzUk0JjLKaOEQjxgTwNhOIi3KldJVDKpPCMXeU9eOaUcp+qPihLTc1QSI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=Ozjk/rtq; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="Ozjk/rtq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso11047795ad.0
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 22:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896059; cv=none;
        d=google.com; s=arc-20260327;
        b=oR8dlLqQYL1lhxovSlmwVrTFCol6t4vPMxex0+ditqjC9aVJZfiMqAqwwl9oGTI7WQ
         ZkCP+nUdFcbAxakUVZEZKgBezjOBbb2Cahp6unv6zZxMOB4wx3L4a5Vr2xPA7AUFaWe3
         jc+1+hR9hsTWMfVe6PEtgIHj5KtytdQMNHsqnCS/n09r9/f/RfK5ZUQdK7AWd0SC2Coa
         kcM7hi+hCvy0ODe6prU6fqH4dZxpHmXyqqyRl3nJKwSioyvz3iHeyJQ+ZoiHL/A9WLQ2
         BrbQ/wn3LIce5FRK1gxP6nT9/Gl37oCvgdMr9bfe9mX+EdkdAWFBBUDckeOTgC1+VSVF
         A18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=xw0u3y77s06SS5fejAicY/4ObOINDzdiC2R7DRjet6U=;
        fh=bBdkpa9nSe+qhOTqVQGhWWvVKWUC5H37lk88qrSmntY=;
        b=dJFn1exSHhT9R9DUCMul0I94J2eIJVjaOXIe4bAXI8UftHh/XzVxzd84mm0c6zBlHk
         slBp1ZJ4vNwZorzrWy6l0dcr0rTTcfMap98WYJ8WIyqYpHB7skp/OCiid1GRth8aWYmz
         0FxY8sza8Q/aDt0In/jZZpffOJNCxs7kw83eLJ7ktlxZSKAQz5Jzx0T0uxIMit6vBLql
         vqEa1/22aGXyZGF+3hQkYa08C8dZjYfqL8sghLcZLit8BPUg2XliTH+s1UZQOtx70aHE
         CFP89D5yr6MKK4IUbAmRWxbWH75CNIOAIBtsbxSkzEf89TGKpV84LwsiU3o3CPfcYprW
         ofMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896059; x=1788500859; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=xw0u3y77s06SS5fejAicY/4ObOINDzdiC2R7DRjet6U=;
        b=Ozjk/rtq9mPBn0Gea7jwhAGrjnlDLnSvVWSQllwZTylRK3/xR5VqFwBbcb8Te5RObL
         C3yRXzWjUqev0Qt1YNd57YruwJfr3bq/hzf4B2gEbMA1Pab5/lMVox15pCSrLChGD/Uq
         Fn06NVcycD13mr1gpuke1YLq59EJZuhZDa6NntWbfyxNOyFziJzvBbZDj8kw8KGLkf8n
         dLrtqWv73aNQpn+bObdOivKOZ4JcL7p5DZo7tZR3XITOMIQmGaCUy1MG2wrq/Tb2ngok
         RqoRDSY8md+yrC6960RCd6v8gqWQOfxWawkjeISJyhhyRnYUDRHAL/ehEUvoN8VGiAYg
         WYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896059; x=1788500859;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xw0u3y77s06SS5fejAicY/4ObOINDzdiC2R7DRjet6U=;
        b=inNCQa+b4tnnM4l2/vc1UQg1otwTwwJjssGPf0dZjMBBHnOxX+nc3euATAxQKnFy/e
         EXs2ftQ1DAwTOk/8q/Pkw3C0qASBgDq2WKaNrE6OuHdoLNZnxUq4veV+0KhEnnuj2Xi/
         gLJUX/cfaKUF5F66PI2QHgBCSI3VvvblRywJkdEUDZn9Ucsx5lV5eZpr0x2z3DFkquiE
         gwWaigFx18PDDut/AeW6NprKnTNixgah0jd5aJNWQ+heTTWpOVjn5uIJG8fklQAIFo6X
         N2+zKrSqjBwDUKujQZYyWeNql8uIW0IIVHsd0pnrtb9tOehF1sRyT88k5jYY7qv6rtl8
         OWGg==
X-Forwarded-Encrypted: i=1; AHgh+RqzmpFDonfcf0uXoXieP3l51skK+nRG0/WK8QV5EJeNRS4jWtbP4XhRGrgVi1TXtdqelgJHwU+a7w==@vger.kernel.org
X-Gm-Message-State: AFuF++mBPsg4s4kVlCunm/3oCeC00z3RVkEmEbalvwIk20ldAFQIYV8F
	N/dVbgAk39+0Mcn6B0ChahEmruDFwp7j7boeFfdkwX5GocqmHBZyIeDi5+3dTTGsUYXSztK6a7D
	vkmU67dNbld1t3I05okBwzPc5BukjxN6pd4+1CnfU
X-Gm-Gg: AR+sD13XT58Xz1AV/jQ/J1kaMU/AUneDr0XHom6yI2XyAcid3ie+T5U/G3GwEFJT1gc
	UCCcPZbBSQejNygIOlAD3vsTvDaFZILRJlaof0eSPz8UFmgdHt3e6/LtVTps72AtK7ouR6VjD7T
	1cKZBEZdUOzo141r6KdWPlbVcXWaj5gL6z5nyecH48dnGG1QtchemTDTlRTPPUFaRe300iDNfaX
	eh6Keh6l0RWf5i07VaL2J9zCZujH9X77/zia9SM+RaKLGiBi7FTy+Ey3hsH4xdf6oM+Je3XfA7A
	tRDTwHT5jHXfGwVudMt7MzkAuI59czucHfEN2A3dcLeT8QFx3+wvBOmCiV/r5/NqOFBMlc/KE9r
	FeOZAjrcCGTWSlBZnabETDPSio2LRLCoj
X-Received: by 2002:a17:902:c103:b0:2d7:344f:4a6f with SMTP id
 d9443c01a7336-2d74ded6d76mr60093875ad.8.1787896058433; Thu, 27 Aug 2026
 22:47:38 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:47:37 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:47:37 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:47:37 +0000
X-Gm-Features: AcwNN1WysQaTDa4WYAtaf7a5tp6RrsTZa7alP9IXFixhGCml7UKU0kt_NQ3GowY
Message-ID: <CA+0ovCj=ojp=46PzmrDUxf4sbNRtF32eKDe1FNmBCcFhnEP8+g@mail.gmail.com>
Subject: [BUG] kernel BUG in mark_free_pages
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: falemi@asu.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/181-kernel-bug-in-mark-free-pages/

  page:ffffea0004c00000 is uninitialized and poisoned
  page dumped because: VM_BUG_ON_PAGE(PagePoisoned(page))
  kernel BUG at ./include/linux/mm.h:2265!
  Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
  RIP: 0010:page_to_nid include/linux/mm.h:2265 [inline]
  RIP: 0010:mark_free_pages+0x49e/0x4b0 kernel/power/snapshot.c:1265
  Call Trace:
   mark_free_pages+0x49e/0x4b0 kernel/power/snapshot.c:1265
   count_data_pages kernel/power/snapshot.c:1417 [inline]
   hibernate_preallocate_memory+0x14f/0x750 kernel/power/snapshot.c:1859
   hibernation_snapshot+0xaa/0x3d0 kernel/power/hibernate.c:429
   hibernate+0x28f/0x680 kernel/power/hibernate.c:839
   state_store+0x234/0x290 kernel/power/main.c:821
   kernfs_fop_write_iter+0x2fa/0x480 fs/kernfs/file.c:352
   ksys_write+0x14d/0x260 fs/read_write.c:740

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
