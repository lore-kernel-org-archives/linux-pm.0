From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: [RFC] Migrate to Hz resolution for OPP binding
Date: Tue, 20 May 2014 15:30:12 -0700
Message-ID: <672dd8e9-2857-49fb-848f-d38d38b23c9b@BN1BFFO11FD024.protection.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:28082
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751103AbaETWd1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 20 May 2014 18:33:27 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

Hi,

I guess this is just to evaluate how big the lynch mob will be. Anyway:
Triggered by this discussion https://lkml.org/lkml/2014/5/15/46, I
looked a little into what it would take to migrate everybody to Hz
frequency resolutions to avoid all the conversions between cpufreq, CCF=
,
OPPs, etc.
Turns out, OPPs are already stored in Hz resolution in the kernel, but =
the DT
bindings use kHz resolution to specify them in DT. So, code-wise there
is just a removal of a multiplication in the OPP parser (see below), bu=
t
then there are the DT bindings...

As plan B, I was thinking to add the property 'operating-points-hz'...

Any better ideas?


diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index 25538675d59e..61795111e8ca 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -731,7 +731,7 @@ int of_init_opp_table(struct device *dev)
=20
 	val =3D prop->value;
 	while (nr) {
-		unsigned long freq =3D be32_to_cpup(val++) * 1000;
+		unsigned long freq =3D be32_to_cpup(val++);
 		unsigned long volt =3D be32_to_cpup(val++);
=20
 		if (dev_pm_opp_add(dev, freq, volt)) {


	Thanks,
	S=C3=B6ren

