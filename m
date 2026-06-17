Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A58E1FE47B;
	Wed, 17 Jun 2026 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715759; cv=none; b=jzpbOf2k/NWnp25WxzlV7xbDQ02kKkSnHK8bUAlWoI9J4ZhLds6mBd1ZkiUOcGhitRYQv3zpnnbsAWHltFNj2Eq4XtYi9wZ2rhPcI6ZghVqV20K2a2wuTuuBZhxqmKsgGf78KSZmTFwSbBKrKoujTDn+gXfgVCOHJV8F1VSiM80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715759; c=relaxed/simple;
	bh=QMV1t9wG7etDTdLwFWzZTqaHhzwu+6lPWKxD2ynYhnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnElaQ81kP9liZ9hLMuKw4rqDpoE/i4328PaAduVSe8OPUcb83HOLEg76QSq6BwG8ikO/Wnh4x//Hb+2R904WZD/YlM3G+FR4hiIulA0Au8YGoJpDayN+I/EHK+CE7aYNR/AqeD9RWFfMag7bOBETzlLd9emmzPkxooD1G9n4nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoxK2RPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoxK2RPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121761F00A3A;
	Wed, 17 Jun 2026 17:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781715757;
	bh=HFm+L/d1F34RtqbF8gqD0SKUgb89rH3LMhjkhl+yJ/8=;
	h=From:To:Cc:Subject:Date;
	b=hoxK2RPa9nZKUkdSGQZoYKoBhTnCBuh0QPvml8lGxwAaKXATYnq0UXgj8tjnLV9N1
	 mS6W+zWVTXo8YVwhrFfE1/y2eR6D2IQrI9Pw7BeBOduTnDsWcGrnWxlcHshlJj1RuN
	 AHdKHvQP7kl7ldz4tCNqPnJzNnn8yC4/pnAjUyRb2egOLd7QP7JObVTnPqJ+uwQOJ+
	 xaw4pj3Aii5IZqKiHBFz53T3DuF+mcPVHBY+Iae2CsT3/xJoTRS1WOMVeuMs4zcfBK
	 ZiTEtyjmLcC8DwDAxbarrM6eZJjZZohymxXMdg4zU0Y/DQSYuPqix8HaP32lXJEr12
	 rNjCx4Toih5Fg==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject:
 [PATCH v1] cpufreq: intel_pstate: Rearrange checks in hybrid_get_cost()
Date: Wed, 17 Jun 2026 19:02:35 +0200
Message-ID: <2832945.mvXUDI8C0e@rafael.j.wysocki>
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

Make the checks in hybrid_get_cost() more straightforward.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/cpufreq/intel_pstate.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -979,12 +979,10 @@ static int hybrid_get_cost(struct device
 	 * capacity.  Similarly, P-cores start to be populated when E-cores are
 	 * utilized above 60% of the capacity.
 	 */
-	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_ATOM) {
-		if (hybrid_has_l3(dev->id)) /* E-core */
-			*cost += 1;
-	} else { /* P-core */
+	if (hybrid_get_cpu_type(dev->id) == INTEL_CPU_TYPE_CORE) /* P-core */
 		*cost += 2;
-	}
+	else if (hybrid_has_l3(dev->id)) /* E-core */
+		*cost += 1;
 
 	return 0;
 }



