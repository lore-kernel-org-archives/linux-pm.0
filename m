From: Todd Poynor <tpoynor-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Subject: Re: comments on irc log
Date: Wed, 23 Mar 2005 17:57:33 -0800
Message-ID: <42421E8D.7040207@mvista.com>
References: <1111113131.25179.73.camel@gaston>
	<200503231153.48230.david-b@pacbell.net>
	<4241CE9B.5050604@mvista.com>
	<200503231246.05656.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503231246.05656.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Help: <mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request-qjLDD68F18O7TbgM5vRIOg@public.gmane.org?subject=subscribe>
Sender: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
Errors-To: linux-pm-bounces-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Cc: linux-pm-qjLDD68F18O7TbgM5vRIOg@public.gmane.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Wednesday 23 March 2005 12:16 pm, Todd Poynor wrote:

>>If so, then at  
>>least the bus driver would need to be told of the system state, which 
>>can code the logic for figuring out which devices must be stopped prior 
>>to entering a state, and device drivers can simply follow orders to 
>>suspend.
> 
> 
> I think it suffices to have the drivers know what to do:
> "If going to system state X, then drop request for clock Y".
> 
> You seem to suggest something that knows which drivers exist,
> and then goes to talk to them.  This isn't IMO a problem that
> needs to be centrally managed, and I think it'd work better
> to just let them do the right thing ... easier to make one
> driver coordinate such stuff internally, than to make it
> cope with various externally-induced surprises.

It was my try at taking some of the other comments I've read on moving 
smarts to the PCI et al busses and applying them to the platform bus, 
looks like that's not what's in the works.  And it would indeed 
presuppose board-specific code that knows about its onchip/onboard 
drivers (for example, PowerPC 4xx at least used to centrally manage 
various aspects of its onchip devices).

So the platform bus is not intended to encapsulate the platform logic 
for device clocking interactions with system power states, this goes 
into the drivers, which should be fine.  Depending on the eventual 
implementation perhaps it could be the case that some common drivers 
would need board-specific logic to deal with these interactions, but if 
so then that can always be dealt with.

-- 
Todd
