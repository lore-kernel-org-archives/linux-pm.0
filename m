From: Kevin Hilman <khilman@ti.com>
Subject: Re: [linux-pm] [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Wed, 15 Feb 2012 17:06:40 -0800
Message-ID: <87d39fk2n3.fsf@ti.com>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com> (Antti
	P. Miettinen's message of "Thu, 19 Jan 2012 14:35:57 +0200")
Sender: cpufreq-owner@vger.kernel.org
To: Antti P Miettinen <amiettinen@nvidia.com>
Cc: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello,

Antti P Miettinen <amiettinen@nvidia.com> writes:

> This is a continuation to "RFC: CPU frequency min as PM QoS param"
> patchset. This patchset adds CPU frequency maximum as a PM QoS
> parameter and modifies CPU frequncy core to enforce the limit. CPU
> frequency ceiling can be used to improve the energy efficiency of
> workloads that would cause the cpufreq governors to enforce an
> unnecessarily high operating point. In other words, CPU frequency
> maximum can act as an energy efficiency level request.
>
> Tested on Dell E6420 with the ACPI cpufreq driver against Ubuntu
> 3.2. Patches are against linux-next, compile tested.

I know there were some earlier discussions about the usefulness of a max
frequency QoS parameter, so I wanted to throw in a reason to include max
as well as min frequency parameters.

IMO, having a max frequency QoS parameter would be very useful from a
thermal perspective.  

There are some ongoing projects in the PM working group at Linaro that
are exploring plugins to the thermal framework that implment a "cooling
device" by capping CPU frequency.  Having a QoS parameter do do this
would be the logical interface.

I also agree with some earlier requests that these should probably be
per-CPU instead of global.  That would make it simple to cap frequency
of one cluster while leaving another alone.

Kevin
