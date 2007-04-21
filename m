From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] s2ram: add arch irq disable/enable hooks
Date: Sat, 21 Apr 2007 16:07:14 +0200
Message-ID: <20070421140601.GC1922@elf.ucw.cz>
References: <1176980411.6141.83.camel@johannes.berg>
	<1177163853.5941.21.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1177163853.5941.21.camel@johannes.berg>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Sat 2007-04-21 15:57:33, Johannes Berg wrote:
> For powermac, we need to do some things between suspending devices and
> device_power_off, for example setting the decrementer. This patch allows
> architectures to have arch_s2ram_{en,dis}able_irqs functions to control
> this step.
> 
> This patch also replaces local_irq_save/restore with
> local_irq_disable/enable since the code must be called with interrupts
> enabled.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

ACK.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
