From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH/RFC v6 0/7] PM / Domains: DT power-on/off and QoS device latencies
Date: Wed, 13 May 2015 10:44:48 +0200
Message-ID: <CAPDyKFqGEuzqb7NC-OJzHYeAuEfaGukgn=in-tbC+Oz8Uo4vgA@mail.gmail.com>
References: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1430138622-14029-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Axel Haslam <ahaslam@baylibre.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 27 April 2015 at 14:43, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>         Hi all,
>
> This patch series is an RFC to add (1) PM Domain power-on/off latencies
> and (2) QoS device latencies to DT.
>
> To provide a good quality of service, the PM subsystem suspends PM
> Domains and devices only if this doesn't break QoS constraints.  While
> the PM subsystem performs measurements of the various latencies
> involved, and adapts automatically according to these measurements, it's
> still beneficial to provide initial values for these latencies.
> Currently these initial values, which are properties of the hardware,
> can only be specified from C code. This RFC adds DT support for
> specifying them.
>
> All of these patches have been sent before (change logs are available in
> the individual patches). I'm resending them upon request from Kevin
> Hilman, and synced them all to the same version number (v6).
>
>   - Patch 1 adds DT bindings for PM Domain power-on/off latencies,
>   - Patches 2 and 3 update the DT bindings and support code for the
>     Renesas R-Mobile system controller, providing a sample
>     implementation,
>   - Patch 4 adds DT bindings for QoS device latencies,
>   - Patches 5 and 6 implement retrieving the QoS device latencies in the
>     genpd code,
>   - Patch 7 updates the DT bindings for the Renesas R-Mobile system
>     controller, adding an example.
>
> Compared to previous submissions, I've left out the (preliminary)
> patches adding the actual latency values to the .dtsi files, as they
> just used a single default value taken from the legacy code[*].
>
> In the mean time, support for PM Domains with multiple states has been
> proposed, cfr. "[RFC v5 0/8]  genpd multiple states v5"
> (http://marc.info/?l=linux-pm&m=142989694214237&w=2).
> If this is accepted, I think we have to rethink how to specify PM Domain
> latencies (and be happy we didn't have the DT part cast in stone yet
> ;-), as they won't be limited to power-on/off latencies anymore.

In regard to the above, how about posting patch 4 and onwards separately?

Then we can come back to patch 1 -> 3, once the above patchset has
been thoroughly discussed.

>
> Perhaps we should switch to a mechanism similar to what's used for idle
> states (cfr. Documentation/devicetree/bindings/arm/idle-states.txt)?
> I.e. a single "idle-states" node, with subnodes for each state, being
> pointed to by phandles in the actual PM domain provider nodes.

Seems reasonable.

Kind regards
Uffe
