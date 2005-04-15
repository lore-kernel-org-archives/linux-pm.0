From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] A New Power Management API
Date: Fri, 15 Apr 2005 14:54:49 -0400
Message-ID: <1113591290.3451.79.camel@localhost.localdomain>
References: <1113533193.3451.40.camel@localhost.localdomain>
	<20050415095003.52f3185a@cosmic.amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============57336962629516863=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050415095003.52f3185a@cosmic.amd.com>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Jordan Crouse <jordan.crouse@amd.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============57336962629516863==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-04-15 at 09:50 -0600, Jordan Crouse wrote:
> Adam - 
> 
> Nice stuff.  A few comments.  First, a question:
> 
> Is it safe to assume that PMU devices  (like these:
>  http://www.dialog-semiconductor.com/template.php?page_id=62) would fall
> under the category of Power Resources?  if so, we may need to consider
> some more advanced hooks than just on/off.

I'm not familiar with how we would control such a device from software.
If you think more than _ON and _OFF would be necessary, I could
certainly revise this code.  ACPI only supports _ON and _OFF in its
model.  More complex stuff is handled by the state of the device.

    ---(power_resource)
    |        |
domain -> device

In my design, power resources are specific power planes and clocks that
belong to a given power domain (or that domain's parent).  They often
depend on the state of the domain or the system state.  A device may
require multiple power resources, but can only belong to one power
domain.  I could see something like having a clock put at a slower
speed, so maybe we do need more than on and off.


> Secondly, I have some comments regarding the system states, especially
> the last three.  While those three states are important, right off the
> bat I can think of several scenarios where additional power states could
> be imagined.  I fear that if we hard code these states, then every
> individual with a slightly different usage model on a given platform
> would have to patch the kernel accordingly.  This isn't such a far
> fetched scenario on an embedded platform.

I agree.

I'm not sure if I was very clear on this, but I intended for those
constants to be used as flags for describing characteristics of
platform-specific system states.  On X86, ACPI would provide the system
states.  So a suspend to ram state like ACPI S3 might be:

PM_SYSTEM_STATE_SLEEP & PM_SYSTEM_STATE_SUSPEND_RAM &
PM_SYSTEM_STATE_BALANCED

And S4 might be:

PM_SYSTEM_STATE_OFF & PM_SYSTEM_STATE_SUSPEND_DISK

I think these may need to be revised.  I look forward to any
suggestions.

Power drivers will often have knowledge of the platform-specific states,
and they will inform the policy manager of what states/options are
available.  The policy manger will then attempt to determine the
intentions of the system state, and after also factoring in user
settings, choose which state to use.  Policy managers have the option of
considering the actual system state number if they're aware of it.
Otherwise, they will use the flags to guess what would be appropriate
for the system state.

> 
> This is where I see the policy managers taking a greater role.  In
> addition to the hard coded states (the first five you defined sound fine
> to me), the user would define a number of pseudo system states as well
> as define the translation tables for device states under those pseudo
> states. Each pseudo state would be registered with the PM core and
> assigned a unique identifier.

That's an interesting idea.  How would the sysfs interface work?  In
general, it's challenging to allow the user to define policy
configuration settings on a per-system-state basis.

> 
> We would then define a system state flag, say
> PM_SYSTEM_STATE_PSEUDO, which would prompt a driver to query its policy
> manager to get the translation for the right device state.  Those
> devices that don't understand or care about user defined power
> states would simply ignore the flag.

I think the policy manager would directly request for a change of the
state.  Then the driver would handle *suspend.  Although the policy
manger is code included with the driver, I'd like it to handle any
decisions.  So it would be the policy manager's job to notice something
like PM_SYSTEM_STATE_PSEUDO.

> 
> I think that way we could keep things simple for for the laptop /
> desktop folks while still providing a bit of flexibility on the embedded
> side of things.
> 
> Regards,
> Jordan

I appreciate the comments.

Thanks,
Adam



--===============57336962629516863==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============57336962629516863==--
