From: Jon Masters <jcm@redhat.com>
Subject: Re: [PATCH v3 0/7] Support PPTT for ARM64
Date: Tue, 31 Oct 2017 08:46:54 -0400
Message-ID: <82688148-de6c-8538-dec8-51c94dc4f068@redhat.com>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20171012194856.13844-1-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 10/12/2017 03:48 PM, Jeremy Linton wrote:

> ACPI 6.2 adds the Processor Properties Topology Table (PPTT), which is
> used to describe the processor and cache topology. Ideally it is
> used to extend/override information provided by the hardware, but
> right now ARM64 is entirely dependent on firmware provided tables.
> 
> This patch parses the table for the cache topology and CPU topology.
> For the latter we also add an additional topology_cod_id() macro,
> and a package_id for arm64. Initially the physical id will match
> the cluster id, but we update users of the cluster to utilize
> the new macro. When we enable ACPI/PPTT for arm64 we map the socket
> to the physical id as the remainder of the kernel expects.

Just wanted to thank you for doing this Jeremy. As you know, we're
tracking these patches and working with multiple vendors to ensure that
firmware has accurate PPTTs populated to match. We're expecting to pull
these patches and replace our current RHEL-only kludge asap. RHEL
currently has to kludge topology based upon magic "known" meanings of
the MPIDRs on various server platforms. It's (known to be) ugly and is
one of the reasons that we pushed for what became PPTT.

Beyond scheduler efficiency, in general, it's very important that Arm
systems can correctly report x86 style topology industry conventions -
especially sockets - since (and I told Arm this years ago, and other
non-Linux vendors backed me up) it's typical on server platforms to use
either "memory" or "number of sockets" when making licensing and
subscription calculations in various tooling. This became a problem
early on even with X-Gene1 and Seattle showing as 8 socket boxes ;)

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop

