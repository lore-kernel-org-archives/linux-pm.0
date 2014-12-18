From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [RFC PATCH 2/2] iommu: rockchip: Handle system-wide and runtime PM
Date: Thu, 18 Dec 2014 23:28:58 +0200
Message-ID: <1649547.QECLmuJenN@avalon>
References: <1418286387-9663-1-git-send-email-tfiga@chromium.org>
	<1462052.lBvkDoBROR@avalon> <7hppbg7j9r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <7hppbg7j9r.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org>
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
Cc: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Tomasz Figa <tfiga-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Kevin,

On Thursday 18 December 2014 13:14:24 Kevin Hilman wrote:
> Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> writes:
> > On Thursday 18 December 2014 02:32:30 Rafael J. Wysocki wrote:
> >> On Wednesday, December 17, 2014 02:15:31 AM Laurent Pinchart wrote:
> >>> On Tuesday 16 December 2014 11:18:33 Tomasz Figa wrote:
> >>>> On Tue, Dec 16, 2014 at 4:53 AM, Laurent Pinchart wrote:
> >>>>> On Monday 15 December 2014 11:39:01 Tomasz Figa wrote:
> >>>>>> On Sat, Dec 13, 2014 at 5:47 AM, Laurent Pinchart wrote:
> >>>>>>> On Friday 12 December 2014 13:15:51 Tomasz Figa wrote:
> >>>>>>>> On Fri, Dec 12, 2014 at 5:48 AM, Rafael J. Wysocki wrote:
> >>>>>>>>> On Thursday, December 11, 2014 04:51:37 PM Ulf Hansson wrote:
> >>>>>>>>>> On 11 December 2014 at 16:31, Kevin Hilman wrote:

[...]

