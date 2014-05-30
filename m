From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [GIT PULL] request to Rafael: devfreq update for Linux 3.16
Date: Fri, 30 May 2014 04:15:13 +0200
Message-ID: <2568920.gZb0G3l1Qp@vostro.rjw.lan>
References: <CAJ0PZbQSKpbwkR7eGb7iLA6JwNKxVNYcV1VWbJuNTdQyy2sKLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54892 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751919AbaE3B6H (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 29 May 2014 21:58:07 -0400
In-Reply-To: <CAJ0PZbQSKpbwkR7eGb7iLA6JwNKxVNYcV1VWbJuNTdQyy2sKLA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@gmail.com
Cc: rafael.j.wysocki@intel.com, Linux PM list <linux-pm@vger.kernel.org>

On Friday, May 30, 2014 01:43:32 AM MyungJoo Ham wrote:
> In case you've missed, updated the subject.

I didn't miss it, but I didn't have the time to handle it.

Pulled now, thanks MyungJoo!


> On Sat, May 24, 2014 at 11:06 PM, MyungJoo Ham <myungjoo.ham@samsung.com> wrote:
> > Dear Rafael,
> >
> > Here goes the pull request of devfreq for 3.16
> >
> >
> > Cheers,
> > MyungJoo
> >
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA1
> >
> > The following changes since commit 4b660a7f5c8099d88d1a43d8ae138965112592c7:
> >
> >   Linux 3.15-rc6 (2014-05-22 06:42:02 +0900)
> >
> > are available in the git repository at:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq.git tags/for-3.16
> >
> > for you to fetch changes up to cb7063f453e543b97285a10343cfc02983d792ad:
> >
> >   PM / devfreq: remove checks for CONFIG_EXYNOS_ASV (2014-05-24 22:33:51 +0900)
> >
> > - ----------------------------------------------------------------
> > Pull Request for Rafael.
> >
> > Merge target is Linux 3.16
> >
> > - - Clean up with modern macro in the core and drivers.
> > - - Fix incorrect error returns
> > - - Remove dead CONFIG check.
> > - - Fix resource leak in a driver.
> >
> > - ----------------------------------------------------------------
> > Bartlomiej Zolnierkiewicz (3):
> >       PM / devfreq: exynos4: introduce struct busfreq_ppmu_data
> >       PM / devfreq: exynos5: introduce struct busfreq_ppmu_data
> >       PM / devfreq: exynos: make more PPMU code common
> >
> > Chanwoo Choi (11):
> >       PM / devfreq: exynos4: Fix bug of resource leak and code clean on probe()
> >       PM / devfreq: exynos4: Use SIMPLE_DEV_PM_OPS macro
> >       PM / devfreq: exynos4: Add CONFIG_PM_OPP dependency to fix probe fail
> >       PM / devfreq: exynos5: Use SIMPLE_DEV_PM_OPS macro
> >       PM / devfreq: exynos5: Add CONFIG_PM_OPP dependency to fix probe fail
> >       PM / devfreq: exynos4: use common PPMU code
> >       PM / devfreq: Fix devfreq_remove_device() to improve the sequence ...
> >       PM / devfreq: Add resource-managed function for devfreq device
> >       PM / devfreq: Add devm_devfreq_{register,unregister}_opp_notfierfunction
> >       PM / devfreq: exynos4: Use devm_devfreq_* function using device ...
> >       PM / devfreq: exynos5: Use devm_devfreq_* function using device ...
> >
> > Paul Bolle (1):
> >       PM / devfreq: remove checks for CONFIG_EXYNOS_ASV
> >
> >  drivers/devfreq/Kconfig              |   5 +-
> >  drivers/devfreq/devfreq.c            | 125 ++++++++++++++++++--
> >  drivers/devfreq/exynos/Makefile      |   2 +-
> >  drivers/devfreq/exynos/exynos4_bus.c | 219 ++++++++++-------------------------
> >  drivers/devfreq/exynos/exynos5_bus.c | 130 ++++++---------------
> >  drivers/devfreq/exynos/exynos_ppmu.c |  60 ++++++++++
> >  drivers/devfreq/exynos/exynos_ppmu.h |   8 ++
> >  include/linux/devfreq.h              |  35 +++++-
> >  8 files changed, 317 insertions(+), 267 deletions(-)
> > -----BEGIN PGP SIGNATURE-----
> > Version: GnuPG v1.4.14 (GNU/Linux)
> >
> > iQIcBAEBAgAGBQJTgKWPAAoJEDv/jgS9xknFYlMP/0zIsdDGxtJA3NdxJGT/dA+d
> > z7sDIBSOCQCBQv8CSMCY6HgtejgbtpRX8coKaSYGjLP9sL43hHCRkJesQdYNo5vE
> > xuU0Zo80ERBZvXj9pXC76ojmvBMRmynYPnbMC7ZgzGEFA2kSf/SoEAwSu6y+5uiF
> > b5igBp22QNd73V5c+Vjr6pzDfSXDyGDv5Km8jDFPvx3YLNChY471VtK+KMikGwGp
> > FplzfNSCThMPertAxKuWRlZMS8v0YVyO9TN4KHNQuwdGotiQcYweeAFL+G183ZaC
> > 8m+komdIP2oct0h19j8298cGPQSH/NpCXTwXSFMhn/QEU6W3WtaTF3crURjhTxja
> > EZiSOClumMnZPJt6di10vV6TOS0e4pWgfP2ZX9sNRBYLf5Vs/P46kB3mzAM1LSeV
> > D/93dkv5mAoZPTt/eruB/4jOeQDewAtOf/o3/vOjXUu4QwQ7JARGUEZ8RKJktVHs
> > R5q7nrEFOckyoSME131ePODy5EUgYv2kFGmaLqwulZaUN7ooslBZiaph7Fc0f1VB
> > 2TEQKLtbkPIYiDqTHF8MAkIjwzhuul02NpEN7UccHfc4RIkoyhNnOrhwsi2ktAJw
> > ID7x2ofVKvevHp2qiLWlAHAryEJ+aTYNpiDRByZiUWFrt8LlLIZuCkdxWYGWcyOY
> > dkeARTmbHnqfdYAeuTNn
> > =ZUxh
> > -----END PGP SIGNATURE-----
> 
> 
> 
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
