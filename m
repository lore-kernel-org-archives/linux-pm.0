From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] swsusp: do not use pm_ops (was: Re: suspend2
	merge (was: Re: CFS and suspend2: hang in atomic copy))
Date: Mon, 30 Apr 2007 16:51:45 +0200
Message-ID: <200704301651.46376.rjw@sisk.pl>
References: <20070425072350.GA6866@ucw.cz>
	<200704291448.44855.Rafal.Wysocki@fuw.edu.pl>
	<1177921759.5102.24.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177921759.5102.24.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, linux-pm <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Monday, 30 April 2007 10:29, Johannes Berg wrote:
> On Sun, 2007-04-29 at 14:48 +0200, R. J. Wysocki wrote:
> 
> > +	status = acpi_enter_sleep_state(ACPI_STATE_S4);
> > +	local_irq_restore(flags);
> > +
> > +	/*
> > +	 * Restore processor state
> > +	 * We should only be here if we're coming back from hibernation and
> > +	 * the memory image should have already been loaded from disk.
> 
> That comment doesn't seem right. This is in ->enter so afaict the image
> hasn't been loaded yet at this point. I don't know if you just moved
> code but if you did then I don't think it was correct before.

It was in your patch, so I kept it, but I don't think it's correct too.

Moreover, it seems that acpi_save_state_mem() and acpi_restore_state_mem() are
only needed by s2ram, so we can safely remove them from the hibernation code
path.  Pavel, is that correct?

> > +	 */
> > +	acpi_restore_state_mem();
> 
> Maybe that needs to be in ->finish then? Or somewhere in the deeper arch
> code?
> 
> Other than that it looks good to me on a cursory look. I'll give it a
> try on my G5 on Wednesday or Thursday.

I think I'll have an improved version till then. :-)

Greetings,
Rafael
