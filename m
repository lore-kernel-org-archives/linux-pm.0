From: Adam Belay <ambx1@neo.rr.com>
Subject: Re: [RFC] Linux Power Management
Date: Thu, 5 May 2005 00:39:20 -0400
Message-ID: <20050505043920.GB21223@neo.rr.com>
References: <1115094736.28902.167.camel@localhost.localdomain>
	<Pine.LNX.4.44L0.0505031132520.19073-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============65398491155640048=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0505031132520.19073-100000@iolanthe.rowland.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============65398491155640048==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 03, 2005 at 11:52:45AM -0400, Alan Stern wrote:
> On Tue, 3 May 2005, Adam Belay wrote:
> 
> > Hi all,
> > 
> > I've been putting together some documentation for my proposed power
> > management changes.  In some areas it may be different or more detailed
> > than what I originally posted.  I look forward to any comments or
> > suggestions.
> > 
> > Thanks,
> > Adam
> 
> I think there are some good ideas here, but you've taken the development 
> much too far for something that's still in the "early proposal" stages.  
> Also it seems much more elaborate than we really need, and it includes 
> distinctions that aren't necessary.
> 
> Let me try to summarize quickly the high points as I see them.  You've
> defined power devices and power domains, where a power domain is really
> just a power device that can act as a parent to other power devices.  In
> other words there's no significant difference between devices and domains
> -- there's just leaves and interior nodes in a power tree.
> 
> You said explicitly that power devices may or may not coincide with struct 
> devices in the driver model.  Why do you want to do this?  Why not insist 
> that power devices _are_ struct devices?  It would make many things a lot 
> easier and allow much more code sharing plus reduction of memory usage.  
> (Kobjects aren't cheap, especially for embedded systems.)

I think you make a good point.  My original intention here was to support
strange power relationships that do not match the device tree.  However, I
don't think this will be common, and not every layer in between the tree
has to participate.  So, psuedo-logical device layers like we're seeing in the
PCI express bus driver could just be skipped past.  I'll change my plans to
reflect this.

> You've got power resources totally outside the power tree.  This seems
> like a very good way to handle oddball configurations and other things
> that don't fit the generic model.  It takes advantage of the fact that
> most power constraints can be represented in terms of a device tree even
> though some of them can't.

I'm going to try to develop this idea further.

> 
> You've got both power drivers and policy managers.  Why separate the two?  
> Won't a real implementation have to keep them closely interconnected 
> anyway?  Or have I misunderstood?

My original intention was to have "power drivers" that transition device
power state and "policy managers" that say when to make those state
transitions.  However, after giving it some thought, I don't think the
"policy manager" distinction is so important.  It could just be a component
of the device driver.

> 
> For that matter, what sort of policy options can the kernel offer to 
> userspace?  I'm not aware of many possibilities:

Mostly enabling dynamic power management features and tuning idle timeout
values.
 
> 
> 	System power transitions can be thought of as policy changes.
> 
> 	Individual devices or subsystems can be powered down either
> 	immediately or after some inactivity timeout.
> 
> 	Devices may or may not be set to resume on demand.
> 
> Anything else?  This list in itself doesn't require much in the way of 
> policy management.

Wake devices would also require userspace configuration of policy.

I appreciate your comments.  To sumarize, I'd like to introduce power
resources into our current PM model and add a concept of device power states.
Also, I'd like improve power domain handling so we can better support dynamic
power management.  However, these power domains will live inside the normal
device tree.  Finally, I'd like to implement a PCI bus power management
driver to demonstrate these concepts.  I'll have more details on these changes
soon.

Thanks,
Adam

--===============65398491155640048==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============65398491155640048==--
