From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [FOR DISCUSSION 0/9] Dove PMU support
Date: Fri, 20 Mar 2015 17:19:41 +0000
Message-ID: <20150320171941.GK8656@n2100.arm.linux.org.uk>
References: <20150312183020.GU8656@n2100.arm.linux.org.uk>
 <1824813.kJQ02QuMbA@vostro.rjw.lan>
 <20150320121659.GJ8656@n2100.arm.linux.org.uk>
 <1466359.8taRhRkKWI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:59753 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751077AbbCTRVH (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 13:21:07 -0400
Content-Disposition: inline
In-Reply-To: <1466359.8taRhRkKWI@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Len Brown <len.brown@intel.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, linux-arm-kernel@lists.infradead.org

On Fri, Mar 20, 2015 at 01:44:30PM +0100, Rafael J. Wysocki wrote:
> Both work for me, actually.  I think that Kevin has ACKed the patch despite
> the comments, so it would be fine to apply it I guess.

Here's the set of three - with the second one reworked.

 drivers/base/power/domain.c | 58 +++++++++++++++++++++++++++++----------------
 include/linux/pm_domain.h   |  6 ++---
 2 files changed, 40 insertions(+), 24 deletions(-)

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
