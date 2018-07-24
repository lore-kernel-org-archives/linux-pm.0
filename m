From: Calvin Walton <calvin.walton@kepstin.ca>
Subject: Re: [PATCH 0/2] turbostat: Improve support for AMD Zen CPUs (RAPL,
 CPUID) (Resend)
Date: Tue, 24 Jul 2018 18:12:52 -0400
Message-ID: <2f5c94891ef890b1821e0a83e40cad8a98e4ea3b.camel@kepstin.ca>
References: <20180718222656.11795-1-calvin.walton@kepstin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718222656.11795-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 2018-07-18 at 18:26 -0400, Calvin Walton wrote:
> Based on the documentation provided in AMD's Open-Source
> Register Reference For AMD Family 17h Processors:
> https://support.amd.com/TechDocs/56255_OSRR.pdf
> 
> I've added support for reading Cores and Package energy usage from
> AMD's
> "RAPL" MSRs. In order to correctly detect the AMD processor
> generation,
> I've also had to update the CPUID code to handle AMD's extended
> family
> field.

Having now had the chance to look at recent changes to the turbostat
tool (these patches were based on the version from the 4.17 kernel), it
looks like I'm going to have to update the second patch in this set
because of the changes to handle processor "Nodes".

One thing I'm not sure about is whether the "Package" power reporting
on multi-node AMD systems is reported per node - I suspect it is, but
don't have hardware to confirm. If someone has a processor where this
applies (I'm guessing this is Threadripper and EPYC?) I'd appreciate
seeing the output of

turbostat --Dump --add msr0xc001029b,u32,raw

to know which is the case.

-- 
Calvin Walton <calvin.walton@kepstin.ca>
