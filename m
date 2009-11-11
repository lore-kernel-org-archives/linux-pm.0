From: Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH -queue 1/2] [loongson] 2f: add suspend
	support framework
Date: Wed, 11 Nov 2009 23:32:56 +0800
Message-ID: <1257953576.7308.27.camel__35131.2869847336$1257953766$gmane$org@falcon.domain.org>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
	<1257922625.2922.97.camel@falcon.domain.org>
	<20091111103304.GB26423@elf.ucw.cz>
Reply-To: wuzhangjin@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111103304.GB26423@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-mips@linux-mips.org, Len Brown <len.brown@intel.com>, yanh@lemote.com, Ralf Baechle <ralf@linux-mips.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi,

On Wed, 2009-11-11 at 11:33 +0100, Pavel Machek wrote:
> On Wed 2009-11-11 14:57:05, Wu Zhangjin wrote:
> > (Add CC to Rafael J. Wysocki, Len Brown and Pavel Machek)
> > 
> > This patch add basic suspend support for loongson2f family machines,
> > loongson2f have a specific feature: when we set it's frequency to ZERO,
> > it will go into a wait mode, and then can be waked up by the external
> > interrupt. so, if we setup suitable interrupts before putting it into
> > wait mode, we will be able wake it up whenever we want via sending the
> > relative interrupts to it.
> > 
> > These interrupts are board-specific, Yeeloong2F use the keyboard
> > interrupt and SCI interrupt, but LingLoong and Fuloong2F use the
> > interrupts connected to the processors directly. and BTW: some old
> > LingLoong and FuLoong2F have no such interrupts connected, so, there is
> > no way to wake them up from suspend mode. and therefore, please do not
> > enable the kernel support for them.
> > 
> > The board-specific support will be added in the coming patches.
> > 
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Comments are slighlty "interesting", but otherwise it looks ok.
> 
> > +	/* stop all perf counters */
> > +	stop_perf_counters();
> 
> This is not exactly useful comment, right?
> 
 
Will remove it later ;) the same to the following two.

> > +	/* mach specific suspend */
> > +	mach_suspend();
> ...
> > +	/* mach specific resume */
> > +	mach_resume();
> 
> 
> It is probably ok, but you may want to avoid them in future.
> 
> ACK.
> 									Pavel
> 

Thanks!
	Wu Zhangjin
