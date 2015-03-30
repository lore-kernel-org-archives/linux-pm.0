From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH] powercap / RAPL: mark rapl_ids array as __initconst
Date: Mon, 30 Mar 2015 15:46:35 -0700
Message-ID: <20150330154635.3fb82c23@ultegra>
References: <1427318152-21800-1-git-send-email-minipli@googlemail.com>
	<6448986.08Uv5dyIEs@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:40262 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753067AbbC3Wqg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 Mar 2015 18:46:36 -0400
In-Reply-To: <6448986.08Uv5dyIEs@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mathias Krause <minipli@googlemail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, 30 Mar 2015 21:17:02 +0200
Rafael J. Wysocki <rjw@rjwysocki.net> wrote:

> On Wednesday, March 25, 2015 10:15:52 PM Mathias Krause wrote:
> > The RAPL ids are only tested in rapl_init() which is itself an
> > __init function. For the MODULE_DEVICE_TABLE() file2alias doesn't
> > care about the section, just about the symbol name. Therefore it's
> > safe to mark the rapl_ids[] array as __initconst so its memory can
> > be released after initialization is done.
> > 
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > Signed-off-by: Mathias Krause <minipli@googlemail.com>
> 
> Jacob, any comments?
> 
looks good to me, though i did ack last week perhaps something wrong
with my email.
> > ---
> >  drivers/powercap/intel_rapl.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/powercap/intel_rapl.c
> > b/drivers/powercap/intel_rapl.c index 63d4033eb683..62f9b322fde0
> > 100644 --- a/drivers/powercap/intel_rapl.c
> > +++ b/drivers/powercap/intel_rapl.c
> > @@ -1054,7 +1054,7 @@ static const struct rapl_defaults
> > rapl_defaults_atom = { .driver_data = (kernel_ulong_t)&_ops,
> > \ }
> >  
> > -static const struct x86_cpu_id rapl_ids[] = {
> > +static const struct x86_cpu_id rapl_ids[] __initconst = {
> >  	RAPL_CPU(0x2a, rapl_defaults_core),/* Sandy Bridge */
> >  	RAPL_CPU(0x2d, rapl_defaults_core),/* Sandy Bridge EP */
> >  	RAPL_CPU(0x37, rapl_defaults_atom),/* Valleyview */
> > 
> 
> -- 
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.




-- 
Jacob Pan
