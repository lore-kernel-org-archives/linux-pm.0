From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 12:46:05 -0800
Message-ID: <200503231246.05656.david-b@pacbell.net>
References: <1111113131.25179.73.camel@gaston>
	<200503231153.48230.david-b@pacbell.net>
	<4241CE9B.5050604@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============41956252274964534=="
In-Reply-To: <4241CE9B.5050604-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: Todd Poynor <tpoynor-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

--===============41956252274964534==
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 23 March 2005 12:16 pm, Todd Poynor wrote:
> David Brownell wrote:
> 
> > 
> > So to focus on one point:  "pm_message_t" doesn't work well
> > at all, since it doesn't have a way to identify the target
> > system power state, and drivers thus have no way to see if
> > they should drop their requests for those clocks or whether
> > the hardware should keep working away.
> 
> If I've followed the discussion correctly, it sounds like a lot of the 
> system intelligence is targeted at the bus driver level, and the current 
> generic platform bus driver for embedded onchip devices will probably 
> become something very tied to the particular platform. 

There's no driver for the "platform bus", just individual drivers
that hang off that data structure.   So nothing to target with
any "intelligence"; it's safe from Homeland Security.  :)


> If so, then at  
> least the bus driver would need to be told of the system state, which 
> can code the logic for figuring out which devices must be stopped prior 
> to entering a state, and device drivers can simply follow orders to 
> suspend.

I think it suffices to have the drivers know what to do:
"If going to system state X, then drop request for clock Y".

You seem to suggest something that knows which drivers exist,
and then goes to talk to them.  This isn't IMO a problem that
needs to be centrally managed, and I think it'd work better
to just let them do the right thing ... easier to make one
driver coordinate such stuff internally, than to make it
cope with various externally-induced surprises.


> But I suppose there's some cases in which a device driver may  
> have options more complicated than run/suspend in the face of changes in 
> clock gating, so having the info available to all drivers could be 
> useful even in that situation.

That too.  But, remember that in this case <asm/hardware/clock.h>
isn't structured to give clock change notifications to drivers; it's
not a cpufreq style thing, as a rule.  The model is that drivers
manage their own clocks, there's no scale() callback from any
central manager (like DPM does).  And the only question is when
they clk_unuse():  which system state is active after suspend().

- Dave


> 
> -- 
> Todd
> 

--===============41956252274964534==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============41956252274964534==--
