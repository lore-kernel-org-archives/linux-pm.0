From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: Re: [PATCH 1/2] acpi: Added acpi_subtable_proc to ACPI table parsers
Date: Wed,  9 Sep 2015 15:47:26 +0200
Message-ID: <1441806449-27481-1-git-send-email-lukasz.anaczkowski@intel.com>
References: <55F00E55.9080008@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:53423 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751947AbbIINri (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 9 Sep 2015 09:47:38 -0400
In-Reply-To: <55F00E55.9080008@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: marc.zyngier@arm.com, lorenzo.pieralisi@arm.com, tomasz.nowicki@linaro.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, jason@lakedaemon.net
Cc: rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

From: Marc Zyngier [mailto:marc.zyngier@arm.com] 
Sent: Wednesday, September 9, 2015 12:48 PM

> Nit: Please add a version number to the patches you send - this is at
> least the 4th revision of this series, and it is harder to keep track of
> what I'm reviewing. git send-email --subject-prefix "PATCH v4" is your
> friend.

Oh... so this is how you do that! Thanks!
Let me put 'v4' on this series and I'll start counting from that.

> If you respin it to address the above minor
> comments, you can add my:

> Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
> Tested-by: Marc Zyngier <marc.zyngier@arm.com>

I've incorporated your comments and putting tags into 1/2 patch.
Thanks, Marc, for all your support!

Cheers,
Lukasz


