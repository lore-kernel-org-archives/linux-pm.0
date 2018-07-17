From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [Nouveau] [PATCH 1/5] drm/nouveau: Prevent RPM callback
 recursion in suspend/resume paths
Date: Tue, 17 Jul 2018 09:16:41 +0200
Message-ID: <20180717071641.GA5411@wunner.de>
References: <20180716235936.11268-1-lyude@redhat.com>
 <20180716235936.11268-2-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180716235936.11268-2-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lyude Paul <lyude@redhat.com>
Cc: nouveau@lists.freedesktop.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[cc += linux-pm]

Hi Lyude,

First of all, thanks a lot for looking into this. 

On Mon, Jul 16, 2018 at 07:59:25PM -0400, Lyude Paul wrote:
> In order to fix all of the spots that need to have runtime PM get/puts()
> added, we need to ensure that it's possible for us to call
> pm_runtime_get/put() in any context, regardless of how deep, since
> almost all of the spots that are currently missing refs can potentially
> get called in the runtime suspend/resume path. Otherwise, we'll try to
> resume the GPU as we're trying to resume the GPU (and vice-versa) and
> cause the kernel to deadlock.
> 
> With this, it should be safe to call the pm runtime functions in any
> context in nouveau with one condition: any point in the driver that
> calls pm_runtime_get*() cannot hold any locks owned by nouveau that
> would be acquired anywhere inside nouveau_pmops_runtime_resume().
> This includes modesetting locks, i2c bus locks, etc.
[snip]
> --- a/drivers/gpu/drm/nouveau/nouveau_drm.c
> +++ b/drivers/gpu/drm/nouveau/nouveau_drm.c
> @@ -835,6 +835,8 @@ nouveau_pmops_runtime_suspend(struct device *dev)
>  		return -EBUSY;
>  	}
>  
> +	dev->power.disable_depth++;
> +

I'm not sure if that variable is actually private to the PM core.
Grepping through the tree I only find a single occurrence where it's
accessed outside the PM core and that's in amdgpu.  So this looks
a little fishy TBH.  It may make sense to cc such patches to linux-pm
to get Rafael & other folks involved with the PM core to comment.

Also, the disable_depth variable only exists if the kernel was
compiled with CONFIG_PM enabled, but I can't find a "depends on PM"
or something like that in nouveau's Kconfig.  Actually, if PM is
not selected, all the nouveau_pmops_*() functions should be #ifdef'ed
away, but oddly there's no #ifdef CONFIG_PM anywhere in nouveau_drm.c.

Anywayn, if I understand the commit message correctly, you're hitting a
pm_runtime_get_sync() in a code path that itself is called during a
pm_runtime_get_sync().  Could you include stack traces in the commit
message?  My gut feeling is that this patch masks a deeper issue,
e.g. if the runtime_resume code path does in fact directly poll outputs,
that would seem wrong.  Runtime resume should merely make the card
accessible, i.e. reinstate power if necessary, put into PCI_D0,
restore registers, etc.  Output polling should be scheduled
asynchronously.

Thanks,

Lukas
