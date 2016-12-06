From: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] Documentation/core-api/device_link: Add initial
	documentation
Date: Tue, 6 Dec 2016 02:41:50 +0100
Message-ID: <20161206014150.GY1402@wotan.suse.de>
References: <cover.1480849144.git.lukas@wunner.de>
	<f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Hanjun Guo <guohanjun-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jonathan Corbet <corbet-T1hC0tSOHrs@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Christoph Hellwig <hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Tomeu Vizoso <tom>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 04, 2016 at 01:10:04PM +0100, Lukas Wunner wrote:
> Document device links as introduced in v4.10 with commits:
>     4bdb35506b89 ("driver core: Add a wrapper around
>                    __device_release_driver()")
>     9ed9895370ae ("driver core: Functional dependencies tracking
>                    support")
>     8c73b4288496 ("PM / sleep: Make async suspend/resume of devices use
>                    device links")
>     21d5c57b3726 ("PM / runtime: Use device links")
>     baa8809f6097 ("PM / runtime: Optimize the use of device links")
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>

First, thanks for doing this work.

> ---
>  Documentation/core-api/device_link.rst | 279 +++++++++++++++++++++++++++++++++
>  Documentation/core-api/index.rst       |   8 +
>  2 files changed, 287 insertions(+)
>  create mode 100644 Documentation/core-api/device_link.rst
> 
> diff --git a/Documentation/core-api/device_link.rst b/Documentation/core-api/device_link.rst
> new file mode 100644
> index 0000000..5f57134
> --- /dev/null
> +++ b/Documentation/core-api/device_link.rst
> @@ -0,0 +1,279 @@
> +============
> +Device links
> +============
> +
> +By default, the driver core only enforces dependencies between devices
> +that are borne out of a parent/child relationship within the device
> +hierarchy: 

This "device hierarchy" was rather confusing to grasp, I specially hard
a hard time understanding *why* the device links work did not do any
topological sorting at all. I'm also afraid this is not just "tribal
knowledge" -- not everyone was able to answer my questions about these
things, Rafafel however did do justice to some degree and I did provide notes
from this. I think it would be important then to jot down to help humans
grok:

  o where the implicit order we embrace comes from
  o what mechanisms are used to help provide some of this order
  o why this is *not* sufficient

The last one justifies the work. And more importantly, it may help
replace a whole bunch of other parallel work which had similar type of
solutions. To what extent it can do that well remains to be seen but
from what I can tell, that's future work worth looking into.

<-- snip -->

> +Limitations
> +===========
> +
> +Driver authors should be aware that a driver presence dependency (i.e. when
> +``DL_FLAG_STATELESS`` is not specified on link addition) may cause probing of
> +the consumer to be deferred indefinitely.  This can become a problem if the
> +consumer is required to probe before a certain initcall level is reached.
> +Worse, if the supplier driver is blacklisted or missing, the consumer will
> +never be probed.
> +
> +Sometimes drivers depend on optional resources.  They are able to operate
> +in a degraded mode (reduced feature set or performance) when those resources
> +are not present.  An example is an SPI controller that can use a DMA engine
> +or work in PIO mode.  The controller can determine presence of the optional
> +resources at probe time but on non-presence there is no way to know whether
> +they will become available in the near future (due to a supplier driver
> +probing) or never.  Consequently it cannot be determined whether to defer
> +probing or not.  It would be possible to notify drivers when optional
> +resources become available after probing, but it would come at a high cost
> +for drivers as switching between modes of operation at runtime based on the
> +availability of such resources would be much more complex than a mechanism
> +based on probe deferral.  In any case optional resources are beyond the
> +scope of device links.

Well you also forgot to mention the issues with deferred probe. It uses
deferred probe so if for whatever reason your subsystem or driver has issues
with it, this won't help.

<-- snip -->
> +* ACPI allows definition of a device start order by way of _DEP objects.
> +  A classical example is when ACPI power management methods on one device
> +  are implemented in terms of I\ :sup:`2`\ C accesses and require a specific
> +  I\ :sup:`2`\ C controller to be present and functional for the power
> +  management of the device in question to work.

Here is an example of current mechanisms used which to driver developers
provides implicit order --its all magical. This has can have limitations,
its important to annotate how this is limiting and also why this perhaps
was not considered as an enhancement in ACPI space. Ie, if semantics
existed in ACPI space for dependency info, why are we now left to our hims
for some cases on driver code?

> +
> +Alternatives
> +============
> +
> +* A :c:type:`struct dev_pm_domain` can be used to override the bus,
> +  class or device type callbacks.  It is intended for devices sharing
> +  a single on/off switch, however it does not guarantee a specific
> +  suspend/resume ordering, this needs to be implemented separately.
> +  It also does not by itself track the runtime PM status of the involved
> +  devices and turn off the power switch only when all of them are runtime
> +  suspended.  Furthermore it cannot be used to enforce a specific shutdown
> +  ordering or a driver presence dependency.
> +
> +* A :c:type:`struct generic_pm_domain` is a lot more heavyweight than a
> +  device link and does not allow for shutdown ordering or driver presence
> +  dependencies.  It also cannot be used on ACPI systems.

I provided a list of other frameworks in the kernel which have
their own solutions which are worth looking into, if anything to at
least determine if we have older frameworks to replace or to use
them to help complement device links framework to help with other
areas other "firmware tools" clearly are lacking.

> +
> +Implementation
> +==============
> +
> +The device hierarchy, which -- as the name implies -- is a tree,
> +becomes a directed acyclic graph once device links are added.

<insert sarcasm>

Oh look a DAG without any sort. How did that happen?

</end sarcasm>
> +
> +Ordering of these devices during suspend/resume is determined by the
> +dpm_list.

And where did order from that come from? My notes provided answers to
these questions.

  Luis
