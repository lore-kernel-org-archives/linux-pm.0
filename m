From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: [PATCH 1/2] Documentation/core-api/device_link: Add initial
 documentation
Date: Mon, 5 Dec 2016 10:07:39 -0200
Message-ID: <20161205100720.5156a4d2@vento.lan>
References: <cover.1480849144.git.lukas@wunner.de>
        <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Silvio Fricke <silvio.fricke@gmail.com>, "Luis R. Rodriguez" <mcgrof@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Andrzej Hajda <a.hajda@samsung.com>, Inki Dae <inki.dae@samsung.com>, Joerg Roedel <joro@8bytes.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Mark Brown <broonie@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Tomasz Figa <tomasz.figa@gmail.com>
List-Id: linux-pm@vger.kernel.org

Em Sun, 4 Dec 2016 13:10:04 +0100
Lukas Wunner <lukas@wunner.de> escreveu:

> Document device links as introduced in v4.10 with commits:
>     4bdb35506b89 ("driver core: Add a wrapper around
>                    __device_release_driver()")
>     9ed9895370ae ("driver core: Functional dependencies tracking
>                    support")
>     8c73b4288496 ("PM / sleep: Make async suspend/resume of devices use
>                    device links")
>     21d5c57b3726 ("PM / runtime: Use device links")
>     baa8809f6097 ("PM / runtime: Optimize the use of device links")
> 
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Luis R. Rodriguez <mcgrof@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Silvio Fricke <silvio.fricke@gmail.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Andrzej Hajda <a.hajda@samsung.com>
> Cc: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
> Cc: Inki Dae <inki.dae@samsung.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: linux-pm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: iommu@lists.linux-foundation.org
> Cc: linux-samsung-soc@vger.kernel.org
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
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
> +hierarchy: When suspending, resuming or shutting down the system, devices
> +are ordered based on this relationship, i.e. children are always suspended
> +before their parent, and the parent is always resumed before its children.
> +
> +Sometimes there is a need to represent device dependencies beyond the
> +mere parent/child relationship, e.g. between siblings, and have the
> +driver core automatically take care of them.
> +
> +Secondly, the driver core by default does not enforce any driver presence
> +dependencies, i.e. that one device must be bound to a driver before
> +another one can probe or function correctly.
> +
> +Often these two dependency types come together, so a device depends on
> +another one both with regards to driver presence *and* with regards to
> +suspend/resume and shutdown ordering.
> +
> +Device links allow representation of such dependencies in the driver core.
> +
> +In its standard form, a device link combines *both* dependency types:
> +It guarantees correct suspend/resume and shutdown ordering between a
> +"supplier" device and its "consumer" devices, and it guarantees driver
> +presence on the supplier.  The consumer devices are not probed before the
> +supplier is bound to a driver, and they're unbound before the supplier
> +is unbound.
> +
> +When driver presence on the supplier is irrelevant and only correct
> +suspend/resume and shutdown ordering is needed, the device link may
> +simply be set up with the ``DL_FLAG_STATELESS`` flag.  In other words,
> +enforcing driver presence on the supplier is optional.
> +
> +Another optional feature is runtime PM integration:  By setting the
> +``DL_FLAG_PM_RUNTIME`` flag on addition of the device link, the PM core
> +is instructed to runtime resume the supplier and keep it active
> +whenever and for as long as the consumer is runtime resumed.
> +
> +Usage
> +=====

You should be using, instead:

Usage
-----

(and the same '-' symbol for all sections of this chapter)

The way you did, in thesis, ReST should be putting all tags at the
same level as the first one, as they're all using '='. 

The other ReST markups look OK on my eyes.

Regards,
Mauro

> +
> +The earliest point in time when device links can be added is after
> +:c:func:`device_add()` has been called for the supplier and
> +:c:func:`device_initialize()` has been called for the consumer.
> +
> +It is legal to add them later, but care must be taken that the system
> +remains in a consistent state:  E.g. a device link cannot be added in
> +the midst of a suspend/resume transition, so either commencement of
> +such a transition needs to be prevented with :c:func:`lock_system_sleep()`,
> +or the device link needs to be added from a function which is guaranteed
> +not to run in parallel to a suspend/resume transition, such as from a
> +device ``->probe`` callback or a boot-time PCI quirk.
> +
> +Another example for an inconsistent state would be a device link that
> +represents a driver presence dependency, yet is added from the consumer's
> +``->probe`` callback while the supplier hasn't probed yet:  Had the driver
> +core known about the device link earlier, it wouldn't have probed the
> +consumer in the first place.  The onus is thus on the consumer to check
> +presence of the supplier after adding the link, and defer probing on
> +non-presence.
> +
> +If a device link is added in the ``->probe`` callback of the supplier or
> +consumer driver, it is typically deleted in its ``->remove`` callback for
> +symmetry.  That way, if the driver is compiled as a module, the device
> +link is added on module load and orderly deleted on unload.  The same
> +restrictions that apply to device link addition (e.g. exclusion of a
> +parallel suspend/resume transition) apply equally to deletion.
> +
> +Several flags may be specified on device link addition, two of which
> +have already been mentioned above:  ``DL_FLAG_STATELESS`` to express that no
> +driver presence dependency is needed (but only correct suspend/resume and
> +shutdown ordering) and ``DL_FLAG_PM_RUNTIME`` to express that runtime PM
> +integration is desired.
> +
> +Two other flags are specifically targeted at use cases where the device
> +link is added from the consumer's ``->probe`` callback:  ``DL_FLAG_RPM_ACTIVE``
> +can be specified to runtime resume the supplier upon addition of the
> +device link.  ``DL_FLAG_AUTOREMOVE`` causes the device link to be automatically
> +purged when the consumer fails to probe or later unbinds.  This obviates
> +the need to explicitly delete the link in the ``->remove`` callback or in
> +the error path of the ``->probe`` callback.
> +
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
> +
> +Examples
> +========
> +
> +* An MMU device exists alongside a busmaster device, both are in the same
> +  power domain.  The MMU implements DMA address translation for the busmaster
> +  device and shall be runtime resumed and kept active whenever and as long
> +  as the busmaster device is active.  The busmaster device's driver shall
> +  not bind before the MMU is bound.  To achieve this, a device link with
> +  runtime PM integration is added from the busmaster device (consumer)
> +  to the MMU device (supplier).  The effect with regards to runtime PM
> +  is the same as if the MMU was the parent of the master device.
> +
> +  The fact that both devices share the same power domain would normally
> +  suggest usage of a :c:type:`struct dev_pm_domain` or :c:type:`struct
> +  generic_pm_domain`, however these are not independent devices that
> +  happen to share a power switch, but rather the MMU device serves the
> +  busmaster device and is useless without it.  A device link creates a
> +  synthetic hierarchical relationship between the devices and is thus
> +  more apt.
> +
> +* A Thunderbolt host controller comprises a number of PCIe hotplug ports
> +  and an NHI device to manage the PCIe switch.  On resume from system sleep,
> +  the NHI device needs to re-establish PCI tunnels to attached devices
> +  before the hotplug ports can resume.  If the hotplug ports were children
> +  of the NHI, this resume order would automatically be enforced by the
> +  PM core, but unfortunately they're aunts.  The solution is to add
> +  device links from the hotplug ports (consumers) to the NHI device
> +  (supplier).  A driver presence dependency is not necessary for this
> +  use case.
> +
> +* Discrete GPUs in hybrid graphics laptops often feature an HDA controller
> +  for HDMI/DP audio.  In the device hierarchy the HDA controller is a sibling
> +  of the VGA device, yet both share the same power domain and the HDA
> +  controller is only ever needed when an HDMI/DP display is attached to the
> +  VGA device.  A device link from the HDA controller (consumer) to the
> +  VGA device (supplier) aptly represents this relationship.
> +
> +* ACPI allows definition of a device start order by way of _DEP objects.
> +  A classical example is when ACPI power management methods on one device
> +  are implemented in terms of I\ :sup:`2`\ C accesses and require a specific
> +  I\ :sup:`2`\ C controller to be present and functional for the power
> +  management of the device in question to work.
> +
> +* In some SoCs a functional dependency exists from display, video codec and
> +  video processing IP cores on transparent memory access IP cores that handle
> +  burst access and compression/decompression.
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
> +
> +Implementation
> +==============
> +
> +The device hierarchy, which -- as the name implies -- is a tree,
> +becomes a directed acyclic graph once device links are added.
> +
> +Ordering of these devices during suspend/resume is determined by the
> +dpm_list.  During shutdown it is determined by the devices_kset.  With
> +no device links present, the two lists are a flattened, one-dimensional
> +representations of the device tree such that a device is placed behind
> +all its ancestors.  That is achieved by traversing the ACPI namespace
> +or OpenFirmware device tree top-down and appending devices to the lists
> +as they are discovered.
> +
> +Once device links are added, the lists need to satisfy the additional
> +constraint that a device is placed behind all its suppliers, recursively.
> +To ensure this, upon addition of the device link the consumer and the
> +entire sub-graph below it (all children and consumers of the consumer)
> +are moved to the end of the list.  (Call to :c:func:`device_reorder_to_tail()`
> +from :c:func:`device_link_add()`.)
> +
> +To prevent introduction of dependency loops into the graph, it is
> +verified upon device link addition that the supplier is not dependent
> +on the consumer or any children or consumers of the consumer.
> +(Call to :c:func:`device_is_dependent()` from :c:func:`device_link_add()`.)
> +If that constraint is violated, :c:func:`device_link_add()` will return
> +``NULL`` and a ``WARNING`` will be logged.
> +
> +Notably this also prevents the addition of a device link from a parent
> +device to a child.  However the converse is allowed, i.e. a device link
> +from a child to a parent.  Since the driver core already guarantees
> +correct suspend/resume and shutdown ordering between parent and child,
> +such a device link only makes sense if a driver presence dependency is
> +needed on top of that.  In this case driver authors should weigh
> +carefully if a device link is at all the right tool for the purpose.
> +A more suitable approach might be to simply use deferred probing or
> +add a device flag causing the parent driver to be probed before the
> +child one.
> +
> +State machine
> +=============
> +
> +.. kernel-doc:: include/linux/device.h
> +   :functions: device_link_state
> +
> +::
> +
> +                 .=============================.
> +                 |                             |
> +                 v                             |
> + DORMANT <=> AVAILABLE <=> CONSUMER_PROBE => ACTIVE
> +    ^                                          |
> +    |                                          |
> +    '============ SUPPLIER_UNBIND <============'
> +
> +* The initial state of a device link is automatically determined by
> +  :c:func:`device_link_add()` based on the driver presence on the supplier
> +  and consumer.  If the link is created before any devices are probed, it
> +  is set to ``DL_STATE_DORMANT``.
> +
> +* When a supplier device is bound to a driver, links to its consumers
> +  progress to ``DL_STATE_AVAILABLE``.
> +  (Call to :c:func:`device_links_driver_bound()` from
> +  :c:func:`driver_bound()`.)
> +
> +* Before a consumer device is probed, presence of supplier drivers is
> +  verified by checking that links to suppliers are in ``DL_STATE_AVAILABLE``
> +  state.  The state of the links is updated to ``DL_STATE_CONSUMER_PROBE``.
> +  (Call to :c:func:`device_links_check_suppliers()` from
> +  :c:func:`really_probe()`.)
> +  This prevents the supplier from unbinding.
> +  (Call to :c:func:`wait_for_device_probe()` from
> +  :c:func:`device_links_unbind_consumers()`.)
> +
> +* If the probe fails, links to suppliers revert back to ``DL_STATE_AVAILABLE``.
> +  (Call to :c:func:`device_links_no_driver()` from :c:func:`really_probe()`.)
> +
> +* If the probe succeeds, links to suppliers progress to ``DL_STATE_ACTIVE``.
> +  (Call to :c:func:`device_links_driver_bound()` from :c:func:`driver_bound()`.)
> +
> +* When the consumer's driver is later on removed, links to suppliers revert
> +  back to ``DL_STATE_AVAILABLE``.
> +  (Call to :c:func:`__device_links_no_driver()` from
> +  :c:func:`device_links_driver_cleanup()`, which in turn is called from
> +  :c:func:`__device_release_driver()`.)
> +
> +* Before a supplier's driver is removed, links to consumers that are not
> +  bound to a driver are updated to ``DL_STATE_SUPPLIER_UNBIND``.
> +  (Call to :c:func:`device_links_busy()` from
> +  :c:func:`__device_release_driver()`.)
> +  This prevents the consumers from binding.
> +  (Call to :c:func:`device_links_check_suppliers()` from
> +  :c:func:`really_probe()`.)
> +  Consumers that are bound are freed from their driver; consumers that are
> +  probing are waited for until they are done.
> +  (Call to :c:func:`device_links_unbind_consumers()` from
> +  :c:func:`__device_release_driver()`.)
> +  Once all links to consumers are in ``DL_STATE_SUPPLIER_UNBIND`` state,
> +  the supplier driver is released and the links revert to ``DL_STATE_DORMANT``.
> +  (Call to :c:func:`device_links_driver_cleanup()` from
> +  :c:func:`__device_release_driver()`.)
> +
> +API
> +===
> +
> +.. kernel-doc:: drivers/base/core.c
> +   :functions: device_link_add device_link_del
> diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> index 2872ca1..2aed045 100644
> --- a/Documentation/core-api/index.rst
> +++ b/Documentation/core-api/index.rst
> @@ -16,6 +16,14 @@ Core utilities
>     local_ops
>     workqueue
>  
> +Devices
> +=======
> +
> +.. toctree::
> +   :maxdepth: 1
> +
> +   device_link
> +
>  Interfaces for kernel debugging
>  ===============================
>  


-- 
Thanks,
Mauro
