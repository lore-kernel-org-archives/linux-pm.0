From: Thomas Renninger <trenn@suse.de>
Subject: Re: Improving High-Load Performance with the Ondemand
	Governor [PATCH ATTACHED]
Date: Fri, 17 Sep 2010 11:25:44 +0200
Message-ID: <201009171125.44403.trenn__14929.0762762123$1284715731$gmane$org@suse.de>
References: <4C88EF04.1030908@verisign.com> <4C928094.7080207@verisign.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C928094.7080207@verisign.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David C Niemi <dniemi@verisign.com>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 16 September 2010 22:39:48 David C Niemi wrote:
> I've been doing more testing, and have a couple of observations.  I'm 
> attaching a minimal form of my changes as a patch for the latest 
> 2.6.pre36 git version of the driver.  However, it is difficult for me to 
> test under anything other than 2.6.32 (RHEL 6 beta 2), and there are 
> some minor differences, though I don't believe they are relevant to my 
> results.
...
Adrian van dev Van "pre-announced" changes in the cpufreq area about
half a year ago:
Here is a comment from Arjan on the cpufreq list from 2010-04-19:
====================
Subject: Re: [PATCH 7/7] ondemand: Solve the big performance issue with 
ondemand during disk IO

<cut>
As for your general "ondemand is for everyone" concern; there are many
things wrong with ondemand, and I'm writing a new governor to fix the
more fundamental issues with it (and also, frankly, so that I won't
break existing users and hardware I don't have access to). This is
basically a backport of a specific feature of my new governor to
ondemand because Andrew keeps hitting the really bad case and basically
ended up turning power management off.
</cut>
====================

Unfortunately there didn't happen much since then.
If there is already some Alpha version or some measure results, it
would be great to see/compare those.

Also there is a research group who fiddled with that.
They also have a "new governor" approach and already have some
interesting results. They hopefully (said they will the next weeks)
can show some code which can be compared on the same HW
with your or other approaches then:
http://www.betriebssysteme.org/Aktivitaeten/Treffen/2009-Bommerholz/Programm/docs/Talks/richling.pdf

I expect with Arjan's latest "count IO as busy time" there is only some
fine tuning with the ondemand or say polling approach that could still
be done. The patch you sent probably increases performance a bit with again
some power trade-offs depending on the HW and C-states available.

Interesting is:
---------------------
I've testing on a dual Xeon X5680 system
(other times I've been testing on 2-year-old dual Opterons).
I observe about a 10W power consumption reduction at idle between the 
"performance" governor and the "ondemand" governor.
---------------------
On the Opteron or Xeon system? That would mean that reducing frequency
from OS still is an important power consumption knob even on latest Westmere
systems.

         Thomas
