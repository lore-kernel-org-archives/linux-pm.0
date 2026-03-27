Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE5399002;
	Fri, 27 Mar 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605124; cv=none; b=NhabMHq8JAKKowp36UwERJawL7UzkcWdpxN6lQL18Irb64fZ6N5SFQrCda4YrG1ujl3E14hwX+h9Zntke5Yi1s35uiPS2chzC334A9M+WQ+1GQUs36cIiFVGAjfzC0/ihsGPB4wtFKkjQ6YOwMq3UBx8LsiOxBVfpSpvuyQtT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605124; c=relaxed/simple;
	bh=affQBU+zm+5N2Yof7U/miUHwDKSJuB6P4ntIJZ3Y1qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=f51ZWwrAoglu2zTmND7Ta0rZqZagWIgbv46KHDDqg8BmfyJHHVcGktuZ1ZSodSLDdn9AMDZu40vep+AKuwkUyzLo+DD5a5EQyEqMfq/c+DqlDHlkYNuAyZa/Ht7DyCPpCsdScs4A3+yUd2YFk6D6FMe4KjK5c3DPLzyUNmSJw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgXX0G0l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgXX0G0l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C37C2BC87;
	Fri, 27 Mar 2026 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774605123;
	bh=affQBU+zm+5N2Yof7U/miUHwDKSJuB6P4ntIJZ3Y1qo=;
	h=From:To:Cc:Subject:Date:From;
	b=BgXX0G0lAOGQdzPSWiDAw5qx5kQo95/b2BcFMRqbrv8g1kBzbVCTdvu3Opk1AUUD3
	 CD29HWXfvVPoJ463Hbpm9NRzMCBwzmkkteeQjISTh28F1qL4KeTDdcmEfZvomP2G3O
	 Hgc11+UHf4wsKcYbpCSk1F9i3R9PRdrtoYLyOeu+zM7vErUCCVuH+LCNSz4iDr/vmX
	 03qWDjdYBGgzAolsWVb0Qj776qhX5z5oIwb6QpQT9Im0wyy7iji2kAX5ADda/SQgMR
	 +9Q8Wk/bggilBCw4AV7xnM5t0ei2GqLdWF4nGWkqGlR6shyfWAxSi9ASRdl+JYI+TJ
	 7e7Io+C7i13IQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Linux Driver Core Development <driver-core@lists.linux.dev>
Subject: [PATCH v1] driver core: auxiliary bus: Drop auxiliary_dev_pm_ops
Date: Fri, 27 Mar 2026 10:51:59 +0100
Message-ID: <4738700.LvFx2qVVIh@rafael.j.wysocki>
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

Since the PM core automatically falls back to using the driver PM
callbacks directly if no bus type callbacks are present, it is not
necessary to define a struct dev_pm_ops for a bus type that will only
invoke driver PM callbacks from its PM callbacks.

Accordingly, auxiliary_dev_pm_ops is redundant, so drop it.

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/auxiliary.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/base/auxiliary.c
+++ b/drivers/base/auxiliary.c
@@ -207,11 +207,6 @@ static int auxiliary_uevent(const struct
 			      (int)(p - name), name);
 }
 
-static const struct dev_pm_ops auxiliary_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(pm_generic_runtime_suspend, pm_generic_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_generic_suspend, pm_generic_resume)
-};
-
 static int auxiliary_bus_probe(struct device *dev)
 {
 	const struct auxiliary_driver *auxdrv = to_auxiliary_drv(dev->driver);
@@ -258,7 +253,6 @@ static const struct bus_type auxiliary_b
 	.shutdown = auxiliary_bus_shutdown,
 	.match = auxiliary_match,
 	.uevent = auxiliary_uevent,
-	.pm = &auxiliary_dev_pm_ops,
 };
 
 /**



