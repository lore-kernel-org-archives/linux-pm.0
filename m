From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] base: Change power/wakeup output from "" to
	"unsupported" if wakeup feature isn't supported by a device
Date: Fri, 04 Jan 2008 08:09:33 -0800
Message-ID: <20080104160933.B01D81FBAB5__23516.134490683$1199463064$gmane$org@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
References: <1199441414.19185.9.camel@yangyi-dev.bj.intel.com>
	<20080104114832.GA4114@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080104114832.GA4114@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: yi.y.yang@intel.com, pavel@ucw.cz
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> > This patch changes empty output to "unsupported" in order that a user knows
> > wakeup feature isn't supported by this device when he/she
> > 'cat /sys/devices/.../power/wakeup', please consider to apply,
> > thanks.
>
> What about simply removing "wakuep" file if wakeup is not supported?

It may not *stay* unsupported, so I think changing it in either
of those permanent ways would be confusing/misleading.

For example, USB devices have multiple states ... minimally, an
unconfigured state, and a configured state.  Some have multiple
configurations.  Only configured states can be wakeup-capable.
So a given device might have three states, but support wakeup
except in one of them...

- Dave
