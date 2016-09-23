From: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>
Subject: Re: [PATCH v3 0/2] Exynos IOMMU: proper runtime PM support (use
	device dependencies)
Date: Fri, 23 Sep 2016 14:49:20 +0200
Message-ID: <6114649.EDczdxzVVo@vostro.rjw.lan>
References: <CGME20160913124917eucas1p23425d2cb1c24e73ae3c2927ec141fd30@eucas1p2.samsung.com>
	<57E05C68.80804@math.uni-bielefeld.de>
	<ef63bd8c-1797-cbf7-5c9e-ee2855c9e395@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ef63bd8c-1797-cbf7-5c9e-ee2855c9e395-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Marek Szyprowski <m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 20, 2016 10:51:13 AM Marek Szyprowski wrote:
> Hi All,
> 
> On 2016-09-19 23:45, Tobias Jakobi wrote:
> > I did some tests with the new version today. Sadly the reboot/shutdown
> > issues are still present.
> 
> Thanks for the report. I've managed to reproduce this issue and it is again
> caused by modifying device on devices_kset list before it will be finally
> added by device_add(). I thought that the new patchset allows creating links
> to a device, which has not been yet added to system device list.
> 
> Rafael:
> What is your opinion?

Well, this is a problem. :-)

> Should it be allowed to create a link to device, which
> has not yet been added to system device list by device_add()?

While it would be easy to require both the consumer and producer devices to
be registered for creating a link between them, that would just make it harder
to use links in the first place.

So ideally, it should be possible to create links between devices before
registering them, but since I didn't take that into account in the current
patch series, some quite substantial changes are needed to cover that.

Additional link states come to mind, but then the "stateless" links are
affected by this problem too.

> My code used to do that, because IOMMUs are configured from 
> of_platform_device_create_pdata()
> of_dma_configure() of_iommu_configure(), which happens before device_add().
> 
> To solve the reported corruption of devices_kset list, following change is
> needed:
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index aa8196508db9..4542ba9f60d4 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1039,11 +1039,18 @@ static void devices_kset_move_after(struct 
> device *deva, struct device *devb)
>    */
>   void devices_kset_move_last(struct device *dev)
>   {
> +       struct device *d;
> +
>          if (!devices_kset)
>                  return;
>          pr_debug("devices_kset: Moving %s to end of list\n", 
> dev_name(dev));
>          spin_lock(&devices_kset->list_lock);
> -       list_move_tail(&dev->kobj.entry, &devices_kset->list);
> +       list_for_each_entry(d, &devices_kset->list, kobj.entry) {
> +               if (d == dev) {
> +                       list_move_tail(&dev->kobj.entry, 
> &devices_kset->list);
> +                       break;
> +               }
> +       }
>          spin_unlock(&devices_kset->list_lock);
>   }
> 
> 
> If you think that links can be created only to a device, which has been 
> fully
> added to the system, I will register a bus notifier and create a link on 
> consumers
> device probe then.

That would be a workaround for a coverage gap, so not particularly attractive.

Thanks,
Rafael
