From: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Subject: Re: Delayed acpi frequency governor call
Date: Tue, 24 Jan 2017 15:49:51 +0100
Message-ID: <2f9b2f69-8b93-c77a-a09f-540240fecf1e@tik.ee.ethz.ch>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
 <20170123101145.GB26681@vireshk-i7>
 <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
 <20170124042235.GA16906@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:55792 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbdAXOt4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Jan 2017 09:49:56 -0500
In-Reply-To: <20170124042235.GA16906@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


> You are using a 4.4 kernel, which used the older delayed work stuff at sampling
> rate. This has all changed a lot and we hooks paired with the scheduler now to
> do this instead. Things have mostly changed since 4.7. Would it be possible for
> you to use a later kernel and see if you still see something wrong?
I switched to the latest stable kernel available, 4.9.5. Judging from 
the first test I ran, using this kernel I cannot
reproduce this behavior anymore. Looks like it has been fixed by the 
changes introduced.
> Now coming back to 4.4, the timers (in the delayed works) can't get delayed but
> the work can as it is just another process.
Can you please describe how things changed from version 4.4 to 4.9 - I'm 
not sure if I understand correctly.
Before 4.7 the governor was just running as a kernel process and 
triggered by the (free running) timers and
now its hooked with the scheduler. So the scheduler ensures that the 
governor work is not delayed?!
> But your setup has no almost load
> and that seems unlikely as well. So, it looks to be a problem at some other
> place. Tracers are your friend, only those can confirm something here.
Thanks for the tip with the tracers. If time allows I will have a look 
into that - I would like to know whats going
on, just out of curiosity.

-- 
--------------------------------------------------------------------
|  Philipp Miedl                                                   |
|  PhD Student @ Computer Engineering and Networks Laboratory      |
|  ETH Zurich, ETZG76, Gloriastrasse 35, 8092 Zurich, Switzerland  |
|  mail: philipp.miedl@ee.tik.ethz.ch      phone: +41 44 632 70 61 |
--------------------------------------------------------------------

