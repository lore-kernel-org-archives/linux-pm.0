From: Lukasz Majewski <l.majewski@samsung.com>
Subject: Re: [PATCH 5/8] thermal:cpu cooling:tegra: Provide deferred probing
 for tegra driver
Date: Mon, 17 Nov 2014 12:50:13 +0100
Message-ID: <20141117125013.3493a3a1@amdc2363>
References: <1411547232-21493-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-1-git-send-email-l.majewski@samsung.com>
 <1415898165-27406-6-git-send-email-l.majewski@samsung.com>
 <5465DDC5.6090301@kapsi.fi> <20141117114341.GF25699@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20141117114341.GF25699@ulmo>
Sender: linux-kernel-owner@vger.kernel.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: Mikko Perttunen <mikko.perttunen@kapsi.fi>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Linux PM list <linux-pm@vger.kernel.org>, Vincenzo Frascino <vincenzo.frascino@st.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Lukasz Majewski <l.majewski@majess.pl>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, Mikko Perttunen <mperttunen@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Alexandre Courbot <gnurou@gmail.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Thierry,

> On Fri, Nov 14, 2014 at 12:47:33PM +0200, Mikko Perttunen wrote:
> > Tested-by: Mikko Perttunen <mikko.perttunen@kapsi.fi>
> > 
> > One potential issue I can see is that if the cpufreq driver fails
> > to probe then you'll never get the thermal driver either. For
> > example, Tegra124 currently has no cpufreq driver, so if
> > CONFIG_CPU_THERMAL was enabled, then the soctherm driver would
> > never be able to probe. But I don't really have a solution for this
> > either.
> 
> It doesn't seem like there's any code whatsoever to deal with cpufreq
> within the soctherm driver, so deferring probe based on something
> we're not using anyway seems rather useless.

So, If I understood you correctly - this patch is not needed in the 
/tegra_soctherm.c:[tegra_defconfig] driver and can be safely omitted in
v2 of this driver.

Please note that I'm not aware of Tegra specific use cases and hence
I've prepared fixes for all potential candidates.

> 
> Thierry

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
