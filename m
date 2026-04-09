Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A960E3CF699
	for <linux-pm@vger.kernel.org>; Thu,  9 Apr 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747394; cv=none; b=tJ3m46/94jrsJ2ppv38GR/pVzy0yhZQdkmpS0i1gDrIPLlhcWr/ut30KhMLyE8qaV92gnxKrxgLTrQ/v51oIVjPF0D/uSDwityh8Z2Nyi6eT5sl7JnhYxLGfGQM1Pq1rRQoNi+APnrM/69AH15McajHMAh+rAt2QCfhxFGmMorA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747394; c=relaxed/simple;
	bh=WDevnGZ+9DOywOwRj2Ruq15Fv6McW6pPyLzt64lg8/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uTd0qb1fJ3o/wi2plOFYNT6LdSAhvVKedohFFA6BSz/O+EmipyAr4aWV0bCTnMPQ69ukLQVRYgpGf6p4T1iLaBEOpP2FWHGfRYowM1mcfZcU6cv6fChg8OCkh+Nfq11FOV8RRfNKCSgdgsjcOaPO7i1DxnUcQ5jCGjW8bXwN0Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uhHAKgtT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uhHAKgtT"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so911884e87.2
        for <linux-pm@vger.kernel.org>; Thu, 09 Apr 2026 08:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775747392; x=1776352192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+HP2NPOCwSfxfjXKB1IjPCNrMct9KR3awrP+o31EZQ=;
        b=uhHAKgtTjYwMCIMxVBbOcWgtApLIDSIrpJtvsePfMxSzKxTU99j7W6mUF+8ajvoveS
         mBKGlQv45iv0KuA72f1pLWhtAlVyRMYeim6VcBH6KfTTlRvef4UdnzflsZzE3UI3P/TG
         ELBFo7RiKuC4NLUIdJqQtLFq1NxfDjv3e6XMJK+rWcrdwGUDarcp1nVtIq5Uhz+IOBgN
         /RwO/HEl8yGBOm36vv2lmxRUpRyY9vG02lI9ja+LcdvKTB5xFQ9jRBDiWqQ4ekF9wZxi
         qpYJvwtN1xTLWXcMmsMbZ4r0/6V3xWOrSgFqNfWXBuSDmuQznUEixE7vPXbLVwDnkzZz
         x7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775747392; x=1776352192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+HP2NPOCwSfxfjXKB1IjPCNrMct9KR3awrP+o31EZQ=;
        b=p2/N6GUO+5Mvsd5EzdPP2wUfCcgA5k96euzKE2EeWRrDN/uRWipFjju7fW8l9KKgOE
         uGyWNIr4Vz3h41+a01IGzhKqJWDBsindqeFLoKAqNFeCqNp3MP64CfiauGnG8IlxMaoa
         g4SbthglRt/cjNkwbmf/O70ToW4p1/Vc3R+lgjcm2XjED5c3/rbQHX2Zc0mra/W8/fX5
         Ec0XFGca1y5XkbW37udvurQ1AhSYWw2HXxolhw4UepasJYSvRELCa2a82RKruZqwh1vF
         1mhhDVkxw0PlFY8ZccCoIcPs5IpMyiagoC+JrlgNa3EHG41WBsgTr3IlTOcp5Bkoz/9o
         wFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjQA0LdZIOYB6asvkpYgAg1m6k1TjVsZRBLiUKv2LCsej862HhMN/nbJbk92Dix2d7t1AuY7FDpg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEV5Pag5I3nYJhSM9ynk3maO4XkhOQtm/IW90TcslBPPuQRUf4
	6MmjfvcCTCRO99ZA/gcxHvUoSUL+pfe9ye7iDsJhyut0YnKzDq7X+9/Kh0MNpD2e1N7ZYkFL8Wp
	89BE4
X-Gm-Gg: AeBDietM5ttwh8fk6sA2rKaE2I85NjEtDeqTJRqM8vhFBjN33BiylfXM/jcqaUrNeNR
	gCNhk6kTVn6y7jWxgqvCsAAuc+c4lWWnHoz5Bu1Y2gHvUXEQJ8oWH9HqBKo1R+Ri+wQwo0nCDuW
	vzy5h7iglg1cNWAGTnm5VmXwq6CP9t4Lipo80J9y9gQwfeE6YD0sNxRcutr+9I0cKiqTrgsgeXG
	RUZkFTloMiSTAujLj8R0vsc12zq1QTzogY/GK2MnFJ79fwIa1CI7LU+o71h19p757qWT7hVwyZW
	QEmP1Url7tjyySr++B0ks5assgfRTPe3u7Y/CKQeXIKlqwWh2HHI5aC0oJsSIwI79nLVEgeCA9N
	n5lCkEGDAPJFKlOuQqXzH36ocVgUojp+RoNDS7+t6z+mgMrsEvkCs044jHLn5JGGNSFEWBoFoTK
	sS1ss2UBzkt0D0XN2RnyUJ4XOpRu8/OqIVOjHtqLXosUFTGQfWT4IFe/IOFXxXGkex4pF3YaxU
X-Received: by 2002:a05:6512:1283:b0:5a2:7c1c:74a with SMTP id 2adb3069b0e04-5a3375847e9mr9439536e87.29.1775747391581;
        Thu, 09 Apr 2026 08:09:51 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a2c6c95288sm5643977e87.14.2026.04.09.08.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 08:09:51 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Linus <torvalds@linux-foundation.org>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [GIT PULL] pmdomain fixes for v7.0-rc8
Date: Thu,  9 Apr 2026 17:09:50 +0200
Message-ID: <20260409150950.28527-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

Here's a pull-request with a couple of pmdomain/firmware fixes intended for
v7.0-rc8. I have also included a patch to update my email in MAINTAINERS and
mailmap. Details about the highlights are as usual found in the signed tag.

Please pull this in!

Kind regards
Ulf Hansson


The following changes since commit 7aaa8047eafd0bd628065b15757d9b48c5f9c07d:

  Linux 7.0-rc6 (2026-03-29 15:40:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git tags/pmdomain-v7.0-rc6

for you to fetch changes up to c2812c0cb909211a1d2e7cec862406e32833b9de:

  MAINTAINERS, mailmap: Change Ulf Hansson's email (2026-04-07 14:17:48 +0200)

----------------------------------------------------------------
pmdomain providers:
 - imx: Prevent hang at power down for imx8mp-blk-ctrl

firmware:
 - thead: Fix buffer overflow for TH1520 AON driver

MAINTAINERS, mailmap:
 - Change Ulf Hansson's email

----------------------------------------------------------------
Jacky Bai (1):
      pmdomain: imx8mp-blk-ctrl: Keep the NOC_HDCP clock enabled

Michal Wilczynski (1):
      firmware: thead: Fix buffer overflow and use standard endian macros

Ulf Hansson (1):
      MAINTAINERS, mailmap: Change Ulf Hansson's email

 .mailmap                                        |  2 +
 MAINTAINERS                                     | 14 ++---
 drivers/firmware/thead,th1520-aon.c             |  7 +--
 drivers/pmdomain/imx/imx8mp-blk-ctrl.c          |  8 +--
 include/linux/firmware/thead/thead,th1520-aon.h | 74 -------------------------
 5 files changed, 13 insertions(+), 92 deletions(-)
