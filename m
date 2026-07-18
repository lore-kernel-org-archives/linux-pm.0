Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3C8271468
	for <linux-pm@vger.kernel.org>; Sat, 18 Jul 2026 03:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784343840; cv=none; b=W332PaXd46VtAm1emJfQ/D4jyaa/J3fbhiz2Rpqu8JLMS8AYjsxDeqleIvKiaqvMmAEYjrxTVMy2+zxdXWOQw255ixrwHtweBOEajKioQFkUjVtn3/9w9Yl0yBvCbD8p1ydMPewzZtKYB6TLl0FN5fuSZbmZ6Z7NsU4kz6cW/Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784343840; c=relaxed/simple;
	bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AzeTUZKknCP5RIZgl7eQlEKfHaIkXF3yXACIjVpDGBla+mhQIX3ATwiD+QksmSOGAgLS8viTjZlx9PK5siwea6sDLn8woMCQbr8TcsH1e70JMVWvzwiX8S+MPBckJ3cAcRtVDKtsU7YEV6rEkIxh24s0zjoaL5gEpctq7uQz1oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTwgm+Wg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTwgm+Wg"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9aea40d799so2394457a12.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 20:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784343839; x=1784948639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
        b=iTwgm+Wg2sS+mIV0DMNR6fLahIQmiUCyx4MCpU4VHB2tOSMZZJEnajl7+z+JMectZC
         Xb9ETdLRW295iKotIi0gKsgIq6Ammqyq7ZcNhqWE3gvozAbBRLAf2CxBVaoklYWTwTER
         SEp0pNdVmmrZgWTVDj4VldMMNmeXoFzScibBXI0LrDOWeU9dKFVeOpgVyZHv3Hhw/hoX
         uPYWH7pYsu1au0atDZtQRWD8ofsWKpGQRKijQmqvIIiE8yPdzuRWOdF66Zf+tXpOBmF6
         4/9Rn6hUrr/ehSvZ2RuiaBgcDh2+4s4khJNv33FuondztEgNSFyzZqcVMy2fDd42gKBs
         YPEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784343839; x=1784948639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPCpxr9XgsyMz1xhP7Hg7iTwImnOiQD93GKWC8ZNcxo=;
        b=hAF/O1fMIrp2xot86K26SPCvIfMCllCd1WSZ7G7+FslKR6vsNcG4iOn4nqtAkmgEZN
         j+VMejCexTD3f/H3hZy18Aq7V17Mj8MuxTiE2FXazD+qabxQytypRWGakq7+tbzPJXyh
         7lCi4H0MVdDt7zI1z0oxJERHI3DBX0DxZj91m9PVC5QOV48ZfPKRIVecVfsx4FJR2n7B
         oaXBVAm4XuBKh74pA/7IAFd+XtEmRe4P7It4LnzDkrKja4VBNUjjQF0VxipIY429naEC
         0M9xHZm4rbF8n33EVGiSNRxR8AuOrzC9w2mLVQvD5sxHlqJEzEUnuXPwONJlDaoB5WcQ
         KfWg==
X-Forwarded-Encrypted: i=1; AHgh+RodaRRCqtjq+Mc8wjRDbRXSyYQK/0MKAHqWbvFkizG53isRCFDxX3EnXEU3Si9eV5IR2x9+hbiqvQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3u0cDC7KT7Ob5aqff48ydI0R1WOVdO7jB994Wnh2llcY7Km2o
	tRGO/qXdZ2kvhVZJdeEU0i19Xx0YeDv+CJR8qD96i8iwkCj6ENNMV2BUMT/RB5CmJCI=
