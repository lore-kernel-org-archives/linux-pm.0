From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v2] Thermal: ACPI INT3403 thermal driver
Date: Thu, 02 Jan 2014 09:50:42 +0800
Message-ID: <1388627442.3739.66.camel@rzhang1-mobl4>
References: <1388436906-16295-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46752 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750704AbaABBus (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 1 Jan 2014 20:50:48 -0500
In-Reply-To: <1388436906-16295-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: eduardo.valentin@ti.com, linux-pm@vger.kernel.org

On Mon, 2013-12-30 at 12:55 -0800, Srinivas Pandruvada wrote:
> The ACPI INT3403 device objects present on some systems can be used to retrieve
> temperature data from thermal sensors. Add a driver registering each INT3403
> device object as a thermal zone device and exposing its _TMP, PATx and GTSH
> method via the standard thermal control interface under /sys/class/thermal/.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

applied.

thanks,
rui

