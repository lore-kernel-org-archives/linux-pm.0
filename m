Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F53283FD9;
	Wed,  1 Apr 2026 14:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055099; cv=none; b=oLZEgU4gPlp4xapIssOt0+kLk50Xz7QlFDHgZNVbwgYklferlZJUrfyGNQkNH9akraQcaQesDDuDtWtpKhFIDCYaNBjvwt1AW9hNAZHHRzQ8/JWo+zlcjTSkcOU3d64Wcm0VWiwEtKId8rSHfJOKhpajItXlfPukMnDZowSkuAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055099; c=relaxed/simple;
	bh=/JCkDWeITmw49NLRBIZY31n7l2BWCkQwnd7kTByIP5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcVxJk5BpfrI0hjdf+88xDB5c57PI8KGCUQy1zP4q78t+ymulPkPQjeCkoyWtAGKO1gYIazhzQ7/svCICRpmgr+/SDlCNvoJ51sKnSf5w5K2QMADhzKhRgThrkv2uulRnBKIAbpIajeX0p9PT0LBE4Ccz8x5onZxC+gmz1x+xy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKLreg48; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKLreg48"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D935FC4CEF7;
	Wed,  1 Apr 2026 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775055098;
	bh=/JCkDWeITmw49NLRBIZY31n7l2BWCkQwnd7kTByIP5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PKLreg48SOAlp8o8/zFjs0OXXW+q3yMwdfureYJTu1ul83U5z6K0FMqoL/pf14dU8
	 Ibr0Q4TPveLAiyOmMnxJXatYVyrsLJCUuKkE/Qnb/wxmTZqTSg9CHSNmRCfledM6nF
	 jeZgqA/YWCAeh7fF6SjVI2PTyW5gNHMUJnHOxah6Aaz4Z+fAxgnbnQn2tPum/nCzmU
	 HDtbdets7nId0206ksotkECQuIue5qFuNXquO/AV0IgfnsjmZr5fUnTn2XikoKswfl
	 Z+S+pF/phH++zO51kSCRwhkSiypbq0Da2x3F0FhQULa9aRHnw1w9J6aKLwFK+6jQ0T
	 LLBCV//Uo9+dw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Armin Wolf <w_armin@gmx.de>
Subject:
 [PATCH v2 2/4] thermal: core: Change thermal_wq to be unbound and not
 freezable
Date: Wed, 01 Apr 2026 16:38:40 +0200
Message-ID: <5084924.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
References: <6277980.lOV4Wx5bFT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The thermal workqueue doesn't need to be freezable or per-CPU, so drop
WQ_FREEZABLE and WQ_PERCPU from the flags when allocating it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: No changes

---
 drivers/thermal/thermal_core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1915,8 +1915,7 @@ static int __init thermal_init(void)
 	if (result)
 		goto error;
 
-	thermal_wq = alloc_workqueue("thermal_events",
-				      WQ_FREEZABLE | WQ_POWER_EFFICIENT | WQ_PERCPU, 0);
+	thermal_wq = alloc_workqueue("thermal_events", WQ_POWER_EFFICIENT, 0);
 	if (!thermal_wq) {
 		result = -ENOMEM;
 		goto unregister_netlink;



