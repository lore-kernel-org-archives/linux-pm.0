Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF183274B43;
	Wed,  1 Apr 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054038; cv=none; b=BbJ1IYw15y2crLcNX84MaSAakc+YHjjDyQUxyxtCg6QN5U7qdihhOjhiXU97iQTPsJh/i1ZTq+lr33rHVXrwhUYqmYyxjANFyeCSNCHtRM3eMMTYavfxtsmqboFq8eXabedi4ysT9EcdhiN7a1QldFdz0WHT+SkzzTJyC8S/JvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054038; c=relaxed/simple;
	bh=mStKtn8GHpOSB6wIXGLLxIJXiCjo+r3/qNLhN95dLtA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pTYjOx8ZrUHUQKNlKvsFa3IjuhPGyF9/K7W68nwnU15w35unLx2oKtqGGU7HcncaailvEwKnywaLVPdi5DBglba/9uq2WQCmW5oo/qs8IPsVP3utTeEbqBKe98M/ys71gYx8OW0s3E3ufIQgrBFYzRB+pEmQLVuFQoRrq3M8XQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=garV6nj2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="garV6nj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68308C4CEF7;
	Wed,  1 Apr 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775054037;
	bh=mStKtn8GHpOSB6wIXGLLxIJXiCjo+r3/qNLhN95dLtA=;
	h=From:To:Cc:Subject:Date:From;
	b=garV6nj2XmKQWht8Z80GfG2ISALAtJaiTv+xC9wEN49TEoTzR5xKaCC+femGflxzR
	 uYfs2I/Qs3Jl8ekug3RGNrAYCRmoIMPkgqDoTnVmyhh0kfx4/bZDY8Fku/PI6UiRkm
	 MsnFoV+zfzsBAMsX9NcYuM37fZgXRzhzT33rjW5OA8gN9ZAVgt7xEaWUImTlTgzxWB
	 juSFRvfgUoC1FD7OiERPSFKt3miEIGbQU1Kk9ZkZalguL+Ekg4j1L8s1Zd3Kc5+Pvl
	 dzvx1tFCb0HMCphO/eMuFrtjPhazqqtPDmuIde6Qb3iMXWOBvGHi6BckARH6p0s62B
	 lswUZ163eassw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>
Subject:
 [PATCH v1] thermal: core: Fix thermal zone device registration error path
Date: Wed, 01 Apr 2026 16:33:53 +0200
Message-ID: <2849815.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If thermal_zone_device_register_with_trips() fails after registering
a thermal zone device, it needs to wait for the tz->removal completion
like thermal_zone_device_unregister(), in case user space has managed
to take a reference to the thermal zone device's kobject, in which case
thermal_release() may not be called by the error path itself and tz may
be freed prematurely.

Add the missing wait_for_completion() call to the thermal zone device
registration error path.

Fixes: 04e6ccfc93c5 ("thermal: core: Fix NULL pointer dereference in zone registration error path")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: All applicable <stable@vger.kernel.org>
---
 drivers/thermal/thermal_core.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1651,6 +1651,7 @@ unregister:
 	device_del(&tz->device);
 release_device:
 	put_device(&tz->device);
+	wait_for_completion(&tz->removal);
 remove_id:
 	ida_free(&thermal_tz_ida, id);
 free_tzp:



