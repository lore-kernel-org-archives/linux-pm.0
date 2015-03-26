From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] pm: domains: factor out code to get the generic PM
 domain from a struct device
Date: Thu, 26 Mar 2015 16:00:08 +0000
Message-ID: <20150326160007.GP8656@n2100.arm.linux.org.uk>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
 <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
 <20150323151740.GR8656@n2100.arm.linux.org.uk>
 <5429586.AxdftPXcBp@vostro.rjw.lan>
 <20150326152043.GL8656@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44440 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbCZQAV (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 12:00:21 -0400
Content-Disposition: inline
In-Reply-To: <20150326152043.GL8656@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kevin Hilman <khilman@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Thu, Mar 26, 2015 at 03:20:43PM +0000, Russell King - ARM Linux wrote:
> I'll replicate what you've applied and test it here (build in progress...)

It looks like it works as desired.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
