From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: NOHZ: WARNING: at arch/x86/kernel/smp.c:123 native_smp_send_reschedule,
 round 2
Date: Mon, 20 May 2013 15:10:42 +0530
Message-ID: <CAKohpomjuv6G6Qj2YLv=j=pjASx=6vAaUOzd6gJ-NA2PBhOZAg@mail.gmail.com>
References: <alpine.LNX.2.00.1305091423460.23038@pobox.suse.cz>
	<20130509125040.GF27333@pd.tnic>
	<20130509125859.GG27333@pd.tnic>
	<20130515184528.GO4442@linux.vnet.ibm.com>
	<20130515224358.GF11783@pd.tnic>
	<20130515235512.GT4442@linux.vnet.ibm.com>
	<20130517135641.GF23035@pd.tnic>
	<51999591.8030401@linux.vnet.ibm.com>
	<20130520045023.GA12690@pd.tnic>
	<CAFTL4hwm4Cox=ynVcO-oLG=Jt_1Lro+hbcpEE5hiAYEJGipaLA@mail.gmail.com>
	<5199ED83.5040804@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f47.google.com ([209.85.219.47]:59036 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908Ab3ETJkn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 20 May 2013 05:40:43 -0400
Received: by mail-oa0-f47.google.com with SMTP id m1so7519876oag.34
        for <linux-pm@vger.kernel.org>; Mon, 20 May 2013 02:40:43 -0700 (PDT)
In-Reply-To: <5199ED83.5040804@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Michael Wang <wangyun@linux.vnet.ibm.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Jiri Kosina <jkosina@suse.cz>, Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org, x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM mailing list <linux-pm@vger.kernel.org>, Tejun Heo <tj@kernel.org>

On 20 May 2013 15:01, Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> And Viresh, in the regular hotplug paths, the call to gov_cancel_work() is
> supposed to kill any pending workqueue functions pertaining to offline CPUs
> right?

Yes.. It will cancel work for all cpus first and will start again for
online cpus again.

> Could there be a synchronization bug somewhere due to which this
> might not be happening properly?

Not sure.. I have seen mutex's are used well in cpufreq_governor.. don't know
if I missed something.
