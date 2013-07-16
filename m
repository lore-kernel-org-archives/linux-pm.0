From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 7/8] cpufreq: Preserve policy structure across suspend/resume
Date: Tue, 16 Jul 2013 11:45:16 +0530
Message-ID: <CAKohpo=tfd_CXDBkbE23=UdEF99ZK-17NM_cvpGJ_e9wXGzsZQ@mail.gmail.com>
References: <20130711221419.547.69781.stgit@srivatsabhat.in.ibm.com>
	<20130711221704.547.64296.stgit@srivatsabhat.in.ibm.com>
	<CAKohpom+WcTcefCZitgZQcSjTPsgXsa6VKQF5y6GJA31-rBm0w@mail.gmail.com>
	<51E3C950.90503@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:58755 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751618Ab3GPGPQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 16 Jul 2013 02:15:16 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so349954oag.33
        for <linux-pm@vger.kernel.org>; Mon, 15 Jul 2013 23:15:16 -0700 (PDT)
In-Reply-To: <51E3C950.90503@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: rjw@sisk.pl, toralf.foerster@gmx.de, robert.jarzmik@intel.com, durgadoss.r@intel.com, tianyu.lan@intel.com, lantianyu1986@gmail.com, dirk.brandewie@gmail.com, stern@rowland.harvard.edu, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On 15 July 2013 15:35, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Actually even I was wondering about this while writing the patch and
> I even tested shutdown after multiple suspend/resume cycles, to verify that
> the refcount is messed up. But surprisingly, things worked just fine.
>
> Logically there should've been a refcount mismatch and things should have
> failed, but everything worked fine during my tests. Apart from suspend/resume
> and shutdown tests, I even tried mixing a few regular CPU hotplug operations
> (echo 0/1 to sysfs online files), but nothing stood out.
>
> Sorry, I forgot to document this in the patch. Either the patch is wrong
> or something else is silently fixing this up. Not sure what is the exact
> situation.

To understand it I actually applied your patches to get better view of the code.
(Haven't tested it though).. And found that your code is doing the right thing
and we shouldn't get a mismatch.. This is the sequence of events I can draw:

- __cpu_add_dev() for first cpu. sets the refcount to 'x', where x are
the no. of
cpus in its clock domain.
- _cpu_add_dev() for other cpus: doesn't change anything in refcount

- Suspend:
 - cpu_remove_dev() for all cpus, due to frozen flag we don't touch the value
of count
- Resume:
 - cpu_add_dev() for all cpus, due to frozen flag we don't touch the
value of count.

And so things work as expected. That's why your code isn't breaking anything I
believe.

But can no. of cpus change inbetween suspend/resume? Then count would be
tricky as we are using the same policy structure.
