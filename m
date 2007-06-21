From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFD] How to tell ACPI drivers what the target sleep
	state is (was: Re: [PATCH 1/2] acpi choose sleep state help)
Date: Thu, 21 Jun 2007 16:46:05 +0200
Message-ID: <200706211646.06594.rjw__37196.6073908426$1182436809$gmane$org@sisk.pl>
References: <1182220394.14837.9.camel@sli10-conroe.sh.intel.com>
	<200706211442.41140.rjw@sisk.pl>
	<20070621130312.GB18392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070621130312.GB18392@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thursday, 21 June 2007 15:03, Pavel Machek wrote:
> Hi!
> 
> > > > > Not. Could pm_message_t have a member indicating the suspend state?
> > > > 
> > > > Well, I thought about that, but I did't know what people on linux-pm would
> > > > think about that.
> > > 
> > > Let's get rid of pm_message_t entirely.  Didn't we already discuss
> > > how the main reasons for it will vanish if drivers get new PM methods?
> > > 
> > >  
> > > > Alternatively, we could introduce a pm_target() global PM operation that will
> > > > set the target sleep state for the entire system.
> > > 
> > > I hope you mean "get the target state"!!
> > > 
> > > If drivers actually need a handle on that state, that'd be a fair
> > > approach; make it an opaque type though, platform-specific.
> > > 
> > > But actually I don't see much point to having such a struct.  What
> > > matters is the attributes of the target state (what resources will
> > > be present, especially), and that rarely needs to be indicated by
> > > any kind of cookie.  Consider the "current" task ... it's implicit,
> > > always present (except in IRQ contexts), and hardly ever accessed
> > > despite being more fundamental than "target PM state".
> > 
> > The issue at hand is that some device drivers may need to know what the
> > target sleep state of the system will be when their .suspend() routines are
> > being executed.  Currently, there's no means of passing that information to the
> > drivers and my question is how to do this.
> > 
> > IMO it can be done in two different ways:
> > 1) via a .suspend() argument
> > 2) via a global variable that the drivers can read.
> 
> Just do 1). Global variables are ugly, and we already have space in
> pm_message_t. 

Well, this is what Len voted for, I think.  David is against it.

I also think that the cleanest way would be to pass that as an argument
to .suspend(), but currently pm_message_t. is passed by value and if we
made it a real struct (ie. with more than one field), that would also become
ugly, IMHO.

So, can we make pm_message_t consist only of the target state?

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
