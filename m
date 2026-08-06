Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F903876A7
	for <linux-pm@vger.kernel.org>; Thu,  6 Aug 2026 06:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785998499; cv=none; b=szBywYtSYdrGcKixDHL2BA6UHxrQ4gUyvPAQPKu2j+wkB7OPIEEI7ZoxqbF7ATY2uyn01YHA3f6I5Ic9Qtn8goDrETzjvBacukxoCbo15xMx2lGtu3a3FD2KXpjpRjNwdix7QbTaDqpikymJwwOn82oPQjinfwAMadEyEUMQIx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785998499; c=relaxed/simple;
	bh=jT/b65AheROeycVvzzXHPx0QumPN1qfWe3p2JB8pfHU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IQ/BGYYMYo48bQLr1w4tWzBAAAcaM9HHzR2/u7HD7GUpKS15gZT5f9pkrtxsyaI0yXo8NZ+kxMDqw9nDICXxRThyhi8GnGREtVV8rwAe0oGDOH9S+1goSqNXLoxgrtUEQPVUYMsOhb6Fwxy8qHkwYflgtbnPcfQ4hQ7ew2IL4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtAGLNyw; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtAGLNyw"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-ca97d139d8dso1216777a12.2
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 23:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1785998498; x=1786603298; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6cR4ttVz7/mybJUP8a33vEkGCZOo/mIBMLrRSStJEls=;
        b=xtAGLNywYweigdlAnHGFw3nLo2L6L9o38RV38Nq0V0d1gOWuIbJbTbPJ+sxy6zxfdk
         JES0K4axkAZeRfsU9TvNx8ca+RDNdXbOjJG8WATr+ce4Rb7BwW4xYlAvbXibPlMepxff
         TDA+OwGczzaBhy2pub1Rwqz8hvq0aFaaH/geobNRvtUON0ImeLJi+yJcn8HwL68sBbpW
         1JwY13gvcjX65mEWkMGZAjjvLdF/fQVqXdjdPL/BTWyzs066AJoykvzt7D1nLK/6+igX
         CzAv66HMhaWh+QttkHsyVcZOAKLLO8cIWaRXnxvZ01pKamCxCFDKsI/NZStsZ/PNWjhW
         ivaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785998498; x=1786603298;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6cR4ttVz7/mybJUP8a33vEkGCZOo/mIBMLrRSStJEls=;
        b=l05JlrlMkOUOFIPu1VagcIRGZQUMi5gJ0bsyDY3iH6s3tWzcRbxldXzA7K+OfWb+tY
         mHnGI+1jes84xWkWLBl+pksH77moorbWkOXYV4/eSvdQxqrxr+Im/+5TuR5x5/siEO9P
         vC3npwGrgN1KtFa2wqpBKsGqBmrzPZtb/Wgg357aMmJqsLB/7zARpIjlaE92JIXxrkYL
         LuuC8lLHi1IbKwVFV4s95YR5gEygBNrPNi9Xlanp2mBrNVFdJ2Q2SfA3MQCSxRatSbJV
         LH2QWnD2HVm+Eq0wP2mrRjie6o+5m4frkQKr9Ha3zPYRc4oWXueLki65A0mKpUS56OWq
         8d2Q==
X-Gm-Message-State: AOJu0Yxe8A7uqGo/j/R2ErRuv5d1yf4CKsuvppEzOF4TYFXg5GM2dT+k
	xdL4sWEp+4FpGJx1ZIayVqd1OyOgJoKlkMGkE3Ar3j3ofUMY5tyfmozKQ6aDDuKr/6o=
