From: Greg KH <gregkh@suse.de>
Subject: Re: platform_bus: Allow runtime PM by default
Date: Fri, 23 Apr 2010 08:05:28 -0700
Message-ID: <20100423150528.GB7648__19126.3479450301$1272035475$gmane$org@suse.de>
References: <1269625370-17754-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20100422235353.GA16310@kroah.com>
	<20100423105750.GA27232@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100423105750.GA27232@rakim.wolfsonmicro.main>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, Apr 23, 2010 at 11:57:51AM +0100, Mark Brown wrote:
> On Thu, Apr 22, 2010 at 04:53:53PM -0700, Greg KH wrote:
> > On Fri, Mar 26, 2010 at 05:42:50PM +0000, Mark Brown wrote:
> 
> > > Change the default implementation to the standard pm_generic_runtime
> > > one, allowing drivers to use runtime PM without per-architecture
> > > changes.
> 
> > That's nice, but it breaks the build on my system:
> >   CC      drivers/base/platform.o
> > drivers/base/platform.c: In function ???platform_pm_runtime_suspend???:
> > drivers/base/platform.c:970: error: implicit declaration of function ???pm_generic_runtime_suspend???
> > drivers/base/platform.c: In function ???platform_pm_runtime_resume???:
> > drivers/base/platform.c:975: error: implicit declaration of function ???pm_generic_runtime_resume???
> > drivers/base/platform.c: In function ???platform_pm_runtime_idle???:
> > drivers/base/platform.c:980: error: implicit declaration of function ???pm_generic_runtime_idle???
> > make[1]: *** [drivers/base/platform.o] Error 1
> > make: *** [_module_drivers/base] Error 2
> 
> > Care to fix it up?
> 
> This depends on "PM: Provide generic subsystem-level callbacks" which is
> in Linus' tree - which kernel version are you building against and with
> what config?  Things work fine for me in -next...

I was using Linus's latest tree as of yesterday when this failed.  Are
you relying on something in -next that is not in Linus's tree?

thanks,

greg k-h
