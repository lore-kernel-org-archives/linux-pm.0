Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C00471269
	for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986171; cv=pass; b=Mhqt9xxvFrTq1zELm+k0UA+7uYAZKpSL2KRWgGMDyfGj2F8u20Kau8REENNTAhkM6/xurJ/x8Ox0q40g24zYK60eFTrHXs5VAM22EF1HBFX/kwIBBbrYZfSSvXNF+uI0cmpfdyauvx2X1OXELPn9bctMx7fRvi1qRNz75BPW4Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986171; c=relaxed/simple;
	bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unWTaAJYv/1v8PGxQzKNWxWBTyCk5I3+bwEYqiAS2SiEG30HSKPdgWr8wfFE9EljNrIDon5BUcqwuW1GzwNkQOsq5Z94DUD6P8x0COv8WOCgQ06yfSRa2v/NkuGss5QbVc2AI6+60bGYGFrtOT8lGlh0oZ2rH8yz/W0lde3U9jg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA6Bsv+I; arc=pass smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA6Bsv+I"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469d20963so1766031b3a.1
        for <linux-pm@vger.kernel.org>; Mon, 21 Sep 2026 03:22:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789986169; cv=none;
        d=google.com; s=arc-20260327;
        b=GYZsAoCXFWqrBDgCXU2jbUS/NzU1XfmCwMBISwQ5ztTHVdgiIa0kVyXREcHIX3uB2t
         SgPTsBRC8/8MyK5S60Y3KUqI2LGKBmOEYkGFA0o2DcM01DQkRhfLoUJmJR3Gw8JGcXeT
         VZHqRnIUA8kmP5QBVDgtEzWn+/0qMQg0W5LivFkgIP1UoDB7HFIlAhJcAebMjkYpcHAR
         Zh5yM6862KSeB8vwwhYydSqRf60qrvj5iletcpeOAXoV/4W+SJxKfJsjUU7FOM4qJ+qi
         6MrmOEbN94Pthqu7qiFwZN2owLn7Sdk1rIw3FrrznnVn685GVPYjiSM+J1nI2qtJAqA/
         hpdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        fh=MqLsG+kkdbtigR0FL9ZlrHdY69j4gQskvxr8Y0spr3U=;
        b=AWMyywpKkr9nHDqFZhlEdlgakYNH+slTqejseZOrrM7WNNFNKKZ3uPKhhhbKVAQ8CS
         Q4nR06bCgJu+KszMcfViAI4X91OzqpXLIPvaWrI7gj+LiSB3bDllXFCWT1tbLlerXX8N
         x60PwlTLGwGxIf4d5yHuSngPyHd9KYebr1fE2KiGTxxbqTTAjN9kjVu2FQ1kM3r+GUqz
         9FcB5TW17jZWcVh0AFAvVc6GlqX7iNBGSuKVgp4fzCMBTYNNyT1PIBWfguvsJJBRV3IV
         PGV3Bs6xgmM9nAl96/T0QR/iwPQppmkgFnozgoHsIOOsknUdGuwLIElXjnPwE2oEYbDz
         kR8Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789986169; x=1790590969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        b=GA6Bsv+IbjKXDV8Z+ZUxLSVfcj49O5x6PQJCBF+IBGTeLPjicYnO5sTP70HqUNXWu6
         zutnluptb+2nkx3MxD3mYtrxS/FLUfJ/NnumpxyO5nLSE1B3uPJkcXVOQxVAMJYsdtuJ
         Jf8CO6ges/3Og3148pE7WWM+9RkBxsgyfQfq0d10b1ns8TLsKxBZF/ySPAEA5Iq3Viq+
         Q+gYFGRwJYetsslUDK/s8vKvSBMEJj0TqUh84y8ZbERGVqYArVgXOBvrZGA+q4eAfcO2
         Bfq5eVWt7/gbaCnj3qiL2MlszeLpJUDU5og1g6VwZvGqvhxxotkYUkAUOhjcn8maCdtq
         NMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986169; x=1790590969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jxiUfSa+budlgOb4deQ6ne2o5T4IBUsXkRWChU/Uls0=;
        b=zU9f3rvowGsgmoZxjU7yafhKcBPtueirGSCU2zZCQgMLorRE3/tV7aUTd8AanHTRmr
         ziqrexQwDQ9G/mnOOIDviqhCn/CY7+/YVaykS6+jLymVMclujSKTrqi+gJ5PrlTm+QEu
         PHioGNhXgdCH4LfChPyVCf8P/6URfu5uP67wQm58YTcZv8F5KyTp8sTlxBkIXgayWd3R
         HUvpkAbFybn1TxOeZKAg/Vi1g/+j36Of6M4jV551qD4Tzavvz9GBK2HIWmQXaVJmPWD+
         N5AKyiQQPne3zUXUXOOsbWRlcaSY6AvS2vSputbBILmkR0MQoRhxdvp3j7WQbODxjolF
         MnyQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9ztxV3pFxn3AusUyI7hlNIlxFQFZgQGTlPW1RcIvlHsWPihQ8DnJPPgmDAYIXjzV71p+cnw6QxA==@vger.kernel.org
