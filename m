From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/3] pm: domains: factor out code to get the generic PM
 domain from a struct device
Date: Thu, 26 Mar 2015 15:20:43 +0000
Message-ID: <20150326152043.GL8656@n2100.arm.linux.org.uk>
References: <20150320171941.GK8656@n2100.arm.linux.org.uk>
 <CAPDyKFrpM0TYnNvAX8Jw6zUAekh0=XXMJyxWxSgKSao=TQf62Q@mail.gmail.com>
 <20150323151740.GR8656@n2100.arm.linux.org.uk>
 <5429586.AxdftPXcBp@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:44310 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbCZPU7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 26 Mar 2015 11:20:59 -0400
Content-Disposition: inline
In-Reply-To: <5429586.AxdftPXcBp@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Tue, Mar 24, 2015 at 01:29:05AM +0100, Rafael J. Wysocki wrote:
> On Monday, March 23, 2015 03:17:40 PM Russell King - ARM Linux wrote:
> > Rafael, please merge these three as we previously agreed.  Thanks.
> 
> I said I would do that, didn't I?

I wasn't sure if you were going to hold back on it as a result of Uwe's
comments.

> I've applied this series plus https://patchwork.kernel.org/patch/6056201/
> and https://patchwork.kernel.org/patch/6057441/ on top of that.
> Please let me know if you need anything more from the core.

I'll replicate what you've applied and test it here (build in progress...)

Thanks!

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
