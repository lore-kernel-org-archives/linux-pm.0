From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH RFC 0/2] ARM: defining power states DT bindings
Date: Mon,  2 Dec 2013 16:20:03 +0000
Message-ID: <1386001205-11978-1-git-send-email-lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:53726 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752556Ab3LBQUF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Dec 2013 11:20:05 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Dave Martin <dave.martin@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Charles Garcia Tobin <Charles.Garcia-Tobin@arm.com>, Nicolas Pitre <nico@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Grant Likely <grant.likely@linaro.org>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Mark Hambleton <mark.hambleton@broadcom.com>, Hanjun Guo <hanjun.guo@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Amit Kucheria <amit.kucheria@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>

ARM based systems embed power management HW that allows SW to enter
low-power states according to run-time criteria based on parameters (eg
power state entry/exit latency) that define how a power state has to be
managed and its respective properties. ARM partners implement HW power
management schemes through custom HW, with power controllers and relative
control mechanisms differing on both HW implementations and the way SW can
control them. This differentiation forces PM software in the kernel to cope
with states differences in power management drivers, which cause code
fragmentation and duplication of functionality.

Most of the power control scheme HW parameters are not probeable on ARM
platforms from a SW point of view, hence, in order to tackle the drivers
fragmentation problem, this patch series defines device tree bindings to
describe power states parameters on ARM platforms.

Device tree bindings for power states also require the introduction of devi=
ce
tree bindings for processor caches, since power states entry/exit require
SW cache maintainance; in some ARM systems, where firmware does not
support power down interfaces, cache maintainance must be carried out in th=
e
OS power management layer, which then requires a description of the cache
topology through device tree nodes.

The power states on ARM are described as "C-states" in this patchset,
borrowing the nomenclature from ACPI power states bindings which have by no=
w
been widely adopted on both x86 and ARM world as power states names.

C-states device tree standardization shares most of the concepts and
definitions with the ongoing ACPI ARM C-state bindings proposal so that
both standards can contain a coherent set of parameters, simplifying the
way SW will have to handle the respective device drivers.

Lorenzo Pieralisi (2):
  Documentation: arm: add cache DT bindings
  Documentation: arm: define DT C-states bindings

 Documentation/devicetree/bindings/arm/c-states.txt | 830 +++++++++++++++++=
++++
 Documentation/devicetree/bindings/arm/cache.txt    |  25 +
 2 files changed, 855 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/c-states.txt
 create mode 100644 Documentation/devicetree/bindings/arm/cache.txt

--=20
1.8.4


