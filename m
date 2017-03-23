From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] cpuidle: Validate cpu_dev in cpuidle_add_sysfs
Date: Thu, 23 Mar 2017 21:10:01 +0530
Message-ID: <20170323154001.GA9058@drishya.in.ibm.com>
References: <20170323152247.14733-1-svaidy@linux.vnet.ibm.com>
 <20170323152247.14733-3-svaidy@linux.vnet.ibm.com>
 <CAJZ5v0hkgKEqMy0N9V21zt2fseoAoriLKYP4GaMJ40q+B9BtvA@mail.gmail.com>
Reply-To: svaidy@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57424 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751619AbdCWPkS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 11:40:18 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2NFctGl114150
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 11:40:17 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29c0uhg9sg-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 11:40:16 -0400
Received: from localhost
        by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
        Thu, 23 Mar 2017 21:10:13 +0530
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hkgKEqMy0N9V21zt2fseoAoriLKYP4GaMJ40q+B9BtvA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>

* Rafael J. Wysocki <rafael@kernel.org> [2017-03-23 16:27:31]:

> On Thu, Mar 23, 2017 at 4:22 PM, Vaidyanathan Srinivasan
> <svaidy@linux.vnet.ibm.com> wrote:
> > If a given cpu is not in cpu_present and cpu hotplug
> > is disabled, arch can skip setting up the cpu_dev.
> >
> > Arch cpuidle driver should pass correct cpu mask
> > for registration, but failing to do so by the driver
> > causes error to propagate and crash like this:
> >
> > [   30.076045] Unable to handle kernel paging request for
> >                                 data at address 0x00000048
> > [   30.076100] Faulting instruction address: 0xc0000000007b2f30
> > cpu 0x4d: Vector: 300 (Data Access) at [c000003feb18b670]
> >     pc: c0000000007b2f30: kobject_get+0x20/0x70
> >     lr: c0000000007b3c94: kobject_add_internal+0x54/0x3f0
> >     sp: c000003feb18b8f0
> >    msr: 9000000000009033
> >    dar: 48
> >  dsisr: 40000000
> >   current = 0xc000003fd2ed8300
> >   paca    = 0xc00000000fbab500   softe: 0        irq_happened: 0x01
> >     pid   = 1, comm = swapper/0
> > Linux version 4.11.0-rc2-svaidy+ (sv@sagarika) (gcc version 6.2.0
> > 20161005 (Ubuntu 6.2.0-5ubuntu12) ) #10 SMP Sun Mar 19 00:08:09 IST 2017
> > enter ? for help
> > [c000003feb18b960] c0000000007b3c94 kobject_add_internal+0x54/0x3f0
> > [c000003feb18b9f0] c0000000007b43a4 kobject_init_and_add+0x64/0xa0
> > [c000003feb18ba70] c000000000e284f4 cpuidle_add_sysfs+0xb4/0x130
> > [c000003feb18baf0] c000000000e26038 cpuidle_register_device+0x118/0x1c0
> > [c000003feb18bb30] c000000000e26c48 cpuidle_register+0x78/0x120
> > [c000003feb18bbc0] c00000000168fd9c powernv_processor_idle_init+0x110/0x1c4
> > [c000003feb18bc40] c00000000000cff8 do_one_initcall+0x68/0x1d0
> > [c000003feb18bd00] c0000000016242f4 kernel_init_freeable+0x280/0x360
> > [c000003feb18bdc0] c00000000000d864 kernel_init+0x24/0x160
> > [c000003feb18be30] c00000000000b4e8 ret_from_kernel_thread+0x5c/0x74
> >
> > Validating cpu_dev fixes the crash and reports correct error message like:
> >
> > [   30.163506] Failed to register cpuidle device for cpu136
> > [   30.173329] Registration of powernv driver failed.
> >
> > Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> 
> The previous version is in linux-next already and I'm going to push it
> for merging shortly.

Thanks Rafael.  The previous version is good for merge.

--Vaidy
