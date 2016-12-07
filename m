From: Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH 1/2] Documentation/core-api/device_link: Add initial
 documentation
Date: Wed, 7 Dec 2016 12:50:17 +0100
Message-ID: <20161207115017.GA8201@wunner.de>
References: <cover.1480849144.git.lukas@wunner.de>
 <f5b568e349aaeb31039a0c4d01fdb05d8b3bdd2a.1480849144.git.lukas@wunner.de>
 <20161206014150.GY1402@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161206014150.GY1402@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, Marek Szyprowski <m.szyprowski@samsung.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, Hanjun Guo <guohanjun@huawei.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

[got complaints on length of Cc: header, so trimming a bit]

On Tue, Dec 06, 2016 at 02:41:50AM +0100, Luis R. Rodriguez wrote:
> On Sun, Dec 04, 2016 at 01:10:04PM +0100, Lukas Wunner wrote:
> > +============
> > +Device links
> > +============
> > +
> > +By default, the driver core only enforces dependencies between devices
> > +that are borne out of a parent/child relationship within the device
> > +hierarchy: 
> 
> This "device hierarchy" was rather confusing to grasp, I specially hard
> a hard time understanding *why* the device links work did not do any
> topological sorting at all. I'm also afraid this is not just "tribal
> knowledge" -- not everyone was able to answer my questions about these
> things, Rafafel however did do justice to some degree and I did provide notes
> from this. I think it would be important then to jot down to help humans
> grok:
> 
>   o where the implicit order we embrace comes from
>   o what mechanisms are used to help provide some of this order

I'm already explaining this further down in the "Implementation" section:

	"That is achieved by traversing the ACPI namespace or OpenFirmware
	 device tree top-down and appending devices to the lists as they
	 are discovered."

If this is not sufficiently clear, please let me know how to improve it.

For didactic reasons I can't explain everything in the opening paragraph,
but the device hierarchy is exposed in sysfs and I think even casual
users might have seen it, certainly driver authors, and so the term
"device hierarchy" may evoke the right connotations and readers may even
realize that it's pre-determined by the platform, the kernel basically
just discovers it.


>   o why this is *not* sufficient

Well the introduction section already explains this abstractly:

	"Sometimes there is a need to represent device dependencies
	 beyond the mere parent/child relationship, e.g. between
	 siblings, and have the driver core automatically take care
	 of them.  Secondly, the driver core by default does not
	 enforce any driver presence dependencies, i.e. that one
	 device must be bound to a driver before another one can
	 probe or function correctly. [...] Device links allow
	 representation of such dependencies in the driver core."

And the "Examples" section further down presents specific use cases.

So I'd expect that the need for device links is already made
sufficiently clear to the reader.  Again, please let me know
if you have specific ideas to improve this.


> > +Limitations
> > +===========
> > +
>
> Well you also forgot to mention the issues with deferred probe. It uses
> deferred probe so if for whatever reason your subsystem or driver has issues
> with it, this won't help.

This very section does mention that deferred probing may cause issues:

	"Driver authors should be aware that a driver presence dependency
	 (i.e. when DL_FLAG_STATELESS is not specified on link addition)
	 may cause probing of the consumer to be deferred indefinitely.
	 This can become a problem if the consumer is required to probe
	 before a certain initcall level is reached.  Worse, if the
	 supplier driver is blacklisted or missing, the consumer will
	 never be probed."

Again I'd surmise that the deferred probing issue is sufficiently
explained, if you think otherwise please explain more specifically
what is missing.


> > +* ACPI allows definition of a device start order by way of _DEP objects.
> > +  A classical example is when ACPI power management methods on one device
> > +  are implemented in terms of I\ :sup:`2`\ C accesses and require a specific
> > +  I\ :sup:`2`\ C controller to be present and functional for the power
> > +  management of the device in question to work.
> 
> Here is an example of current mechanisms used which to driver developers
> provides implicit order --its all magical. This has can have limitations,
> its important to annotate how this is limiting and also why this perhaps
> was not considered as an enhancement in ACPI space. Ie, if semantics
> existed in ACPI space for dependency info, why are we now left to our hims
> for some cases on driver code?

If I understood Rafael correctly, Linux currently does not handle _DEP
objects correctly or at all.  So this isn't an alternative to device links,
but rather something that we can finally handle correctly with device links.
(@Rafael:  Please correct me if I'm wrong.)

Hence this is listed in the "Examples" section.  It's a future use case for
device links.

In drivers/acpi/scan.c I can see that _DEP objects are scanned and stored
on an acpi_dep_list, but that list isn't used anywhere else.  Presumably
in the future (once device links have landed in Linus' tree) we're going
to traverse the list after scanning the namespace and add a device link
for each dependency.


> > +Alternatives
> > +============
> > +
> > +* A :c:type:`struct dev_pm_domain` can be used to override the bus,
> > +  class or device type callbacks.  It is intended for devices sharing
> > +  a single on/off switch, however it does not guarantee a specific
> > +  suspend/resume ordering, this needs to be implemented separately.
> > +  It also does not by itself track the runtime PM status of the involved
> > +  devices and turn off the power switch only when all of them are runtime
> > +  suspended.  Furthermore it cannot be used to enforce a specific shutdown
> > +  ordering or a driver presence dependency.
> > +
> > +* A :c:type:`struct generic_pm_domain` is a lot more heavyweight than a
> > +  device link and does not allow for shutdown ordering or driver presence
> > +  dependencies.  It also cannot be used on ACPI systems.
> 
> I provided a list of other frameworks in the kernel which have
> their own solutions which are worth looking into, if anything to at
> least determine if we have older frameworks to replace or to use
> them to help complement device links framework to help with other
> areas other "firmware tools" clearly are lacking.

So you mentioned explicitly "DAPM, the DRM / Audio component framework,
v4l async solution".

By "DRM / Audio component framework" I assume you're referring to
vga_switcheroo.  That one I know fairly well and as I've explained
in previous e-mails it's kind of broken and I'm actually looking
into replacing it with device links myself.  Therefore I've listed
this as a use case in the "Examples" section, because we'll hopefully
get rid of it soon.

The two other ones, "DAPM" and "v4l async solution", I know nothing
about.

Marek Szyprowski wrote:  "components and v4l-async solutions are for
resolving only probe and registration issues and they are some kind
of pool for grouping devices and triggering special callback once all
requested devices in the pool have probed"

It would probably be good if someone familiar with "DAPM" and
"v4l async solution" could look at the device links documentation,
determine whether they're a potential use case of or alternative to
device links, and amend the documentation accordingly.


> > +
> > +Implementation
> > +==============
> > +
> > +The device hierarchy, which -- as the name implies -- is a tree,
> > +becomes a directed acyclic graph once device links are added.
> 
> <insert sarcasm>
> 
> Oh look a DAG without any sort. How did that happen?
> 
> </end sarcasm>
> > +
> > +Ordering of these devices during suspend/resume is determined by the
> > +dpm_list.
> 
> And where did order from that come from? My notes provided answers to
> these questions.

Well, see above, the order is achieved by traversing the device tree
provided by the platform (either ACPI or DT) top-down.  That is already
mentioned in the "Implementation" section.  So I'm not sure what piece
of information is missing?

Thanks,

Lukas
