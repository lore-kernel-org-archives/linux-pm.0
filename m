From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: Re: [PATCH v2 07/13] power: bq24257: Extend scope of mutex protection
Date: Thu, 10 Sep 2015 16:43:10 +0300
Message-ID: <20150910134309.GI21512@lpalcu-desk>
References: <1441757557-7266-1-git-send-email-dannenberg@ti.com>
 <1441757557-7266-8-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:27783 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752602AbbIJNnN (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 10 Sep 2015 09:43:13 -0400
Content-Disposition: inline
In-Reply-To: <1441757557-7266-8-git-send-email-dannenberg@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andreas Dannenberg <dannenberg@ti.com>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org

On Tue, Sep 08, 2015 at 07:12:31PM -0500, Andreas Dannenberg wrote:
> This commit extends the use of the existing mutex to pave the way for
> using direct device access inside sysfs getter/setter routines in a
> way that the access during interrupts and timer routines does not
> interfere with device access by the CPU or between multiple cores.
> 
> This also addresses a potential race condition that could be caused
> by bq24257_irq_handler_thread() and bq24257_iilimit_autoset() accessing
> the device simultaneously.
What potential race? AFAIK, we're doing all the operations through
regmap, and regmap operations are serialized. It has its own mutex for
this. Unless I got it all wrong...

So, IMHO, you don't need to protect against simultaneous device access.
It's taken care of by regmap. Chip state data protection should be enough.

laurentiu


