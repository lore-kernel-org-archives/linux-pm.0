From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 update 4/4] Thermal: add INT3406 thermal driver
Date: Sat, 14 May 2016 00:05:24 +0200
Message-ID: <5104945.McBGKbKeb7@vostro.rjw.lan>
References: <1461761105-5961-1-git-send-email-aaron.lu@intel.com> <20160509075458.GA8945@aaronlu.sh.intel.com> <1462867730.25391.2.camel@rzhang1-mobl4>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41921 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753759AbcEMWCA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 13 May 2016 18:02:00 -0400
In-Reply-To: <1462867730.25391.2.camel@rzhang1-mobl4>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Zhang, Rui" <rui.zhang@intel.com>, "Lu, Aaron" <aaron.lu@intel.com>
Cc: "jingoohan1@gmail.com" <jingoohan1@gmail.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tuesday, May 10, 2016 08:08:52 AM Zhang, Rui wrote:
> On Mon, 2016-05-09 at 15:54 +0800, Aaron Lu wrote:
> > INT3406 ACPI device object resembles an ACPI video output device, but its
> > _BCM is said to be deprecated and should not be used. So we will make
> > use of the raw interface to do the actual cooling.
> > 
> > Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> 
> Acked-by: Zhang Rui <rui.zhang@intel.com>

Applied, thanks!

