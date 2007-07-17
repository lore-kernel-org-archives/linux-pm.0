From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 16:40:38 +0200
Message-ID: <200707171640.39955.rjw__45366.7982634672$1184683021$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0707171010490.3551-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: david@lang.hm, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 17 July 2007 16:15, Alan Stern wrote:
> On Mon, 16 Jul 2007 david@lang.hm wrote:
> 
> > > I agree, it would be good to have a non-ACPI-specific hibernation mode,
> > > something which would look to ACPI like a normal shutdown.  But I'm not
> > > so sure this is possible.
> > 
> > why would it not be possible?
> 
> > I can't think of anything much more frustrating then thinking that I 
> > suspended a system and then discovering that becouse the battery went dead 
> > (a complete power loss) that the system wouldn't boot up properly. to me 
> > this would be a fairly common condition (when I'm mobile I use the machine 
> > until I am out of battery, then stop and it may be a long time (days) 
> > before I can charge the thing up again) this would not be a reliable 
> > suspend as far as I'm concerned.
> > 
> > for suspend-to-ram you have to worry about ACPI states and what you are 
> > doing with them, for suspend-to-disk you can ignore them and completely 
> > power the system off instead.
> 
> If the only problem with doing this would be lack of wakeup support
> then I'm all for it.  There must be a lot of people who would like
> their computers to hibernate with power drain as close to 0 as possible
> and who don't care about remote wakeup.  In fact they might even prefer
> not to have wakeup support, so the computer doesn't resume at
> unexpected times.

I'm afraid of one thing, though.

If we create a framework without ACPI (well, ACPI needs to be enabled in the
kernel anyway for other reasons, like the ability to suspend to RAM) and then
it turns out that we have to add some ACPI hooks to it, that might be difficult
to do cleanly.

Thus, it seems reasonable to think of the ACPI handling in advance.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
