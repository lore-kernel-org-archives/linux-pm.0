Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1273DEFF1
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998462; cv=none; b=tDF3Rx8EVUmGd/EdcX+l8KoK71soMh4OZhJYzKW6n4rtcnwuMerDcrYnrdOQbNxy9KjXwnfGzD+ZpmWluGtwQSxQqUGBzPPo9A1ZLADn5dEUd1PdWnjv0JUQOxVFrXX4nCYo+sN+9Kph7DVM5wBJAbnBS5h0zXjoT+ipE8TL7I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998462; c=relaxed/simple;
	bh=+ieNpYftwP3fdQx/oqU0wgv6bnj24ofZj0CnjsRIfWg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=LiBrJ9x1wGPnDNe+okgc0c+Jj67S3vvAhigJuDW71N4PIusBmOuLiAK3YmHmoSRBPWnoVCz7yr/ceztfRIdYm+YZ04VB7/+na8Ac4guTpar0jV8BEGoKdiOhW0oZeigBIBmiO1XZve7T98B29jgV6kDoOOi9QdXLs4ezFhxz4GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LdEXHVGH; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LdEXHVGH"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cf452def93so4810215ad.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785998460; x=1786603260; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KrtVVdnJpRkxCHWS+gT4fEPtiIBwhvi3D3PiEK4HKg=;
        b=LdEXHVGHPQYlgkcyJkYStAR8QF8K9J99lmJFJ8jvWWCRv2QlZWs53NlyAhfLcoOmVE
         EwNkSwfgW0tQNG4Bq9+qmJuajY3e19LUYcOFY7nz8CMIWv0PPsTMZxCh64VlLyEupiyW
         C/hgRU74tVPaw7NGpKhV01LoZhMLJuUKNNJzzkOXbCiqXMKZdgyY8D38BOuj2imEKJzB
         KaMPx4tFtqs5LA9CNtRQF7QFNUO0rn1jEuGL7Yn/09uyg1cQISbxWNUmIzqFj9+oiWtL
         7bPv0IUMmv5ftC2B0FRgQYFzqIi7qgJqpqVvHuA+Sp2TatTfg7JEtVtO63BT9FBGCSKP
         HxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998460; x=1786603260;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4KrtVVdnJpRkxCHWS+gT4fEPtiIBwhvi3D3PiEK4HKg=;
        b=J+XrluA0PDImQygVsHOi3eXNlLQ+M4rWA6Z6191fIYfNYtpAW5wKBSAZO4cBdkCDfT
         qBHgkdhs3VIaHUMg0+4+HCMmYhw6Dow15iW+Wp+0iKxKbCOOJq/ib02Hy6rqcrxrxpqP
         OnVwExiTbCQjfPdt+8Kfz8kBHZlCUyPYSeEg1PIFR716xzVxpGqJ2Ys/ZM73uMIqwYC3
         F4qrRx03prYdfueBbK/dV2ZY0htcUg0duCzliwrthyDhu017KSfivJTANtVWqKakd8rI
         KsKXAiXr660MyahmYc1C5b+wimfU+QztQ2+LmnhUSHK3AXVGC7HEuWI0L0s8dCCmuq8O
         4UCg==
X-Gm-Message-State: AOJu0YyLT/NSoqxl5t/n31g9MQifANkN9oIAiubB4cg9NWnYcso4VrYL
	70dP6xuAiNxH+J17BYf/DHwRyIGMQWS6kqtOKbIjQRhrlFdv/p6uMzL81xGX7RQAr50=
X-Gm-Gg: AR+sD11HRbS5ooZhPRQliZSlBQxx4HLEZjG+9BmyXbAOxhfSf+HCesDschs+t0LT19g
	ajfsE9fE8qnJHeDxGnZBeOMqsU0PRityh5f+Y9LeVOLYri/BGPMtqAZIzllGSk8ltZr4ofZGaky
	ZK8OvlQC/1F+01W0MaqUgfQbZGKy6R50XdfO9zZ2+9pF+zEul1BdRZk2bd7sznwUIcThu3pnwRi
	Yq5VsGkWCQA43Kveiu1MSXHFaLWM3JKx/cb0pOAaMcbPw6uyTMtis79HtuHRb77LF2XNkkDV+x1
	j91TKoNY/tcllomoKf5EQ+1h27VR/BqPbfYsKqa6oLbdRqbxe92fMZzezD6K7ADMybfBFwwVsox
	6cHGNP1SfCWOOevtFojf2T+ksVhzXKAbnYs2MDCx8WUeaIrXNftpZXRMizdSkdj3b37sgciF8Uj
	JDxhzHUEM+Ns/nadi/Ps1+8LrC8ZHYsBjhb4S0l7nwh0sZXZ6MnWrV7JLFMYQq
X-Received: by 2002:a17:903:1845:b0:2bd:2c3a:2a36 with SMTP id d9443c01a7336-2d0f121ed8amr61613285ad.0.1785998460302;
        Wed, 05 Aug 2026 23:41:00 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be4dsm30695841eec.16.2026.08.05.23.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:40:59 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:10:56 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.3
Message-ID: <id2g5cfhmuiy7mkf5vlfkefkh35miye2qdsgnivbkecera4wur@y33swy7czaua>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit dc59e4fea9d83f03bad6bddf3fa2e52491777482:

  Linux 7.2-rc1 (2026-06-28 12:01:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.3

for you to fetch changes up to 84f05af0975c9f9c8ffee0361d6f7cbb1f289231:

  opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer (2026-08-06 11:54:14 +0530)

----------------------------------------------------------------
OPP updates for 7.3

- Fix cleanup ordering around scope-based pointers (Gregor Herburger).

- Use clk_get_optional() for optional clocks (Praveen Talari).

----------------------------------------------------------------
Gregor Herburger (1):
      OPP: Fix cleanup ordering

Praveen Talari (1):
      opp: Use clk_get_optional() to avoid leaving opp_table->clk as an error pointer

 drivers/opp/core.c | 67 +++++++++++++++++++++++++++++--------------------------------------
 1 file changed, 29 insertions(+), 38 deletions(-)

-- 
viresh
