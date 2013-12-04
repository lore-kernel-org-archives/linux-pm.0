From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Wed, 4 Dec 2013 20:11:01 +0530
Message-ID: <CAKohpomBeJSMc3=BSPbo97nkGbc5MRRvTtJn1z062FN01B51Qw@mail.gmail.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
	<529F04B2.7050303@linaro.org>
	<87fvq8lsxt.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87fvq8lsxt.fsf@nemi.mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F8rn_Mork?= <bjorn@mork.no>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-pm@vger.kernel.org

On 4 December 2013 17:38, Bj=F8rn Mork <bjorn@mork.no> wrote:
> Yes, that patch looks like it fix the problem, and I cannot spot any
> obvious missing cleanups.

Great!!

> But I must say that the whole kobj + free thing makes me feel a bit
> uneasy.  I assume there are good reasons why "cpufreq" isn't just a
> device with a release method?

I didn't get it completely.. How exactly you wanted it to be..

> And I do hope there is something gained by the special suspend handli=
ng,
> because keeping this partial device looks really messy. If it's all j=
ust
> for some file permissions, then there must be better ways?

We didn't found many and so Srivatsa went with this way.. If you have a
better way then we are all for it :)

> Isn't consistent file permissions on device creation really a userspa=
ce issue?

Yes, normally it is.. But suspend/resume or hibernation isn't a userspa=
ce
problem at all. We had a discussion earlier on it and realized that ker=
nel
is screwing it up and so it should get it back. Userspace doesn't have =
to
know how cpufreq removed these directories/files and added them back
on resume.

> Anyway, the patch works so you can add
>
> Tested-by: Bj=F8rn Mork <bjorn@mork.no>

Great. Rafael can take this with a revert of your patch now..

> BTW, a simple way to test these things is cancelling a userspace
> hibernate on an ACPI system.  It will always make the acpi_cpufreq
> driver fail because it attemps to call _PPC inbetween
> acpi_ec_block_transactions and acpi_ec_unblock_transactions.  There i=
s
> no acpi_ec_unblock_transactions_early call in this case.

I did test it on my thinkpad with following hack:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 57c80a7..ebaec3d 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1046,6 +1046,10 @@ static int __cpufreq_add_dev(struct device
*dev, struct subsys_interface *sif,
        /* call driver. From then on the cpufreq must be able
         * to accept all calls to ->verify and ->setpolicy for this CPU
         */
+       if (frozen) {
+               ret =3D -EBUSY;
+               goto err_set_policy_cpu;
+       }
+
        ret =3D cpufreq_driver->init(policy);
        if (ret) {
                pr_debug("initialization failed\n");
