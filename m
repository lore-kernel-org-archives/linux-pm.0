From: Mohammad Merajul Islam Molla <meraj.enigma@gmail.com>
Subject: Re: [Query] cpuidle functions cpuidle_install_idle_handler/cpuidle_uninstall_idle_handler
Date: Tue, 5 Aug 2014 14:55:23 +0600
Message-ID: <CAHu9=sPEDuC-nQqP4Xe-_vLXz3FFGpkzSnCMCdJcUbmT+choeQ@mail.gmail.com>
References: <CAHu9=sPqfgxO5YbA28pa2jdRwjnvwE22JUNhr0XzwaLurf_gWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ie0-f176.google.com ([209.85.223.176]:54333 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755635AbaHEIzo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 Aug 2014 04:55:44 -0400
In-Reply-To: <CAHu9=sPqfgxO5YbA28pa2jdRwjnvwE22JUNhr0XzwaLurf_gWg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

ping!

Since its been a while. Anyone has any comment on this? Should I go
ahead submit a patch?

--
Thanks,
-Meraj


On Thu, Jul 24, 2014 at 9:35 PM, Mohammad Merajul Islam Molla
<meraj.enigma@gmail.com> wrote:
> Hi
>
> In drivers/cpuidle/cpuidle.c, there are two functions
> cpuidle_install_idle_handler & cpuidle_uninstall_idle_handler.
> The names seem confusing to me as they don't install any handler,
> rather set 'initialized'  variable to 1/0.
>
> In kernel version 3.0, these functions used to look as below where
> they installed and uninstalled some handler function (pm_idle) -
>
> void cpuidle_install_idle_handler(void)
>  {
>         if (enabled_devices && (pm_idle != cpuidle_idle_call)) {
>                  /* Make sure all changes finished before we switch
> to new idle */
>                  smp_wmb();
>                  pm_idle = cpuidle_idle_call;
>           }
>  }
>
> void cpuidle_uninstall_idle_handler(void)
>  {
>          if (enabled_devices && pm_idle_old && (pm_idle != pm_idle_old)) {
>                  pm_idle = pm_idle_old;
>                  cpuidle_kick_cpus();
>          }
>  }
>
> In recent kernel (3.16.0-rc6) , the code for the two mentioned
> functions looks as below -
>
> /**
>  * cpuidle_install_idle_handler - installs the cpuidle idle loop handler
>  */
> void cpuidle_install_idle_handler(void)
> {
>         if (enabled_devices) {
>                 /* Make sure all changes finished before we switch to
> new idle */
>                 smp_wmb();
>                 initialized = 1;
>         }
> }
>
> /**
>  * cpuidle_uninstall_idle_handler - uninstalls the cpuidle idle loop
> handler
>  */
> void cpuidle_uninstall_idle_handler(void)
> {
>         if (enabled_devices) {
>                 initialized = 0;
>                 kick_all_cpus_sync();
>         }
> }
>
> There is no idle handler (pm_idle) installed/uninstalled anymore.
>
> So should these functions be renamed now to something -
> cpuidle_initialize()/cpuidle_uninitialize()?  Also, the comments
> should be removed?
>
>
> --
> Thanks,
> -Meraj
