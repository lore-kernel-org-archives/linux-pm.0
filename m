From: Greg KH <greg@kroah.com>
Subject: Re: default value of power/wakeup
Date: Wed, 22 Apr 2015 17:52:33 +0200
Message-ID: <20150422155233.GC32576@kroah.com>
References: <CAGnHSEkaEBeHdCGCGpLXtF3tKwT4Ck+7TZBpJoO5gNzvpNde4w@mail.gmail.com>
 <Pine.LNX.4.44L0.1504221028370.1630-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:54062 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756464AbbDVPwg (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 22 Apr 2015 11:52:36 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id BD30D207CC
	for <linux-pm@vger.kernel.org>; Wed, 22 Apr 2015 11:52:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1504221028370.1630-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Tom Yan <tom.ty89@gmail.com>, linux-usb@vger.kernel.org, linux-pm@vger.kernel.org

On Wed, Apr 22, 2015 at 11:28:29AM -0400, Alan Stern wrote:
> On Wed, 22 Apr 2015, Tom Yan wrote:
> 
> > On 21 April 2015 at 23:51, Alan Stern <stern@rowland.harvard.edu> wrote:
> > > Anyway, you're suggesting that drivers should never override sysfs
> > > attribute values.  But there doesn't seem to be any other way to
> > > implement the kernel's policy that wakeup should be enabled by default
> > > for all keyboard devices.
> > 
> > I just doubt if there should be any of these kinds of kernel's policy,
> 
> The kernel _has_ to have some policy about default values.  It's 
> unavoidable -- even if you say that the default value for everything 
> will be 0, that's still a policy!
> 
> > especially for non-critical attributes like wakeup. Obviously now udev
> > is put to a very embarassed position (supposedly it should be the one
> > managing these policy, but now the fact is the kernel took its job
> > from it). Also, from the case of my two receivers, we can see that it
> > also causes unnecessary inconsistency to user experience.
> 
> The inconsistency is a bug.  Not all keyboard drivers have implemented
> the wakeup policy.  That can be fixed.  Try applying the patch below 
> and let me know what happens.
> 
> Overriding udev is unfortunate and we should try to avoid it.  But at
> the moment, I can't see any way to avoid it without making a lot of
> users unhappy (because their keyboards will no longer automatically be
> enabled for wakeup).
> 
> > To me it's more of "driver's policy" than the kernel's.
> 
> What's the difference?  Drivers are part of the kernel, after all.
> 
> >  If it's not
> > trying to make people with same hardware capibilities share the same
> > experience on the same attributes, what's the meaning of these
> > policies then? Yes of course there might be a (great) chance that it
> > might make (many) people with certain hardware feel happier, but
> > objectively does it mean anything? Not to mention that not everyone
> > likes the policy. (Can anyone even confirm that the majority likes
> > wakeup to be enabled for keyboards by default?)
> 
> If the kernel developers never did anything until they had first 
> checked to see that a majority of users were in favor, they would never 
> do anything at all.
> 
> Do you think Microsoft checked with all their users before introducing
> Windows Vista or Windows 8?  Obviously Linux is not like Windows, for 
> many reasons, but in some respects their developments are similar.
> 
> > IMHO it would be best that any general policies considered important
> > to be off-loaded to udev (as a udev rule?). Only when there's no
> > better way (like "communicate directly" with udev?) for the driver to
> > set necessary specific policies for itself, it goes back to this
> > not-so-good method.
> 
> If we were to change the policy now, it would be a regression because
> it would make lots of keyboards stop being wakeup-enabled by default.  
> Kernel developers are not allowed to cause regressions except in a few
> rare cases (such as those involving security problems).
> 
> > >  After all, only the driver knows whether or not the device it
> > > manages is a keyboard.
> > 
> > I am not sure that I understand what does this mean practically to this issue.
> 
> It means that the wakeup setting cannot be initialized correctly when
> the sysfs attribute is created, because the attribute is created before
> the kernel knows that the device is a keyboard (since only the driver
> knows this, and the driver doesn't get bound to the device until after
> the attribute is created).
> 
> Alan Stern
> 
> 
> 
> Index: usb-4.0/drivers/hid/hid-logitech-dj.c
> ===================================================================
> --- usb-4.0.orig/drivers/hid/hid-logitech-dj.c
> +++ usb-4.0/drivers/hid/hid-logitech-dj.c
> @@ -990,6 +990,7 @@ static int logi_dj_probe(struct hid_devi
>  			 const struct hid_device_id *id)
>  {
>  	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
> +	struct usb_device *udev = interface_to_usbdev(intf);
>  	struct dj_receiver_dev *djrcv_dev;
>  	int retval;
>  
> @@ -1078,6 +1079,9 @@ static int logi_dj_probe(struct hid_devi
>  		goto logi_dj_recv_query_paired_devices_failed;
>  	}
>  
> +	/* Keyboards are enabled for wakeup by default */
> +	device_set_wakeup_enable(&udev->dev, 1);

But this device isn't always a keyboard.  For example, mine works with a
mouse.  It's a "universal receiver", you can't know what type of HID
device is plugged into it until it connects to it.  I don't mind making
it auto wakeup, if that works, but the comment isn't correct.

thanks,

greg k-h
