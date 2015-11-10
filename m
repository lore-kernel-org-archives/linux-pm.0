From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] thermal: rcar_thermal: use pm_runtime_put_sync()
Date: Wed, 11 Nov 2015 00:57:13 +0100
Message-ID: <2060819.A5Wq9BbBOH@vostro.rjw.lan>
References: <87h9kulkfg.wl%kuninori.morimoto.gx@renesas.com> <CAMuHMdX_mAd1PVv5_UCJJZ2U5EjYUbqQ36zaEgP5KdUuZiGQMQ@mail.gmail.com> <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrDKXRui3onqCp0tH1E4MFN4AchaBrRcfdYi63hNLU63Q@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux-SH <linux-sh@vger.kernel.org>, Linux-Kernel <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Cao Minh Hiep <cm-hiep@jinso.co.jp>, =?utf-8?B?RHVuZ++8muS6uuOCvQ==?= <nv-dung@jinso.co.jp>, Alan Stern <stern@rowland.harvard.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, November 10, 2015 02:00:38 PM Ulf Hansson wrote:
> +Rafael, Alan
> 
> On 10 November 2015 at 11:10, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Hi Ulf,
> >

[cut]

> >>
> >> The problem is that the runtime PM status of the device isn't
> >> correctly updated at ->remove(). The effect is that the the
> >> pm_runtime_get_sync() in ->probe() at re-bind will *not* trigger the
> >> ->runtime_resume() callbacks to be invoked, as the runtime PM core
> >> believes the device is already runtime resumed.
> >
> > So that's where it should be fixed?
> 
> That would be a more generic approach, although I am not sure how the
> driver/PM core should be able to take the correct decision in this
> phase. Devices may be runtime PM managed also without a driver bound.
> 
> Perhaps when __device_release_driver() finds a bounded driver for the
> device, it could after all actions been performed to unbind the
> driver, check if runtime PM is enabled. If it isn't, it could set the
> runtime PM status to suspended!?
> 
> I have no idea if that would introduce other issues as it would kind
> of force the runtime PM status of the device to suspend, without
> actually knowing if it's the correct thing to do.

IMO, that needs to depend on the bus type.  If the bus type has a way
to manage PM for devices without drivers, it should be allowed to do so.

Of course, the platform bus type is somewhat special in that respect,
but it looks like we simply need some sort of a convention in there too
(the expectations should be the same for everybody).

Thanks,
Rafael

