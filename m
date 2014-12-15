From: Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
Date: Mon, 15 Dec 2014 11:39:01 +0900
Message-ID: <CAAFQd5A5UAYpV6Z3ii+TTuPOxJF8VFJmnUnHZWkc9dZN04qxYA@mail.gmail.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
	<1576771.dIVCOxU0se@vostro.rjw.lan>
	<CAAFQd5B28WiWUqmbmROJUa3H25R=Y774NuemTZDvkoa=CvZUsw@mail.gmail.com>
	<1508486.LLFuttrbI2@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1508486.LLFuttrbI2@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Sat, Dec 13, 2014 at 5:47 AM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> Hello,
>
> On Friday 12 December 2014 13:15:51 Tomasz Figa wrote:
>> On Fri, Dec 12, 2014 at 5:48 AM, Rafael J. Wysocki wrote:
>> > On Thursday, December 11, 2014 04:51:37 PM Ulf Hansson wrote:
>> >> On 11 December 2014 at 16:31, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>> >> > [+ Laurent Pinchart]
>> >> >
>> >> > Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:
>> >> >> On Thu, Dec 11, 2014 at 8:58 PM, Ulf Hansson wrote:
>> >> > [...]
>> >> >
>> >> >>>> @@ -988,11 +1107,28 @@ static int rk_iommu_probe(struct
>> >> >>>> platform_device *pdev)>> >>>>
>> >> >>>>                 return -ENXIO;
>> >> >>>>
>> >> >>>>         }
>> >> >>>>
>> >> >>>> +       pm_runtime_no_callbacks(dev);
>> >> >>>> +       pm_runtime_enable(dev);
>> >> >>>> +
>> >> >>>> +       /* Synchronize state of the domain with driver data. */
>> >> >>>> +       pm_runtime_get_sync(dev);
>> >> >>>> +       iommu->is_powered = true;
>> >> >>>
>> >> >>> Doesn't the runtime PM status reflect the value of "is_powered", thus
>> >> >>> why do you need to have a copy of it? Could it perpahps be that you
>> >> >>> try to cope with the case when CONFIG_PM is unset?
>> >> >>
>> >> >> It's worth noting that this driver fully relies on status of other
>> >> >> devices in the power domain the IOMMU is in and does not enforce the
>> >> >> status on its own. So in general, as far as my understanding of PM
>> >> >> runtime subsystem, the status of the IOMMU device will be always
>> >> >> suspended, because nobody will call pm_runtime_get() on it (except the
>> >> >> get and put pair in probe). So is_powered is here to track status of
>> >> >> the domain, not the device. Feel free to suggest a better way, though.
>> >> >
>> >> > I still don't like these notifiers.  I think they add ways to bypass
>> >> > having proper runtime PM implemented for devices/subsystems.
>> >>
>> >> I do agree, but I haven't found another good solution to the problem.
>> >
>> > For the record, I'm not liking this mostly because it "fixes" a generic
>> > problem in a way that's hidden in the genpd code and very indirect.
>>
>> Well, that's true. This is indeed a generic problem of PM dependencies
>> between devices (other than those represented by parent-child
>> relation), which in fact doesn't have much to do with genpd, but
>> rather with those devices directly. It is just that genpd is the most
>> convenient location to solve this in current code and in a simple way.
>> In other words, I see this solution as a reasonable way to get the
>> problem solved quickly for now, so that we can start thinking about a
>> more elegant solution.
>>
>> >> > From a high-level, the IOMMU is just another device inside the PM
>> >> > domain, so ideally it should be doing it's own _get() and _put() calls
>> >> > so the PM domain code would just do the right thing without the need
>> >> > for notifiers.
>> >>
>> >> As I understand it, the IOMMU (or for other similar cases) shouldn't
>> >> be doing any get() and put() at all because there are no IO API to
>> >> serve request from.
>
> Speaking purely from an IOMMU point of view that's not entirely tree. IOMMU
> drivers expose map and unmap operations, so they can track whether any memory
> is mapped. From a bus master point of view the IOMMU map and unmap operations
> are hidden by the DMA mapping API. The IOMMU can thus track the existence of
> mappings without any IOMMU awareness in the bus master driver.
>
> If no mapping exist the IOMMU shouldn't receive any translation request. An
> IOMMU driver could thus call pm_runtime_get_sync() in the map handler when
> creating the first mapping, and pm_runtime_put() in the unmap handler when
> tearing the last mapping down.
>
> One could argue that the IOMMU would end up being powered more often than
> strictly needed, as bus masters drivers, even when written properly, could
> keep mappings around at times they don't perform bus access. This is true, and
> that's an argument I've raised during the last kernel summit. The general
> response (including Linus Torvald's) was that micro-optimizing power
> management might not be worth it, and that measurements proving that the gain
> is worth it are required before introducing new APIs to solve the problem. I
> can't disagree with that argument.
>

This would be a micro optimization if the IOMMU was located in its own
power domain. Unfortunately in most cases it is not, so keeping all
the devices in the domain powered on, because one of them have a
mapping created doesn't sound like a good idea.

Moreover, most of the drivers will keep the mapping for much longer
than one run cycle. Please take a look at V4L2's videobuf2 subsystem
(which I guess you are more familiar with than me;)), which will keep
MMAP buffers mapped in IOMMU address space for their whole lifetime. I
believe similar is the case for DRM drivers.

Best regards,
Tomasz
