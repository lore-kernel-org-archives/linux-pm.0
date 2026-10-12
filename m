Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF953F23D0
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830434; cv=none; b=O/dy/6gAkI2wFz/kAm2D90i8dAXb+0IotNKPiMztTcu9WZGe1Y7DPI0vAA+1PA7OCn+Bgz2+Y8xIw8kvkLyHPVP/ZnqO8PMs2u4HUv6ShcQGJTDj7KtawgNaV+4iVbLiNWUHp7jZcn2wHu9Rov+ReYpk8NbZaSsQuT6SrR1pKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830434; c=relaxed/simple;
	bh=jt+Eji9rYzHMfK+EI+5uEwnD4ioO+UsqVK2ItGcwumk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=Oa53RxJab4HoFFxuXxdkf4MpTGMlDGjImBwlDAfIQYqNCj2zb9ia3IdEv1FHdDwQraJtDIuynJVlz4qGZfDfiu9C97FUO5oC6x/2OEgOah/L1StxwU9U2ZqgHulnItQe9OSvaMS5PHkZfDXGuLMylIC5V/Y2dYUABEFV8tcKn5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dtiep1DK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dtiep1DK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404881F008A2
	for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830433;
	bh=0CFZbCRHLx6gGcXCH5+UaihTRZ/cdKaSVDmi8apsr+I=;
	h=From:Date:Subject:To:Cc;
	b=Dtiep1DKHxfltcj1VY9Rx9BNUzMdBQ8Huck4k63IsjbwJQ1aa9PrEPjXBISbOegGh
	 sRgJA3ncB/ZmD/g4Ne2wGoc4XBht8YLmSoU8BksLQB4wnEWj6pXzjvTyeTZZjiCWo8
	 kJDH3BVZBF3dcNxo2+oK/AL+xRbriUlyFSA1lbigoGC2VZ6pWMFPCzSkMUUaLNdwAn
	 qk2cwCvSCNDz5uOhI62nA4pCXmbVPLbOC1fgUxfZh4of10hACl1QMLlj18qZaTXemR
	 e1pkUIeOHBTNTLk7CCQJs4SpKhiaxeOcn56iWeXGiEuqikpwtl8+IkvY0ClUuuYM3s
	 MI+qH4zMfqvsw==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6acb57c2b88so2879962a12.2
        for <linux-pm@vger.kernel.org>; Mon, 12 Oct 2026 11:40:33 -0700 (PDT)
X-Gm-Message-State: AFq9FYIiyCmC60qfvbLWfLtw9xQkzxR29M/vf7lZcI66yn7KDdF2kHOn
	sBg3t6XOJ6m6MNEwH92W+uRtcu2Z0m8mhl0G2KMUkZ+P4WRk1F0Jgb5aM9uzpEyvsjnzluPJmfe
	9LrPMEtp7dHP7ihcozPsjLaiSg6RkWMU=
X-Received: by 2002:a05:6402:460a:b0:6b1:d961:ec97 with SMTP id
 4fb4d7f45d1cf-6b1d961f8e6mr1347785a12.19.1791830432123; Mon, 12 Oct 2026
 11:40:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Len Brown <lenb@kernel.org>
Date: Mon, 12 Oct 2026 14:40:19 -0400
X-Gmail-Original-Message-ID: <CAJvTdKmxHEXJppqNcBDNv_5E8FZt-faB1Zh4G=L+j=iABc=tRw@mail.gmail.com>
X-Gm-Features: AclHuK8nApLNnn2k9ipQp-9svmB9ZAuqb65n9aRWAtry7Y4nfqKmwHHf3TdWNzM
Message-ID: <CAJvTdKmxHEXJppqNcBDNv_5E8FZt-faB1Zh4G=L+j=iABc=tRw@mail.gmail.com>
Subject: [GIT PULL] turbostat fixes for Linux-7.3-rc7
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull these turbostat-2026.09.28 patches.

thanks!
Len Brown, Intel Open Source Technology Center

The following changes since commit 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e:

  Linux 7.3-rc5 (2026-09-27 13:55:01 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git
tags/turbostat-2026.09.28

for you to fetch changes up to d3eea584b56fecf5c3fba0979f0da28a6600d6a3:

  turbostat 2026.09.28 (2026-10-03 13:02:41 -0400)

----------------------------------------------------------------
turbostat-2026.09.28

Since turbostat-2026.04.21: bug fixes

----------------------------------------------------------------
Ali Ahmet Memis (1):
      tools/power turbostat: Read complete CPU lists

Len Brown (7):
      tools/power turbostat: Warn, but don't Err on out-dated perf systems
      tools/power turbostat: Sanity check GFX%rc6 and SAM%mc6 percentages
      tools/power turbostat: Fix fd_perf leak on reset
      tools/power turbostat: Fix CWF PMT off-by-one
      tools/power turbostat: Fix PMT error path fd handling
      tools/power turbostat: Fix add_counter issue if > 24 counters.
      turbostat 2026.09.28

longlong yan (1):
      tools/power turbostat: add NULL check after calloc()

 tools/power/x86/turbostat/turbostat.c | 86 ++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 32 deletions(-)
