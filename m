From: <Igor.Stoppa@nokia.com>
Subject: RE: [linux-pm] RFC: /sys/power/policy_preference
Date: Thu, 17 Jun 2010 08:03:50 +0200
Message-ID: <D32AB456855CBD4987499F68AFA421F4299A56E336@NOK-EUMSG-02.mgdnok.nokia.com>
References: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.00.1006161659140.24913@localhost.localdomain>
Content-Language: en-GB
Sender: linux-acpi-owner@vger.kernel.org
To: lenb@kernel.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

hi,

> From:  Len Brown [lenb@kernel.org]

policy_preference has 5 levels, from max_performance
through max_powersave.  Here is how 4 parts of the kernel
might respond to those 5 levels:

[levels description]

i do understand that you are mostly targetting acpi based systems, but even there, based on static leaks, it might not be always true that lower frequencies are correlated to higher power savings (or maybe i have misunderstood your draft - i am not so fluent in acpi)

> it is likely
> that some users would want to use "powersave" when on
> battery and perhaps shift to "performance" on A/C.

if we consider also the thermal envelope and the fact that "performance" might steal power from a charging battery, even ton A/C it might not be possible to settle down in one state permanently.

Or do you expect other mechanisms to intervene?

Cheers, igor