Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFD3AE1A2
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792131376; cv=none; b=BP1xLQjCun8dlxDRXSgqaeEvIqom1VUg4UxyL2UaR3UkAk2Y4cew01FCWfJOxEfcWm2jPR02gWpqZ4ZKMpbPv+e6y1xxS4nqx9nO9p4PcE2yf/Jhloc54zAJ4XG2Bd8ARN3vDQW8uIMXNOPu18/q8rN7VwDUndGNvrJsje3KDP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792131376; c=relaxed/simple;
	bh=u+NClVvtSKTYwQUlLmRXWNDb/Z8AZDnLehe7rC+G6T0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZdI2rLy7qcC+6W8P2hPy+oDXXZ5ZUi6PeWj0xGmYntzWqcz4/c0CtJoQn0NWZb9fs7Q+prztbtnZ5P0C+uDCT1WlMyfBNqZvLO0gQxoFc2XJ/nnOv121SddbarQTyPhl7s4xAesQaZboGHdnU8f++sUZzDzCJL2mi5OhO2BRxwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=V1R/vLFi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V1R/vLFi"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-35943f55c06so876780eec.0
        for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2026 23:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1792131374; x=1792736174; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsXaOyxOPm1NcJY0FwjZGqKTHVdPJFrxFfgG26eRfb8=;
        b=V1R/vLFiUh5puvtJcKpTjJvT0ELIWugc7+cUdclkektg3c3Yk7twCsTYNQvTlAukCh
         S2skLWKdks5ardqY8G66kAk+/a6QDtxJyLlJLrBcMew3y7e85UecTTJxHWAnsYNbgXDV
         fGvOrdQAOU+C8+dte8o9KHbji1Qdw8JgyrAPzNa3koAZR+NL/TKyJb5wAaWy5nYyTJfW
         hMxjT1ewpcL1Blm4GDjC+PcVKBC8IflFcO+5MTYvtqVo1CYEDGbF8FrlMSBL+kit1iRO
         53kyZxx2Qy5y9l2e+amrd5wXq83TblZTXQhDS3ZNC1PIggfyrn9ODWmeMU2ZU5O9Kz/2
         3FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792131374; x=1792736174;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LsXaOyxOPm1NcJY0FwjZGqKTHVdPJFrxFfgG26eRfb8=;
        b=0J8cm9JXLa1alZn49EY+xKjrQZeuyA1dfojx2LcyTj9dWFr+ie8DCdeFbQhBtSX1X6
         nIIWZLAP6T3ZcHCvvv1J0nlxSELuurgzV5Kvb3LgncN+pBqNy6F2tYY6MNhBuhH64zBW
         sTNaeIOt4bWEg3xQsXuVPRiem72MBswK7CrvMeK7Cjcj4IPoNGNLF+im8Mpys0e0sW1j
         reSuNKGAyRs4wWHSyYC1QaHiw7MTHwToGOY7rIejBuJILTFlPXduK6mRXmjcxRaiUxp5
         JmOk91ZtjR/aI5y+bR3LD6gtpUavRUmJ3Ewgjz6tJsvvxpbEJL38vD4k+8Maf8deUeLL
         vcxQ==
X-Gm-Message-State: AFq9FYK85yIoUXZoiAys1LYRW99IKWr0QfkdSCOB15B3sFJnpDDSVm0D
	/ByrVnLi/Tb+ngWcgmSV7uZcMRXBZgvNywS8PGxi9F2er7ZTgB6YHF0DQ69/vsKTy6w=
X-Gm-Gg: AYBFou1WHB7Z2lbYLrxjBMQMbUlTU2bRR17HWWO+wHfZMOZIHAnW00DzP7CK6PfNMX7
	MAJhqItGahSkNcpfAQGK4P1W0UrMsPHFTvHiuwMqkOwLqV0c+f9tpTyJ5IzH7KcKzIDF8M9Dn52
	ZJu3YVBQdaLdjlNwMhlVjYg+dcecmX7kzpa7Moeede2liKUDZbOk0Yq0Sj1PO8ARe8yOWfyv2fg
	m3ltpvpTxiRwUfjk9afULJF0nO7gNdaWyhrqJgSDxmz8QEFe8K88eSU2wnFINw5IctnwjNLk1yo
	j0Uj6aag/ImJQc59KnLJBos6nEXlTZYuptlAIj9ufjt5CmOyYJavNWH6d7g9cFF8XJaPglR5AHK
	5SP/IBfXsOKlBqD/oP+XWrX2UyBSe5+5x+bpOaz86dZz7Vy/bfIbCwYwFVKeoRYy+Ac2Yil1E3h
	SjFRZtue0CTVJHhBciM/PNZXwC6a+6WZAKyI4JwUsDKNGvhlPC3oDh9yGt/S/90Y27hnOMg2ndg
	Q==
X-Received: by 2002:a05:693c:42d2:b0:34b:3f7d:6105 with SMTP id 5a478bee46e88-3602e3a6861mr2578210eec.14.1792131373896;
        Thu, 15 Oct 2026 23:16:13 -0700 (PDT)
Received: from localhost ([122.172.82.240])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-360820a79c7sm3535110eec.18.2026.10.15.23.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 23:16:13 -0700 (PDT)
Date: Fri, 16 Oct 2026 11:46:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] OPP updates 7.4
Message-ID: <atHBKtyNwXb8jK25@vireshk-B250M-D3H>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 1f6de65e3314519ce462bfd3a1d29e918f97e4e5:

  opp: fix use after free in _update_opp_table_clk() (2026-09-09 10:23:05 +0530)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/opp-updates-7.4

for you to fetch changes up to 706081c6b9327dd611dd72b20130a77f0f059b6e:

  OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc (2026-10-01 11:40:49 +0530)

----------------------------------------------------------------
OPP updates for 7.4

- Fix the return value in dev_pm_opp_get_of_node() kernel-doc (Karl Mehltretter).

----------------------------------------------------------------
Karl Mehltretter (1):
      OPP: Fix the return value in dev_pm_opp_get_of_node() kernel-doc

 drivers/opp/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
viresh
