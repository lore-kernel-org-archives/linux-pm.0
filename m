From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v8 3/4] PM / sleep: Go direct_complete if driver has no callbacks
Date: Fri, 02 Oct 2015 15:42:57 +0200
Message-ID: <3377500.WbTIbyZKB6@vostro.rjw.lan>
References: <1443770071-2570-1-git-send-email-tomeu.vizoso@collabora.com> <CAAObsKBM2tto0cFAu-pyvatGQevB6ynvuuSNghHNQGQSgfLzdA@mail.gmail.com> <CAPDyKFrDO37Tuy3QosWXxogG2WSrwr79yxr_894TvWk6EO7T8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrDO37Tuy3QosWXxogG2WSrwr79yxr_894TvWk6EO7T8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, October 02, 2015 10:40:49 AM Ulf Hansson wrote:
> On 2 October 2015 at 10:10, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> > On 2 October 2015 at 09:48, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >> On 2 October 2015 at 09:14, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
> >>> If a suitable prepare callback cannot be found for a given device and
> >>> its driver has no PM callbacks at all, assume that it can go direct to
> >>> complete when the system goes to sleep.
> >>>
> >>> The reason for this is that there's lots of devices in a system that do
> >>> no PM at all and there's no reason for them to prevent their ancestors
> >>> to do direct_complete if they can support it.
> >>>
> >>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> >>> ---
> >>>
> >>> Changes in v8:
> >>> - Move no_pm_callbacks field into CONFIG_PM_SLEEP
> >>> - Call device_check_pm_callbacks only after a device is bound or unbound
> >>
> >> Devices that don't use a driver, will not get this feature for "free".
> >> I expect in those cases, they will have to call
> >> device_check_pm_callbacks() themselves, right?
> >
> > You are right, but wonder if we shouldn't go back to calling
> > device_check_pm_callbacks() from device_pm_add() and
> > dev_pm_domain_set() so they don't have to.
> 
> That seems reasonable to me, and I didn't quite understand why you
> decided to remove it. :-)

Right.

device_check_pm_callbacks() needs to be called on device registration too
(in case the device doesn't have a driver and doesn't use a PM domain) and
it won't hurt to call it in dev_pm_domain_set() either, although that likely
will be redundant in the majority of cases.

Thanks,
Rafael
