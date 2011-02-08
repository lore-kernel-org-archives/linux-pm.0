From: Tim Bird <tbird20d@gmail.com>
Subject: Re: [PATCH] Remove CONFIG_PM altogether,
 enable power management all the time
Date: Tue, 8 Feb 2011 15:35:32 -0800
Message-ID: <AANLkTimWnT8f=PyLgOOrZOaMx0pdv+yNtPw2T7=kO2G-__13619.0741476186$1297211722$gmane$org@mail.gmail.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102072046.48763.rjw@sisk.pl>
	<20110207201803.GU10564@opensource.wolfsonmicro.com>
	<201102072215.59921.rjw@sisk.pl> <20110208122159.GA8284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110208122159.GA8284@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 8, 2011 at 4:21 AM, Ingo Molnar <mingo@elte.hu> wrote:
> Rafael, could you do a defconfig-ish x86 build with and without CONFIG_PM, and post
> the 'size vmlinux' comparison - so that we can see the size difference? We make some
> things CONFIG_EXPERT configurable just to enable folks who *really* want to cut down
> on kernel size to configure it out.

I'm one of those people who *really* wants to cut down the kernel size.
I've recently worked on a product where the kernel RAM budget is ~1M.

>
> Note that those usecases, even if they want a super-small kernel, might not care
> about PM at all while they care about size: small boot kernels in ROMs, or simple
> devices where CPU-idling implies deep low power mode, etc.
>
> So the vmlinux size comparisons would be needed really. If it's 5k nobody will care.
I care about 5K.  (But honestly, I don't actively hunt stuff less than
10K in size, because
there's too many of them to chase, currently).

 -- Tim
