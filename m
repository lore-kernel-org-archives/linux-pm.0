From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [Q] freezing tasks vs. suspending drivers during STR
Date: Thu, 14 Jul 2011 14:42:04 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1107141430460.10688@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi all

I ran across an issue, which I cannot understand. In short: kernel threads 
continue running also after freezing of the tasks has completed, late into 
the device suspend. My scenario was suspending the system, while running 
dmatest. At some point also the DMA driver is suspended, but the dmatest 
threads continue running, so they issue further requests, which then 
confuse the driver. In case this is a known design "decision," you do not 
have to read on. Below I'll just provide some excerpts from kernel logs, 
supporting my statement. Any explanation and fix suggestions would be 
appreciated!

* In the kernel log we first dee processes being frozen:

[   60.414062] Freezing user space processes ... 
[   60.421875] sh-dma-engine sh-dma-engine.2: submit #60@cc87fdb4 on 3: 4ca1c388[15140] -> 4ca203b4
[   60.421875] sh-dma-engine sh-dma-engine.2: submit #61@cc87fdb4 on 3: 4ca24be8[9316] -> 4ca28928
[   60.421875] sh-dma-engine sh-dma-engine.2: submit #62@cc87fdb4 on 3: 4ca1f2ec[3332] -> 4ca22644

* The above "submit" lines come from the dmatest _kernel threads_, which 
* is the context, from which all these calls are made

[   60.437500] (elapsed 0.01 seconds) done.
[   60.437500] Freezing remaining freezable tasks ...

* Some more freezable tasks...

[   60.437500] sh-dma-engine sh-dma-engine.2: submit #72@cc87fcf4 on 3: 4ca27584[236] -> 4ca2abdc
[   60.437500] sh-dma-engine sh-dma-engine.2: submit #73@cc87fcf4 on 3: 4ca24430[11668] -> 4ca28c3c
[   60.437500] sh-dma-engine sh-dma-engine.0: submit #32@cf7343d4 on 2: 4f7de588[1668] -> 4f7e1d34

...

[   60.460937] sh-dma-engine sh-dma-engine.2: submit #76@cc87fcf4 on 3: 4ca244cc[12012] -> 4ca2852c
[   60.460937] sh-dma-engine sh-dma-engine.2: submit #43@cc87f0f4 on 4: 4ca4cf90[11548] -> 4ca507f8
[   60.468750] sh-dma-engine sh-dma-engine.0: submit #50@cf668e14 on 0: 4f78cb18[9008] -> 4f7916c0
[   60.468750] (elapsed 0.03 seconds) done.
[   60.468750] Suspending console(s) (use no_console_suspend to debug)

* Ok, should be done with processes by now, right?

[   60.476562] sh-dma-engine sh-dma-engine.0: submit #51@cf668e14 on 0: 4f784b30[620] -> 4f788098
[   60.476562] sh-dma-engine sh-dma-engine.2: submit #77@cc87fcf4 on 3: 4ca24670[2712] -> 4ca2a250
[   60.476562] sh-dma-engine sh-dma-engine.2: submit #44@cc87f0f4 on 4: 4ca4cd80[5324] -> 4ca51ba4
[   60.476562] sh-dma-engine sh-dma-engine.0: submit #52@cf668e14 on 0: 4f78c380[12772] -> 4f790420
...
[   60.585937] sh-dma-engine sh-dma-engine.0: submit #70@cf668214 on 1: 4f7a8764[13720] -> 4f7ac7dc
[   60.593750] sh-dma-engine sh-dma-engine.0: submit #58@cf734434 on 2: 4f7c4978[12780] -> 4f7c82c4
[   60.593750] sh-dma-engine sh-dma-engine.0: submit #71@cf6681b4 on 1: 4f7a2074[7960] -> 4f7a47ec
[   60.593750] sh-dma-engine sh-dma-engine.0: submit #59@cf734434 on 2: 4f7c70d4[1116] -> 4f7cb630

* Ouch... they are still running.

