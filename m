From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: Re: [linux-pm] [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Mon, 27 Feb 2012 13:00:16 +0200
Message-ID: <87aa44o81r.fsf@amiettinen-lnx.nvidia.com>
References: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
	<87d39fk2n3.fsf@ti.com> <20120217030453.GA3266@gs62>
	<CAGF5oy9LC4Ve8u6UqG3EbGkWmWYVMthHatJdaRR_ZMO4UQh3CA@mail.gmail.com>
	<87pqd94yeu.fsf@amiettinen-lnx.nvidia.com>
	<CAGF5oy-64J3vMKvzY=NvdV-m8_wFo=NGZANF_cnVm-iq0s-wZQ@mail.gmail.com>
	<20120221145632.GA2840@envy17> <87linw5aod.fsf@ti.com>
	<20120225174449.GA17141@envy17>
	<CAN5iSWq8M4OnMMDYKVZYY=M25jw6ru6ODUNmi3wLmnZ5Vxpdrw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAN5iSWq8M4OnMMDYKVZYY=M25jw6ru6ODUNmi3wLmnZ5Vxpdrw@mail.gmail.com>
	(Jean Pihet-XID's message of "Mon, 27 Feb 2012 11:17:26 +0100")
Sender: cpufreq-owner@vger.kernel.org
To: "Pihet-XID, Jean" <j-pihet@ti.com>
Cc: markgross@thegnar.org, Kevin Hilman <khilman@ti.com>, "Valentin, Eduardo" <eduardo.valentin@ti.com>, len.brown@intel.com, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

"Pihet-XID, Jean" <j-pihet@ti.com> writes:
> Re-adding cpufreq and linux-pm MLs in Cc.
>
> Regards,
> Jean

Thanks Jean. And sorry for causing the lists to get dropped.

Does anyone have comments about the user space interface for per device
constraints:

>>>>>> Another complication for the per device constraints is the user space
>>>>>> interface. Dynamic minors run out pretty fast if we have per CPU
>>>>>> parameters and the system has huge number of CPUs. Does anyone have any
>>>>>> opinions about the user space interface for device PM QoS?

My current view is that CPU frequency constraints could be global just
like the CPU latency constraints are.

	--Antti
