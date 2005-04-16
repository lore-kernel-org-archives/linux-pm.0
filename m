From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: [RFC] A New Power Management API
Date: Fri, 15 Apr 2005 19:53:40 -0700
Message-ID: <42607E34.7060909@mvista.com>
References: <1113533193.3451.40.camel@localhost.localdomain>	<20050415095003.52f3185a@cosmic.amd.com>
	<1113591290.3451.79.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1113591290.3451.79.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <ambx1@neo.rr.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Adam Belay wrote:
> On Fri, 2005-04-15 at 09:50 -0600, Jordan Crouse wrote:
...
>>This is where I see the policy managers taking a greater role.  In
>>addition to the hard coded states (the first five you defined sound fine
>>to me), the user would define a number of pseudo system states as well
>>as define the translation tables for device states under those pseudo
>>states. Each pseudo state would be registered with the PM core and
>>assigned a unique identifier.
> 
> 
> That's an interesting idea.  How would the sysfs interface work?  In
> general, it's challenging to allow the user to define policy
> configuration settings on a per-system-state basis.
> 
> 
>>We would then define a system state flag, say
>>PM_SYSTEM_STATE_PSEUDO, which would prompt a driver to query its policy
>>manager to get the translation for the right device state.  Those
>>devices that don't understand or care about user defined power
>>states would simply ignore the flag.
> 
> 
> I think the policy manager would directly request for a change of the
> state.  Then the driver would handle *suspend.  Although the policy
> manger is code included with the driver, I'd like it to handle any
> decisions.  So it would be the policy manager's job to notice something
> like PM_SYSTEM_STATE_PSEUDO.

As a real-life embedded systems example, I have periodic conversations 
with some folks who design Linux-based mobile phones, and they have 
recently asked for the addition of features that I figure can be 
addressed by approximately just this.

On the other hand, I've been trying to push them toward a simpler-kernel 
model in which all the product-specific logic for placing various 
devices in designated power states occurs in a userspace power policy 
manager, and: (a) most drivers take no additional action at system 
suspend, leaving the policy-manager-set power state in place, with some 
exceptions for drivers necessary to run the system right up until sleep 
time; (b) most drivers do nothing at system resume other than those 
needed to get the system up and running (for a mobile phone, say, at 
least mtd subsystem and flash chip driver) and then let userspace policy 
manager decide what power state to place all the devices in.  Their 
products tend to do highly customized things like power back up a small 
subset of devices that were on prior to the sleep, or briefly power up 
previously-off devices to check to see if any important changes in the 
environent occurred during the sleep, etc.

I think either way will work fine for what they're trying to do, am open 
to discuss the merits of either approach.  If anyone has any comments on 
the simplistic kernel method it's appreciated.  Thanks,

-- 
Todd
