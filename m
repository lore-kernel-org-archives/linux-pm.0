From: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH v8 3/6] cpufreq: powernv: Remove cpu_to_chip_id() from
 hot-path
Date: Sat, 19 Mar 2016 10:20:21 +1100
Message-ID: <1458343221.6622.88.camel@neuling.org>
References: <1454442102-1229-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <1454442102-1229-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
	 <1458273857.6622.75.camel@neuling.org>
	 <1458340635.3107.89.camel@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:52897 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751822AbcCRXUX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 18 Mar 2016 19:20:23 -0400
In-Reply-To: <1458340635.3107.89.camel@au1.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: benh@au1.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: ego@linux.vnet.ibm.com, linux-pm@vger.kernel.org, shreyas@linux.vnet.ibm.com, rjw@rjwysocki.net, pc@us.ibm.com, viresh.kumar@linaro.org, anton@samba.org

On Sat, 2016-03-19 at 09:37 +1100, Benjamin Herrenschmidt wrote:
> On Fri, 2016-03-18 at 15:04 +1100, Michael Neuling wrote:
> > 
> >  static int nr_chips;
> > +static DEFINE_PER_CPU(unsigned int, chip_id);
> >  
> >  /*
> >   * Note: The set of pstates consists of contiguous integers, the
> > @@ -317,9 +318,7 @@ static void powernv_cpufreq_throttle_check(void
> > *data)
> >  
> >         pmsr = get_pmspr(SPRN_PMSR);
> >  
> > -       for (i = 0; i < nr_chips; i++)
> > -               if (chips[i].id == cpu_to_chip_id(cpu))
> > -                       break;
> > +       i = this_cpu_read(chip_id);
> 
> Except it's not a chip_id, so your patch confused me for a good 2mn
> ...
> Call it chip_idx maybe ? ie, index.

Yeah, it was a badly named variable but I changed it even more and
Shilpasri rebased it here:

http://patchwork.ozlabs.org/patch/599523/

Mikey
