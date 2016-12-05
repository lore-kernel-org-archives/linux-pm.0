From: Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Subject: Re: [PATCH 2/2] driver core: Silence device links sphinx warning
Date: Mon, 5 Dec 2016 10:57:56 -0200
Message-ID: <20161205105756.73ca3780@vento.lan>
References: <cover.1480849144.git.lukas@wunner.de>
	<a1c7a93ee8ef057fb70aa3abeed38daf989444fc.1480849144.git.lukas@wunner.de>
	<20161205102030.2abae2b5@vento.lan>
	<20161205124449.GA7539@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161205124449.GA7539-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg
List-Id: linux-pm@vger.kernel.org

Em Mon, 5 Dec 2016 13:44:49 +0100
Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> escreveu:

> On Mon, Dec 05, 2016 at 10:20:53AM -0200, Mauro Carvalho Chehab wrote:
> > Em Sun, 4 Dec 2016 13:10:04 +0100 Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> escreveu:  
> > > Silence this warning emitted by sphinx:
> > > include/linux/device.h:938: warning: No description found for parameter 'links'
> > > 
> > > While at it, fix typos in comments of device links code.
> > > 
> > > Cc: Rafael J. Wysocki <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > > Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
> > > Cc: Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>
> > > Cc: Silvio Fricke <silvio.fricke-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> > > ---
> > >  drivers/base/core.c    | 4 ++--
> > >  include/linux/device.h | 1 +
> > >  2 files changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > > index d0c9df5..8c25e68 100644
> > > --- a/drivers/base/core.c
> > > +++ b/drivers/base/core.c
> > > @@ -172,7 +172,7 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
> > >   *
> > >   * The supplier device is required to be registered when this function is called
> > >   * and NULL will be returned if that is not the case.  The consumer device need
> > > - * not be registerd, however.
> > > + * not be registered, however.
> > >   */
> > >  struct device_link *device_link_add(struct device *consumer,
> > >  				    struct device *supplier, u32 flags)
> > > @@ -225,7 +225,7 @@ struct device_link *device_link_add(struct device *consumer,
> > >  	INIT_LIST_HEAD(&link->c_node);
> > >  	link->flags = flags;
> > >  
> > > -	/* Deterine the initial link state. */
> > > +	/* Determine the initial link state. */
> > >  	if (flags & DL_FLAG_STATELESS) {
> > >  		link->status = DL_STATE_NONE;
> > >  	} else {
> > > diff --git a/include/linux/device.h b/include/linux/device.h
> > > index 3896af4..87edfdf 100644
> > > --- a/include/linux/device.h
> > > +++ b/include/linux/device.h
> > > @@ -813,6 +813,7 @@ struct dev_links_info {
> > >   * 		on.  This shrinks the "Board Support Packages" (BSPs) and
> > >   * 		minimizes board-specific #ifdefs in drivers.
> > >   * @driver_data: Private pointer for driver specific info.
> > > + * @links:	Links to suppliers and consumers of this device.
> > >   * @power:	For device power management.
> > >   * 		See Documentation/power/admin-guide/devices.rst for details.
> > >   * @pm_domain:	Provide callbacks that are executed during system suspend,  
> > 
> > Hmm... I'm not seeing "links" at driver-core-next:
> > 	https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git/tree/include/linux/device.h?h=driver-core-next
> > 
> > On what tree did you base this patch?  
> 
> You're looking at the right tree, just maybe not the right line. :-)

Ah, OK! yeah, I was tricked by this:
	@@ -813,6 +813,7 @@ struct dev_links_info {

Need more caffeine ;)

> It's in line 887:
> 
> 	https://git.kernel.org/cgit/linux/kernel/git/gregkh/driver-core.git/tree/include/linux/device.h?h=driver-core-next#n887

Patch looks good on my eyes.

Reviewed-by: Mauro Carvalho Chehab <mchehab-JsYNTwtnfakRB7SZvlqPiA@public.gmane.org>

-- 
Thanks,
Mauro
