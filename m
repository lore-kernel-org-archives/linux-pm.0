From: Olaf Hering <olaf@aepfle.de>
Subject: adjusting broken ACPI thermal trip points
Date: Thu, 1 Oct 2015 18:16:22 +0200
Message-ID: <20151001161622.GA21024@aepfle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.160]:38677 "EHLO
	mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752232AbbJAQWp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 1 Oct 2015 12:22:45 -0400
Received: from probook.fritz.box ([2001:a62:17:8701:1ec1:deff:feb9:bb48])
	by smtp.strato.de (RZmta 37.12 AUTH)
	with ESMTPSA id u02acdr91GGOgZf
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
	(Client did not present a certificate)
	for <linux-pm@vger.kernel.org>;
	Thu, 1 Oct 2015 18:16:24 +0200 (CEST)
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

My HP ProBook 6555b has broken trip points. As a result the fan is
either off, or running at full speed until it cooled down, the its off
again.

How is this supposed to be handled?


And the long version is:

Initially I reported https://bugzilla.kernel.org/show_bug.cgi?id=67101
and provided some details about the machine and I was pointed to some
patches in https://bugzilla.kernel.org/show_bug.cgi?id=78201. At some
point the mainboard was replaced by HP, and it got a new firmware.  This
one is appearently (still?) broken, the trip points are wrong. I used
the patches from #78201 and added a hack ontop which forced sane values
in ACPI code. This worked well enough for me to not be constantly
annoyed by the noise changes.

This week I checked the state of #78201 again and noticed some or all of
the suggested changes are in mainline, which is what runs right now.
This allows me to manually start the fan by writing to sysfs, just like
I have done it in the last months. But I have not yet ported my hack for
the ACPI core (acpi_thermal_trips_update) to adjust the hardware trip points.

Thats because I saw during make oldconfig a new config option which is
supposed to avoid such hack. But so far I have not seen the
corresponding sysfs files to tweak the trip points at runtime.

So what should be done for this machine? Fix the firmware during boot
with some custom DSDT as suggested in comment #35, use that new
trip-adjustment interface, or something else?


Another question: how does one control the fan speed anyway? I think the
firmware provides no info about the current state of the fan, if and how
fast it runs. It looks like the only way to decide which of the three
states should be activated is to poll the current temperature and enable
one of the states. Are there already GUI tools to control fan behaviour?

Olaf
