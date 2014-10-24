From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [RFC 1/2] PM / Domains: Power on domain early during system resume
Date: Fri, 24 Oct 2014 09:30:11 +0200
Message-ID: <1414135811.2989.8.camel@AMDC1943>
References: <1414072090-11293-1-git-send-email-k.kozlowski@samsung.com>
 <1414072090-11293-2-git-send-email-k.kozlowski@samsung.com>
 <54492ADA.4000309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-reply-to: <54492ADA.4000309@ti.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Andrzej Hajda <a.hajda@samsung.com>, Len Brown <len.brown@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, linux-pm@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Seung-Woo Kim <sw0312.kim@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, linux-samsung-soc@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, linux-arm-kernel@lists.infradead.org, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On czw, 2014-10-23 at 19:20 +0300, Grygorii Strashko wrote:
> Hi Krzysztof,
> 
> On 10/23/2014 04:48 PM, Krzysztof Kozlowski wrote:
> > When resuming the system the power domain has to be powered on early so
> > any runtime PM aware devices could resume.
> > 
> > This fixes following scenario reproduced on Exynos DRM:
> > 1. Power domain is off before suspending the system.
> > 2. System is suspended to RAM.
> > 3. Resuming starts. The Exynos DRM driver resume callback is called.
> > 4. The Exynos DRM driver calls drm_helper_resume_force_mode which turns
> >     the screen on by calling exynos_dsi_dpms with DRM_MODE_DPMS_ON.
> > 5. The Exynos DSI driver calls pm_runtime_get. The driver runtime
> >     resumes and this should turn LCD power domain on.
> > 6. Unfortunately the domain cannot be turned on because system resume is
> >     in progress and genpd->prepared_count is positive.
> 
> Just interesting, what value will be returned by pm_runtime_enabled()
> from any of your .resume() callback (for any device which belongs to
> some Generic PM domain)?

exynos_drm_resume: false
exynos_dsi_enable: true

Full backtrace leading to exynos_dsi_enable:
[   37.944830] ------------[ cut here ]------------
[   37.944860] WARNING: CPU: 0 PID: 3125 at drivers/gpu/drm/exynos/exynos_drm_dsi.c:1360 exynos_dsi_dpms+0xc0/0x398()
[   37.944869] Modules linked in:
[   37.944883] CPU: 0 PID: 3125 Comm: bash Tainted: G        W      3.17.0-next-20141020-00050-g844ed80678d5-dirty #479
[   37.944923] [<c0013d64>] (unwind_backtrace) from [<c0010eb0>] (show_stack+0x10/0x14)
[   37.944949] [<c0010eb0>] (show_stack) from [<c04a37b0>] (dump_stack+0x70/0xbc)
[   37.944977] [<c04a37b0>] (dump_stack) from [<c0021420>] (warn_slowpath_common+0x64/0x88)
[   37.944992] [<c0021420>] (warn_slowpath_common) from [<c0021460>] (warn_slowpath_null+0x1c/0x24)
[   37.945011] [<c0021460>] (warn_slowpath_null) from [<c0268940>] (exynos_dsi_dpms+0xc0/0x398)
[   37.945024] [<c0268940>] (exynos_dsi_dpms) from [<c0263520>] (exynos_drm_encoder_commit+0x24/0x40)
[   37.945044] [<c0263520>] (exynos_drm_encoder_commit) from [<c023f0b4>] (drm_crtc_helper_set_mode+0x400/0x4e8)
[   37.945057] [<c023f0b4>] (drm_crtc_helper_set_mode) from [<c023f204>] (drm_helper_resume_force_mode+0x68/0x124)
[   37.945083] [<c023f204>] (drm_helper_resume_force_mode) from [<c0262b9c>] (exynos_drm_resume+0x80/0x90)
[   37.945100] [<c0262b9c>] (exynos_drm_resume) from [<c02832f8>] (platform_pm_resume+0x2c/0x4c)
[   37.945118] [<c02832f8>] (platform_pm_resume) from [<c028a320>] (dpm_run_callback.isra.7+0x2c/0x64)
[   37.945130] [<c028a320>] (dpm_run_callback.isra.7) from [<c028a404>] (device_resume+0xac/0x180)
[   37.945141] [<c028a404>] (device_resume) from [<c028b65c>] (dpm_resume+0xe8/0x20c)
[   37.945152] [<c028b65c>] (dpm_resume) from [<c028b91c>] (dpm_resume_end+0xc/0x18)
[   37.945175] [<c028b91c>] (dpm_resume_end) from [<c0054b48>] (suspend_devices_and_enter+0x230/0x3c8)
[   37.945190] [<c0054b48>] (suspend_devices_and_enter) from [<c0054f48>] (pm_suspend+0x268/0x29c)
[   37.945202] [<c0054f48>] (pm_suspend) from [<c0053a74>] (state_store+0x6c/0xbc)
[   37.945220] [<c0053a74>] (state_store) from [<c01d0890>] (kobj_attr_store+0x14/0x20)
[   37.945235] [<c01d0890>] (kobj_attr_store) from [<c011e56c>] (sysfs_kf_write+0x44/0x48)
[   37.945245] [<c011e56c>] (sysfs_kf_write) from [<c011dc10>] (kernfs_fop_write+0xc0/0x17c)
[   37.945268] [<c011dc10>] (kernfs_fop_write) from [<c00c7bfc>] (vfs_write+0xa0/0x1a8)
[   37.945282] [<c00c7bfc>] (vfs_write) from [<c00c7f14>] (SyS_write+0x40/0x8c)
[   37.945299] [<c00c7f14>] (SyS_write) from [<c000e6e0>] (ret_fast_syscall+0x0/0x30)
[   37.945307] ---[ end trace e930e0edfd9a5ad2 ]---


> I'm asking, because as I can see Runtime PM can be disabled from pm_genpd_prepare().
> 
> Thank you.
> 
> Oh. I've just found that you might get this issue if you will try to do
> suspend when PM domain is ON ;)
> 
> Any way, In my opinion, It might be better to fix pm_genpd_prepare() so
> it will not increment prepared_count when initial state of the GPD is
> GPD_STATE_POWER_OFF. Seems it's needed only in opposite case -
> when state of GPD has to be restored from pm_genpd_resume_noirq().

That sounds good but what about cases when the device will runtime
resume during suspend (early at suspend)? Actually I seen this with
framebuffer console. Right after starting suspend the console is flushed
and poked which leads to powering on LCD.

Best regards,
Krzysztof
