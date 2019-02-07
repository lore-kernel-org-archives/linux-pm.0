From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH] drivers: base: add support to skip power management in
 device/driver model
Date: Thu, 7 Feb 2019 10:36:00 +0000
Message-ID: <20190207103600.GA14464@e107155-lin>
References: <20190206150935.12140-1-sudeep.holla@arm.com>
 <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFr2qwXoOL3SRy7Crf-pg4FMn_qecPrw__BE+YpVAjAFZA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Jisheng Zhang <jszhang@marvell.com>, Steve Longerbeam <slongerbeam@gmail.com>, Eugeniu Rosca <erosca@de.adit-jv.com>, Joshua Frkuska <joshua_frkuska@mentor.com>, Eugeniu Rosca <roscaeugeniu@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Feb 07, 2019 at 10:53:56AM +0100, Ulf Hansson wrote:
> On Wed, 6 Feb 2019 at 16:09, Sudeep Holla <sudeep.holla@arm.com> wrote:
> >
> > All device objects in the driver model contain fields that control the
> > handling of various power management activities. However, it's not
> > always useful. There are few instances where pseudo devices are added
> > to the model just to take advantage of many other features like
> > kobjects, udev events, and so on. One such example is cpu devices and
> > their caches.
> >
> > The sysfs for the cpu caches are managed by adding devices with cpu
> > as the parent in cpu_device_create() when secondary cpu is brought
> > online. Generally when the secondary CPUs are hotplugged back in as part
> > of resume from suspend-to-ram, we call cpu_device_create() from the cpu
> > hotplug state machine while the cpu device associated with that CPU is
> > not yet ready to be resumed as the device_resume() call happens bit
> > later. It's not really needed to set the flag is_prepared for cpu
> > devices as they are mostly pseudo device and hotplug framework deals
> > with state machine and not managed through the cpu device.
>
> What's the point of removing and then re-adding the sysfs attributes
> for the cpu caches, at each hotplug off/on sequence? To me that sounds
> inefficient and unnecessary, no?
>

Oh well, you must look at PowerPC pHyp which can change cache nodes for
suspend/resume operation too, let alone hotplug operations. So, we can't
assume the same CPUs with exact same caches are always hotplugged back
in. That's may happen in embedded and other static platforms but not
everywhere. Anyway that's my understand as why it's done in hotplug
patch. So it's not so simple to call it inefficient and unnecessary IMO.

> If you avoid this, would that solve this problem?
>

May be, but as mentioned above we can't really. Also this change will
help to avoid creating unnecessary power sysfs which is mainly runtime
pm related for some of the devices created. CPU/caches was just one
example which triggered this, but this can be more useful. We can avoid
adding them to dpm list.

--
Regards,
Sudeep