X-Gm-Gg: AfdE7cmiuRR+V49WIBEv7GgSAA06drLoW53Eg2NledSFs0xz0PFNcqVyVea8svxNsU1
	SFK18gUMazzlRHC2gMJBUTFfP5omKI/FmFpjLyplBi1Ex+D6y1asl7Td/0i/oJ81M9Tz3Bx9bFd
	KxeTEINoz/mDtrk2X3yks62EcZ6CvySrUHoR/J9cIi0+JEpFwJ46I29uSPjrKQo07pQ8cVJAgum
	0Du77D/qdIsJfnXzhT3erubPfhQW+KQqK2rGOF0ea7UHo7hsB98fbASl62vgKWSk5n//8hvrpFS
	eKA2kTeF90tnpn5ZbEhlq9H8Z9NsrV0w/igRAbTnOFnWgbRHW+JDp3d0W1ASGkWwJgOdnKtrNI0
	kQM/JHoDOEcVTXEbKbKX6YOfNgUq821gp3VHbhG1fQD6glpkfT21EdhoxmRorK6VTv/vMOvW0WJ
	sW3x2A5JTcmGzEVFLCRlQjENPtQATDiTqpFSH5+y/dBVVNMLzMtCtHU/A5zAo98FfPIjrcw+qVL
	KsFmJUR6utXa1RjtHPWsBlfTeFrEME7/5ttnourgxgTvsE6lNIqvUUQ98TOW5S2fxUg/UAKX2NF
	DBTXz3GdYnOiabbyHx36VqQwlU/zCu3eXf2moIVibVg3g3fJRVTHdlxW/lqrTG6NoNM=
X-Received: by 2002:a05:6a00:451b:b0:848:7459:5f62 with SMTP id d2e1a72fcca58-84c2945a902mr5377409b3a.44.1784343839028;
        Fri, 17 Jul 2026 20:03:59 -0700 (PDT)
Received: from ip-172-31-21-198.us-west-2.compute.internal (ec2-54-213-160-35.us-west-2.compute.amazonaws.com. [54.213.160.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e48csm2015355b3a.45.2026.07.17.20.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:03:58 -0700 (PDT)
From: Bruce Robertson <brucer42@gmail.com>
To: Igor Korotin <igor.korotin@linux.dev>
Cc: rust-for-linux@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sre@kernel.org,
	ojeda@kernel.org,
	gary@garyguo.net,
	tamird@kernel.org,
	aliceryhl@google.com,
	boqun@kernel.org,
	dakr@kernel.org
Subject: Re: [RFC PATCH 1/3] rust: i2c: add SMBus byte transfer helpers
Date: Sat, 18 Jul 2026 03:03:46 +0000
Message-ID: <20260718030346.1698-1-brucer42@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178376605131.22511.1602274538745913609@linux.dev>
References: <178376605131.22511.1602274538745913609@linux.dev>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Jul 11, 2026 at 11:34:11 +0100, Igor Korotin wrote:
> I2cClient should implement the `Io` trait rather than adding standalone
> SMBus methods like these -- this was already agreed on previously [1][2].
>
> There's also an in-flight series doing exactly this rework right now:
> Muchamad's "[RFC PATCH v4 1/3] i2c: rust: implement SMBus read
> abstraction via kernel::io::Io for I2cClient".

Thanks -- I hadn't seen the prior agreement or Muchamad's series (it
ran on linux-iio, which I don't follow). The Io direction makes sense
to me, especially given Danilo's point that it's what gets I2C the
register!() framework.

I'll drop this patch. No point in two competing implementations, and
Muchamad's series is further along the agreed path. When the
FallibleIoCapable discussion settles I'll rebase the SMB347 driver
(patch 3/3) onto the Io-based accessors it provides.

> Your smbus_update_bits() is exactly the kind of read-modify-write
> that's affected

Right -- and it may be useful as a test case. Unlike the AS5600, the
SMB347 driver is write-capable: it does a config-unlock write and
read-modify-write updates of charge-control fields, so it exercises
exactly the try_write/try_update paths you identified as unsound if
left routed through the infallible backend. I've offered it as an
early consumer on that thread.

The power_supply abstraction and the driver (patches 2/3 and 3/3)
don't depend on the shape of the I2C accessors, so I'll continue
revising those in the meantime.

Bruce

[1] https://lore.kernel.org/all/20260708214738.25008-1-brucer42@gmail.com/
