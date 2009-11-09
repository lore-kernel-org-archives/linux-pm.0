From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [alsa-devel] [PATCH 1/2 v2] ASoC: sh: fsi: Add
	runtime PM	support
Date: Mon, 9 Nov 2009 13:31:36 +0000
Message-ID: <20091109133136.GC1245__2616.79335167191$1257773663$gmane$org@sirena.org.uk>
References: <ud43sjtaf.wl%morimoto.kuninori@renesas.com>
	<20091109105858.GB1245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091109105858.GB1245@sirena.org.uk>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kuninori Morimoto <morimoto.kuninori@renesas.com>
Cc: alsa-devel@alsa-project.org, linux-pm@lists.linux-foundation.org, Magnus Damm <damm@opensource.se>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Nov 09, 2009 at 10:58:58AM +0000, Mark Brown wrote:

Adding in an address for Magnus which hopefully won't bounce and also
the linux-pm list which get_maintainers didn't find.

> On Mon, Nov 09, 2009 at 11:54:47AM +0900, Kuninori Morimoto wrote:
> > This patch add support runtime PM.
> > Driver callbacks for Runtime PM are empty because
> > the device registers are always re-initialized after
> > pm_runtime_get_sync(). The Runtime PM functions replaces the
> > clock framework module stop bit handling in this driver.
> 
> > Signed-off-by: Kuninori Morimoto <morimoto.kuninori@renesas.com>
> 
> Hrm.  I'll have to see how this plays with ASoC core pm_runtime support
> when that appears.  It should be OK as-is, I think.
> 
> > +	pm_suspend_ignore_children(&pdev->dev, true);
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_resume(&pdev->dev);
> 
> Why pm_suspend_ignore_all_children()?  I'd not expect the device to have
> any children and if it did it doesn't seem like an entirely safe
> assumption.
> 
> > +static int fsi_runtime_nop(struct device *dev)
> > +{
> > +	/* Runtime PM callback shared between ->runtime_suspend()
> > +	 * and ->runtime_resume(). Simply returns success.
> > +	 *
> > +	 * This driver re-initializes all registers after
> > +	 * pm_runtime_get_sync() anyway so there is no need
> > +	 * to save and restore registers here.
> > +	 */
> > +	return 0;
> > +}
> 
> This sets off alarm bells but it's perfectly reasonable, especially with
> platforms able to put things into a low power state with no explicit
> driver code now they can do power domain style things like SH.  I've
> CCed in the PM folks since this seems like a perfectly reasonable use
> case which ought to be handled more nicely.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
"You grabbed my hand and we fell into it, like a daydream - or a fever."
