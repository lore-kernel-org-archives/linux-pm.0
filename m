From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH v2 00/14] ARM: shmobile: Add CPG Clock Domains
Date: Mon, 15 Jun 2015 18:15:04 +0200
Message-ID: <CAMuHMdXntR6c4-uUNGVGx7D7941e8hvnmtVBvDu2+iUsNHQ=Qw@mail.gmail.com>
References: <1432839219-475-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1432839219-475-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux PM list <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 28, 2015 at 8:53 PM, Geert Uytterhoeven
<geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org> wrote:
>         Hi all,
>
> This patch series adds Clock Domain support to the Clock Pulse Generator
> (CPG) Module Stop (MSTP) Clocks driver using the generic PM Domain, to
> be used on shmobile SoCs without device power domains (R-Car Gen1 and
> Gen2, RZ).  This allows to power-manage the module clocks of SoC devices
> that are part of the CPG Clock Domain using Runtime PM, or for system
> suspend/resume, similar to SoCs with device power domains (SH-Mobile and
> R-Mobile).
>
> SoC devices that are part of the CPG Clock Domain and can be
> power-managed through an MSTP clock are tagged in DT with a proper
> "power-domains" property. This applies to most on-SoC devices, which
> have a one-to-one mapping from SoC device to DT device node.
> Notable exceptions are "display" and "sound" device nodes, which
> represent multiple SoC devices, each having their own MSTP clocks. Hence
> drivers for such devices still have to manage their (multiple module)
> clocks themselves.
>
> The (MSTP) clock to use for power-management is found by scanning for
> clocks that are compatible with "renesas,cpg-mstp-clocks".
> Before, the "first" clock tied to each device (con_id NULL) was used,
> being a bit ad-hoc. It was suggested to use the "fck" clock instead,
> but this may conflict with DT bindings for devices we don't control
> (e.g. GIC-400 plans to mandate "clk" for the clk-name of its single
> clock). Looking for real MSTP clocks avoids this problem.
>
> Logically, the CPG Clock Domain operates on the SoC CPG/MSTP block.
> As there's no single device node in DT representing this block (there
> are separate device nodes for the CPG and for the individual MSTP
> clocks), I bound the logic to the CPG device node.
> Perhaps this is something we should change for future SoCs?

Inside Renesas, we've been discussing this face-to-face, but haven't
reached a conclusion yet.

In Linux terminology, "PM domain" is a higher-level abstraction than
just (hardware) "power domain" (sometimes called "power area").
A "PM domain" is any collection of devices that are power-managed
similarly. As such it covers not only hardware power domains, but also
clock domains, and even firmware controlled devices (e.g. as used by the
Linux ACPI subsystem).

I find it a bit unfortunate this was not reflected in the DT bindings
for Generic PM domains, which use "power-domains" properties, making
believe people this is about hardware power domains only.

One other point of confusion is that there are multiple kernel
subsystems that can (or seem to be able to) be used for the same
purpose. Both regulators and power domains are used to "control power".
The same is true for clocks vs. clock domains.
My point of view is that the regulator and clock subsystems are more
about the properties of regulators (voltage, current) resp. clocks
(frequencies), while power/clock domains are about being active or
inactive.

On Renesas SoCs (SH/R-Mobile, R-Car, RZ), the MSTP (Module Standby and
Software Reset) block is very intimately tied to the CPG (Clock Pulse
Generator) block.

The MSTP block provides two functions:
  1. Module Standby: "Clock supply to specified modules is stopped by
     setting the module stop control register bits."
     However, the clock supply to a module is not stopped until all CPUs
     in the SoC agree.  Indeed, there are separate MSTP registers for
     application (Cortex-A) and real-time (SH and/or Cortex-R) cores.
  2. Reset control. to perform a software reset of a specific module.

Given the second function, perhaps the MSTP bits shouldn't have been
moduled as clocks, but it made sense at the time of introduction, and
IMHO it still does.

However, due to the module standby function, all connected devices are
grouped into a collection of devices that are power-managed similarly,
by controlling the clock supply to the individual modules. So this
warrants the use of a PM domain.

Alternative solutions that have been proposed are:

  1. | Explicit opt-in in drivers (from Laurent)
     | As the driver knows best which clock it wants to manage, the
     | driver could tell runtime PM if/when which clock to use.

     My rebuttal here is twofold:
       - Does the driver know best? It may know it may need to enable a
         clock. But the clock may be optional: on some SoCs, the same IP
         core may be present without the Module Standby feature (e.g.
         the GPIO blocks on R-Car Gen1 are not documented to have MSTP
         bits, while they do on R-Car Gen2). Why would the driver have
         to care?

         The hardware documentation clearly states the purpose of the
         MSTP clocks: when a module is not in use, its module clock can
         be stopped to reduce power consumption.  All of this should be
         described in DT. We already have the clocks in DT. If a module
         has an MSTP clock, it means the module can be put in standby
         mode. This is the same for all modules, hence for all drivers.

       - The idea is to reduce the amount of boilerplate code, not to
         increase it. The more code we can move into platform code, the
         less drivers have to care.

         This is the real power behind the abstraction of runtime PM.
         The driver only has to tell runtime PM when it wants to "use"
         the hardware module, using pm_runtime_{get_sync,put}().
         It doesn't have to know this involves enabling clocks and/or
         power domains, or parent devices. All of this is taken care of
         by a small piece of platform code, and the generic code.
         As not all drivers are runtime PM-aware yet, calls to
         pm_runtime_*() functions may have to be added, though. But
         that's it.

     Side note: Laurent has been mostly involved with multimedia devices.
     And let display and sound be the two exceptions where there's no
     one-to-one mapping from SoC devices to DT device nodes...
     Hence the multimedia drivers would have to manage the (multiple)
     module clocks anyway.

     Perhaps the display and sound bindings can be reworked, to better
     describe the hardware structure, and expose a one-to-one mapping
     between MSTP clocks and hardware modules, too?

  2. | Handling MSTP clocks automatically in a similar way that the current
     | code handles the first clock, without requiring usage of a
     | power-domain property in DT (from Magnus)
     | As there are already "clocks = <...>" links from device nodes to MSTP
     | clocks in DT, we can just scan for those, without requiring
     | (superfluous) "power-domains = <...>" properties in DT.

     Indeed, given the presence of a link to an MSTP clock in a device
     node, we know the module can be put in standby mode.
     But without the standard "power-domains" property, we would need
     our own specialized code to scan all nodes for MSTP clocks (through
     a platform_bus notifier again?), and add the corresponding devices
     to the clock domain.  Hence the "power-domains" properties allow to
     use the generic code, and thus share more code with other SoCs.
     In addition, a "power-domains" property gives a strong clue to
     people not familiar with Renesas SoCs and their MSTP clocks.

Thanks for your comments/suggestions/supports/flames/...!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
