From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 17:07:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0805151700190.3639-100000__19960.6958464303$1211204168$gmane$org@iolanthe.rowland.org>
References: <m18wybqooh.fsf@frodo.ebiederm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <m18wybqooh.fsf@frodo.ebiederm.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 15 May 2008, Eric W. Biederman wrote:

> Alan Stern <stern@rowland.harvard.edu> writes:
> 
> > On Wed, 14 May 2008, Eric W. Biederman wrote:
> >
> >> My take on the situation is this.  For proper handling we
> >> need driver device_detach and device_reattach methods.
> >> 
> >> With the following semantics.  The device_detach methods
> >> will disable DMA and place the hardware in a sane state
> >> from which the device driver can reclaim and reinitialize it,
> >> but the hardware will not be touched.
> >> 
> >> device_reattach reattaches the driver to the hardware.
> >
> > How would these differ from the already-existing remove and probe 
> > methods?
> 
> Honestly I would like for them not to, and they should be
> proper factors of the remove and probe methods.

So then there's no need for new methods, right?

> However we have a fundamental gotcha that we need to handle.
> Logical abstractions on physical devices.
> 
> i.e.  How do we handle the case of a filesystem on a block
>       device, when we remove the block device and then read it.

The filesystem code should then receive an error for any I/O operating 
it tries to carry out.  That's what happens when you unplug a USB flash 
drive.

> We have two choices.
> 1) We go through the pain of teaching the upper layers in the
>    kernel of how to deal with hotplug and then we are sane
>    when someone removes a usb stick accidentally before
>    unmounting it and then reinserts the usb stick.

I don't understand.  Suppose you teach the filesystem layer about 
hot-unplugging.  So the user removes a USB stick before unmounting it, 
and when the filesystem tries to access the media it learns that the 
device is gone -- and the filesystem is gone with it.  How is that any 
better than getting an I/O error (apart from not filling the system log 
up with error messages)?

> 2) Teach the drivers how to do just the lower have of hotplug/remove.
>    In which case with the driver still present and presenting it's
>    upper layer queues we have the driver relinquish it's hardware
>    and then later check to see if it's hardware is still present
>    and reinitialize it.

That's how usb-storage works in 2.4.  Linus told us to change it,
probably because there was no mechanism for removing the driver's data
structures after a device was unplugged.  They had to be kept around
indefinitely, in case the device was plugged in again.

> I don't know if anyone has looked at moving this to an upper layer.
> Definitely a question worth asking.  The simpler we can make this
> for driver authors the better.  Especially as that will make
> the drivers more maintainable long term.

Maybe you're talking about adding some sort of Persistent-Device
feature to the LVM?

In an event, I'm not sure why you brought all this up.  How is it 
relevant to kexec or kexec jump?

Are you worried that there needs to be a way to tell drivers to quiesce 
their devices before doing the kexec?

Alan Stern