X-Gm-Message-State: AFuF++lBYwFOr+2aAJAO7+vJzOdGTOGWEtdL678ASiXkSi8IrzMWmTtk
	xIDX8A4lJlP5LGx/rqWAJIhQCsxZv0DLTxQlVxh/e0IG7sO8IuDGufZh3cYWor2UWtS4TH/X7/U
	AhpLzL4XuK/abPUXbiW8PWyv6iSSivMVKO7sh
X-Gm-Gg: AYBFou1gmnVT4kOIj8OQKZyW+duCDTQs3QBePjlPbZnCGKYcMHrjbr4AtInPVVA3Txr
	qPdxHzGc4STi28eJZOhgAbsuRwBFFITOTxZGzbvo8L0ED6s5qWQ5//MFq9BusiyLENo1N0E6o2/
	evfDT1OqhO47Buun5SxHtpxKJAF6D74gIsgt0mWJWVgNxQF2lrMZ0tdClKN7ALk5FTt9ynFOZ5k
	+zFVoQH8BwkbHttGRJaYLKP+rnHijUjXIBhDi9mEAdsKOMbqDzwLnuQ8GmdAnuswsAggOXbtanm
	5BNDT6l27KvicYEfYBhRCoabRmab1ywoaygrDiRyLWjqWSr5mrvK1aSmnEDxNuj9b0urUzpm7Lq
	uxTWeAseb2I+8NOJh/K9G/VhXcycxrs2YKr4I46Cu3G491H4b0VtDKdEnt4E39FsTH3EFeqzXzw
	==
X-Received: by 2002:a05:6a20:728e:b0:3dd:85aa:4525 with SMTP id
 adf61e73a8af0-3dd8c4f0d4fmr17653691637.32.1789986169161; Mon, 21 Sep 2026
 03:22:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjEBWQo0-Sdimo+aRNKUQvgDGw=jBFCcfwCXaqVdtoPrHLAQA@mail.gmail.com>
 <2026-09-20-daily-reply-0011-re-hibernate-preallocate-deadlock@kernel.org> <a40f9988-7e82-42f0-a27d-7a7c94dc37d7@leemhuis.info>
In-Reply-To: <a40f9988-7e82-42f0-a27d-7a7c94dc37d7@leemhuis.info>
From: David Lomas <david.s.lomas@gmail.com>
Date: Mon, 21 Sep 2026 11:22:11 +0100
X-Gm-Features: AcwNN1VGK9eJqWQOMs5ndg88mO9M-KWXOKX7uR7KJ_FGuaACwylQwUWYMMOnr8M
Message-ID: <CALjEBWQrDh5KrEscjVutk_H3a0+jH-=DOa=au32z3aZq20fxug@mail.gmail.com>
Subject: Re: [PATCH 6.18 0167/1250] PM: hibernate: call preallocate_image()
 after freeze prepare
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org, rafael.j.wysocki@intel.com, 
	gregkh@linuxfoundation.org, matthew.leach@collabora.com, superm1@kernel.org, 
	linux-pm@vger.kernel.org, regressions@lists.linux.dev, 
	Florian Schmaus <flo@geekplace.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> David, you might want to take a closer look or even try that patch.

I'm building 7.2.6 with that patch, and will run it for a few days;
obviously hard to prove a negative, but usually on 7.2 after 2=E2=80=933 da=
ys
of continuous use, a hibernate would hang.

I had one more hang yesterday, captured with SysRq: the same deadlock,
systemd-sleep in throttle_direct_reclaim() under
preallocate_image_memory(), waiting on the frozen kswapd. That one was
with vm.watermark_boost_factor=3D0.
