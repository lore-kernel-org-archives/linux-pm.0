From: David Brownell <david-b@pacbell.net>
Subject: Re: Re: [PATCH] swsusp: do not use pm_ops (was: Re: ...))
Date: Mon, 7 May 2007 14:43:16 -0700
Message-ID: <200705071443.17429.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0705071426090.3429-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0705071426090.3429-100000@iolanthe.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Pekka Enberg <penberg@cs.helsinki.fi>, Johannes Berg <johannes@sipsolutions.net>, Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <nigel@nigel.suspend2.net>
List-Id: linux-pm@vger.kernel.org

On Monday 07 May 2007, Alan Stern wrote:
> On Sun, 6 May 2007, David Brownell wrote:
> 
> > On Saturday 05 May 2007, Alan Stern wrote:
> > 
> > > But who says that hibernate has to use "Non-Volatile Sleep" and normal 
> > > shutdown has to use software-controlled "poweroff"?  Why shouldn't the 
> > > user be able to do it the other way 'round?
> > 
> > Well, the definition of NVS matches hibernation, and
> > the definition of soft-off matches poweroff.
> 
> Okay, I read sections 2.2 and 2.4 of the ACPI 3.0 spec.  Here's the story
> in a nutshell:
> 
> 	G3 = "mechanical off" = no wakeup devices are enabled,
> 				safe to disassemble
> 	G2/S5 = "soft off" = wakeup may be enabled, not safe to
> 				disassemble
> 	S4 = "non-volatile sleep" = hibernation, memory image is saved
> 	S5 = "soft off" = almost the same as S4 except there is no
> 				memory image

This summary suggests there are two S5 states, which I believe
is incorrect.  G2 is just another name for S5.  See Fig 3-1;
the ACPI 2.0 spec has the same figure.

Also, section 2.2 highlights that after S5 the OS restarts,
which it doesn't do from S4 (table 2-1) ... although when it
describes S4/NVS it fuzzes that issue by saying the key issue
is whether an NVS state file is found and used, not the level
of power available.


> The spec does not explicitly associate S4 with either G2 or G3, and in
> fact it contains language suggesting very strongly that the system could
> be in either one.  The spec also uses the same name for G2 and for S5, no 
> doubt leading to extra levels of confusion.

Figure 3-1 seemed quite explicit to me ... S4 is one of the G1
states, S5 is the only G2 state, and G3 is is a different beast.
Text elsewhere agrees with that.

What's confusing is how it describes NVS/hibernate.  It's very
explicitly a G1 state.  But leaving G2 or G3 can also trigger
a resume-from-NVS ... according to the text in 2.2 but not the
state diagrams, which don't show entering G3 even cleanly, much
less uncleanly (like a neighborhood power failure).  Bleech.

I think the implication is that going to either G2 or G3 "off"
states discards something that a G1 state preserves.  But I'd
have to search more deeply to see if that's clearly defined.
It's suggestive that there are no "_S5D" or "_S5W" methods;
such wake events would evidently be managed by BIOS not OSPM.


> So there's no question that S4 = NVS = hibernation.  But hibernation
> can involve either G2 or G3.

I suspect there's a reason this part of ACPI is so vague;
it may relate to the desire to allow direct BIOS handling
of the NVS state.

 
> And there's no question (in my mind at least) that normal shutdown should
> be able to involve either G2/S5 or G3.

G2/S5, yes ... that can be entered under software control.

But by definition, not G3 since it requires a mechanical/manual
power switch update.  ("Mechanical OFF", or in the spec's example
"movement of a large red switch".)


> So although the spec doesn't put  
> things quite this way, we could say:
> 
> 	hibernation = S4 = G2/S4 or G3/S4,
> 
> 	shutdown = S5 = G2/S5 or G3/S5.

No, you're missing the key "mechanical" red-switch-ish step in G3.

G3 *can't* be entered under software control.  By definition.  It's
there for among other things regulatory reasons ... the only power
consumed in G3 is from the on-board RTC battery.


> > > > That's a different suggestion, yes.  I'm not sure I see any
> > > > benefit of that flexibility for "soft off" states though,
> > > > especially if it made "off" consume more power.
> > > 
> > > The benefit is that it allows more devices to function as wakeup sources, 
> > > right?
> > 
> > With downsides of "more power consumed during 'off' states"
> > and "invalidating documentation, training, and expectations".
> 
> Okay, let's clear up the confusion.  The additional flexibility I'm 
> suggesting for "soft off" = G2 states is that we should allow both G2/S4 
> and G2/S5.  They would consume the same amount of power since they are 
> both G2 states; the difference is that G2/S4 involves saving and restoring 
> a memory image and G2/S5 does not.

There is no G2/S4 state; it's G1/S4 or G2/S5.  And S5 does not
involve an NVS file, or it'd be S4.  The ACPI spec is sadly
vague in those areas, however.

- Dave
