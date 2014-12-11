From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
Date: Thu, 11 Dec 2014 16:51:37 +0100
Message-ID: <CAPDyKFo6zH4__Odm+RiJCbvXquAQqaLyCAiXrSN6s3KfQhok=A@mail.gmail.com>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
	<1418286387-9663-3-git-send-email-tfiga@chromium.org>
	<CAPDyKFoBRxFh+BzHTakij6=NvLm0C-S8eX8+p2odpSwtdTrvoA@mail.gmail.com>
	<CAAFQd5CA374MF-_w=3zqsZctwTcBHz9J_0Ygg4fD_wjg8kLATg@mail.gmail.com>
	<7h8uiemce7.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7h8uiemce7.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 11 December 2014 at 16:31, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> [+ Laurent Pinchart]
>
> Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:
>
>> On Thu, Dec 11, 2014 at 8:58 PM, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>
> [...]
>
>>>> @@ -988,11 +1107,28 @@ static int rk_iommu_probe(struct platform_device *pdev)
>>>>                 return -ENXIO;
>>>>         }
>>>>
>>>> +       pm_runtime_no_callbacks(dev);
>>>> +       pm_runtime_enable(dev);
>>>> +
>>>> +       /* Synchronize state of the domain with driver data. */
>>>> +       pm_runtime_get_sync(dev);
>>>> +       iommu->is_powered = true;
>>>
>>> Doesn't the runtime PM status reflect the value of "is_powered", thus
>>> why do you need to have a copy of it? Could it perpahps be that you
>>> try to cope with the case when CONFIG_PM is unset?
>>>
>>
>> It's worth noting that this driver fully relies on status of other
>> devices in the power domain the IOMMU is in and does not enforce the
>> status on its own. So in general, as far as my understanding of PM
>> runtime subsystem, the status of the IOMMU device will be always
>> suspended, because nobody will call pm_runtime_get() on it (except the
>> get and put pair in probe). So is_powered is here to track status of
>> the domain, not the device. Feel free to suggest a better way, though.
>
> I still don't like these notifiers.  I think they add ways to bypass
> having proper runtime PM implemented for devices/subsystems.

I do agree, but I haven't found another good solution to the problem.

>
> From a high-level, the IOMMU is just another device inside the PM
> domain, so ideally it should be doing it's own _get() and _put() calls
> so the PM domain code would just do the right thing without the need for
> notifiers.

As I understand it, the IOMMU (or for other similar cases) shouldn't
be doing any get() and put() at all because there are no IO API to
serve request from.

In principle we could consider these kind devices as "parent" devices
to those other devices that needs them. Then runtime PM core would
take care of things for us, right!?

Now, I am not so sure using the "parent" approach is actually viable,
since it will likely have other complications, but I haven't
thoroughly thought it though yet.

>
> No knowing a lot about the IOMMU API, I'm guessing the reason you're not
> doing that is because the IOMMU API currently doesn't have an easy way
> to keep track of *active* users so it's not obvious where to put those
> _get and _put calls.  If that doesn't exist, perhaps a simple
> iommu_get() and iommu_put() API needs to be introduced (which inside the
> IOMMU core would just do runtime PM calls) so that users of the IOMMU
> could inform the subsystem that the IOMMU is needed and it should not be
> powered off.
>
> I Cc'd Laurent because I know he's thought about this before from the
> IOMMU side, and not sure if he came up with a solution.

Cool, let's see then.

Kind regards
Uffe
