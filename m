Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC0935836A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780898296; cv=none; b=kyjHBBgwhBStWRy2kVkL6x9ZZvUahOmFD1/KKQ8AYQp6nkfk/d7gnqKn+OUWjTl5dFsI1TyToF78y4pYhvzH0OgGd5zicud/+oISF8+4lu8tibPw2JcFf+8PDZIvljHatT1QII5HdXr8TLFwfHJwBTcDVHxk2H2UPOHBxvpRNWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780898296; c=relaxed/simple;
	bh=IvF38aC7nyidh+MU3oCGQQci1zHyra/ISRvvn1AE09I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Gt/AyBLRlUxZssPZ+1tLi+NF+pdHHyNfJzvIU7Di0rOba20MAKmlV8Fl/yhJkxhjqkmQthvJScd/a5mkKEpIc7PTVLcYygDJtuoLKsJQOxhuRsc77F/ncfmIMN0bbfV+Av9NlOH4wcWG/MOCUEcBS01bI43qdOyPTF42GJfsnPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TqXi1W1b; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TqXi1W1b"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b95eb4bb4so2434015a91.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1780898294; x=1781503094; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eomF6cbxmWnjErp1NB+2/KYVzLr07lbZGEt1QVQj2jQ=;
        b=TqXi1W1bpWBYZBoALkYMqvMyWtiHqlAILc1/jewxZEXqlTbKXaKrIb2Psz7JODrysd
         H4/I0DNtzzui8q3MJxcOv9CFe8WFH4YlFQv1RDHwv+0u/vQ13NDzdJSUr9+KGBGZMXoO
         2TcECoubAGkvKrd/kX1xY1iH5j13Lwtt3B3lugeEhzovSxtEuumbUqNQRv9OWQi28lmm
         HseyC09MYTQaEcryRIJHaGeId1I7BTBPlqLE8r3oOhdMAH3usHYRZrJZ7L3gMOKo++fF
         LB3ETBlpjlHiNFzyP7vlCA6sBmcsOKJzQYtYmUilBs06yWrxwgPbBfD21JxZ3WTz6ucS
         whgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780898294; x=1781503094;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eomF6cbxmWnjErp1NB+2/KYVzLr07lbZGEt1QVQj2jQ=;
        b=S6ujdyjkTomJ2NKHUpVy5jDkjINegAqVfqk0MFUZshNNKsenX6eLiDkDLtHTJXxGye
         23OCDzoBfDdalB1Yw22vRxxVvGNanI90YDeL5haLPBbGME7Jxi5TWle6Dt7vMIyktXd0
         x3b0VryYqDikYYwSNWvI241DjAnSqkt73qne15nDy/Zx1B48k6R8LdQp07uLTKkt1AX8
         ZNY2yaIOJczdYlLm0dSMx5Y4HsewFAfVnM+fvzMcKpa6+kvrAtZoJ9dqyIpM+0UYfMu4
         zY+/lO11M1J3UapRBCA3Dne4LyclQILr0VVlpORoE/ODHYjMNj+kZMhjlqJ2GQQ4499X
         yE+A==
X-Gm-Message-State: AOJu0YzFIjFJI82JwqBbgbthp/yC2g4rMadkp6QoGHdGOvb7DgVAVDkT
	ctb6Iz6cuqmfJiHUhBiYASyFhIrgymTAbocubJqyIKgPzxv1lWsXDbk2DE2Es89IFxU=
X-Gm-Gg: Acq92OF6mpLsDe6rHnXWtzBOfn9D+2oz9AXItUPt7Rzsbs4BitxfwXDciI94/v32mJj
	JeuSXxX3oW9pYda1MZEiTWFcbYCsKWoPs165BZc4PtNnaLJj6CMWhbXcAtlIieNdwC13Nj2Fsvg
	b5On/lpTcCHi+0bCU/4ogNBqvZ8YNxsEEtqon4sBbXT0NuQg076Yra8+BLK9tfLNQdXSwKRKClJ
	gD39PIocd26K+C7/4IAZwaLByMYv76Q0eJyvQy0I78BxPltRan6YBEQliPwl2da//hpAeDXInJT
	qLtOUhQYVPF/J89bBlrYBKQFumtXdWpxpgRudXW7dxohk3tyjZpasspm5DPN/xz1KkKi64wPeOG
	v6icEXmsA79cCJnyE6glEVNn5R+dkF52rLHfbpXRd6aYPetaZK/kBIkDD64I7+pa5q6XqZxhamX
	JIGDT7okZSxq2sJLsW5hlNv7CohhMVcfBv0MNeD4IUOr+K
X-Received: by 2002:a17:90b:5906:b0:36b:ba9b:7efb with SMTP id 98e67ed59e1d1-370ee33d318mr14897283a91.5.1780898293871;
        Sun, 07 Jun 2026 22:58:13 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf90a32sm17396280a91.1.2026.06.07.22.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:58:13 -0700 (PDT)
Date: Mon, 8 Jun 2026 11:28:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm updates for 7.2
Message-ID: <bzbh6b62uekudzc6zqyiezhbeke4g6b5hde35yr5hsgyhsn33u@k6t254axv6l3>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

The following changes since commit 254f49634ee16a731174d2ae34bc50bd5f45e731:

  Linux 7.1-rc1 (2026-04-26 14:19:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-updates-7.2

for you to fetch changes up to b7a76f38ef3500d53ec87489c445fec8100c7a6b:

  cpufreq: ti: Add EPROBE_DEFER for K3 SoCs (2026-06-08 11:16:42 +0530)

----------------------------------------------------------------
CPUFreq arm updates for 7.2

- Add cpufreq scaling support for Qualcomm Shikra SoC (Taniya Das, and
  Imran Shaik).

- Minor fixes for cpufreq drivers (Krzysztof Kozlowski, Akashdeep Kaur,
  Hans Zhang, Guangshuo Li, and Xueqin Luo).

----------------------------------------------------------------
Akashdeep Kaur (1):
      cpufreq: ti: Add EPROBE_DEFER for K3 SoCs

Guangshuo Li (1):
      cpufreq: qcom-cpufreq-hw: Fix possible double free

Hans Zhang (2):
      cpufreq/amd-pstate: Use FIELD_MODIFY()
      cpufreq: apple-soc: Use FIELD_MODIFY()

Imran Shaik (1):
      dt-bindings: cpufreq: Document Qualcomm Shikra SoC EPSS

Krzysztof Kozlowski (1):
      cpufreq: qcom: Unify user-visible "Qualcomm" name

Taniya Das (1):
      cpufreq: qcom: Add cpufreq scaling support for Qualcomm Shikra SoC

Xueqin Luo (1):
      cpufreq: cppc: mask Desired_Excursion when autonomous selection is enabled

 Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml | 96 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                                     |  2 +-
 drivers/cpufreq/amd-pstate.c                                    | 26 ++++++++++----------------
 drivers/cpufreq/apple-soc-cpufreq.c                             |  6 ++----
 drivers/cpufreq/cppc_cpufreq.c                                  | 29 ++++++++++++++++++++++++++++-
 drivers/cpufreq/qcom-cpufreq-hw.c                               | 24 ++++++++++++++++++++----
 drivers/cpufreq/ti-cpufreq.c                                    | 10 ++++++++++
 7 files changed, 167 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom,shikra-epss.yaml

-- 
viresh
