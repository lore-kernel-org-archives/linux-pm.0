From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCHv3 0/8] devfreq: Add generic exynos memory-bus frequency
 driver
Date: Tue, 24 Feb 2015 08:55:29 +0900
Message-ID: <54EBBDF1.1030306@samsung.com>
References: <1420681257-3078-1-git-send-email-cw00.choi@samsung.com>
 <54DFE797.1020008@math.uni-bielefeld.de> <54E4FD40.8020206@gmx.net>
 <54EA69D2.7010706@samsung.com> <54EB8645.4060608@math.uni-bielefeld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <54EB8645.4060608@math.uni-bielefeld.de>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tobias Jakobi <tjakobi@math.uni-bielefeld.de>
Cc: Tobias Jakobi <liquid.acid@gmx.net>, myungjoo.ham@samsung.com, kgene@kernel.org, kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, mark.rutland@arm.com, a.kesavan@samsung.com, tomasz.figa@gmail.com, k.kozlowski@samsung.com, b.zolnierkie@samsung.com, robh+dt@kernel.org, inki.dae@samsung.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Tobias,

On 02/24/2015 04:57 AM, Tobias Jakobi wrote:
> Hello Chanwoo!
> 
> Chanwoo Choi wrote:
>> As you thought, when maintaining lower clock of memory bus frequency,
>> some issue related to multimedia feature will happen.
>>
>> Separately, We have to check the miminum lower clock for working of multimedia feature.
>> and then multimedia or other IP have to request it to DVFS driver (memory busfreq driver).
>> But, latest mainline kernel currently has not some way to inform minimum clock to DVFS driver.
>>
>> So, If you check the miminum clock for hdmi, I'll use this clock as minumu frequency of dvfs table.
>>
>> Thanks,
>> Chanwoo Choi
>>
> 
> First I have to apologize. I didn't check carefully. Actually it's not
> the HDMI subsystem which seems to hang during my test, but the G2D
> subsystem.
> 
> Here's a snippet of the kernel log with drm.debug=0xff:
> [ 1157.911264] [drm:drm_framebuffer_reference] ee144e00: FB ID: 27 (2)
> [ 1157.911271] [drm:drm_framebuffer_unreference] ee37fb80: FB ID: 25 (2)
> [ 1157.911277] [drm:drm_framebuffer_unreference] ee144e00: FB ID: 27 (3)
> [ 1157.911315] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> EXYNOS_G2D_GET_VER
> [ 1158.434439] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> EXYNOS_G2D_SET_CMDLIST
> [ 1158.434536] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1, EXYNOS_G2D_EXEC
> [ 1158.437484] [drm:drm_vm_close_locked] 0xaf840000,0x00140000
> [ 1158.437507] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> DRM_IOCTL_GEM_CLOSE
> [ 1158.437524] [drm:exynos_drm_gem_destroy] handle count = 0
> [ 1158.437532] [drm:lowlevel_buffer_deallocate] dma_addr(0x20500000),
> size(0x140000)
> [ 1158.437810] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> EXYNOS_GEM_CREATE
> [ 1158.437819] [drm:exynos_drm_init_buf] desired size = 0x256000
> [ 1158.437851] [drm:exynos_drm_gem_init] created file object = 0xe97c8d00
> [ 1158.445506] [drm:lowlevel_buffer_allocate] dma_addr(0x21400000),
> size(0x256000)
> [ 1158.445535] [drm:exynos_drm_gem_handle_create] gem handle = 0x1
> [ 1158.445556] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> DRM_IOCTL_MODE_MAP_DUMB
> [ 1158.445570] [drm:exynos_drm_gem_dumb_map_offset] offset = 0x101c2000
> [ 1158.445600] [drm:drm_vm_open_locked] 0xaec15000,0x00256000
> [ 1158.445608] [drm:update_vm_cache_attr] flags = 0x0
> [ 1158.457696] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1,
> EXYNOS_G2D_SET_CMDLIST
> [ 1158.457745] [drm:drm_ioctl] pid=2569, dev=0xe200, auth=1, EXYNOS_G2D_EXEC
> 
> 
> So G2D_EXEC seems to work once, but the second time it hangs forever. I
> even fail at attaching gdb to the application then (gdb then also hangs
> in D state).
> 
> If I just use the 'vsynced page flipping' test, then everything works:
> ./modetest -M exynos -s 16@13:1280x720 -v
> setting mode 1280x720-60Hz@XR24 on connectors 16, crtc 13
> freq: 61.08Hz
> freq: 60.00Hz
> freq: 60.00Hz
> <etc.>
> 
> I'm going to do some tests with the G2D in the next time, checking how
> much I can lower MIF/INT clocks before the engine becomes unstable.

Thanks for your test. If you have any question or help, please feel free to ask me.

I'm working to implemnet new generic exynos memoby-bus frequency driver (exynos-busfreq.c).
because this version of patch-set used the 'virtual operating-points'.
So, I'm working to implment this drvier without 'virtual operation-points'.
After finishing the implmentaion, I'll add you to mailing list ac Cc.

Best Regards,
Chanwoo Choi
