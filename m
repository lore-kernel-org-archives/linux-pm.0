Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AC2DB7B8
	for <linux-pm@vger.kernel.org>; Tue, 27 Jan 2026 05:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769493450; cv=none; b=J22vgZBI3fG6+3RuxvJSEU0xYXS3im8IcbTGawt8+H41CwZ8SFngS7dnfxfdrJy17joIykW8UiR3Q1Pj6T5TlxwqJqot04KvdRakMgM4kICy7FQwcTC4xHvfkBXILbfRCAYPtzL6P6SXuFG0k7xjcmKAPD3TockAL5yBLHhqNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769493450; c=relaxed/simple;
	bh=XPvG3+7byBwsjoBOpXDDqwgH+jtY628GE61tjz52YLU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DnZrDHb3TNXl70FZotwMR7inz0YibBFTgT5/tf1WYWNqilXsvftEFJ4z8/UUCzaRpDH8oREpNbPvweUPkOeqKF5OWvLhVs8KxVvR8bphbSnqsSxqzis1UtaR8T6sn3fyIRIEhzu2KyKmwTmo+Sjadi2mVox/Q5D+ZqRtx1Nlp/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nK8BshzU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nK8BshzU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3530f597ea3so2359780a91.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Jan 2026 21:57:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769493449; x=1770098249; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhFLcT/RM7twPJRiwgEXRp6cSRq0YTknnubGG9Zs3dw=;
        b=nK8BshzUAM75TPBtWHM2b+ak7a+y0AXPWetcBrFwvZaql3+RHDoCd0w4Q3g91MRVYd
         fsqGWjEdmmx8O+EioMr7TjZX3O3XjoRg+SSbcASKK26frTv1XGkNWhe9UjDD/CNlbxpU
         xgrPgW7y+FL8T7GEVty/0rhN22CDBnaE8A5sswIQPk4iPFSh3mEeDpmIYyKQFuj6vQp5
         iuGxCeFIIk05dHUk+BtZbN2k8ebwzcqPQMelyD1Qcr+XX14+DSjTAXPXWDscnEsk8B3f
         XFwRyKcOU2fPvhww7WoaV+TAcW85epjBpxmivkxVDf9UNDxpVeToBWbPBxYKOOLxHTSV
         6lww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769493449; x=1770098249;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UhFLcT/RM7twPJRiwgEXRp6cSRq0YTknnubGG9Zs3dw=;
        b=P69RXy5VHcrPqEK+6Ftev2I0tvOSfsK3y6xakvBqyJL+e/QQI4epFKXbbeiSimCVSY
         Wbakc9XyyTG0FGDj4JS2yl4mIJHr80Md+/+UfS65HsuOaTBe2zgx539WwR2kVRX9l3cP
         N9OpcVkfmy6bSz2ThCFOVbOQgKavIcaljv2kmbauW+hP2cBuToXmnDD7DNk5m7soYM40
         1Y9aLogkD+rCvahST8VE1osIQhDGhP2TXcop2RAizVnnG6KYUASFLZgbaJLG4U1VH9R/
         6b81Nm7UpqupKI7+tusmsoqSVsrcnTzxfgfsa/bYd1zMksdsvY+cTwpy+x1Xgsvz+GUI
         PUeA==
X-Gm-Message-State: AOJu0YywhOdMyLZLIZPkIJoiczLMWf2yhsK1BMhJkrbd82ErMZ15q4/j
	/vTDUxOOIdTvb+LNWxKsZoBQ4W7mjAlc82lhGeKT75dITZiq4Z/8H86Roq0GmVimphCb2F3Fhus
	a9tzQ
X-Gm-Gg: AZuq6aL8gDtHI6JALcrc6XZuOig27EUiXQM01HvZZRucG+89rtt+3BLAJRbXvsaY+HB
	fsoTAPOfhcTUx4tbr5kO+TqXyOpJdlVcd+kIAcPA0IOeG24kGWJNoY5Max80eLi/UViKH6L8u63
	YpsE+Q+9VBV+PAwOyPT4TyVtnwOpR+ggbaEcT0rPo3u1+UjTln2AM8oj7jtSv5z0eqbALVtXnPi
	yAetKTwHJkP12oNnViWN3fALpE88GEyi0rVbhBdNJSBUcoBw1aOSGwn/WvJub10S0nclBSQV9mm
	RNuzojY4PMjA1B51ir8IB2K625La42eJA2fcISCd0q41i6NtuIAzeBJdLepurFHzAhgKfYtnD6i
	fU57Gj/8kGl0TnDhA9Z+RpyyUN8UI5ovEf0LROqBUwgJqBYbNwl+INT4o8LDlA1tcsKkWXlgDrg
	bCM0VlRsQ15ic=
X-Received: by 2002:a17:90b:1b46:b0:34e:63c1:4a08 with SMTP id 98e67ed59e1d1-353fed6ec0amr805260a91.20.1769493448927;
        Mon, 26 Jan 2026 21:57:28 -0800 (PST)
Received: from localhost ([122.172.80.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8234fd9a5a7sm3486783b3a.63.2026.01.26.21.57.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 21:57:28 -0800 (PST)
Date: Tue, 27 Jan 2026 11:27:25 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>
Subject: [GIT PULL] cpufreq/arm fixes for 6.19
Message-ID: <k3brbzyfuqulewxmkyjolnxtkn7nnsduf7keqch5obgpcqyovl@jtopk3yoqlr5>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Rafael,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git tags/cpufreq-arm-fixes-6.19-rc8

for you to fetch changes up to 7e3debb4c72fe840d60014192cf93950871fb3be:

  cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list (2026-01-27 11:21:22 +0530)

----------------------------------------------------------------
CPUFreq fixes for 6.19

- Add sentinel to qcom_cpufreq_ipq806x_match_list (Pei Xiao).

----------------------------------------------------------------
Pei Xiao (1):
      cpufreq: qcom-nvmem: add sentinel to qcom_cpufreq_ipq806x_match_list

 drivers/cpufreq/qcom-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

-- 
viresh
