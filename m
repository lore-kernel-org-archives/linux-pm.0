Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5EF4B8DED;
	Wed, 17 Jun 2026 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713832; cv=none; b=BanVxhd1igegU6KhruqLCidcirMIrg6WEE8O0ShTapqvZbXPvW8hjsejbRVmFdHqjAzRYimWNZGym8iSyKjQuPngLV3JhRlAtfhdH/kMHWWfY+S9PH6bnlybXO0h2AREUGhteUgu/ZG/9dsBgnPkyuNN4acj87wm0pf0evLsWMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713832; c=relaxed/simple;
	bh=vQcEGpDH52JnsZ2TRq+AWRgshRKqpQyB9+NZIpb8WFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BI8jE5NPPbzCBGq1c4WshbaQTtwLFOXNrTwD1FPcmzIh4B5rjczVTBj/hl+4WLc0iW+ZXn7FfyTfPwMmqhyLaG+BKRviUyNI32/413H2qZy0r1o6n0cNXXSpc4AeeYbf4YkR0e3w+sc0qRra5URFtt9SmMZi7PG9Au2g2CxAazg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfmJeZRL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfmJeZRL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D9901F00A3D;
	Wed, 17 Jun 2026 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781713827;
	bh=vQcEGpDH52JnsZ2TRq+AWRgshRKqpQyB9+NZIpb8WFE=;
	h=From:To:Cc:Subject:Date;
	b=UfmJeZRLGo4/YpE5kmBVIZkcoVlRJjN1fzneNVwRUdh8BxZwwqLCMkl+yKBp1dNFR
	 8HF58h1cYH8Qxt8q9UpRGifOdb3/WtmK91dD26jXY+mdAbTfmx5gAElWFs1PvebDmR
	 wWNuwbTWavTCP3Tp8nYrt+MCkxo093OkexKeLnFXBArVhBBgizRQVB8S1AHJxq40cV
	 DkQ3JLyzdOUrE+lO0HoOb/5Pcv6NStXaElZxFvUR2ePsGTlGgwrNO5D6HeaZAYHJnx
	 XGjKaNNY3l69WZpW//IIkxWFtJSJBSUFHTZsyl0iEvHIp49+mbcCjM2RQK/OqCpua6
	 HGtXk8TIGAC3g==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1 0/2] cpufreq: intel_pstate: Set cpuinfo_min_freq to a lower value
 with HWP enabled
Date: Wed, 17 Jun 2026 18:28:23 +0200
Message-ID: <2381464.iZASKD2KPV@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi,

This series updates the intel_pstate driver to set cpuinfo_min_freq to a lower
value when HWP is enabled to support systems in which CPUs can actually run
at performance levels below the current minimum level.

Thanks!



