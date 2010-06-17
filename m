From: Len Brown <lenb@kernel.org>
Subject: RE: [linux-pm] RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 15:00:15 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006171445010.4214@localhost.localdomain>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
 <D32AB456855CBD4987499F68AFA421F4299A56E336@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <D32AB456855CBD4987499F68AFA421F4299A56E336@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Igor.Stoppa@nokia.com
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 17 Jun 2010, Igor.Stoppa@nokia.com wrote:

> i do understand that you are mostly targetting acpi based systems,
> but even there, based on static leaks, it might not be always true
> that lower frequencies are correlated to higher power savings
> (or maybe i have misunderstood your draft - i am not so fluent in acpi)

Right, my assertion is that ondemand deals only with P-states,
where, by defintion, the deeper the P-state the lower the voltage,
the higher the efficiency.

I assume that ondemand is not used to enable T-states
where the clock is throttled w/o lowering the voltage.
I put a note to try to make that clear under
max_powersave:

"ondemand: min P-state (do not invoke T-states)"

Of course it is also possible for a processor to do a poor job
implementing P-states and a great job optimizing idle states
such that race to idle were always a win.  However, on such
a processor it would make more sense to simply disable P-states.

> > it is likely
> > that some users would want to use "powersave" when on
> > battery and perhaps shift to "performance" on A/C.
> 
> if we consider also the thermal envelope and the fact that "performance"
> might steal power from a charging battery, even ton A/C it might not be 
> possible to settle down in one state permanently.
> 
> Or do you expect other mechanisms to intervene?

Typical laptop BIOS commonly implement a scheme where
they maximize performance on AC and bias towards saving energy
on DC.

That, of course, is just one example use-model.
Here Linux user-space can choose whatever policy
makes sense for them at run-time.

cheers,
-Len Brown, Intel Open Source Technology Center

