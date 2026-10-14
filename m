Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CB4A2A6D
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009219; cv=none; b=o4Tu825vcKN6V4oqXhcV+jaUVrqatf1OkRiNXaK+iqHY8XyuztW7FWWvQi5pBnsdQeOBqy+Ppka7xX9YNZ+O1ezK8uDB/GJR7lPQCBJtBIIJsfB6rm58uMRRHdhSAgeM6CDrb2rwnGU8AvuySEGYasjLidx/H3MiOGQNX/CF1/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009219; c=relaxed/simple;
	bh=R7JR22Zek+jal8Sl0lZ4s2uTD51HF5iTPDu3kpV3W+4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uBYF73ZKfuiekzC9Hxza8AJDFz6Mc48ogoFMzlll7R9TSn/Vcd/kBDZ7AtkEvtO9azakH9nctjNJ4JVkAEb48BcrpAEItZ87x3xFrgAIshbKdBrlsNDggjeicWloDpKcFFWTyV8layzqNbY0+coW4LZpjTYaBqf1w2Mn5YC24Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ao4JzbPn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ym7jSars; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ao4JzbPn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ym7jSars"
Date: Wed, 14 Oct 2026 20:20:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1792009216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWn786j2a1McLGdXmBNo4oKZMQb3s6N7w82gm/5efSs=;
	b=Ao4JzbPn1pb3OJ3g5OPf1s61VnMc6DQPWOhm/dBgr590LJ6BLsrLYEtwBv6iQfbdmZdGRM
	dJOyS3pmuGZhIOc9QnDW7fQnl6XzGjR5eCn5My6IyQkEbTUd+M4evSqlmNIfjIspfaBixB
	5dARmWebzOnXshKJgX59mHpM/a01o7zb4aA9vg3lYem8QLR0SGwvzbqm/Zoj4qIynX8i++
	aknqvBy4ISmDTXjb+alFO9yevLO8j1oeQ8eQA/BqstMzoCUjINO6eNCRxXnT69x53arGJ9
	YLzaiHSoeh4UN3aRCCC5V2ydUZvqD0vSzfPl2URPOViZRkDtaOE9/bzWxGDMlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1792009216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kWn786j2a1McLGdXmBNo4oKZMQb3s6N7w82gm/5efSs=;
	b=ym7jSarshWvOs0f51K4VfuXMYNXHIYUd/mlxym+OVBQO7GajppfOq2w4tmUDgLrxtJgIQW
	TKGedkoV4l9+vdAg==
From: "thermal-bot for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Subject: [thermal: thermal/linux-next] thermal/drivers/imx9: Constify struct
 thermal_zone_device_ops
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Lezcano <daniel.lezcano@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 daniel.lezcano@oss.qualcomm.com
In-Reply-To: =?utf-8?q?=3C5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88=2E1786220?=
 =?utf-8?q?585=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3C5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88=2E17862205?=
 =?utf-8?q?85=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <179200921466.2666337.15805909552359196463.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the thermal/linux-next branch of th=
ermal:

Commit-ID:     e7cfcccd8c38ba674240636d882da879c904296a
Gitweb:        https://git.kernel.org/pub/scm/linux/kernel/git/thermal/linux.=
git//e7cfcccd8c38ba674240636d882da879c904296a
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Sat, 08 Aug 2026 22:23:33 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@kernel.org>
CommitterDate: Fri, 18 Sep 2026 12:15:51 +02:00

thermal/drivers/imx9: Constify struct thermal_zone_device_ops

'struct thermal_zone_device_ops' is not modified in this driver.

Constifying this structure moves some data to a read-only section, so
increases overall security, especially when the structure holds some
function pointers.

On a x86_64, with allmodconfig:
Before:
=3D=3D=3D=3D=3D=3D
   text	   data	    bss	    dec	    hex	filename
   8567	   2144	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o

After:
=3D=3D=3D=3D=3D
   text	   data	    bss	    dec	    hex	filename
   8695	   2016	      0	  10711	   29d7	drivers/thermal/imx91_thermal.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/5cce9ea713edcf2aa3c0efd5d31e9d9fd9f40a88.17862=
20585.git.christophe.jaillet@wanadoo.fr
---
 drivers/thermal/imx91_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx91_thermal.c b/drivers/thermal/imx91_thermal.c
index 274eee3..196ee20 100644
--- a/drivers/thermal/imx91_thermal.c
+++ b/drivers/thermal/imx91_thermal.c
@@ -225,7 +225,7 @@ static int imx91_tmu_change_mode(struct thermal_zone_devi=
ce *tz, enum thermal_de
 	return 0;
 }
=20
-static struct thermal_zone_device_ops tmu_tz_ops =3D {
+static const struct thermal_zone_device_ops tmu_tz_ops =3D {
 	.get_temp =3D imx91_tmu_get_temp,
 	.change_mode =3D imx91_tmu_change_mode,
 	.set_trips =3D imx91_tmu_set_trips,
