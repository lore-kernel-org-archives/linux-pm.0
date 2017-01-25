From: Philipp Miedl <philipp.miedl@tik.ee.ethz.ch>
Subject: Re: Delayed acpi frequency governor call
Date: Wed, 25 Jan 2017 10:48:40 +0100
Message-ID: <47c8a3d0-c871-c211-f951-2b6607310cff@tik.ee.ethz.ch>
References: <c8ee7078-ad5a-0a23-66ae-620c507300e5@tik.ee.ethz.ch>
 <20170120100725.GO11478@vireshk-i7>
 <9b332b49-11a1-a5fc-d48e-2c113cdca202@tik.ee.ethz.ch>
 <20170123101145.GB26681@vireshk-i7>
 <086bc55f-d1cc-b893-49c6-1667f6067f1b@tik.ee.ethz.ch>
 <20170124042235.GA16906@vireshk-i7>
 <2f9b2f69-8b93-c77a-a09f-540240fecf1e@tik.ee.ethz.ch>
 <20170125032341.GC20040@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from virgo01.ee.ethz.ch ([129.132.2.226]:41021 "EHLO
        virgo01.ee.ethz.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbdAYJso (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 25 Jan 2017 04:48:44 -0500
In-Reply-To: <20170125032341.GC20040@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: alex@digriz.org.uk, jun.nakajima@intel.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>


On 25.01.2017 04:23, Viresh Kumar wrote:
> On 24-01-17, 15:49, Philipp Miedl wrote:
>> Can you please describe how things changed from version 4.4 to 4.9 - I'm not
>> sure if I understand correctly.
>> Before 4.7 the governor was just running as a kernel process and triggered
>> by the (free running) timers and
>> now its hooked with the scheduler. So the scheduler ensures that the
>> governor work is not delayed?!
> Now the cpufreq callbacks gets called from within the scheduler every few
> milliseconds. And once we have crossed the sampling-rate time, we reevaluate the
> frequency. Though ondemand/conservative governors still used workqueue until
> very recently for most of the platforms. Recently it is replaced by a RT thread.
>

Ok got it now. Thanks a lot for your help!

-- 
--------------------------------------------------------------------
|  Philipp Miedl                                                   |
|  PhD Student @ Computer Engineering and Networks Laboratory      |
|  ETH Zurich, ETZG76, Gloriastrasse 35, 8092 Zurich, Switzerland  |
|  mail: philipp.miedl@ee.tik.ethz.ch      phone: +41 44 632 70 61 |
--------------------------------------------------------------------

