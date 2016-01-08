From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v1 2/8] device property: convert to use match_string()
 helper
Date: Fri, 8 Jan 2016 15:01:13 +0200
Message-ID: <20160108130113.GM1770@lahna.fi.intel.com>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1452168368-75630-2-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2841 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754571AbcAHNBZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 8 Jan 2016 08:01:25 -0500
Content-Disposition: inline
In-Reply-To: <1452168368-75630-2-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Tejun Heo <tj@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, Jan 07, 2016 at 02:06:02PM +0200, Andy Shevchenko wrote:
> The new helper returns index of the mathing string in an array. We would use it
> here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
