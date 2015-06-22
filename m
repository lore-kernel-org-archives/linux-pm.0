From: Michael Turquette <mturquette@linaro.org>
Subject: Re: [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
Date: Mon, 22 Jun 2015 13:46:17 -0700
Message-ID: <20150622204617.9112.71054@quantum>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdXntR6c4-uUNGVGx7D7941e8hvnmtVBvDu2+iUsNHQ=Qw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34387 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932072AbbFVUqc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 16:46:32 -0400
Received: by pdbki1 with SMTP id ki1so145969290pdb.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 13:46:31 -0700 (PDT)
In-Reply-To: <CAMuHMdXntR6c4-uUNGVGx7D7941e8hvnmtVBvDu2+iUsNHQ=Qw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Magnus Damm <magnus.damm@gmail.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-clk@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Quoting Geert Uytterhoeven (2015-06-15 09:15:04)
> On Thu, May 28, 2015 at 8:53 PM, Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> >         Hi all,
> >
> > This patch series adds Clock Domain support to the Clock Pulse Generator
> > (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
> > be used on shmobile SoCs without device power domains (R-Car Gen1 and
> > Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
> > that are part of the CPG Clock Domain using Runtime PM, or for system
> > suspend/resume, similar to SoCs with device power domains (SH-Mobile and
> > R-Mobile).
> >
> > SoC devices that are part of the CPG Clock Domain and can be
> > power-managed through an MSTP clock are tagged in DT with a proper
> > "power-domains" property. This applies to most on-SoC devices, which
> > have a one-to-one mapping from SoC device to DT device node.
> > Notable exceptions are "display" and "sound" device nodes, which
> > represent multiple SoC devices, each having their own MSTP clocks. Hence
> > drivers for such devices still have to manage their (multiple module)
> > clocks themselves.
> >
> > The (MSTP) clock to use for power-management is found by scanning for
> > clocks that are compatible with "renesas,cpg-mstp-clocks".
> > Before, the "first" clock tied to each device (con_id NULL) was used,
> > being a bit ad-hoc. It was suggested to use the "fck" clock instead,
> > but this may conflict with DT bindings for devices we don't control
> > (e.g. GIC-400 plans to mandate "clk" for the clk-name of its single
> > clock). Looking for real MSTP clocks avoids this problem.
> >
> > Logically, the CPG Clock Domain operates on the SoC CPG/MSTP block.
> > As there's no single device node in DT representing this block (there
> > are separate device nodes for the CPG and for the individual MSTP
> > clocks), I bound the logic to the CPG device node.
> > Perhaps this is something we should change for future SoCs?
> 

Hello Geert,

I'm still going through this series but I have a few comments/questions.

> Inside Renesas, we've been discussing this face-to-face, but haven't
> reached a conclusion yet.
> 
> In Linux terminology, "PM domain" is a higher-level abstraction than
> just (hardware) "power domain" (sometimes called "power area").
> A "PM domain" is any collection of devices that are power-managed
> similarly. As such it covers not only hardware power domains, but also
> clock domains, and even firmware controlled devices (e.g. as used by the
> Linux ACPI subsystem).
> 
> I find it a bit unfortunate this was not reflected in the DT bindings
> for Generic PM domains, which use "power-domains" properties, making
> believe people this is about hardware power domains only.

"Power island" is used commonly to describe the hardware power domain.
I like that one since it conveys the concept of power isolation/clamping
in a power distribution network.  It might be more clear to refer to the
hardware as power islands and reserve "power domains" for the Linux
construct?

> 
> One other point of confusion is that there are multiple kernel
> subsystems that can (or seem to be able to) be used for the same
> purpose. Both regulators and power domains are used to "control power".
> The same is true for clocks vs. clock domains.
> My point of view is that the regulator and clock subsystems are more
> about the properties of regulators (voltage, current) resp. clocks
> (frequencies), while power/clock domains are about being active or
> inactive.

Only speaking for the clock framework, but the prepare/unprepare and
enable/disable semantics are very important here, not just the
rate-change stuff.

> 
> On Renesas SoCs (SH/R-Mobile, R-Car, RZ), the MSTP (Module Standby and
> Software Reset) block is very intimately tied to the CPG (Clock Pulse
> Generator) block.
> 
> The MSTP block provides two functions:
>   1. Module Standby: "Clock supply to specified modules is stopped by
>      setting the module stop control register bits."
>      However, the clock supply to a module is not stopped until all CPUs
>      in the SoC agree.  Indeed, there are separate MSTP registers for
>      application (Cortex-A) and real-time (SH and/or Cortex-R) cores.
>   2. Reset control. to perform a software reset of a specific module.
> 
> Given the second function, perhaps the MSTP bits shouldn't have been
> moduled as clocks, but it made sense at the time of introduction, and
> IMHO it still does.

Does the clk.enable_count refcount for an MSTP "clock" mirror your
statement, "the clock supply to a module is not stopped until all CPUs
in the SoC agree"? Put another way, is it possble in a shmobile system
for an MSTP "clock" to have an enable_count of zero, but still by
physically enabled in hardware?

Regards,
Mike
--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
