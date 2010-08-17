From: Bryan Huntsman <bryanh@codeaurora.org>
Subject: Re: [linux-pm] Notes from the Boston Linux Power	Management	Mini-summit
 - August 9th, 2010
Date: Mon, 16 Aug 2010 18:09:17 -0700
Message-ID: <4C69E13D.3020809@codeaurora.org>
References: <alpine.LFD.2.00.1008150134180.7641@localhost.localdomain> <20100816144914.GB10354@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100816144914.GB10354@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Len Brown <lenb@kernel.org>, Linux Power Management List <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Mark Brown wrote:
> On Sun, Aug 15, 2010 at 01:36:33AM -0400, Len Brown wrote:
> 
>> A gap:
>>
>> On OMAP, bus control is independent of CPU frequency control,
>> so cpufreq and cpuidle don't quite fit the bill.
>>
>> Perhaps a "bus-idle" analogous to "cpu-idle" may be appropriate?
> 
> FWIW this applies to a bunch of other embedded processors too - OMAP
> isn't particularly unique here, though it's one of the furthest along in
> terms of exploting this in mainline Linux.

This capability would benefit MSM as well.  We're looking into a 
soc-specific implementation using Pat Pannuto's "pseudo" platform bus 
extensions (discussed here http://lkml.org/lkml/2010/8/10/389).  After 
we have something working, I would be curious to see if some common 
functionality could be extracted into a more generic mechanism.

- Bryan

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
