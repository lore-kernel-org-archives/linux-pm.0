From: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH V5] thermal: Add cooling device's statistics in sysfs
Date: Mon, 13 Aug 2018 20:02:50 +0300
Message-ID: <18709513.zahsa7p5Fo@dimapc>
References: <bab196f91cbddca175c725ae6159c0af639bfe07.1522666398.git.viresh.kumar@linaro.org> <3394204.qE6hlQGZ2Z@dimapc> <CAKohpo=BnVJ5uO5+6p6ONhucHkxS893t6d1gtHJZW1kKB0EXOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=BnVJ5uO5+6p6ONhucHkxS893t6d1gtHJZW1kKB0EXOw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Vincent Guittot <vincent.guittot@linaro.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 13 August 2018 19:53:33 MSK Viresh Kumar wrote:
> On 13 August 2018 at 22:13, Dmitry Osipenko <digetx@gmail.com> wrote:
> > On Monday, 13 August 2018 19:21:43 MSK Viresh Kumar wrote:
> >> On 13 August 2018 at 21:36, Dmitry Osipenko <digetx@gmail.com> wrote:
> >> > I'm working on adding support of OPP and cooling for NVIDIA Tegra20/30
> >> > CPUFreq driver and stumbled upon a bug that is introduced by this
> >> > patch.
> >> > It is triggered on the driver module unload.
> >> 
> >> The problem is that device_unregister() will end up freeing the cdev as
> >> well, so the current sequence is surely wrong.
> >> 
> >> > diff --git a/drivers/thermal/thermal_core.c
> >> > b/drivers/thermal/thermal_core.c index 6ab982309e6a..de53c821a282
> >> > 100644
> >> > --- a/drivers/thermal/thermal_core.c
> >> > +++ b/drivers/thermal/thermal_core.c
> >> > @@ -1102,8 +1102,8 @@ void thermal_cooling_device_unregister(struct
> >> > thermal_cooling_device *cdev)>
> >> > 
> >> >         mutex_unlock(&thermal_list_lock);
> >> >         
> >> >         ida_simple_remove(&thermal_cdev_ida, cdev->id);
> >> > 
> >> > -       device_unregister(&cdev->device);
> >> > 
> >> >         thermal_cooling_device_destroy_sysfs(cdev);
> >> > 
> >> > +       device_unregister(&cdev->device);
> >> 
> >> But this looks wrong as well, as the device is still around while
> >> memory of its sysfs data is gone.
> > 
> > Indeed.
> > 
> >> Maybe something like this is what we need:
> >> 
> >> device_del();
> >> thermal_cooling_device_destroy_sysfs();
> >> device_put();
> > 
> > [I just realized that thermal_zone and cooling_device are not
> > interrelated.
> > I'm not familiar with the thermal/ code]
> > 
> > Thank you Viresh, your proposal looks good to me and works fine. Will you
> > make a proper patch?
> 
> Maybe you send a patch for this and take the credit as well :)

Okay, I'll make the patch. Thank you for the help.
