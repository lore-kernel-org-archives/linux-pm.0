From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: [RFC] A New Power Management API
Date: Mon, 18 Apr 2005 20:09:04 -0700
Message-ID: <42647650.3030607@mvista.com>
References: <1113533193.3451.40.camel@localhost.localdomain>	<1113591290.3451.79.camel@localhost.localdomain>	<42607E34.7060909@mvista.com>
	<200504161226.12849.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504161226.12849.david-b@pacbell.net>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Friday 15 April 2005 7:53 pm, Todd Poynor wrote:
>...
>>On the other hand, I've been trying to push them toward a simpler-kernel 
>>model in which all the product-specific logic for placing various 
>>devices in designated power states occurs in a userspace power policy 
>>manager,
> 
> So maybe you have some answers for me about why there should need
> to be *any* notion of exporting device power states.  (Rather than
> not caring, and just requiring driver-internal powers states always
> to become consistent with the upcoming system power state.)
> 
> If one takes the notion of userspace managing those states off the table,
> is there any other motivation to expose those device power states? 

So far as I have been able to determine, the usage you describe, as well 
as straightforward individual device power state management (power this 
device off upon receipt of some event, period of inactivity, etc.) is 
common, although with enough flexibility in creating custom system power 
states and reacting to those states in driver power controller objects, 
the second usage may be covered by the first.  I believe in some cases 
power policy management applications are also examining device power 
state to make policy decisions, but I certainly recommend use of 
kernel-to-userspace notification of power events over such polling.  If 
I recall any other more exotic things I've run across I'll post a 
response later.

> I'm pretty sure that supporting this sort of userspace functionality
> won't really fit into the "simpler kernel" rubric.  If for no other
> reason than the self-evident fact that a kernel exporting such stuff
> must have more code than one not exporting it...

It may not be simpler overall on the kernel side (at least prior to 
being customized for a particular policy, for which the in-kernel 
alternative does add some amount of code).  It does, however, place the 
code implementing custom system power states and associated decisions on 
device power states (which might fall under the general category of 
"policy") in userspace and exports just enough kernel interfaces for 
controlling system and device power behavior to let userspace handle it. 
  As I say, though, the userspace vs. kernel home for this isn't a 
matter of strong preference to me, but have suggested userspace device 
state management as arguably more in keeping with prevailing winds of 
kernel development.

I don't mean to get hung up in the terminology, but I wouldn't call 
relatively infrequent changes to fairly large-grained device power 
states "micro-policy management" either -- there is plenty of room for 
more frequent, possibly finer grained, changes to device power 
characteristics in driver code based on device state or hardware 
capabilities (auto clock gating, power up/down according to app use...), 
the aggressiveness of which may also be a policy consideration to be 
configured, perhaps from userspace (at least MacOS seems to have such 
interfaces).

-- 
Todd
