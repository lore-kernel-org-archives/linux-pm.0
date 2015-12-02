From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] Driver core: Re-init runtime PM states at probe error and driver unbind
Date: Wed, 02 Dec 2015 03:16:42 +0100
Message-ID: <2700429.mOlVKAzJmn@vostro.rjw.lan>
References: <1447843719-9501-1-git-send-email-ulf.hansson@linaro.org> <7hoaerxiws.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:44990 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753637AbbLBBqv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Dec 2015 20:46:51 -0500
In-Reply-To: <7hoaerxiws.fsf@deeprootsystems.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Geert Uytterhoeven <geert@linux-m68k.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Eduardo Valentin <edubezval@gmail.com>

On Wednesday, November 18, 2015 10:27:15 AM Kevin Hilman wrote:
> Ulf Hansson <ulf.hansson@linaro.org> writes:
> 
> > There are two common expectations among several subsystems/drivers that
> > deploys runtime PM support, but which isn't met by the driver core.
> 
> [...]
> 
> > To address these issues, let's change the policy of the driver core to
> > meet these expectations. More precisely, at ->probe() failures and driver
> > unbind, restore the initial states of runtime PM.
> >
> > Although to still allow subsystem's to control PM for devices that doesn't
> > ->probe() successfully, don't restore the initial states unless runtime PM
> > is disabled.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> 
> Reviewed-by: Kevin Hilman <khilman@linaro.org>
> 
> Thanks for the detailed changelog!

Patch queued up for v4.5, thanks!

Rafael

