From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v5 6/6] PCC: Enable PCC only when needed
Date: Wed, 27 May 2015 02:43:12 +0200
Message-ID: <2070004.cs8zNmgBiA@vostro.rjw.lan>
References: <1432590731-9194-1-git-send-email-ashwin.chaugule@linaro.org> <1432676153.11262.278.camel@spandruv-DESK3.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:57276 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751320AbbE0ARn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 26 May 2015 20:17:43 -0400
In-Reply-To: <1432676153.11262.278.camel@spandruv-DESK3.jf.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "ashwin.chaugule@linaro.org" <ashwin.chaugule@linaro.org>
Cc: "patches@linaro.org" <patches@linaro.org>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "jaswinder.singh@linaro.org" <jaswinder.singh@linaro.org>, "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tuesday, May 26, 2015 09:37:45 PM Pandruvada, Srinivas wrote:
> On Mon, 2015-05-25 at 17:52 -0400, Ashwin Chaugule wrote:
> > CPPC is the first client to make use of the PCC Mailbox channel. So
> > enable it only when CPPC is also enabled.
> > 
> > Signed-off-by: Ashwin Chaugule <ashwin.chaugule@linaro.org>
> > ---
> >  drivers/mailbox/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
> > index 84b0a2d..60c8da6 100644
> > --- a/drivers/mailbox/Kconfig
> > +++ b/drivers/mailbox/Kconfig
> > @@ -45,7 +45,7 @@ config OMAP_MBOX_KFIFO_SIZE
> >  
> >  config PCC
> >  	bool "Platform Communication Channel Driver"
> > -	depends on ACPI
> > +	depends on ACPI && ACPI_CPPC
> If we add such dependency then we will end up in adding many ..
> Is there any specific reason, you want to to do this?

The reason is that we want PCC to only be enabled if there's any user of it.

However, it would be better to make (a) PCC default to unset and
(b) ACPI_CPPC select PCC for this purpose.


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
