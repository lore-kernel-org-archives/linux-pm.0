From: Guenter Roeck <linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v3 2/9] hwmon: (core) New hwmon registration API
Date: Mon, 10 Oct 2016 16:48:22 -0700
Message-ID: <20161010234822.GA11563@roeck-us.net>
References: <1469417552-9749-1-git-send-email-linux@roeck-us.net>
 <1469417552-9749-3-git-send-email-linux@roeck-us.net>
 <1475570759.3052.22.camel@chaos.suse>
 <20161004193713.GA26304@roeck-us.net>
 <20161007143213.0ba633fe@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161007143213.0ba633fe@endymion>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jean Delvare <jdelvare-l3A5Bk7waGM@public.gmane.org>
Cc: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Punit Agrawal <punit.agrawal-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-hwmon-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 07, 2016 at 02:32:13PM +0200, Jean Delvare wrote:
> Hi Guenter,
> 
> On Tue, 4 Oct 2016 12:37:13 -0700, Guenter Roeck wrote:
> > On Tue, Oct 04, 2016 at 10:45:59AM +0200, Jean Delvare wrote:
> > > I see this patch is upstream now, but I had started reviewing it and
> > > maybe some of my comments are still relevant.
> > > 
> > As always, I appreciate the feedback. I'll be happy to submit follow-up
> > patches to address any concerns.
> > 
> > > It's not meant to be a complete review, which is why I had not sent it
> > > yet :-(
> > > 
> > > Also I did not follow the first iterations of this patchset so my
> > > apologies if I raise points which have already been discussed.
> > > 
> > > May I ask if any other subsystem is already doing anything like that?
> > > 
> > Depends what you mean with "anything like that". The API is inspired by
> > the iio API and a little by the thermal API. The details are probably
> > unique, though.
> 
> I meant the idea of describing the device capabilities and letting the
> core code generate the device attributes (or anything else) based on
> that data. The benefits are obvious, but it has a complexity and
> run-time cost so I am wondering how popular this approach is.
> 

The goal of this patch series was to provide abstraction between driver
and userspace ABI. I think this is quite common in the kernel.

I am not sure I undersatand the run-time cost concern. The main run-time
cost occurs during device instantiation and only happens once. Other
abstraction APIs in the kernel have a much higher runtime cost, and
instantiation tends to be quite costly as well.

The new API has the addd benefit of reducing driver size, in some cases
significantly. Maybe I am off, but I considered this important, which is
why I mentioned it. Maybe I should not have mentioned it at all, and
instead have focused on abstraction alone.

> You mean at the binary level?
> 
> Have you considered the case where several devices exist for the same
> driver? Static attributes are shared between devices, but with the
> generated ones this is no longer the case, right?
> 
As mentioned above, I considered static sizes to be more important.
Sure, there are situations where multiple instances of a driver are
loaded, but those are not typically memory size limited. But, again,
I guess maybe I should not have mentioned driver size impact at all.

> > > > +
> > > > +	mode = ops->is_visible(drvdata, type, attr, index);
> > > 
> > > Any reason why you don't simply attach the provided ->is_visible to the
> > > attribute group and let the driver core do the work?
> > > 
> > Parameter are all different
> > 	umode_t (*is_visible)(const void *drvdata, enum hwmon_sensor_types type,
> > 	                              u32 attr, int channel);
> > vs.
> > 	umode_t (*is_visible)(struct kobject *, struct attribute *, int);
> 
> But this is the consequence of how you implemented it, not the reason?
> 
Not really. The drivers are now abstracted from the ABI and don't know anything
about it. Effectively I would need a shim is_visible function to convert the
sysfs parameters into driver function parameters. That should still be possible,
I just don't immediately see the benefits.

> Now I seem to understand that delegating the check to the driver core
> would make it happen later, which means you would have to instantiate
> all attributes, even if some are never going to be used? So this is an
> optimization?
> 
Not for that purpose. I didn't even get to that point because I did not see
a value in the shim function mentioned above.

> But this prevents sharing the attributes between devices, as pointed
> out above. Well, I guess you can't have it all. I don't know what is
> the more important.
> 
> > > > +		return ERR_PTR(-ENOENT);
> > > > +
> > > > +	if ((mode & S_IRUGO) && !ops->read)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +	if ((mode & S_IWUGO) && !ops->write)
> > > > +		return ERR_PTR(-EINVAL);
> > > > +
> > > > +	if (type == hwmon_chip) {
> > > 
> > > This needs a comment. It's not obvious what "hwmon_chip" is supposed to
> > > represent. From what I understand, maybe "hwmon_unique" would be a more
> > > appropriate name.
> > > 
> > Those are meant to be for attributes which apply to the entire chip.
> 
> Not really. As you implemented it, it is meant for attributes which are
> not specific to an input or output in particular. That is, attributes
> which do not include a channel number. "update_interval" and
> "alarms" (which I'd like to get rid of, btw) apply to the entire chip,
> but "temp_reset_history" does not.
> 
> > Not sure if 'hwmon_unique' would reflect that better.
> > From the documentation:
> > 	"A virtual sensor type, used to describe attributes
> > 	 which apply to the entire chip"
> > 
> > Do you have an idea for a better description ?
> 
> For one thing I would rename hwmon_chip_attr_templates to
> hwmon_chip_attrs (or whatever, without _templates.) They are used
> directly, as opposed to all other hwmon_*_attr_templates strings which
> must be generated as needed.
> 
> This is the reason why the term "unique" came to my mind: the absence
> of %d in the name makes this array special. If we can't find a name
> that expresses that, I think a comment should be added to explain it.
> 
> As for the description in the documentation, what about:
> 
> 	"A virtual sensor type, used to describe attributes
> 	which are not bound to a specific input or output"
> 
> "input or output" could be shortened as "channel" but I think spelling
> it out is more explicit.
> 
I have no problem with that.

> > > > +		name = (char *)template;
> > > > +	} else {
> > > > +		name = devm_kzalloc(dev, strlen(template) + 16, GFP_KERNEL);
> > > > +		if (!name)
> > > > +			return ERR_PTR(-ENOMEM);
> > > > +		scnprintf(name, strlen(template) + 16, template,
> > > > +			  index + hwmon_attr_base(type));
> > > > +	}
> > > > +
> > > > +	hattr = devm_kzalloc(dev, sizeof(*hattr), GFP_KERNEL);
> > > > +	if (!hattr)
> > > > +		return ERR_PTR(-ENOMEM);
> > > 
> > > So basically you are doing 1 or 2 memory allocations for every
> > > attribute? Looks quite bad from a memory fragmentation
> > > perspective :-( Not to mention performance. Given that you have all the
> > > data at hand before you start, can't you preallocate an array with the
> > > right number of hattr and pick from it? That would at least solve half
> > > of the problem.
> 
> FTR I took a quick look at the iio code and there seems to be something
> like the idea above implemented in iio_device_register_sysfs(). But
> attributes themselves as instantiated by iio_device_register_sysfs()
> are still allocated individually. But hey I'm not familiar with the iio
> code anyway, I'm sure you know it better than I do.
> 
> > > Something similar for string allocation may work too, although it's
> > > somewhat more complex due to the variable length. But I think the
> > > abituguru3 driver is doing it right, so maybe you can too.
> >
> > I'll look into it.
> 
> > > (...)
> > > As a side note I am wondering if it would be reasonable to limit it to a
> > > single group, instead of a NULL-terminated array of groups. This would
> > > make the code a little more efficient.
> > > 
> > The underlying code is all the same; hwmon_device_register_with_groups()
> > also calls __hwmon_device_register(). I would prefer to keep the code as
> > common as possible.
> 
> OK, that makes sense. Maybe it can be revisited when/if we manage to
> remove some of the old registration methods.
> 
> > > > (...)
> > > > @@ -26,6 +164,16 @@ struct device *
> > > >  devm_hwmon_device_register_with_groups(struct device *dev, const char *name,
> > > >  				       void *drvdata,
> > > >  				       const struct attribute_group **groups);
> > > > +struct device *
> > > > +hwmon_device_register_with_info(struct device *dev,
> > > > +				const char *name, void *drvdata,
> > > > +				const struct hwmon_chip_info *info,
> > > > +				const struct attribute_group **groups);
> > > > +struct device *
> > > > +devm_hwmon_device_register_with_info(struct device *dev,
> > > > +				     const char *name, void *drvdata,
> > > > +				     const struct hwmon_chip_info *info,
> > > > +				     const struct attribute_group **groups);
> > > >  
> > > >  void hwmon_device_unregister(struct device *dev);
> > > >  void devm_hwmon_device_unregister(struct device *dev);
> > > 
> > > This is adding a 4th and 5th way to register a hwmon device. Starts
> > > being a bit messy... Do you have any plans to get rid of some of the
> > > other functions to make things more consistent and efficient?
> >
> > Would be nice, but then someone would have to spend the time cleaning
> > up the old drivers to replace the old API, and for the most part we would
> > not be able to test the result. Are you sure that is worth the risk ?
> 
> What I had in mind was rather along the lines of marking the function
> as __deprecated, adding a run-time notice message when it is called,
> and let whoever uses these driver contribute the fix. Call me an
> optimistic :-) There are 54 drivers still using
> hwmon_device_register(), out of 157.
> 
For most of those testing was not possible, otherwise I would have converted
them by now.

I am not sure about deprecated; doesn't that mean a failure to compile with
-Werror ? That would not help much.

Thanks,
Guenter
