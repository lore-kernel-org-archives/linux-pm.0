Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF133909BA
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 18:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548675; cv=none; b=k7YawSraGhDPWVfjdyLr4lIeM2ikeDubx2aVKtHE/YQBLCLgxik1RMfIyxzcZx9iurKrA6zLA4gVVJ1YNFglxrG/KyJEGWnOyYWCF3lOBTs/vzHQilOiiX+p0IX2xFhUW9R1OG7HF0zJ0IpZ9B+fF/17VtT/ZWRafzKqEfHe8JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548675; c=relaxed/simple;
	bh=fpVXQ+OeoqUa9CGlLq02+eUXwbj1mVFSo9a08t4kDRY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=dUJE9N2Btfj382PnAwf3prMduyO9EYxyf/wcCgbkipb2ELARfR+++Ui1vtCqv4VTeMvyynsZlbgGGU1xq48ZbLKS8KlV4Ps+i+XIjnV00SUkZV0ZSRP8QKU5YNTtUqowpklG4vqRGPEh2SWfnUIGH6PHwm2xFNx4xI6mRmj/FUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCyb8UCW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCyb8UCW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53C24C2BCB1
	for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 18:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774548675;
	bh=fpVXQ+OeoqUa9CGlLq02+eUXwbj1mVFSo9a08t4kDRY=;
	h=From:Date:Subject:To:Cc:From;
	b=GCyb8UCWImki9U8fRImpFRKJslSfkszJS6pHZdDRsWTPhdR3sCOxmK6nrN0OhhG4h
	 ZHaDDx4Mjcq6FNs6W9k0jMBy7BTaLR1sC4c9AVmC0cJPryp/WktX/wayOekcY2o8Pd
	 +UFhCX9Cay7LouHqN+9LW0E5DQPtDCGu/Q+MN8dGhCL+1gPjo4cByTKZ9PQpsUNNhk
	 toBribHj1vn/j09Bl0Ag/beKNgTJIlqhOuVsAtwqqY4gK0TLKFru3Ot/NcOmH5G77p
	 ynoCasWBO5NMZ4TONlJboLN9a0FJVQmrHBPyU+brrqahNltGHHLFCsV5vT4JJLLe7m
	 7tXq/cxA4OZjQ==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9b1c57a4cso993270a34.3
        for <linux-pm@vger.kernel.org>; Thu, 26 Mar 2026 11:11:15 -0700 (PDT)
X-Gm-Message-State: AOJu0YzgpE5o/WNJK1gHjzmo5fmd/wPbcfQnaFkYv/7ePefd9x5A8gTY
	vLy3g7KWCqBmsezeoIUj8UjoYSFGykQrbm1Dz5pYbaNzYYlH9LBA0PO54h+soydRD7wqKwKdlcP
	PiHQ0u6HAnEP7zl5OoHdSm6VYH/RgB9g=
X-Received: by 2002:a05:6870:b013:b0:417:540b:6838 with SMTP id
 586e51a60fabf-41ca70072f7mr4832790fac.25.1774548674433; Thu, 26 Mar 2026
 11:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 26 Mar 2026 19:11:02 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0ggLdfPQZSThBgNhErY7n66quQoo_uhiMZVFawRGpfA9A@mail.gmail.com>
X-Gm-Features: AQROBzCb6XXzGQpRt5YaXDyRxLdCFCmHS5_cG-QM5opJhQ2fC8IKmjhvbETbowk
Message-ID: <CAJZ5v0ggLdfPQZSThBgNhErY7n66quQoo_uhiMZVFawRGpfA9A@mail.gmail.com>
Subject: [GIT PULL] Thermal control fix for v7.0-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-7.0-rc6

with top-most commit 7dfe9846016b15816e287a4650be1ff1b48c5ab4

 thermal: intel: int340x: soc_slider: Set offset only for balanced mode

on top of commit c369299895a591d96745d6492d4888259b004a9e

 Linux 7.0-rc5

to receive a thermal control fix for 7.0-rc6.

This prevents the int340x thermal driver from taking the power slider
offset parameter into account incorrectly in some cases (Srinivas
Pandruvada).

Thanks!


---------------

Srinivas Pandruvada (1):
      thermal: intel: int340x: soc_slider: Set offset only for balanced mode

---------------

 .../thermal/intel/int340x_thermal/processor_thermal_soc_slider.c  | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)
