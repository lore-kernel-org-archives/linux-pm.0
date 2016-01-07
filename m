From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v1 7/8] ata: hpt366: convert to use match_string() helper
Date: Thu, 7 Jan 2016 10:44:32 -0500
Message-ID: <20160107154432.GG29797@mtj.duckdns.org>
References: <1452168368-75630-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <1452168368-75630-7-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:34156 "EHLO
	mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751534AbcAGPoe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2016 10:44:34 -0500
Content-Disposition: inline
In-Reply-To: <1452168368-75630-7-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, David Airlie <airlied@linux.ie>, Andrew Morton <akpm@linux-foundation.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>

On Thu, Jan 07, 2016 at 02:06:07PM +0200, Andy Shevchenko wrote:
> The new helper returns index of the mathing string in an array. We would use it
> here.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Tejun Heo <tj@kernel.org>

Please feel free to route as you see fit.

Thanks.

-- 
tejun
