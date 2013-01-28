From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 3/4 v11] arm highbank: add support for pl320 IPC
Date: Mon, 28 Jan 2013 21:48:36 +0100
Message-ID: <10392328.6vDAltcmAi@vostro.rjw.lan>
References: <1351631056-25938-1-git-send-email-mark.langsdorf@calxeda.com> <1457500.uzVh9cxXhS@vostro.rjw.lan> <510680AD.2070908@calxeda.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <510680AD.2070908@calxeda.com>
Sender: cpufreq-owner@vger.kernel.org
To: Mark Langsdorf <mark.langsdorf@calxeda.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Rob Herring <rob.herring@calxeda.com>, Omar Ramirez Luna <omar.luna@linaro.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: linux-pm@vger.kernel.org

On Monday, January 28, 2013 07:44:13 AM Mark Langsdorf wrote:
> On 01/28/2013 06:49 AM, Rafael J. Wysocki wrote:
> 
> >> +int pl320_ipc_register_notifier(struct notifier_block *nb)
> >> +{
> >> +	return atomic_notifier_chain_register(&ipc_notifier, nb);
> >> +}
> >> +EXPORT_SYMBOL(pl320_ipc_register_notifier);
> >> +
> >> +int pl320_ipc_unregister_notifier(struct notifier_block *nb)
> >> +{
> >> +	return atomic_notifier_chain_unregister(&ipc_notifier, nb);
> >> +}
> >> +EXPORT_SYMBOL(pl320_ipc_unregister_notifier);
> > 
> > I need all of your symbols to be exported with EXPORT_SYMBOL_GPL().
> > 
> > Is it OK to make that change when applying the patch or do you want to send
> > a new one?
> 
> I probably should resend so I can include the drivers level Kconfig and
> Makefile.
> 
> I'll get that out this morning.

OK, thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