X-Gm-Gg: AR+sD10dmkRfkW8lLm749hERqp4oLpIPKXeMnrsEe498w1HVQx4Y++Gu7CAJnXHLPVO
	UmwG2jjeGhqygIhevoCmhmvwYrenNX7dsNNOaoDkOwyySoh9j+CdW5SLeMyK6SrlQbVm60TLb4T
	z09QEP9vEFdFBLkxT9LaZphd1VCTRVRPwivwN1ll5TemTkDc6cKB6CyPwDcJXf8GWOmPIklJfRr
	3UreeLLiuGbV3FRUr5DLJM4zPkodm29lD5arQnu3sM/11953D9UhyvpOeOO3jcxnbclY9nCFM4M
	SongWwj9hSocScPoSYFYI+kop1VjqLGZyizoWVDPaP7t7OHo7xJIMEXvC46uHAQ+UBmvr8CwpwU
	pjVw2CDAmrAjV3owYUAA3RU5oMY/izEiJAr1qoSnN5zKRzUSfbyyRddBbbtU8fBOAPaf68YyLoc
	D+Yj8rW+Wj8r9iz2gSuZ3LNoPlMMinavMI4rvy8XkWrZSBO7Z+Bd/EJPw5Shg+
X-Received: by 2002:a05:6a21:3181:b0:3c3:6544:6083 with SMTP id adf61e73a8af0-3cb85bdca07mr15754207637.0.1785998497793;
        Wed, 05 Aug 2026 23:41:37 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315ae6c1fd4sm1500620eec.14.2026.08.05.23.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 23:41:36 -0700 (PDT)
Date: Thu, 6 Aug 2026 12:11:34 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 7.3
Message-ID: <ji5tgqbqadfypamzmr26pizz6f6mrvr75wndg5nd7exa52vm7u@eksikcoeenpj>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.3

for you to fetch changes up to 8c3afcf27fa4582c1ab912503dc8a4ebb8dc0f82:

  cpufreq: imx6q: fix out-of-bounds write when probed more than once (2026-08-06 11:54:41 +0530)

----------------------------------------------------------------
CPUFreq arm updates for 7.3

- Minor fixes / cleanups in cpufreq drivers (Dan Carpenter, Guru Das
  Srinagesh, Haoxiang Li, Karl Mehltretter, Sasha Finkelstein, and Pan
  Chuang).

- Fix cpufreq table creation and bios_limits() callback in the Rust
  bindings (Priya Bala Govindasamy).

- Add IPQ5210 support to qcom-nvmem driver (Varadarajan Narayanan).

----------------------------------------------------------------
Dan Carpenter (1):
      cpufreq: spear: Fix an IS_ERR() vs NULL bug in spear1340_set_cpu_rate()

Guru Das Srinagesh (1):
      rust: rcpufreq_dt: use vertical import style

Haoxiang Li (1):
      cpufreq: apple-soc: Fix OPP table cleanup

Karl Mehltretter (2):
      cpufreq: imx6q: fix devres accumulation across driver rebind
      cpufreq: imx6q: fix out-of-bounds write when probed more than once

Pan Chuang (1):
      cpufreq: brcmstb-avs: Remove redundant dev_err()

Priya Bala Govindasamy (2):
      rust: cpufreq: Add CPUFREQ_TABLE_END as last table entry in TableBuilder::to_table
      rust: cpufreq: Fix temporary write in Registration::bios_limit_callback

Sasha Finkelstein (1):
      cpufreq: apple-soc: Calculate frequency as a 64-bit value

Varadarajan Narayanan (1):
      cpufreq: qcom-nvmem: Add IPQ5210 support

 drivers/cpufreq/apple-soc-cpufreq.c   | 38 +++++++++++++++-----------------------
 drivers/cpufreq/brcmstb-avs-cpufreq.c |  5 +----
 drivers/cpufreq/cpufreq-dt-platdev.c  |  1 +
 drivers/cpufreq/imx6q-cpufreq.c       |  6 ++++--
 drivers/cpufreq/qcom-cpufreq-nvmem.c  |  8 ++++++++
 drivers/cpufreq/rcpufreq_dt.rs        | 13 ++++++++++---
 drivers/cpufreq/spear-cpufreq.c       |  4 ++--
 rust/kernel/cpufreq.rs                | 24 +++++++++++++++++-------
 8 files changed, 58 insertions(+), 41 deletions(-)

-- 
viresh
