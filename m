From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v4] cpuidle: Add a sysfs entry to disable
 specific C state for debug purpose.
Date: Sun, 18 Mar 2012 10:38:54 -0300
Message-ID: <20120318133854.GA27981@khazad-dum.debian.net>
References: <1331013078.1916.103.camel@ymzhang>
	<20120306143935.GA23346@kroah.com>
	<20120312181151.GE14020@sirena.org.uk>
	<20120312192936.GC24873@kroah.com>
	<1331602594.1916.155.camel@ymzhang>
	<20120313192949.GA8568@kroah.com>
	<1331686500.1916.172.camel@ymzhang>
	<20120314024619.GC22955@kroah.com> <4F600F78.2060902@intel.com>
	<20120316143355.f2dddbbd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20120316143355.f2dddbbd.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Brown, Len" <len.brown@intel.com>, Yanmin Zhang <yanmin_zhang@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, shuox.liu@intel.com, Mark Brown <broonie@opensource.wolfsonmicro.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, andi.kleen@intel.com, Ingo Molnar <mingo@elte.hu>, "linux-pm@lists.linux-foundation.org" <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Fri, 16 Mar 2012, Andrew Morton wrote:
> > +#define define_store_state_function(_name) \
> > +static ssize_t store_state_##_name(struct cpuidle_state *state, \
> > +		const char *buf, size_t size) \
> > +{ \
> > +	long value; \
> > +	if (!capable(CAP_SYS_ADMIN)) \
> > +		return -EPERM; \
> 
> Is the capability check required?  The 0644 permissions aren't sufficient?

That depends.  Without capable(), restricted root (one which had its
capabilities dropped) can disable idle states.

If you want to restrict something to "root only", IMHO it should be
using capable(), as restricted root really doesn't qualify for "root
only" things.

If you wanted to restrict it to "owner only" OTOH, then yes, the
capable() check (especially with the very coarse set of capabilities we
currently have) might not be desireable.

However, if we had a power-management capability, it would be best to
use that one instead of CAP_SYS_ADMIN (aka "the new root" as LWN called
it).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
