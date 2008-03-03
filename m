From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid of
	most #ifdef CONFIG_PM
Date: Mon, 3 Mar 2008 01:29:28 +0100
Message-ID: <200803030129.29087.rjw__25844.8845510886$1204504415$gmane$org@sisk.pl>
References: <20080302234308.GA10116@zarina>
	<20080302160820.1930a770@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080302160820.1930a770@laptopd505.fenrus.org>
Content-Disposition: inline
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Monday, 3 of March 2008, Arjan van de Ven wrote:
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
> to be honest, at this point I would think it's time to remove CONFIG_PM, or rather,
> just make it always be there and just get rid of the ifdefs. We're saving 2 words and a bit of code,
> but only a case that not even the embedded guys use. 

All of the drivers' ->suspend() and ->resume() callbacks currently depend on
CONFIG_PM, which they shouldn't.

Still, we're going to introduce new callbacks for suspend/hibernation and the
$subject change will probably get us in the way.  Also, it won't be necessary
afterwards.

Thanks,
Rafael
