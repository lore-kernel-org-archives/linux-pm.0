Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19113769E6;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301916; cv=none; b=esv0uzeYlLqw3yVerlhSiLAUK5Sviqcci3voIBRlQma+rWgSiERIupaqJxFb2sxvvj5ZnjbHtKTJFC/XykbbCspwzl8ii+Dz+XonES6zfUCKNtTYerTJkQlXfS7HLb4Od7E3+s2HLEWJKlrj69FWfQ1lkN7t6JbGRv3YqBbfg6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301916; c=relaxed/simple;
	bh=a313rgVELQHQ6c+aVQybxcORvj5UN/k+XZliSflHCNg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=lZZm10vgdhquZLQGSfjFys1AxsgkuVMgEcpITyjsQYOmbn1AOMUDbivZr6wrJKMIYwo7bMzZmHlF2NWB2P1QzPFu4aTPJuq+dNvEWD8qHpKm8yXqGwQoHsv0P6AVAderLw2TWaZztyUZ4CyShF4PEz9cO/W3uekctX3kmTwX8mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391CD1F000E9;
	Fri, 12 Jun 2026 22:05:15 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id B3D2D180CEB; Sat, 13 Jun 2026 00:05:13 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Bartosz Golaszewski <brgl@kernel.org>, 
 Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>, 
 linux-doc@vger.kernel.org
In-Reply-To: <20260426232705.422938-1-rdunlap@infradead.org>
References: <20260426232705.422938-1-rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation: ABI:
 sysfs-class-reboot-mode-reboot_modes: fix doc warnings
Message-Id: <178130191372.340022.764793265726304664.b4-ty@collabora.com>
Date: Sat, 13 Jun 2026 00:05:13 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Sun, 26 Apr 2026 16:27:05 -0700, Randy Dunlap wrote:
> Repair the docs build warnings in this file by unindenting the description,
> adding blank lines, and using `` to quote *arg.
> 
> WARNING: Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:36: abi_sys_class_reboot_mode_driver_reboot_modes doesn't have a description
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: WARNING: Inline emphasis start-string without end-string. [docutils]
> Documentation/ABI/testing/sysfs-class-reboot-mode-reboot_modes:1: ERROR: Unexpected indentation. [docutils]
> 
> [...]

Applied, thanks!

[1/1] Documentation: ABI: sysfs-class-reboot-mode-reboot_modes: fix doc warnings
      commit: a888754e51e915731c8974c4d6d62709facb35d3

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

