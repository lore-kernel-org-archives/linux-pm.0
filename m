From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: 3.10-rcX: cpu governor ondemand doesn't scale well after s2ram
Date: Sat, 29 Jun 2013 19:50:11 +0200
Message-ID: <51CF1E53.6060902@gmx.de>
References: <51C08370.4050906@gmx.de> <1778593.ufLkNuJuaY@vostro.rjw.lan> <51CB34A2.7090404@gmx.de> <1475885.FjB577tJj8@vostro.rjw.lan> <CAKohpokbQS8Bb5D2B_UaN-eyVnAbQYKDKh5pm_QzEDMoABwcOw@mail.gmail.com> <51CC7DB2.3020502@gmx.de> <CAKohponp7JbQeeC7D=X7+DBcWtUr2NhRKz7spxKA=+K8SAY+Og@mail.gmail.com> <51CDAAF7.40101@gmx.de> <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpok1gThXL925Yz5UgC54vTVQgymBA1cLGER_g-dgZu0JLA@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The latest bisect attempt gave :

commit a66b2e503fc79fff6632d02ef5a0ee47c1d2553d
Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Date:   Wed May 15 21:47:17 2013 +0200

    cpufreq: Preserve sysfs files across suspend/resume

    The file permissions of cpufreq per-cpu sysfs files are not preserv=
ed
    across suspend/resume because we internally go through the CPU
    Hotplug path which reinitializes the file permissions on CPU online=
=2E

    But the user is not supposed to know that we are using CPU hotplug
    internally within suspend/resume (IOW, the kernel should not silent=
ly
    wreck the user-set file permissions across a suspend cycle).
    Therefore, we need to preserve the file permissions as they are
    across suspend/resume.

    The simplest way to achieve that is to just not touch the sysfs fil=
es
    at all - ie., just ignore the CPU hotplug notifications in the
    suspend/resume path (_FROZEN) in the cpufreq hotplug callback.

    Reported-by: Robert Jarzmik <robert.jarzmik@intel.com>
    Reported-by: Durgadoss R <durgadoss.r@intel.com>
    Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>



To get a more reliable bisect result I had to start BOINC before (4
childs each with nice -19 started)

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
