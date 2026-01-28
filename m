Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC91334EF0D;
	Wed, 28 Jan 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594166; cv=none; b=mZnQASv82P9yP9zEVz4XJ4CkycUPHLKrnBGDaQPT6y5+TZitrd7Bhc5i89BsMaGvQP+6lZqdZLHis8YOK9n7nQ0JJeV+iw6i2N37nLvuSSrn3DvxJU+R5wEYuqOqXFnInPl+H/1LRWZcVMxlT0hU9c2z1ze1Dk0hj+sBUyHsOiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594166; c=relaxed/simple;
	bh=Tv9VtT/tuyIkVlqTZedEc7eEI3ttMxjU9nyE/1eczKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CHRuWLRBBfsuTmbRIGKnDIxvtY/v1owesTtkIdupHaCqAF0h0KUAaUWSsPPGBGW6/UwNQbfglloNjfBPtXKq61KVCqDCXa8dVqzdi8nsfP22s37VBjnXldw+5UYyKpuHtIP0OwZXVRq9ha8WU3usN+EkDfppFlh7T4VBjbg8M1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QrsW2B9m; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q9zEE5Ok; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QrsW2B9m";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q9zEE5Ok"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1CkU/HVc2ibILKVdI+xG85Mza9wEmLT+9RFRhOmAis=;
	b=QrsW2B9mzvVSeDxdgZ58k37uaTiRsEIcoBAj/3gtSMNU7mee/7YgMKb7tLtC2+9pt+ZsCp
	/Qlw7YGtu+D8w9zI/jfeR02K7jkwCwMNWveGSoXd/HJOxdI03H2J/JQnRpe04zb6hVmOLU
	6ASRhGEHkhKPaTQohUyYsml+d/vho4+pvTGLFB4mQzQVPIPUPCaLO+RLz6zjpV63cEsMTQ
	xPtSg7nTryjHvNtvH0FHABPelcg74vSzXfNc+gj5f4lI7wc1/pPrrp58ajIcLLJOSztS03
	WgEci4Jq4kCqDrMLhEueefUgThJw36YmrOP+31eZ8FgG1BJYks7C45Sn47bQgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y1CkU/HVc2ibILKVdI+xG85Mza9wEmLT+9RFRhOmAis=;
	b=Q9zEE5OkRXme6lpHRO+aeYBAG308JfFrDu40HCchk0mHzXsOfjeI4oWDURKNazVljzm7TQ
	2JIz0EXhWlqaWlAg==
To: linux-kernel@vger.kernel.org
Cc: "Thomas Gleixner" <tglx@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 13/20] thermal/qcom/lmh: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Date: Wed, 28 Jan 2026 10:55:33 +0100
Message-ID: <20260128095540.863589-14-bigeasy@linutronix.de>
In-Reply-To: <20260128095540.863589-1-bigeasy@linutronix.de>
References: <20260128095540.863589-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Passing IRQF_ONESHOT ensures that the interrupt source is masked until
the secondary (threaded) handler is done. If only a primary handler is
used then the flag makes no sense because the interrupt can not fire
(again) while its handler is running.
The flag also disallows force-threading of the primary handler and the
irq-core will warn about this.

The intention here was probably not allowing forced-threading.

Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: Rafael J. Wysocki <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
---
 drivers/thermal/qcom/lmh.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index ddadcfada5136..3d072b7a4a6dd 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -220,7 +220,7 @@ static int lmh_probe(struct platform_device *pdev)
 	/* Disable the irq and let cpufreq enable it when ready to handle the int=
errupt */
 	irq_set_status_flags(lmh_data->irq, IRQ_NOAUTOEN);
 	ret =3D devm_request_irq(dev, lmh_data->irq, lmh_handle_irq,
-			       IRQF_ONESHOT | IRQF_NO_SUSPEND,
+			       IRQF_NO_THREAD | IRQF_NO_SUSPEND,
 			       "lmh-irq", lmh_data);
 	if (ret) {
 		dev_err(dev, "Error %d registering irq %x\n", ret, lmh_data->irq);
--=20
2.51.0

