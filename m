Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78843A7D82
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2026 22:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792277886; cv=none; b=eySMekR5QU/HwoEzo3ZDdyIWKDPLJnOcWDyr5G1zIGjD3hS1xTYRgBC980Ee08qs2ayvbHH5i3IMAwVC0IUVpWPyGmPkAPNcNin3CgAD4ToRCL1jC/OSdPVaWod4aHooH8wvnutL4ytcSuYn3PlFQH+esofJBhYjMjWf+dZOCz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792277886; c=relaxed/simple;
	bh=3KV5cRwR30Mttdww7TcOm7FWx6LthzP5VQWcTqUjbUQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=UngNh+5+NRRePY4ak7ebBOXyJBqvpIKOuUduzKMwweSZPF2AyhEipGOxZ25dHVh0wN8hKwxJjKCKqOMNUC3ZCb29i4ZyhDqN6WeeLPM23CnHklu3i1Yt0QzO4CSh93lU2Xe14OpZETUzgdE5IyM3QgFhcQKdhUAKHjSCzCQUlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A59B1F000C4;
	Sat, 17 Oct 2026 22:58:05 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id AE74118233B; Sun, 18 Oct 2026 00:58:03 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Hang Nan <2122295973@qq.com>
Cc: linux-pm@vger.kernel.org
In-Reply-To: <tencent_8258FA5B59F3058B3D0A31E1D31A92CB9706@qq.com>
References: <tencent_8258FA5B59F3058B3D0A31E1D31A92CB9706@qq.com>
Subject: Re: [PATCH] power_supply: serialize property access with
 unregister
Message-Id: <179227788369.87324.8846697889749777164.b4-ty@b4>
Date: Sun, 18 Oct 2026 00:58:03 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On , Hang Nan wrote:
> power_supply: check ->removing under ->epc_sem on the property paths
> 
> This report was produced with the help of AI tooling, so per
> Documentation/process/security-bugs.rst I am reporting it publicly; the
> reproducer is not attached and is available on request.
> 
> 1. Affected version
>    Mainline, i.e. after 5b4bd13e055 ("power: supply: core: prevent
>    unregistering a power supply while a callback runs", 2026-09-10) made
>    power_supply_external_power_changed() take ->epc_sem for read and check
>    ->removing.  __power_supply_get_property() and
>    __power_supply_set_property() still only test atomic_read(&psy->use_cnt).
>    Verified again on the current tip 90201351a86 (2026-10-16): ->epc_sem is
>    only taken in external_power_changed()/init/unregister, and the file is
>    byte-identical to v7.3-rc7.
> 
> [...]

Applied, thanks!

[1/1] power_supply: serialize property access with unregister
      commit: 9f7f7a85945156d5c7626390a8c46d43d5159abc

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

