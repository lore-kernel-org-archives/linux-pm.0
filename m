From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 4 Jan 2008 12:48:32 +0100
Message-ID: <20080104114832.GA4114__23190.9775211991$1199447494$gmane$org@elf.ucw.cz>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Yi Yang <yi.y.yang@intel.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> If a device can't support wakeup, its /sys/devices/.../power/wakeup output is
> empty, this is confusing, a user doesn't know if it supports wakeup feature
> unless he/she read the ralated source code, for this case, it is more
> reasonable to output "unsupported". Otherwise, no matter what value the user
> sets to /sys/devices/.../power/wakeup, the result is the same:  Invalid argument,
> so the user doesn't know why.
> 
> This patch changes empty output to "unsupported" in order that a user knows
> wakeup feature isn't supported by this device when he/she
> 'cat /sys/devices/.../power/wakeup', please consider to apply,
> thanks.

What about simply removing "wakuep" file if wakeup is not supported?
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
