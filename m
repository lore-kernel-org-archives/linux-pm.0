From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid of
 most #ifdef CONFIG_PM
Date: Sun, 2 Mar 2008 16:08:20 -0800
Message-ID: <20080302160820.1930a770__40486.2483534545$1204503030$gmane$org@laptopd505.fenrus.org>
References: <20080302234308.GA10116@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080302234308.GA10116@zarina>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 3 Mar 2008 02:43:08 +0300
Anton Vorontsov <cbouatmailru@gmail.com> wrote:

> Currently drivers handle CONFIG_PM this way:
> 
> #ifdef CONFIG_PM
> drv_suspend() {}
> drv_resume() {}
> #else
> #define drv_suspend NULL
> #define drv_resume NULL
> #endif
> 
> struct driver drv = {
> 	.suspend = drv_suspend,
> 	.resume = drv_resume,
> };
> 
> With this patch, the code above converts into:
> 
> drv_suspend() {}
> drv_resume() {}
> 
> struct driver drv = {
> 	.suspend = pm_call(drv_suspend),
> 	.resume = pm_call(drv_resume),
> };
> 
> GCC will optimize away suspend/resume calls if they're really
> not used.
> 


to be honest, at this point I would think it's time to remove CONFIG_PM, or rather,
just make it always be there and just get rid of the ifdefs. We're saving 2 words and a bit of code,
but only a case that not even the embedded guys use. 
