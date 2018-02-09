From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH v13 4/4] battery: Add the ThinkPad "Not Charging" quirk
Date: Fri, 9 Feb 2018 08:45:30 -0200
Message-ID: <20180209104530.s5i6lymcpgkqyego@khazad-dum.debian.net>
References: <20180207145936.ockmmkipxtwkdsot@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180207145936.ockmmkipxtwkdsot@thinkpad>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Ognjen Galic <smclt30p@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Sebastian Reichel <sre@kernel.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Wed, 07 Feb 2018, Ognjen Galic wrote:
> The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> of "Unknown" when the battery is between the charge start and
> charge stop thresholds. On Windows, it reports "Not Charging"
> so the quirk has been added to also report correctly.
> 
> Now the "status" attribute returns "Not Charging" when the
> battery on ThinkPads is not physicaly charging.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Ognjen Galic <smclt30p@gmail.com>

AFAIK, This behavior goes back to the initial SBS implementation in the
IBM era ECs of the Thinkpads...  We've always called it "idle" in the
linux-thinkpad community.  The behavior comes from SBS
(http://smartbattery.org/specs/), the EC was reporting its status
(charging/not charging *THIS* battery) in one bit, and the battery's
status (discharging/not discharging *THIS* battery) in a different bit.

It was rather simple to observe the behavior of those bits in a
two-battery system.

Would that apply to these newer Lenovo models?  If so, you might want to
consider using "idle", instead. "not charging" does _not_ imply "neither
charging nor discharging", while "idle" does.

-- 
  Henrique Holschuh