> >>>>>>>>>>> From a high-level, the IOMMU is just another device inside the
> >>>>>>>>>>> PM domain, so ideally it should be doing it's own _get() and
> >>>>>>>>>>> _put() calls so the PM domain code would just do the right
> >>>>>>>>>>> thing without the need for notifiers.
> >>>>>>>>>> 
> >>>>>>>>>> As I understand it, the IOMMU (or for other similar cases)
> >>>>>>>>>> shouldn't be doing any get() and put() at all because there are
> >>>>>>>>>> no IO API to serve request from.
> >>>>>>> 
> >>>>>>> Speaking purely from an IOMMU point of view that's not entirely
> >>>>>>> tree. IOMMU drivers expose map and unmap operations, so they can
> >>>>>>> track whether any memory is mapped. From a bus master point of view
> >>>>>>> the IOMMU map and unmap operations are hidden by the DMA mapping
> >>>>>>> API. The IOMMU can thus track the existence of mappings without any
> >>>>>>> IOMMU awareness in the bus master driver.
> >>>>>>> 
> >>>>>>> If no mapping exist the IOMMU shouldn't receive any translation
> >>>>>>> request. An IOMMU driver could thus call pm_runtime_get_sync() in
> >>>>>>> the map handler when creating the first mapping, and
> >>>>>>> pm_runtime_put() in the unmap handler when tearing the last mapping
> >>>>>>> down.
> >>>>>>> 
> >>>>>>> One could argue that the IOMMU would end up being powered more
> >>>>>>> often than strictly needed, as bus masters drivers, even when
> >>>>>>> written properly, could keep mappings around at times they don't
> >>>>>>> perform bus access. This is true, and that's an argument I've raised
> >>>>>>> during the last kernel summit. The general response (including Linus
> >>>>>>> Torvald's) was that micro-optimizing power management might not be
> >>>>>>> worth it, and that measurements proving that the gain is worth it
> >>>>>>> are required before introducing new APIs to solve the problem. I
> >>>>>>> can't disagree with that argument.
> >>>>>> 
> >>>>>> This would be a micro optimization if the IOMMU was located in its
> >>>>>> own power domain. Unfortunately in most cases it is not, so keeping
> >>>>>> all the devices in the domain powered on, because one of them have a
> >>>>>> mapping created doesn't sound like a good idea.
> >>>>>> 
> >>>>>> Moreover, most of the drivers will keep the mapping for much longer
> >>>>>> than one run cycle. Please take a look at V4L2's videobuf2 subsystem
> >>>>>> (which I guess you are more familiar with than me;)), which will
> >>>>>> keep MMAP buffers mapped in IOMMU address space for their whole
> >>>>>> lifetime. I believe similar is the case for DRM drivers.
> >>>>> 
> >>>>> Yes, but that doesn't mean it gets out of control. Buffers shouldn't
> >>>>> be allocated if they won't be used. Granted, they could be
> >>>>> preallocated (or rather premapped) slightly before being used, but in
> >>>>> sane use cases that shouldn't be long before the hardware needs to be
> >>>>> turned on.
> >>>> 
> >>>> Assuming that we don't have a third party, called "user", involved.
> >>> 
> >>> Who needs that ? :-D
> >>> 
> >>>> A simple use case is video playback pause. Usually all the software
> >>>> state (including output buffers that can be used as reference for
> >>>> decoding next frames) needs to be preserved to continue decoding after
> >>>> resume, but it would be nice to power off the decoder, if it is unused
> >>>> for some period. In addition, we would like the pause/resume operation
> >>>> to be fast, so unmapping/freeing buffers and then exactly the opposite
> >>>> on resume doesn't sound like a good idea.
> >>> 
> >>> OK, then we have one possible use case. I expect people to still want
> >>> to see power consumption numbers though.
> >> 
> >> Well, we have them, kind of.
> >> 
> >> In the ACPI world there's something called _DEP which gives us a list of
> >> devices depended on by the given one.  Those may be devices whose drivers
> >> provide so called "operation region" handling which means that an ACPI
> >> method executed for the dependent device may access a device it depends
> >> on indirectly.  Because of that indirection we basically need the devices
> >> listed by _DEP to be "on" whenever the dependent device is "on" or things
> >> may break in nasty ways otherwise.
> >> 
> >> Now, on (some) Intel SoCs some devices listed by _DEP cannot be "on" all
> >> the time, because the lowest-power states of the whole SoC cannot be
> >> used then, which makes hours of battery life of a difference.
> >> 
> >> This isn't exactly the same problem, but it maps to the IOMMU one quite
> >> well IMO.
> > 
> > Agreed, that's certainly a use case for a power dependency implementation.
> > 
> >>> You can call me annoying, but I'm not sure whether a generic PM
> >>> dependency implementation, while it could be a good idea in general, is
> >>> the best solution here, especially if the bus master and the IOMMU are
> >>> in a different power domain. The bus master could provide functions
> >>> that don't require DMA access. For instance a camera controller could
> >>> feed its output to the display directly, without going through memory.
> >>> In that case we probably don't want to power the IOMMU and its complete
> >>> power domain on when using the camera controller in that mode.
> >> 
> >> That's a fair point, but it really boils down to energy usage numbers
> >> again.
> >>
> >>> One alternative solution would be to extend the DMA mapping API with
> >>> two functions to signal that DMA is about to be started and that DMA has
> >>> now finished. It might be considered too ad-hoc though.
> >> 
> >> It would be better to be able to reference count the DMA engine from the
> >> bus master IMO and arguably you can use the runtime PM framework for
> >> that. Namely, give bus masters someting like
> >> 
> >> 	pm_runtime_get_my_DMA_engine(bus_master_device)
> >> 	pm_runtime_put_my_DMA_engine(bus_master_device)
> >> 
> >> and let them call these as they see fit.
> > 
> > Please note that we're not talking about DMA engines here, but about
> > IOMMUs. DMA is involved through the DMA mapping API which hides the IOMMU
> > completely from the bus master drivers, not the DMA engine API.
> > 
> > Exposing the IOMMU is something we want to avoid, but DMA mapping
> > start/stop operations could certainly be implemented.
> 
> The problem with that is it only solves the IOMMU problem.  We have a
> more generic PM dependency problem of which this IOMMU example is only a
> subset, so I think we need a more generic solution.

I agree that a more generic solution is needed at least to support ACPI _DEP, 
but that might not be optimal in the IOMMU use case as explained above.

-- 
Regards,

Laurent Pinchart
