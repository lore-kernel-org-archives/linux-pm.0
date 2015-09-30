From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v7 1/2] PM / sleep: Go direct_complete if driver has no callbacks
Date: Wed, 30 Sep 2015 15:59:48 +0200
Message-ID: <CAAObsKBZLnRBQA-nDzWG1SEyjaR6W68XnS6vBpES=WEQQSWgiA@mail.gmail.com>
References: <1443607098-26666-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443607098-26666-2-git-send-email-tomeu.vizoso@collabora.com>
 <CAPDyKFoSWLEzeLUWC0gPY2_a0Mvo3vbbWm5e0f-_rjZbwdY0Sw@mail.gmail.com> <8277579.lpDi4B1kd8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8277579.lpDi4B1kd8@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 30 September 2015 at 15:05, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, September 30, 2015 01:33:29 PM Ulf Hansson wrote:
>> On 30 September 2015 at 11:58, Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>> > @@ -1369,6 +1372,8 @@ int pm_genpd_remove_device(struct generic_pm_domain *genpd,
>> >
>> >         genpd_free_dev_data(dev, gpd_data);
>> >
>> > +       device_check_pm_callbacks(dev);
>> > +
>> >         return 0;
>>
>> I can't tell whether this is an interesting feature to use for devices
>> that gets attached to the ACPI PM domain. Although, you currently
>> doesn't deal with that case, and too me I think this looks a bit
>> weird/unsymmetrical.
>
> Good point.
>
> It needs to be done in every situation where a PM domain is or can be used.
>
> I guess we might require all PM domains to be attached to devices after
> a successful probe at the latest (no PM domains should be attached/detached
> after probe succeeds IOW), in which case it should be sufficient to do the
> device_check_pm_callbacks() thing each time after probe successds.
>
> Thoughts?

Sound good to me. How were you thinking of doing that? Manually
checking that that's currently the case and adding a WARN() if a
pm_domain is attached to a device that has been probed already?

Thanks,

Tomeu
