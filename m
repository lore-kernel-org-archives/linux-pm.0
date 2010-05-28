From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 8/8] intel_idle: create a native cpuidle
 driver for select intel processors
Date: Thu, 27 May 2010 23:57:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1005272354100.24823__38497.9932489388$1275019118$gmane$org@localhost.localdomain>
References: <1274928151-30919-1-git-send-email-lenb@kernel.org>
	<198450ec1600d9a7f55270dd4d44d6b55bc5b184.1274926772.git.len.brown@intel.com>
	<20100526204426.fd2be7e0.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20100526204426.fd2be7e0.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


> ... What happens when an additional CPU is brought online? 
> It melts?  ;)

With the current driver, processors hot-added after modprobe
will use C1 only, and not use deeper C-states.

Taking online processors offline and bringing them back online
(like we do during suspend) works fine.

> > +		dev->cpu = i;
> > +		if (cpuidle_register_device(dev)) {
> > +			pr_debug(PREFIX "cpuidle_register_device %d failed!\n", i);
> > +			free_percpu(intel_idle_cpuidle_devices);
> > +			return -EIO;
> 
> Should this unregister all the thus-far-registered devices?

yes, that was a bug!

thanks,
Len Brown, Intel Open Source Technology Center
