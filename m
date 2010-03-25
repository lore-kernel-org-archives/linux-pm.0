From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] i2c: Fix bus-level power management callbacks
Date: Thu, 25 Mar 2010 09:28:02 +0000
Message-ID: <20100325092802.GA27729__47019.6510701955$1269509354$gmane$org@rakim.wolfsonmicro.main>
References: <201003132204.30905.rjw@sisk.pl> <201003192344.09000.rjw@sisk.pl>
	<20100325095720.0b115056@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100325095720.0b115056@hyperion.delvare>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-pm@lists.linux-foundation.org, Linux I2C <linux-i2c@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 25, 2010 at 09:57:20AM +0100, Jean Delvare wrote:

> Mark, you contributed the initial runtime PM support for the i2c
> subsystem, I thought you would have comments on Rafael's
> reimplementation?

Yeah, see below...

> >  drivers/i2c/i2c-core.c     |  168 ++++++++++++++++++++++++++-------------------
> >  include/linux/pm_runtime.h |    7 +

> I am a little surprised to see changes to a generic header file here,
> how is the i2c subsystem so special that we have needs other subsystems
> did not?

Very few subsystems actually support runtime PM thus far - I think it's
more the case that I2C is an early user than anything else.

> Apart from the above, the code looks sane to me, but then again I don't
> know a thing about power management. I'll keep this patch in my i2c
> tree, scheduled for merge in 2.6.35. If there are any updates, please
> send them over, either as a new patch or as incremental changes which I
> will merge myself.

I'm in a similar position - the code looks fine except I'm not 100% sure
I follow all the possible ifdefs and I've never actually used hibernate
(s2disk isn't supported on ARM) but for what it's worth:

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
