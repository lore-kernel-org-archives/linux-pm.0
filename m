From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: fix current freq check on policy update
Date: Fri, 14 Feb 2014 14:58:43 +0100
Message-ID: <1799893.BgHaHWcxf3@vostro.rjw.lan>
References: <20140214072623.3dd67851@mjolnir.ossman.eu> <52FE01A2.9030905@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:49552 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752025AbaBNNoA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 14 Feb 2014 08:44:00 -0500
In-Reply-To: <52FE01A2.9030905@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Cc: Pierre Ossman <pierre-list@ossman.eu>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM mailing list <linux-pm@vger.kernel.org>

On Friday, February 14, 2014 05:14:34 PM Srivatsa S. Bhat wrote:
> On 02/14/2014 11:56 AM, Pierre Ossman wrote:
> > From de497de3fcd81e8340498cd0b34b3388fe75cc19 Mon Sep 17 00:00:00 2001
> > From: Pierre Ossman <pierre@ossman.eu>
> > Date: Fri, 14 Feb 2014 07:17:02 +0100
> > Subject: [PATCH] cpufreq: fix current freq check on policy update
> > 
> > There was some variable confusion in cpufreq_update_policy()
> > when we tried to get a current reading of the CPU frequency.
> > If it failed to get the frequency, a current frequency of
> > 0 kHz would be stored which in turn screwed up other parts
> > of the kernel.
> > 
> 
> You know what's interesting? I went through the powernow-k8 cpufreq
> driver code (based on your system data in the bugzilla), and found
> that (if I read it correctly), ->get() can simply never return 0 !
> 
> .get is mapped to powernowk8_get
> 
> powernowk8_get() in turn calls smp_call_function_single() on that cpu
> and fetches the data into data->currfid.
> 
> Then we have this statement:
> 	khz = find_khz_freq_from_fid(data->currfid);
> 
> which is:
> 
>   66 /* Return a frequency in MHz, given an input fid */
>   67 static u32 find_freq_from_fid(u32 fid)
>   68 {
>   69         return 800 + (fid * 100);
>   70 }
>   71 
>   72 /* Return a frequency in KHz, given an input fid */
>   73 static u32 find_khz_freq_from_fid(u32 fid)
>   74 {
>   75         return 1000 * find_freq_from_fid(fid);
>   76 }
> 
> 
> So with that, I don't see how the KHz value can turn out to be zero!

Due to a race condition of some sort?

Rafael

