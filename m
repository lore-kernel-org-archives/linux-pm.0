From: "Rafael J. Wysocki" <rafael-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 7/7] iommu/exynos: Use device dependency links to
	control runtime pm
Date: Thu, 10 Nov 2016 00:42:51 +0100
Message-ID: <CAJZ5v0h5e8OUmu2OCXDO0n1X+zuyJ97nd=aQy7f3p+QfSY_cEA@mail.gmail.com>
References: <1478611764-6473-1-git-send-email-m.szyprowski@samsung.com>
	<CGME20161108133019eucas1p1be275492ba670030324a164320866008@eucas1p1.samsung.com>
	<1478611764-6473-8-git-send-email-m.szyprowski@samsung.com>
	<20161109233126.GM13978@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20161109233126.GM13978-B4tOwbsTzaBolqkO4TVVkw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Luis R. Rodriguez" <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tomasz Figa <tomasz.figa-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mauro Carvalho Chehab <mchehab-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Linux Samsung SoC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux PM <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Inki Dae <inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tobias Jakobi <tjakobi-o02PS0xoJP9W0yFyLvAVXMxlOr/tl8fh@public.gmane.org>, "open list:AMD IOMMU (AMD-VI)" <iommu-cunTk1MwBs9QetFLy7KEm+QpoMPSDrYp@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 10, 2016 at 12:31 AM, Luis R. Rodriguez <mcgrof-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Tue, Nov 08, 2016 at 02:29:24PM +0100, Marek Szyprowski wrote:
>> This patch uses recently introduced device dependency links to track the
>> runtime pm state of the master's device. The goal is to let SYSMMU
>> controller device's runtime PM to follow the runtime PM state of the
>> respective master's device. This way each SYSMMU controller is active
>> only when its master's device is active and can properly restore or save
>> its state instead on runtime PM transition of master's device.
>> This approach replaces old behavior, when SYSMMU controller was set to
>> runtime active once after attaching to the master device. In the new
>> approach SYSMMU controllers no longer prevents respective power domains
>> to be turned off when master's device is not being used.
>>
>> The dependency links also enforces proper order of suspending/restoring
>> devices during system sleep transition, so there is no more need to use
>> LATE_SYSTEM_SLEEP_PM_OPS-based workaround for ensuring that SYSMMUs are
>> suspended after their master devices.
>
> Patches 1-6 seems reasonable to me, however in so far as this patch is
> concerned I'd appreaciate if you and Rafael can reply to Lukas Wunner's
> questions.

Which questions exactly do you mean?

Thanks,
Rafael
