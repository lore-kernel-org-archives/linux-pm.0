From: Olaf Hering <olaf@aepfle.de>
Subject: Re: adjusting broken ACPI thermal trip points
Date: Fri, 2 Oct 2015 09:23:27 +0200
Message-ID: <20151002072327.GA16599@aepfle.de>
References: <20151001161622.GA21024@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.220]:44316 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbbJBHXd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 2 Oct 2015 03:23:33 -0400
Received: from probook.fritz.box ([2001:a62:17:8701:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.12 AUTH)
	with ESMTPSA id u06669r927NToJl
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <linux-pm@vger.kernel.org>;
	Fri, 2 Oct 2015 09:23:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20151001161622.GA21024@aepfle.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

On Thu, Oct 01, Olaf Hering wrote:

> Thats because I saw during make oldconfig a new config option which is
> supposed to avoid such hack. But so far I have not seen the
> corresponding sysfs files to tweak the trip points at runtime.

Why does acpi_thermal_register_thermal_zone call
thermal_zone_device_register with mask=0? IMO the core should remember
that trip_point_temp_store was called and reused that value instead of
reusing broken firmware values again and again...

Olaf