[   60.593750] soc_camera_platform soc_camera_platform.0: platform_pm_suspend().703: soc_camera_platform
[   60.593750] snd-soc-dummy snd-soc-dummy: platform_pm_suspend().703: snd-soc-dummy
[   60.593750] alarmtimer alarmtimer: platform_pm_suspend().703: alarmtimer
[   60.593750] sh_mobile_meram sh_mobile_meram.0: platform_pm_suspend().703: sh_mobile_meram
[   60.593750] sh-mobile-hdmi sh-mobile-hdmi: platform_pm_suspend().703: sh-mobile-hdmi
[   60.593750] sh_mobile_lcdc_fb sh_mobile_lcdc_fb.1: pm_genpd_suspend()

* Above random drivers suspend their devices already

[   60.601562] sh-dma-engine sh-dma-engine.0: submit #60@cf734434 on 2: 4f7c52ec[11480] -> 4f7c9310
[   60.601562] sh-dma-engine sh-dma-engine.0: submit #61@cf734434 on 2: 4f7c5bec[7448] -> 4f7c9428
[   60.601562] sh-dma-engine sh-dma-engine.0: submit #62@cf734434 on 2: 4f7c5434[2036] -> 4f7cac20
[   60.601562] sh-dma-engine sh-dma-engine.0: submit #63@cf734434 on 2: 4f7c4190[8088] -> 4f7c9500
[   60.601562] sh-dma-engine sh-dma-engine.0: submit #64@cf734434 on 2: 4f7c58fc[2824] -> 4f7cad58

* more dmatest kthread runs

[   60.835937] sh-dma-engine sh-dma-engine.1: submit #74@cc874434 on 1: 4c8b8954[7940] -> 4c8bd460
[   60.835937] sh-dma-engine sh-dma-engine.1: submit #77@cc878154 on 5: 4c955d34[7040] -> 4c958bd0
[   60.843750] sh-dma-engine sh-dma-engine.1: submit #78@cc878154 on 5: 4c956258[4796] -> 4c959e98
[   60.843750] smsc911x smsc911x: platform_pm_suspend().703: smsc911x
[   60.843750] physmap-flash physmap-flash.0: platform_pm_suspend().703: physmap-flash
[   60.843750] platform uio_pdrv_genirq.0: pm_genpd_suspend()

* more yet, intermixed with random device suspends

[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan0): 0 @ cf69d0c4
[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan1): 0 @ cf2ace64
[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan2): 1 @ cf2acce4
[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan3): 1 @ cf2acb64
[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan4): 1 @ cf2ac9e4
[   60.843750] sh-dma-engine sh-dma-engine.2: sh_dmae_suspend(dma2chan5): 1 @ cf2ac864
[   60.843750] sh-dma-engine sh-dma-engine.1: pm_genpd_suspend()
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan0): 1 @ cf69da84
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan1): 1 @ cf69d904
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan2): 1 @ cf69d784
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan3): 0 @ cf69d604
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan4): 0 @ cf69d484
[   60.843750] sh-dma-engine sh-dma-engine.1: sh_dmae_suspend(dma1chan5): 1 @ cf69d304
[   60.843750] sh-dma-engine sh-dma-engine.0: pm_genpd_suspend()
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan0): 1 @ cf707824
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan1): 0 @ cf7076a4
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan2): 1 @ cf707524
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan3): 1 @ cf7073a4
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan4): 1 @ cf69de44
[   60.843750] sh-dma-engine sh-dma-engine.0: sh_dmae_suspend(dma0chan5): 1 @ cf69dcc4

* shdma suspended, good

[   60.843750] PM: suspend of devices complete after 248.086 msecs

