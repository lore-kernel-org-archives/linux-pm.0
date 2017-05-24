From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V4 00/17] thermal: cpu_cooling: improve interaction with
 cpufreq core
Date: Wed, 24 May 2017 09:23:52 +0530
Message-ID: <20170524035352.GO6510@vireshk-i7>
References: <cover.1493115651.git.viresh.kumar@linaro.org>
 <20170524024148.GA5004@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36505 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1761881AbdEXDx5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 May 2017 23:53:57 -0400
Received: by mail-pg0-f52.google.com with SMTP id x64so59069845pgd.3
        for <linux-pm@vger.kernel.org>; Tue, 23 May 2017 20:53:57 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170524024148.GA5004@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, linaro-kernel@lists.linaro.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Punit Agrawal <punit.agrawal@arm.com>

On 23-05-17, 19:41, Eduardo Valentin wrote:
> Hey,
> 
> On Tue, Apr 25, 2017 at 03:57:07PM +0530, Viresh Kumar wrote:
> > Hi Guys,
> > 
> > The cpu_cooling driver is designed to use CPU frequency scaling to avoid
> > high thermal states for a platform. But it wasn't glued really well with
> > cpufreq core. For example clipped-cpus is copied from the policy
> > structure and its much better to use the policy->cpus (or related_cpus)
> > fields directly as they may have got updated. Not that things were
> > broken before this series, but they can be optimized a bit more.
> > 
> > This series tries to improve interactions between cpufreq core and
> > cpu_cooling driver and does some fixes/cleanups to the cpu_cooling
> > driver.
> > 
> > I have tested it on ARM 32 (exynos) and 64 bit (hikey) boards (haven't
> > tested the power specific bits).
> > 
> > Lukasz from ARM has been very generous in testing and finding out few
> > bugs in the earlier versions and getting those fixed.  He has
> > successfully tested the new version on his ARM big LITTLE Juno board.
> > 
> > Pushed here as well:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git thermal/cooling
> > 
> > V3->V4:
> 
> 
> Took this version into my -linus branch for the next merge window.
> Including the patch to remove the checkpatch warning. But please send
> an extra patch to fix the style pointed on patch 8.

Thanks Eduardo.

But I am not sure what's left there to be fixed :(

There were two warnings with patch 8, s/kmalloc/kmalloc_array and line
over 80 columns and both were fixed by the patch I sent separately.

-- 
viresh
