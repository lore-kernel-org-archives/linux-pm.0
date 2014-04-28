From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/5] ARM: dove: create a proper PMU driver for power
 domains, PMU IRQs and resets
Date: Mon, 28 Apr 2014 13:55:40 +0200
Message-ID: <CAPDyKFoboE4iKyom86+EwHHTQAGpgKxGq969yrjQVpqizk-SLA@mail.gmail.com>
References: <20140427132312.GC26756@n2100.arm.linux.org.uk>
	<E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qc0-f182.google.com ([209.85.216.182]:42420 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755598AbaD1Lzk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 28 Apr 2014 07:55:40 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so6773613qcx.27
        for <linux-pm@vger.kernel.org>; Mon, 28 Apr 2014 04:55:40 -0700 (PDT)
In-Reply-To: <E1WeP8f-0000Uo-1q@rmk-PC.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Rob Herring <robh+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>

On 27 April 2014 15:29, Russell King <rmk+kernel@arm.linux.org.uk> wrot=
e:
> The PMU device contains an interrupt controller, power control and
> resets.  The interrupt controller is a little sub-standard in that
> there is no race free way to clear down pending interrupts, so we try
> to avoid problems by reducing the window as much as possible, and
> clearing as infrequently as possible.
>
> The interrupt support is implemented using an IRQ domain, and the
> parent interrupt referenced in the standard DT way.
>
> The power domains and reset support is closely related - there is a
> defined sequence for powering down a domain which is tightly coupled
> with asserting the reset.  Hence, it makes sense to group these two
> together.
>
> This patch adds the core PMU driver: power domains must be defined in
> the DT file in order to make use of them.  The reset controller can
> be referenced in the standard way for reset controllers.

Hi Russell,

This patch would be simplified if this was based upon the not yet
merged patchset from Tomasz Figa, "[PATCH v3 0/3] Generic Device Tree
based power domain look-up".

=46or example you would likely not need to add some of the marvel
specific DT bindings, and you wouldn=E2=80=99t need the bus_notifiers t=
o add
devices to the power domain. I guess I just though it could be useful
input to consider while going forward, unless you already knew.

Kind regards
Ulf Hansson
