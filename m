From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after concurrent
 writing to cpufreq/scaling_governor (Resend)
Date: Fri, 25 Jul 2014 14:33:26 +0530
Message-ID: <CAKohpomDkU1nBP4+1EkSdDxQESD+1b6kmaELVfGEifqTL+ZOdg@mail.gmail.com>
References: <1405522398.2348.42.camel@x200t>
	<1406185912.2406.3.camel@x200t>
	<CAKohpomo_Qoc-ioC-L-n6z19SLMgCfzebec7pqkq9y86gt61HA@mail.gmail.com>
	<1406277769.2399.4.camel@x200t>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oi0-f48.google.com ([209.85.218.48]:42134 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756912AbaGYJD0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Jul 2014 05:03:26 -0400
Received: by mail-oi0-f48.google.com with SMTP id h136so3066727oig.7
        for <linux-pm@vger.kernel.org>; Fri, 25 Jul 2014 02:03:26 -0700 (PDT)
In-Reply-To: <1406277769.2399.4.camel@x200t>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?Q?Robert_Sch=C3=B6ne?= <robert.schoene@tu-dresden.de>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 25 July 2014 14:12, Robert Sch=C3=B6ne <robert.schoene@tu-dresden.de=
> wrote:
> The bug is still there. Here's my bash history, so that you can be su=
re I checked it correctly:
>
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git linux-git
> cd linux-git/
> git show 56d07db
> git branch --contains 19c7630
> git branch --contains 56d07db
> git revert -n 56d07db
> make oldconfig
> make clean
> make -j9 deb-pkg
> cd ..
> sudo dpkg -i linux-libc-dev_3.16.0-rc6+-2_amd64.deb
> sudo dpkg -i linux-image-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
> sudo dpkg -i linux-headers-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
> sudo dpkg -i linux-firmware-image-3.16.0-rc6+_3.16.0-rc6+-2_amd64.deb
> sudo update-grub2
> sudo reboot
>
> Again, I didn't get a backtrace for the error, but only this:

Not sure if you did exactly what I asked for:

Please run this in your repository:

git revert 56d07db

save-quit the editor window and try again..
