From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: 3.10.1 cpufreq suspend/resume regression still present in 3.10.2
Date: Mon, 22 Jul 2013 20:52:21 +0530
Message-ID: <51ED4E2D.5020908@linux.vnet.ibm.com>
References: <20130722151653.GA7213@sacarino.pirispons.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130722151653.GA7213@sacarino.pirispons.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Kiko Piris <kernel@pirispons.net>, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 07/22/2013 08:46 PM, Kiko Piris wrote:
> Hi,
>=20
> linux-3.10.1 introduced a regression in cpufreq breaking suspend/resu=
me
> cycle for some people [1].
>=20
> There were also some other threads about it in lkml.
>=20
> I see 3.10.2-stable was released some days ago. I couldn=E2=80=99t se=
e anything
> about fixing this regression reported in the changelog.
>=20
> And to be 110% certain, I compiled it and tried suspending/resuming;
> it=E2=80=99s still broken.
>=20
> Is this going to be fixed in 3.10 stable branch?
>=20

The patches that fix that regression went into mainline just a few days
ago as these commits:=20

commit aae760ed21cd690fe8a6db9f3a177ad55d7e12ab
Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Date:   Fri Jul 12 03:45:37 2013 +0530

    cpufreq: Revert commit a66b2e to fix suspend/resume regression


commit e8d05276f236ee6435e78411f62be9714e0b9377
Author: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
Date:   Tue Jul 16 22:46:48 2013 +0200

    cpufreq: Revert commit 2f7021a8 to fix CPU hotplug regression


And both of them have been CC'ed to -stable. So they should be hitting
the stable tree soon.

Hmm, that reminds me.. whenever a patch cc'ed to stable hit the mainlin=
e,
the patch signers used to receive an automatic email from Greg. I didn'=
t
get that for the above two patches.. Did the process change due to the
recent discussions around -stable tree maintenance?


Regards,
Srivatsa S. Bhat
