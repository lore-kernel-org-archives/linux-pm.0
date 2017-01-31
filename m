From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 0/5] Provide real domain names for Exynos power domain
 driver
Date: Tue, 31 Jan 2017 21:19:55 +0200
Message-ID: <20170131191955.zdv5bzirraf3xoyu@kozik-lap>
References: <CGME20170130121912eucas1p1002708fc40c2d385c41ef2d7574561f9@eucas1p1.samsung.com>
 <1485778740-30337-1-git-send-email-m.szyprowski@samsung.com>
 <20170130183621.3v77pfrncm2qb7nr@kozik-lap>
 <e632ffe1-87ce-7d05-2ec2-a93e7f91058f@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e632ffe1-87ce-7d05-2ec2-a93e7f91058f@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 31, 2017 at 08:04:53AM +0100, Marek Szyprowski wrote:
> 
> 
> On 2017-01-30 19:36, Krzysztof Kozlowski wrote:
> > On Mon, Jan 30, 2017 at 01:18:55PM +0100, Marek Szyprowski wrote:
> > > Hi!
> > > 
> > > For everyone working on power management and runtime power management it
> > > is important to have a meaningful information about the state of the
> > > power domains. Current Exynos power domain driver created names of the
> > > domains based on the device tree node name. Those name
> > > we incorrectly a bit more descriptive (like "mfc-power-domain@10023C40"
> > > in exynos4.dtsi) than they should be (it should be fixed to
> > > "power-domain@10023C40"). This patch series adds reading human readable
> > > names from the 'label' property. While touching this, I've also fixes
> > > a few obvious issues related to power domain driver code.
> > > 
> > > Patches are based on the Linux next-20170130 branch.
> > > 
> > > Best regards
> > > Marek Szyprowski
> > > Samsung R&D Institute Poland
> > > 
> > I think I am missing something... but it looks it does not work. I
> > applied it on top of my for-next tree and:
> > cat /sys/kernel/debug/pm_genpd/pm_genpd_summary
> > domain                          status          slaves
> >      /device                                             runtime status
> >      ----------------------------------------------------------------------
> >      isp-power-domain@10023CA0       off-0
> >      gps-alive-power-domain@10023D00  off-0
> >      gps-power-domain@10023CE0       off-0
> >      cam-power-domain@10023C00       off-0
> > 
> > Also, with enabled debug on pm-domains and unbinding a device:
> > [  180.016800] s5p-mfc 13400000.codec: genpd_runtime_resume()
> > [  180.017289] s5p-mfc 13400000.codec: genpd_runtime_suspend()
> > [  180.017519] s5p-mfc 13400000.codec: Removing 13400000.codec
> > [  180.024283] s5p-mfc 13400000.codec: removing from PM domain mfc-power-domain@10023C40
> > [  180.024323] s5p-mfc 13400000.codec: genpd_remove_device()
> > 
> > I think in both cases the genpd->name is used... which should be the new
> > name (label).
> > 
> > What is wrong?
> 
> I have no idea. Are you sure you have applied the dts patch? Here it works
> fine (Odroid U3 with next-20170130 + this patchset):

Yep:
$ git log --oneline
ee85c687392b arm: dts: exynos: Add labels to all existing power domains
6c63bc30112d soc: samsung: pm_domains: Read domain name from the new label property
f4c8f7f062ca soc: samsung: pm_domains: Remove message about failed memory allocation
90d5c7c36ad3 soc: samsung: pm_domains: Remove unused name field
b8b54d5c4f5a soc: samsung: pm_domains: Use full names in subdomains registration log
95648b747071 Merge branch 'next/soc' into for-next

On the board:
$ uname -a
Linux odroidu3 4.10.0-rc2-00070-gee85c687392b-dirty

The hash matches. Let my try it on the linux-next...

BR,
Krzysztof

> 
> domain                          status          slaves
>     /device                                             runtime status
> ----------------------------------------------------------------------
> ISP                             off-0
> GPS alive                       off-0
> GPS                             off-0
> CAM                             off-0
> TV                              on
>     /devices/platform/12c10000.mixer                    active
>     /devices/platform/12d00000.hdmi                     active
> LCD0                            on              TV
> G3D                             off-0
> MFC                             off-0
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
