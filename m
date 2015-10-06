From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] linux/thermal.h: rename KELVIN_TO_CELSIUS to
 DECI_KELVIN_TO_CELSIUS
Date: Tue, 6 Oct 2015 23:30:34 +0100
Message-ID: <20151006223034.GB43526@vmdeb7>
References: <1443735931-8406-1-git-send-email-linux@rasmusvillemoes.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:59880 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752847AbbJFWam (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 6 Oct 2015 18:30:42 -0400
Content-Disposition: inline
In-Reply-To: <1443735931-8406-1-git-send-email-linux@rasmusvillemoes.dk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, linux-pm@vger.kernel.org

On Thu, Oct 01, 2015 at 11:45:31PM +0200, Rasmus Villemoes wrote:
> The macros KELVIN_TO_CELSIUS and CELSIUS_TO_KELVIN actually convert
> between deciKelvins and Celsius, so rename them to reflect that. While
> at it, use a statement expression in DECI_KELVIN_TO_CELSIUS to prevent
> expanding the argument multiple times and get rid of a few casts.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

If Zhang and Rafael are happy with the termal change, then for the
resulting platform/drivers/x86 changes:

Acked-by: Darren Hart <dvhart@linux.intel.com>

-- 
Darren Hart
Intel Open Source Technology Center
