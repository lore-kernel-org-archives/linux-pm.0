From: Lyude Paul <lyude@redhat.com>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Date: Wed, 18 Jul 2018 16:11:00 -0400
Message-ID: <2724dd5eee8a1e4e523e43915fa184ad5afe1c59.camel@redhat.com>
References: <20180716235936.11268-1-lyude@redhat.com>
         <20180716235936.11268-2-lyude@redhat.com> <20180717071641.GA5411@wunner.de>
         <d7c25a7f41df70685c0c4726315592d1d9b561ff.camel@redhat.com>
         <20180717182041.GA18363@wunner.de>
         <CAJZ5v0g8O8J0U8V-gLMe+NnTd3xgZ5_pjr9p2oci7yAfW54B-A@mail.gmail.com>
         <20180718082505.GB16072@wunner.de> <20180718083601.GC16072@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718083601.GC16072@wunner.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukas Wunner <lukas@wunner.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Ben Skeggs <bskeggs@redhat.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-07-18 at 10:36 +0200, Lukas Wunner wrote:
> On Wed, Jul 18, 2018 at 10:25:05AM +0200, Lukas Wunner wrote:
> > The GPU contains an i2c subdevice for each connector with DDC lines.
> > I believe those are modelled as children of the GPU's PCI device as
> > they're accessed via mmio of the PCI device.
> > 
> > The problem here is that when the GPU's PCI device runtime suspends,
> > its i2c child device needs to be runtime active to suspend the MST
> > topology.  Catch-22.
> > 
> > I don't know whether or not it's necessary to suspend the MST topology.
> > I'm not an expert on DisplayPort MultiStream transport.
> > 
> > BTW Lyude, in patch 4 and 5 of this series, you're runtime resuming
> > pad->i2c->subdev.device->dev.  Is this the PCI device or is it the i2c
> > device?  I'm always confused by nouveau's structs.  In nvkm_i2c_bus_ctor()
> > I can see that the device you're runtime resuming is the parent of the
> > i2c_adapter:
> > 
> > 	struct nvkm_device *device = pad->i2c->subdev.device;
> > 	[...]
> > 	bus->i2c.dev.parent = device->dev;
> > 
> > If the i2c_adapter is a child of the PCI device, it's sufficient
> > to runtime resume the i2c_adapter, i.e. bus->i2c.dev, and this will
> > implicitly runtime resume its parent.
> 
> Actually, having written all this I just remembered that we have this
> in the documentation:
> 
>     8. "No-Callback" Devices
> 
>     Some "devices" are only logical sub-devices of their parent and cannot
> be
>     power-managed on their own. [...]
> 
>     Subsystems can tell the PM core about these devices by calling
>     pm_runtime_no_callbacks().
> 
> So it might actually be sufficient to just call pm_runtime_no_callbacks()

I would have hoped so, but unfortunately it seems that
pm_runtime_no_callbacks() is already called by default for i2c adapters in
i2c_register_adapter(). Unfortunately this really can't fix the problem
though, because it will still try to runtime resume the parent device of the
i2c adapter, which still leads to deadlocking in the runtime suspend/resume
path.

Additionally; I did play around with ignore_children, but unfortunately this
isn't good enough either as it just means that our i2c devices won't wake the
GPU up on access.

I'm pretty stumped here on trying to figure out any clean way to handle this
in the PM core if recursive resume calls are off the table. The only possible
solution I could see to this is if we could disable execution of runtime
callbacks in the context of a certain task (while all other tasks have to
honor the runtime PM callbacks), do what we need to do in suspend, then re-
enable them
> for the i2c devices...
> 
> Lukas
-- 
Cheers,
	Lyude Paul