[   60.851562] sh-dma-engine sh-dma-engine.1: submit #79@cc878154 on 5: 4c95739c[180] -> 4c95805c
[   60.851562] sh-dma-engine sh-dma-engine.1: submit #72@cc8756f4 on 2: 4c91481c[4456] -> 4c91a6dc
[   60.851562] sh-dma-engine sh-dma-engine.1: submit #75@cc874434 on 1: 4c8ac7d8[8576] -> 4c8b07bc
[   60.851562] sh-dma-engine sh-dma-engine.1: submit #59@cc878cf4 on 4: 4c9407d0[2628] -> 4c945dd0
[   60.851562] sh-dma-engine sh-dma-engine.2: submit #40@cc87caf4 on 2: 4c9ca0b0[5200] -> 4c9cdbf0
[   60.851562] sh-dma-engine sh-dma-engine.2: submit #41@cc87c9d4 on 2: 4c9b9b28[5804] -> 4c9bde50
[   60.851562] sh-dma-engine sh-dma-engine.2: submit #42@cc87ca34 on 2: 4c9b07d4[11964] -> 4c9b4390
[   60.851562] sh-dma-engine sh-dma-engine.1: submit #47@cc877a34 on 3: 4c8fcf4c[3784] -> 4c9023a8
[   60.851562] sh-dma-engine sh-dma-engine.2: submit #43@cc87ca94 on 2: 4c9c16c8[9576] -> 4c9c5568
[   60.851562] sh-dma-engine sh-dma-engine.2: submit #120@cc87fcf4 on 3: 4ca2c878[11636] -> 4ca30da4

[   60.859375] sh-dma-engine sh-dma-engine.2: submit #121@cc87fdb4 on 3: 4ca1e2dc[3520] -> 4ca22394
[   60.859375] sh-dma-engine sh-dma-engine.2: submit #122@cc87fe14 on 3: 4c9ab7c8[584] -> 4c9aed98

* Heeeeeelp... still running......

[   60.859375] PM: late suspend of devices complete after 16.277 msecs

* Good night
* Good morning

[   60.859375] sh_tmu sh_tmu.0: used for periodic clock events
[   60.859375] sh-sci sh-sci.0: pm_genpd_resume_noirq()

[   60.859375] PM: early resume of devices complete after 1.416 msecs

[   60.859375] sh-dma-engine sh-dma-engine.1: sh_dmae_resume(dma1chan1): cf69d904
[   60.859375] sh-dma-engine sh-dma-engine.1: sh_dmae_resume(dma1chan2): cf69d784
[   60.859375] sh-dma-engine sh-dma-engine.1: sh_dmae_resume(dma1chan3): cf69d604
[   60.859375] sh-dma-engine sh-dma-engine.1: sh_dmae_resume(dma1chan5): cf69d304
[   60.859375] sh-dma-engine sh-dma-engine.2: pm_genpd_resume(): 0
[   60.859375] sh-dma-engine sh-dma-engine.2: sh_dmae_resume(dma2chan0): cf69d0c4
[   60.859375] sh-dma-engine sh-dma-engine.2: sh_dmae_resume(dma2chan2): cf2acce4
[   60.859375] sh-dma-engine sh-dma-engine.2: sh_dmae_resume(dma2chan3): cf2acb64

* shdma resumed

[   60.859375] PM: resume of devices complete after 2.624 msecs

* threads woken up...

[   60.867187] sh-dma-engine sh-dma-engine.0: submit #65@cf668e14 on 0: 4f7963cc[1904] -> 4f79b0fc
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #72@cf668154 on 1: 4f7b6824[5448] -> 4f7b8674
[   60.867187] sh-dma-engine sh-dma-engine.2: submit #49@cc87f0f4 on 4: 4ca689d8[10648] -> 4ca6c4ec
[   60.867187] sh-dma-engine sh-dma-engine.2: submit #50@cc87f0f4 on 4: 4ca38e94[2036] -> 4ca3d970
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #66@cf668e14 on 0: 4f78d82c[4672] -> 4f791aec
[   60.867187] sh-dma-engine sh-dma-engine.2: submit #51@cc87f0f4 on 4: 4ca4c430[11020] -> 4ca50bdc
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #67@cf668e14 on 0: 4f7848a8[11372] -> 4f7886e8
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #59@cf2a2814 on 3: 4c808f10[7244] -> 4c80d098
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #60@cf2a2814 on 3: 4f7e9684[1428] -> 4f7ecb64
[   60.867187] sh-dma-engine sh-dma-engine.0: submit #61@cf2a2814 on 3: 4c801074[3308] -> 4c8058e8
[   60.867187] sh-dma-engine sh-dma-engine.2: submit #123@cc87fd54 on 3: 4ca24fe0[1372] -> 4ca2b8a8

* What am I missing?

Well, sure, I could hack the driver to reject any submits after suspend or 
queue them without executing, but... Is this behaviour correct?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
