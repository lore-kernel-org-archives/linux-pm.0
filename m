From: Ognjen =?utf-8?B?R2FsacSH?= <smclt30p@gmail.com>
Subject: Re: [PATCH v13 4/4] battery: Add the ThinkPad "Not Charging" quirk
Date: Sat, 10 Feb 2018 09:47:44 +0100
Message-ID: <20180210084744.ykzejcr66ae7kflj@thinkpad>
References: <20180207145936.ockmmkipxtwkdsot@thinkpad>
 <20180209104530.s5i6lymcpgkqyego@khazad-dum.debian.net>
 <20180209132641.6vkwasa4b5pygjkr@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180209132641.6vkwasa4b5pygjkr@earth.universe>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, devel@acpica.org, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>, Platform Driver <platform-driver-x86@vger.kernel.org>, ibm-acpi-devel@lists.sourceforge.net, Linux PM <linux-pm@vger.kernel.org>, Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph@boehmwalder.at>, Kevin Locke <kevin@kevinlocke.name>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 09, 2018 at 02:26:41PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Feb 09, 2018 at 08:45:30AM -0200, Henrique de Moraes Holschuh wrote:
> > On Wed, 07 Feb 2018, Ognjen Galic wrote:
> > > The EC/ACPI firmware on Lenovo ThinkPads used to report a status
> > > of "Unknown" when the battery is between the charge start and
> > > charge stop thresholds. On Windows, it reports "Not Charging"
> > > so the quirk has been added to also report correctly.
> > > 
> > > Now the "status" attribute returns "Not Charging" when the
> > > battery on ThinkPads is not physicaly charging.
> > > 
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Signed-off-by: Ognjen Galic <smclt30p@gmail.com>
> > 
> > AFAIK, This behavior goes back to the initial SBS implementation in the
> > IBM era ECs of the Thinkpads...  We've always called it "idle" in the
> > linux-thinkpad community.  The behavior comes from SBS
> > (http://smartbattery.org/specs/), the EC was reporting its status
> > (charging/not charging *THIS* battery) in one bit, and the battery's
> > status (discharging/not discharging *THIS* battery) in a different bit.
> > 
> > It was rather simple to observe the behavior of those bits in a
> > two-battery system.
> > 
> > Would that apply to these newer Lenovo models?  If so, you might want to
> > consider using "idle", instead. "not charging" does _not_ imply "neither
> > charging nor discharging", while "idle" does.
> 
> I agree, that "Idle" is a better term than "Not Charging", but
> the power supply property exists with this name since it has
> been introduced. This is exposed to userspace and cannot be
> changed easily.

I agree. There is no need to add new definitions to the generic 
power supply API for "Idle", as basically "Not Charging" can also
describe that condition. That's what Microsoft Windows does, since XP.

> 
> -- Sebastian
