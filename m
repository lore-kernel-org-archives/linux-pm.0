Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6259137CD28
	for <linux-pm@vger.kernel.org>; Sun, 12 Apr 2026 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776004465; cv=none; b=eX+PFXV+HczKQJTAdDM92hPE9JXWYTcTgxWvujVjQlScHIHdzFh4VdbAXv/XZHGR22hW3aqhq6PggP7tTBHWG6lHuuTTZtR1kwXYk2kdTJVt3Mgh8J4E6Kyv0orVlVv2RaVqbavUXXN/cJnPisSag62tVaTnPbWF+VXl62uHG5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776004465; c=relaxed/simple;
	bh=DDCfulsVqQTKXylT1KmXG15VDOMTe4rRR0qVZJDr7sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CTqxNqDDDTHxkeyutYXBF/z3svw4lS4EZ+pBU2i+V2+AKnFsbh9fTQjIXd0RGTLaHWpe7T+SoB+1rjPhwqXcvPKH7NxkdbAbT7ItxTMITvkdw7hbxY5AUnC/lfMDDiu8O2p0zN4TuWbaRN60jWDlkYvfN2+H5WD1UmFX9j5AdOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Mskiwlbx; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Mskiwlbx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 0488C1A31B2;
	Sun, 12 Apr 2026 14:34:16 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C3D185FFB9;
	Sun, 12 Apr 2026 14:34:15 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC6A610451B8E;
	Sun, 12 Apr 2026 16:34:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776004455; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=91msdPNkWMnw/BAAIhlDZGhpLVxnZ2cz6aRipzbPmTE=;
	b=Mskiwlbxx4MqBlvN5B+uBf6kKoVpkkiwwdomK5No7A5b1gtWrV9NKl8diP9T2F+SVqgRPL
	7wFh99I5sz7CT8FObkQP36LnpB7i5jK2Zp68/kQz2+ooDvjDEjbmHhJw5o4xXzTtrVIlBY
	aAYUiLGzNaGiI/BMbb/+147XzUulpzRRRUcFDf9Bz21re6qMJR9mBDXWAOU6fhCaZZXzm9
	6nM6GFqmxJtFUkAFzJcGkZuag5KvbS6NOAc3ChYxpBXyz2o9xliYJe/9jkCImnzCxHqaua
	NHAE4S4sm1kjZvEVpfmllPexhgaW+QqiB/G+LZbOuE+eZLPNgNDPGT9PpHafsw==
Date: Sun, 12 Apr 2026 16:34:11 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Frank.Li@nxp.com, rafael@kernel.org, linux-i3c@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH V5 0/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime
 suspended for Intel controllers
Message-ID: <177600443486.2783407.4838575164126519141.b4-ty@b4>
References: <20260306085338.62955-1-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306085338.62955-1-adrian.hunter@intel.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri, 06 Mar 2026 10:53:33 +0200, Adrian Hunter wrote:
> 	Please note all patches have Frank's Rev'd-by.
> 
> 
> Changes in V5:
> 
> 	Re-base on top of v7.0 fixes series:
> 		https://lore.kernel.org/linux-i3c/20260306072451.11131-1-adrian.hunter@intel.com/T
> 
> [...]

Applied, thanks!

[1/5] i3c: mipi-i3c-hci-pci: Set d3hot_delay to 0 for Intel controllers
      https://git.kernel.org/i3c/c/815b4448198f
[2/5] i3c: mipi-i3c-hci: Add quirk to allow IBI while runtime suspended
      https://git.kernel.org/i3c/c/5fe77a6d8d5d
[3/5] i3c: mipi-i3c-hci: Allow parent to manage runtime PM
      https://git.kernel.org/i3c/c/82851828a8b1
[4/5] i3c: mipi-i3c-hci-pci: Add optional ability to manage child runtime PM
      https://git.kernel.org/i3c/c/e813e7e30086
[5/5] i3c: mipi-i3c-hci-pci: Enable IBI while runtime suspended for Intel controllers
      https://git.kernel.org/i3c/c/e7a718627c6f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
