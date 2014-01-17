From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [RFC/RFT][PATCH 0/5] PM / QoS: Introduce latency tolerance device PM QoS type
Date: Fri, 17 Jan 2014 15:42:13 +0100
Message-ID: <5434847.aCyiWHNRe7@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

On some platforms hardware may switch to an energy-saving mode on the fly
on the basis of certain utilization metrics used by it.  That usually is
desirable from the energy conservation standpoint, but it generally causes
latencies to increase which may adversely affect some operations.  For this
reason, the platforms in question usually provide some interfaces for software
to indicate its latency tolerance and possibly to prevent the energy-saving
modes from being selected too aggressively.

The following series of patches introduces a device PM QoS type allowing
those interfaces to be used by kernel code and user space.  It is designed
in analogy with the existing resume latency device PM QoS type, which allows
some pieces of the existing device PM QoS code to be re-used and makes the
new user space interface fit into the existing framework.

Patch [1/5] modifies the names of symbols, variables, functions and structure
fields associated with the existing resume latency device PM QoS type to
avoid any confusion with the new one introduced by the subsequent patches.

Patch [2/5] introduces a new field in struct pm_qos_constraints for specifying
a special value to be returned as the effective requirement when the given list
of PM QoS requirements is empty.  That field is necessary for the new latency
tolerance device PM QoS type.

Patch [3/5] introduces the latency tolerance device PM QoS type along with
documentation.

Patch [4/5] modifies the ACPI LPSS (Low-Power Subsystem) driver to hook up
LPSS devices to the new latency tolerance device PM QoS interface.

Patch [5/5] modifies the dev_pm_qos_add_ancestor_request() routine so that it
can be used by drivers of devices without hardware latency tolerance support
for specifying their requirements via the ancestors of those devies.

Comments welcome!

Thanks,
Rafael

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
