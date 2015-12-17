From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: s3c2410: remove superfluous runtime PM calls
Date: Thu, 17 Dec 2015 09:46:55 +0000
Message-ID: <20151217094655.GV6058@localhost.localdomain>
References: <1450203249-4873-1-git-send-email-wsa@the-dreams.de>
 <56716CC3.50309@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56716CC3.50309@samsung.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 16, 2015 at 02:53:07PM +0100, Sylwester Nawrocki wrote:
> On 15/12/15 19:14, Wolfram Sang wrote:
> > Since commit 6ada5c1e1b077a ("i2c: Mark adapter devices with
> > pm_runtime_no_callbacks"), runtime PM on adapters turned into a no-op.
> > So, we can remove these calls.
> 
> Won't this break i2c client devices that use runtime PM? Not sure
> if any cases of such client exist now, I'll try to find some time
> to test this change.
> 

Our CODECs can be controlled over I2C and use runtime PM.
However, this change doesn't seem to have any adverse effect on
them that I can find.

Tested-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>

> IIRC client's pm_runtime* calls return error if their parent device's
> runtime PM is not enabled. Also enabling runtime PM on the i2c adapter
> allows propagating runtime PM calls up to its parent - the i2c
> controller platform device.
> 
> So perhaps in your patch we should only remove pm_runtime_get_sync,
> pm_runtime_put calls, leaving runtime PM on the adapter enabled.
> For any future cases where the Exynos I2C controller is not in an
> always on power domain the runtime PM handling in this driver would
> need to be further reworked anyway.
> 
> Perhaps we could just enable/disable adapter's runtime PM in i2c core.
> 

Afraid not sure I can comment on this part.

Thanks,
Charles
