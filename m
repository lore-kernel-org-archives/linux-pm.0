From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 02/10] driver core: Functional dependencies tracking
	support
Date: Fri, 17 Jun 2016 14:54:56 +0200
Message-ID: <CAJZ5v0h71xxvzex2D6s9W8Qvq3+BqOQnTJRKy32gMu=tuQLxDA@mail.gmail.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
	<1466144820-6286-3-git-send-email-m.szyprowski@samsung.com>
	<20160617103620.GA1626@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160617103620.GA1626-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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
Cc: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Andreas Noever <andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Jun 17, 2016 at 12:36 PM, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> Hi Marek,
>
> On Fri, Jun 17, 2016 at 08:26:52AM +0200, Marek Szyprowski wrote:
>> From: "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>>
>> Currently, there is a problem with handling cases where functional
>> dependencies between devices are involved.
>>
>> What I mean by a "functional dependency" is when the driver of device
>> B needs both device A and its driver to be present and functional to
>> be able to work.  This implies that the driver of A needs to be
>> working for B to be probed successfully and it cannot be unbound from
>> the device before the B's driver.  This also has certain consequences
>> for power management of these devices (suspend/resume and runtime PM
>> ordering).
>>
>> Add support for representing those functional dependencies between
>> devices to allow the driver core to track them and act on them in
>> certain cases where they matter.
>
> Rafael has indicated that he intends to respin this series:
> https://lkml.org/lkml/2016/6/8/1061

That's OK.

> We also have such a functional dependency for Thunderbolt on Macs:
> On resume from system sleep, the PCIe hotplug ports may not resume
> before the thunderbolt driver has reestablished the PCI tunnels.
> Currently this is enforced by quirk_apple_wait_for_thunderbolt()
> in drivers/pci/quirks.c. It would be good if we could represent
> this dependency using something like Rafael's approach instead of
> open coding it, however one detail in Rafael's patches is problematic:
>
>> New links are added by calling device_link_add() which may happen
>> either before the consumer device is probed or when probing it, in
>> which case the caller needs to ensure that the driver of the
>> supplier device is present and functional and the DEVICE_LINK_PROBE_TIME
>> flag should be passed to device_link_add() to reflect that.
>
> The thunderbolt driver cannot call device_link_add() before the
> PCIe hotplug ports are bound to a driver unless we amend portdrv
> to return -EPROBE_DEFER for Thunderbolt hotplug ports on Macs
> if the thunderbolt driver isn't loaded.
>
> It would therefore be beneficial if device_link_add() can be
> called even *after* the consumer is bound.

I don't quite follow.

Who's the provider and who's the consumer here?

Thanks,
Rafael
