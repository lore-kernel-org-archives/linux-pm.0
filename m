From: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid of
	most	#ifdef CONFIG_PM
Date: Tue, 4 Mar 2008 02:26:58 +0300
Message-ID: <20080303232658.GB27395__39985.6234355413$1204588238$gmane$org@zarina>
References: <20080302234308.GA10116@zarina>
	<20080302160820.1930a770@laptopd505.fenrus.org>
Reply-To: cbouatmailru@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080302160820.1930a770@laptopd505.fenrus.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Mar 02, 2008 at 04:08:20PM -0800, Arjan van de Ven wrote:
> On Mon, 3 Mar 2008 02:43:08 +0300
> Anton Vorontsov <cbouatmailru@gmail.com> wrote:
> 
> > Currently drivers handle CONFIG_PM this way:
> > 
> > #ifdef CONFIG_PM
> > drv_suspend() {}
> > drv_resume() {}
> > #else
> > #define drv_suspend NULL
> > #define drv_resume NULL
> > #endif
> > 
> > struct driver drv = {
> > 	.suspend = drv_suspend,
> > 	.resume = drv_resume,
> > };
> > 
> > With this patch, the code above converts into:
> > 
> > drv_suspend() {}
> > drv_resume() {}
> > 
> > struct driver drv = {
> > 	.suspend = pm_call(drv_suspend),
> > 	.resume = pm_call(drv_resume),
> > };
> > 
> > GCC will optimize away suspend/resume calls if they're really
> > not used.
> > 
> 
> 
> to be honest, at this point I would think it's time to remove
> CONFIG_PM, or rather,
> just make it always be there and just get rid of the ifdefs.

Don't be so CONFIG_PM-centric :-)

$ zcat /proc/config.gz | grep CONFIG_PM
# CONFIG_PM is not set

This is machine I use at home.

> We're saving 2 words and a bit of code,
> but only a case that not even the embedded guys use. 

Well, on my ARM machine, with CONFIG_PM=y vmlinux grows by 30KB, half
of that is in drivers/. 30KB is 1% of the vmlinux. Is it enough to
worth saving? I don't know.

On a x86 box, CONFIG_PM=y grows the vmlinux by 400KB (yeah, it's
including ACPI and stuff), though here I didn't count drivers'
suspend/resume hooks contribution share.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
