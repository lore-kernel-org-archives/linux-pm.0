Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4E32DC789
	for <linux-pm@vger.kernel.org>; Mon,  6 Apr 2026 11:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775473289; cv=none; b=lXd2sokdjlAO2iVOKen1KxYa+j8OJCtw42bJYT7FjPnQU73lLKowhhe07GkSbbitrOsQ1+lCaup4TvH4nxqqD1PCxFWz6B3oiGYgirI5tsv37u+WWaXb4I7/N/amMrEdR+ysO4x25sv01EVZr2iVvJvR7FMn1v5Vnjr7gl0TOcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775473289; c=relaxed/simple;
	bh=2M2cg0EH3aMng+aBU0Rrs9UT5yeB4nWoOPww1b7rrbE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CaxKIu8mysnVmPid9qcDrMjph/AqxObBBnT/6dXqTaGnvsxqiycKpuTnXvib1aLRMOs66SFwHt1cAZ9NTYoJ6guDN2lanw8Hq8HGFhnCTkMlxwKp+DY/TVKa4GTukA118NVad14XXeaxD/q+2OlD2xzssgqGgNKluw4WgnLG+8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y0alqhnt; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y0alqhnt"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c70f91776fcso1428898a12.0
        for <linux-pm@vger.kernel.org>; Mon, 06 Apr 2026 04:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1775473288; x=1776078088; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v7KP9ImoUmNOJElPjjxO5LiEgKEfV2sq1fEI8IanqHo=;
        b=Y0alqhntPu/ZBUfGl1eXDKgmVv6XOmy2e7MUZZp7BImLRBQZqO443Tds3m2KhExQdg
         6PVZKBtr6I/j30KIn2QSMxeN5Q25s/0e6RBe2n3PTTQcz5jIDrgIKYeXwXvTxEyik99Q
         j7cWp2r8pZOQLwWgOSvOXopprzqoX0MNzeYc6S9y4+FZ7oVTBKbhmE9exdkmFj/f4VeR
         2lLah8HNUE2/6Xa2IgIw+2jGqBx1pNeTUu471kTepcXlUI5yCgUnFnHhqZObHPSvl/PL
         mKXjdpGlDutp5IRgw8VifmBhnXuYcHksJ99P5ZYk7+sett+mvXWoN7/PYgq/o+9I8wAA
         o5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775473288; x=1776078088;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v7KP9ImoUmNOJElPjjxO5LiEgKEfV2sq1fEI8IanqHo=;
        b=aVZZo9HK4P4OGdt454+q7ekWedciCaGNWT7IITK0XGoJIfPETWD116zT8WFC9Whc4D
         DvD5Cs5s9phpw94fXYsj7WqhAkZBWCzHe7ZA3+3m4hm+HKmviB1nTC/+HvTul+di/kJD
         omIdwUjFcFRaKNQ6vhaqCUJe40j/N8Tsi1R79HPakAFmYs5q6fBiEJhve9xtiSZTh4Lv
         J84riUSuUrrrSypwe3+VpvaSL/n+aGxm07Eg54iwFVyEPuq6di+1dCUmJ2CxxeR8KOzb
         uyJQS4RnwnL76Q0E2KSPzc2Bv518SqLXjMm9V4A3SawEC94ABb3nyXn85cEDExuWQWXw
         ZbGQ==
X-Gm-Message-State: AOJu0YxnBDrbYXJjrB/HMKAdQcgWJ5NUbsBhFx3gd32RhBvn9E0VNfVC
	A7iXx6aLww592Mbe9JcN+KTPTWcF8pDhLGRsVq348hm4n2IFUBY4CoA/dxEq28o6HFY=
X-Gm-Gg: AeBDies/nldaKTfWRvl2Iw8QyFLARSmQdQGqRe9N8xOsxdPt67suffhi/CN7/S/KXYz
	BX7lJ2eGkdhl98fs/dCIfElHnkq1vZRojB2QWeGFbOUUWxT7C6v6i9RlT2LJS8hRugE6uOTeB+p
	CRp+1JVch6PMVYL+jwXC4REqq/FhrpVOph119OTqHO8Hq7scMrdUcTl/byNyRtHlB6kLziDs6b4
	pquITStKpqwS7LHthqxiSuvKGZ9g8L/X2Bum/X10/uPPovDSWNjhbf3CSD4qAzgmege2VpbkqZq
	/r5dpOt4dwB01MygLbarii49LWW47MXIm3QMEmFGpUQWPLsEx/8Dmvh2OJ/pL+Xz747U6tWz05T
	x9hjIvl1zqSRnJnQe+Bv/SL7lOt+2F6bYIOxTBV4yHt9JzfkfjmnNKNA+vaCtTpbh+gtn/32pSM
	MwAZBLjxB+jtCARjsPG0JfGgPa
X-Received: by 2002:a17:903:2f08:b0:2b0:6365:21a9 with SMTP id d9443c01a7336-2b281789ec2mr132192585ad.31.1775473287290;
        Mon, 06 Apr 2026 04:01:27 -0700 (PDT)
Received: from localhost ([122.172.81.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2749cbd85sm133034655ad.74.2026.04.06.04.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 04:01:26 -0700 (PDT)
Date: Mon, 6 Apr 2026 16:31:24 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 7.1
Message-ID: <a4lvsuklad2ab3tynq34oiuu36rn53fkf6ert7al2tuvgyjziw@wkiqji6svbdj>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.1-rc1

for you to fetch changes up to 8655a4e35cda5534f93303af393eac4e71704701:

  cpufreq: tegra194: remove COMPILE_TEST (2026-03-20 11:03:33 +0530)

----------------------------------------------------------------
CPUFreq arm updates for 7.1

- Update qcom-hw DT bindings to include Eliza hardware (Abel Vesa).

- Update cpufreq-dt-platdev blocklist (Faruque Ansari).

- Minor updates to driver and dt-bindings for Tegra (Thierry Reding and Rosen Penev).

- Add MAINTAINERS entry for CPPC driver (Viresh Kumar).

----------------------------------------------------------------
Abel Vesa (1):
      dt-bindings: cpufreq: qcom-hw: document Eliza cpufreq hardware

Faruque Ansari (1):
      cpufreq: Add QCS8300 to cpufreq-dt-platdev blocklist

Rosen Penev (1):
      cpufreq: tegra194: remove COMPILE_TEST

Thierry Reding (2):
      dt-bindings: arm: nvidia: Document the Tegra238 CCPLEX cluster
      cpufreq: tegra194: Rename Tegra239 to Tegra238

Viresh Kumar (1):
      cpufreq: Add MAINTAINERS entry for CPPC driver

 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml |  1 +
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml               |  1 +
 MAINTAINERS                                                                  | 23 +++++++++++++++++------
 drivers/cpufreq/Kconfig.arm                                                  |  2 +-
 drivers/cpufreq/cpufreq-dt-platdev.c                                         |  1 +
 drivers/cpufreq/tegra194-cpufreq.c                                           |  4 ++--
 6 files changed, 23 insertions(+), 9 deletions(-)

-- 
viresh
