Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A29E472555;
	Sun,  4 Oct 2026 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791136014; cv=none; b=Uak+8wd0Jk2WQT3BW8d3aGhmxKtQuir72XeEKpv4Duhrspry+HvPyLPXHmSoTTwKF0WQZenft3zWune0qb4x5dVQP0LwdlRiEJV/9OIppVvjW4PMDRDBx7LJ/YoenEfKi9+ISQvrZYey2uQlZpJ05K9CjopA+t2921I349zHUew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791136014; c=relaxed/simple;
	bh=ixM8Gqc13PwupKUo3h61Blv8SiKPVNJrBJcYLrVD3CI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=LYoHYSzB8enpb/sZ9fZju/L4iGX8VoUOl2IiIHq19jF5N47IByQFXSUbZjBCqe3BhXEcbuaZZ9eAgdT3+LDcYF6wqlZC3ubzj7is/trTkfONYRo5f4cpRC/pT8lP8NsFcdCTvPuXglfmof9paXcw/DGmkVRQsLpmCpIv/ComUM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48411F0089E;
	Sun,  4 Oct 2026 17:46:43 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 2BB20182ABE; Sun, 04 Oct 2026 19:46:38 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, 
 =?utf-8?q?Iv=C3=A1n_Ezequiel_Rodriguez?= <ivanrwcm25@gmail.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Rafael J . Wysocki" <rafael@kernel.org>
In-Reply-To: <20260831155339.181487-1-ivanrwcm25@gmail.com>
References: <20260831155339.181487-1-ivanrwcm25@gmail.com>
Subject: Re: (subset) [PATCH v1 0/5] power_supply: errno, hwmon rollback
 and docs/ABI sync
Message-Id: <179113599816.190565.6789295553108719903.b4-ty@b4>
Date: Sun, 04 Oct 2026 19:46:38 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16.0


On Mon, 31 Aug 2026 12:53:34 -0300, Iván Ezequiel Rodriguez wrote:
> Small power_supply hygiene on top of v7.3-rc1.
> 
> Patch 1 returns -ENOMEM when OCV table allocation fails (was -EINVAL).
> Patch 2 best-effort recreates hwmon after register_extension() rolls
> back a failed update_sysfs_and_hwmon() that already removed the old
> hwmon group.
> Patches 3-4 align Documentation/power/power_supply_class.rst and the
> sysfs-class-power ABI type values with the current enums/strings.
> Patch 5 replaces spaces with tabs in get_property_direct().
> 
> [...]

Applied, thanks!

[1/5] power: return -ENOMEM on OCV table alloc failure
      commit: 2648e3d4ca08014eb6125d96acb177e767d7c807
[2/5] power: restore hwmon if extension update fails
      commit: c996fa11ce8616aa3e8f5ebc34aa31a73dafac60
[3/5] docs: power: fix power_supply_class.rst status, health and time_to
      commit: 420a1e2763b5df3ed90f92d97cf30fe43822bba8
[5/5] power: use tabs in power_supply_get_property_direct
      commit: 27049920d0cf0396242f517dfdf2694e7b8daa67

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

