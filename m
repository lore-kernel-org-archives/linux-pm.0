From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 0/5] firmware: Add support for TI System Control
 Interface (TI-SCI) protocol driver
Date: Thu, 8 Sep 2016 09:00:37 -0500
Message-ID: <f41d968c-46c9-997e-0fa0-edbef34a1fa5@ti.com>
References: <20160906190127.23522-1-nm@ti.com> <7hshtbtu8l.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59386 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754676AbcIHOB2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 8 Sep 2016 10:01:28 -0400
In-Reply-To: <7hshtbtu8l.fsf@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Tero Kristo <t-kristo@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, devicetree@vger.kernel.org, Dave Gerlach <d-gerlach@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, Russ Dill <Russ.Dill@ti.com>, Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, narmstrong@baylibre.com, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, David Griego <david.griego@linaro.org>

On 09/07/2016 01:55 PM, Kevin Hilman wrote:
> Nishanth Menon <nm@ti.com> writes:

[...] full mail thread in https://lkml.org/lkml/2016/9/6/747

>> Overall architecture is very similar to SCPI[4] as follows:
>
> Dumb Q: I'm curious about the limitations in SCPI that were found that
> made TI decided to implement its own version.


Not really a dumb question.. (and praying I dont trigger a flame war
:D) I will skip the approximately year something worth of discussions
and TI's Linaro connect requests for consolidation of standards aside, 
lets not forget to add ARM's new protocol proposal to the list that I 
cant seem to find public reference to (ccying folks in case I have'nt 
looked the right place in http://infocenter.arm.com), but which also 
developed in parallel to TI-SCI. Anyways..

Just as a background for new folks: ARM Power Control System
Architecture Specification Version (ARM DEN 0050) (which you'd need to 
contact ARM to get access to) strongly recommends System Control
Processor - but ofcourse, SCPI evolved as ARMs way of solving the Juno 
problem set (and Sudeep can probably add lots of backgrounds on that). 
And SCPI is not, at least to my knowledge, mandatory for ARM vendors 
to follow. It probably suffices to say that ARM had SCPI and TI 
developed TI-SCI.

Now, to answer your question, why did we not just use SCPI instead of
re-inventing the wheel? To be honest, and folks who have the year
something background know this: We really did not want to spin our own.

SCPI and TISCI or other similar protocols tend to have few constraints 
to work with:
a) messaging infrastructure and capabilities ARM MHU Vs what we have
for TI message Manager (one word vs upto 128 queued 64byte messages in 
message manager from multiple simultaneous requesters)- examples being 
virtualized pipes and sizes we have for communication allows our 
protocol to optimize messaging appropriate to the SoC.
b) SoC architecture and constraints required of that - examples: here
being the processing entities, multitude variations of integrations
and SoC spins, required higher level of abstraction to even have a
resemblance of sanity at HLOS level.
c) To a minor extent, not really relevant for this thread: timelines
of parallel development and influence from corresponding SoC and other 
stakeholders within each corporates.

Long story short, investigation was done into what SCPI was providing
(TI internal ofcourse) and SCPI did not fit our SoC generation needs -
   -
http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0922g/index.html 

vs http://processors.wiki.ti.com/index.php/TISCI is available to
compare and contrast but the key highlights are probably as follows:
-  SCPI seems to be constrained around capabilities of MHU and does
not allow better leverage of h/w K2G (and future SoCs) have
capabilities of.
- SCPI abstraction levels did not fit our SoC architecture models we
are moving to where ARM cores running Linux are optional and no longer
the system master of the SoC - we do have non-ARM SoCs as well in our
SoC portfolio and obviously non-Linux solutions as well. some little
details:
    - From being able to mandate response messages which can be tuned
from "dont bother to tell me once you are done" to fine grained as
"tell me when you get around to this operation but let me know before
you actually process" as optional states for any type of messages
    - Levels of abstraction of "I dont care what you in system
controller do as long as my Display Subsystem func clk runs as xyz Hz"
    - we need to care about hardware block level operation, not how the
SoC intricacies of operating the hardware block is.. example we need 
capability to hold a hardware block active from two processing 
entities for blocks that are capable of doing so (example: GPIO and 
blocks with virtualized view capability)


and obviously more..

Obviously, each protocol could claim superiority of level of
control/abstraction provided based on SoC arch targeted etc.. but I
will try and avoid getting into that debate.

-- 
Regards,
Nishanth Menon
