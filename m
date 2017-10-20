From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v3 6/7] arm64: topology: Enable ACPI/PPTT based CPU
 topology.
Date: Fri, 20 Oct 2017 10:22:10 +0100
Message-ID: <20171020092210.GB21060@red-moon>
References: <20171012194856.13844-1-jeremy.linton@arm.com>
 <20171012194856.13844-7-jeremy.linton@arm.com>
 <20171019155622.GC18883@red-moon>
 <b6c3fae3-eb6d-e5f2-6887-de1471978897@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b6c3fae3-eb6d-e5f2-6887-de1471978897@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com, gregkh@linuxfoundation.org, viresh.kumar@linaro.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, jhugo@codeaurora.org, wangxiongfeng2@huawei.com, Jonathan.Zhang@cavium.com, ahs3@redhat.com, Jayachandran.Nair@cavium.com, austinwc@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On Thu, Oct 19, 2017 at 11:54:22AM -0500, Jeremy Linton wrote:

[...]

> >>+			cpu_topology[cpu].core_id   = topology_id;
> >>+			topology_id = setup_acpi_cpu_topology(cpu, 2);
> >>+			cpu_topology[cpu].cluster_id = topology_id;
> >>+			topology_id = setup_acpi_cpu_topology(cpu, max_topo);
> >
> >If you want a package id (that's just a package tag to group cores), you
> >should not use a large level because you know how setup_acpi_cpu_topology()works, you should add an API that allows you to retrieve the package id
> >(so that you can use th ACPI_PPTT_PHYSICAL_PACKAGE flag consistenly,
> >whatever it represents).
> 
> I don't think the spec requires the use of PHYSICAL_PACKAGE... Am I
> misreading it? Which means we need to "pick" a node level to
> represent the physical package if one doesn't exist...

The specs define a means to detect if a given PPTT node corresponds to a
package (I am refraining from stating again that to me that's not clean
cut what a package is _architecturally_, I think you know my POV by now)
and that's what you need to use to retrieve a packageid for a given cpu,
if I understand the aim of the physical package flag.

Either that or that flag is completely useless.

Lorenzo

ACPI 6.2 - Table 5-151 (page 248)
Physical package
-----------------
Set to 1 if this node of the processor topology represents the boundary
of a physical package, whether socketed or surface mounted.  Set to 0 if
this instance of the processor topology does not represent the boundary
of a physical package.
