From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH 06/07] usb: rework musb
	suspend()/resume_early()
Date: Wed, 24 Jun 2009 13:34:58 -0700
Message-ID: <20090624203458.GB28516__17889.5412282602$1245877291$gmane$org@suse.de>
References: <20090624092306.14276.127.sendpatchset@rx1.opensource.se>
	<20090624092400.14276.94490.sendpatchset@rx1.opensource.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090624092400.14276.94490.sendpatchset@rx1.opensource.se>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: ben-linux@fluff.org, hskinnemoen@atmel.com, anemo@mba.ocn.ne.jp, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, akpm@linux-foundation.org, linux-omap@vger.kernel.org, linux-pm@lists.linux-foundation.org, felipe.balbi@nokia.com
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 24, 2009 at 06:24:00PM +0900, Magnus Damm wrote:
> From: Magnus Damm <damm@igel.co.jp>
> 
> This patch reworks platform driver power management code
> for musb from legacy callbacks to dev_pm_ops.
> 
> The callbacks are converted for CONFIG_SUSPEND like this:
>   suspend() -> suspend()
>   resume_early() -> resume_noirq()
> 
> Signed-off-by: Magnus Damm <damm@igel.co.jp>
> ---
> 
>  Untested but compiles fine.
> 
>  drivers/i2c/busses/i2c-pxa.c |   25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> --- 0001/drivers/usb/musb/musb_core.c

I think you need to look at the tools you used to create this series,
the diffstat doesn't seem to match up here :)

thanks,

greg k-h
