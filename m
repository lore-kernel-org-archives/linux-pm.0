Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF5E393DF1;
	Tue, 23 Jun 2026 17:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236157; cv=none; b=CboDMR5eCJPq4yFLXy8GW/dO3fXm2DS/j+mcsZy5MV7TCJ9YI9VLDXUiYbC5FfEiPduQYHsZZhr1V1RGmS0e6N/les1fun7UPmtEyElIvyicBgBibegXjZxBtQw3pl6RMgODzHvEdgKkSKn+IKSgwTw1TMV1pQkVVJ2/6CM/Llk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236157; c=relaxed/simple;
	bh=PeQOSXh4jXUhiWxxkg3u8dZzBl2SZ2SvBgjSMan2Rpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VfP5163zEIxTdnQ22EU+PERxeccQYLtUv9rwHCnFnaji/15gOhhItcOC3CvUrZA8SEMygI/P7tKoubSa8kJDOP+aRpSB1iRWX4diWq+iybUgPzu8H4QQAYZWwTD6kDTxcRypLZ91zONHeIbKH74u/l8i2ymHa/v2zOLfWhziCms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GSMnbC/w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GSMnbC/w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87251F000E9;
	Tue, 23 Jun 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782236156;
	bh=PeQOSXh4jXUhiWxxkg3u8dZzBl2SZ2SvBgjSMan2Rpg=;
	h=From:To:Cc:Subject:Date;
	b=GSMnbC/wQaof1G6hFyHjRBvAUjDuIyn27ndccoZRBFyPMb52kBaCUBxWHhT4XylGh
	 IKDcS1WuTm+W2K2FJrINonA2S/VEPYgWcitzfcLqlCvi2GHN62GyeWO/C/jz3v1Pcz
	 sWxUriWdNFW/bVfhuDPnuQCQfGBZTFW1kidBZvRP7/ScwLyhnWVnZFJH6BTJZnuyZq
	 xvgjPs2N/iY8eymnoSIr0v072X+jpLSbxAjNAxi0W9eT+HvfAwMGG6eMV7rHhIDuEi
	 7PcYqvcZiwMO/MT8RDE0nuLFnPOeQvWVl0RV0CTI91QAPnoOIeilwbINm1Yn+VeA3S
	 V6PiQMpGT5vAA==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Chen Yu <yu.c.chen@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 0/2] cpufreq: intel_pstate: Broadwell mode HWP cleanup
Date: Tue, 23 Jun 2026 19:27:21 +0200
Message-ID: <6286434.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This replaces

https://lore.kernel.org/linux-pm/12920597.O9o76ZdvQC@rafael.j.wysocki/

which was incomplete and kind of misguided.

Instead of trying to restore behavior from before 5 years ago, make the
Broadwell mode of HWP only prevent hybrid scaling from being used which
is the only effect of it in practice anyway (patch [1/2]).

On top of that rename a symbol (patch [2/2]).

Thanks!



