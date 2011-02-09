From: Frank Rowand <frank.rowand@gmail.com>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Wed, 09 Feb 2011 11:00:17 -0800
Message-ID: <4D52E441.2000805__48761.1518278301$1297355541$gmane$org@am.sony.com>
References: <4D51D341.3040209@am.sony.com>
	<20110209114137.GA10163@opensource.wolfsonmicro.com>
	<201102091807.03094.rjw@sisk.pl> <4D52DD81.7050401@am.sony.com>
	<20110209184010.GB23747@opensource.wolfsonmicro.com>
Reply-To: frank.rowand@am.sony.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110209184010.GB23747@opensource.wolfsonmicro.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <len.brown@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-embedded@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 02/09/11 10:40, Mark Brown wrote:
> On Wed, Feb 09, 2011 at 10:31:29AM -0800, Frank Rowand wrote:
> 
>> Raphael's patch will turn on CONFIG_PM in the correct circumstances, and
>> leave it off when not needed by other config options.  That means that
>> the size overhead will _not_ be an issue for me because CONFIG_PM
>> will not be enabled when not needed.
> 
> That's not the issue you seemed to be raising, though.  While PM is now
> turned on by PM_SLEEP that'll end up getting turned on by default due to
> the dependency on SUSPEND - you appeared to be raising the concern that
> this could happen and surprise users.

No, that is not my concern.  I was saying that Raphael's patches do
not trigger any concern from me.

My concern was that in your very first email that started this thread,
you wrote:

On 02/07/11 04:22, Mark Brown wrote:
> It is very rare to find a current system which is both sufficiently
> resource constrained to want to compile out power management support
> and sufficiently power insensitive to be able to tolerate doing so.
> Since having the configuration option requires non-zero effort to
> maintain, with ifdefery in most drivers, but it is used with vanishing
> rarity it is simpler to just remove the option.

and my understanding of this proposal was a goal to remove the ability
to have CONFIG_PM disabled, which results in increased memory usage
for some configurations.

-Frank
