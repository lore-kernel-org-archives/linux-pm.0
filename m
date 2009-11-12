From: Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH -queue 1/2] [loongson] 2f: add suspend
	support framework
Date: Thu, 12 Nov 2009 20:03:21 +0100
Message-ID: <20091112190321.GA2887__39345.3468372629$1258052780$gmane$org@linux-mips.org>
References: <cover.1257922151.git.wuzhangjin@gmail.com>
	<1257922625.2922.97.camel@falcon.domain.org>
	<20091111103304.GB26423@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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
Cc: linux-mips@linux-mips.org, Len Brown <len.brown@intel.com>, yanh@lemote.com, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 11, 2009 at 11:33:04AM +0100, Pavel Machek wrote:

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

Thanks.  Queued for 2.6.33 with the comments cleaned up.

  Ralf
