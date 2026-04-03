Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD582FDC5E
	for <linux-pm@vger.kernel.org>; Fri,  3 Apr 2026 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775241084; cv=none; b=M4TD/+TjMzEadLUC6mHvcyzsy0pmQ1yICBZGs/LwwFwbplHKnjQ/Mb8xzGmPNfXp6hiUabdxSjtd45rrY67ZokYnMG3fe/SlESN71d4I1kHK+ysuXGgnNNZqTKslCht/432sA6D8aroivV2Fc0qsbDgbjh3uK3rINaj645rcYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775241084; c=relaxed/simple;
	bh=3kDEKwCjvQbYioCymaYS0/N/wppg3o8PlSWFCzCdKBo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=TmKXVT+LZtjcjwjrpARlC8oCwFWlTLxIPUTyzcGSxhWbhLwUk541DhHs7n7bvakSUeKjGVqoR3tWnrb4CGNhFaRY3XiQ5uQatEJ7I5OMZUMXRvFWwbZyHU42uhN0ken25gxDm+Z7/6bcIqHST6zHUqB2VDkhNqxBnA7u3uLTSjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ASBvKJyh; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ASBvKJyh"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82a893d289bso989928b3a.0
        for <linux-pm@vger.kernel.org>; Fri, 03 Apr 2026 11:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775241082; x=1775845882; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q6b//jCqanlCCc3H2vjBndwqbZQXUM5F5sCZV0dcjjc=;
        b=ASBvKJyhiU+Yhr3i+3WCXaWxzANHJeah20b+aPIfyl83v5qlMzV5YTTYycfX/QkdQN
         ar/KeCPm+Fjh22JygYYWiAuQ/kRhuSxroh5QDdCOSDHhF1U73TeaBYMpw7gsJBYV1YRP
         TB0Gq4rw3P/+I6iszVtcXbjspjNMal/6a/YVG4WY6npOmEWbOo1p30PBorwQvPJ8ASgL
         Z7fuq3+K+BW8persA7J6B7y63OnoN76d2MCqAonUntubfcfGfW0DB4TzjBfJPAgjuNgf
         XN4bXQ76SujwfRp5q4SIVjRhaW50b7C5ysNShgPm/s9LQzrMQzF8NN+lv4kuM5C3ZYNe
         jlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775241082; x=1775845882;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q6b//jCqanlCCc3H2vjBndwqbZQXUM5F5sCZV0dcjjc=;
        b=PJeTwtQxQ7IupIhCebf8MyHZMMRKYvhYwAccOruRwHJ2LqQvE+DbCZyNwehADIJtbT
         9N5IyhvVHutoexhMPRJag+/PSsHlIFkNSsiTdnxqz80Ir/GKHz2+sDktc7BAVoHLJewO
         hZkIqwFKQecEv1TxtD4XEpdaP7thSyr9zq2KsC6L/NEi9tnVcOv6x7QqDRw3w9mO39A6
         eRdmApjSCfpRXuZXyxYt2vC+w9WWSBsTGCz4Yy6o98JKoDAfb9p0nMrb3Az8tlBcP/rq
         v8Kke6NA7DCFuCpmlamPXyu7nfO5OWfTnf/gAS2PFDdLpxBmZd+pfqRO04+S32DCqf3c
         mRuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQI8qFW9zCT9xPiT3UUWP54Wg3c01cCA3tqNsGwTVrnXk7yR1F7hJQao0+yHST1alGK9V9h0EgqQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCHRwUhEhP2pJQ6e9DmJEVQJbq1T1qlfdw7JcntOYOsBRVUl+t
	Qlmvw9qZ/vGXOo981XvKauQwKbegF0kkH+goHyUiwU1f1OR/1NLX6CZ9
X-Gm-Gg: AeBDiesfjiO+JWHXNY6kW3BXELlmzWq+uqmMXM4PwmK7vAjIIPc2cuVAcrVWkdGrBCx
	ZZilPS1B030X9sDKXr6ZZzJ39g/1lOhyE+xMfJbs3yGUJPD3ChizfZQtG3tnSnYMyXYSosV3jZs
	NpJEeeYFJPVR/V8vRSVAbaYoDiSI+w8hd6LeX6U+buZ8nHaSA8USnKUX0mP0SM83zS7Reg878R3
	zk3pSauKg4oQuZqB7eDYt3Vvnzxzc+NsOTLSkEawMoEBHaEXJ+69pZ0D7InmRd16chbdDHqBBTx
	JtYe4XQ/AaRdqsGeseDBHkC8pjqYv7CP9klyI6ZuS+kMyVJHZz4RH9f/nodXRZBH3wZEonG+yer
	37gOKIzTi/MHmGwtCCyWNNTYxtJHJyhPKUncq25Pt14YaDAEaZZ8soxC8fTXYVeAXU5cIFEIZB9
	VMDuTx2yabbwL2hYCq8+YGt4izScBkLOJ2jwXnio8=
X-Received: by 2002:a05:6a00:23d2:b0:827:433c:ba7e with SMTP id d2e1a72fcca58-82d0db96da9mr3597695b3a.41.1775241081598;
        Fri, 03 Apr 2026 11:31:21 -0700 (PDT)
Received: from [172.30.1.22] ([222.106.243.217])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c9cbdfsm8381577b3a.53.2026.04.03.11.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 11:31:20 -0700 (PDT)
Message-ID: <346b33f9-5ca5-4735-a89b-f7cf813419ef@gmail.com>
Date: Sat, 4 Apr 2026 03:31:16 +0900
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: ko
From: Choi Chanwoo <cwchoi00@gmail.com>
Subject: [GIT PULL] devfreq next for 7.1
To: rafael@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 myungjoo.ham@samsung.com, kyungmin.park@samsung.com, cw00.choi@samsung.com,
 chanwoo@kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Rafael,

This is devfreq-next pull request. I add detailed description of
this pull request on the following tag. Please pull devfreq with
following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git tags/devfreq-next-for-7.1

for you to fetch changes up to cd905830ea6184d6678386ce2d652bec324034d1:

  PM / devfreq: tegra30-devfreq: add support for Tegra114 (2026-04-04 03:15:39 +0900)

----------------------------------------------------------------
Update devfreq next for v7.1

Detailed description for this pull request:
- Remove unneeded casting for HZ_PER_KHZ on devfreq.c

- Use _visible attribute to replace create/remove_sysfs_files() to fix sysfs
  attribute race conditions on devfreq.c

- Add support for Tegra114 activity monitor device on tegra30-devfreq.c

----------------------------------------------------------------

Andy Shevchenko (1):
      PM / devfreq: Remove unneeded casting for HZ_PER_KHZ

Pengjie Zhang (1):
      PM / devfreq: use _visible attribute to replace create/remove_sysfs_files()

Svyatoslav Ryhel (1):
      PM / devfreq: tegra30-devfreq: add support for Tegra114

 drivers/devfreq/devfreq.c         | 108 ++++++++++++++++++++++----------------
 drivers/devfreq/tegra30-devfreq.c |  17 ++++--
 2 files changed, 74 insertions(+), 51 deletions(-)
