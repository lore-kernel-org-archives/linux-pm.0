From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH -mm] kexec jump -v9
Date: Thu, 15 May 2008 13:48:14 -0700
Message-ID: <m18wybqooh.fsf__20030.9278945953$1210884902$gmane$org@frodo.ebiederm.org>
References: <Pine.LNX.4.44L0.0805151012150.2107-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0805151012150.2107-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Thu, 15 May 2008 10:14:00 -0400 (EDT)")
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Vivek Goyal <vgoyal@redhat.com>
List-Id: linux-pm@vger.kernel.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Wed, 14 May 2008, Eric W. Biederman wrote:
>
>> My take on the situation is this.  For proper handling we
>> need driver device_detach and device_reattach methods.
>> 
>> With the following semantics.  The device_detach methods
>> will disable DMA and place the hardware in a sane state
>> from which the device driver can reclaim and reinitialize it,
>> but the hardware will not be touched.
>> 
>> device_reattach reattaches the driver to the hardware.
>
> How would these differ from the already-existing remove and probe 
> methods?

Honestly I would like for them not to, and they should be
proper factors of the remove and probe methods.

However we have a fundamental gotcha that we need to handle.
Logical abstractions on physical devices.

i.e.  How do we handle the case of a filesystem on a block
      device, when we remove the block device and then read it.

We have two choices.
1) We go through the pain of teaching the upper layers in the
   kernel of how to deal with hotplug and then we are sane
   when someone removes a usb stick accidentally before
   unmounting it and then reinserts the usb stick.

2) Teach the drivers how to do just the lower have of hotplug/remove.
   In which case with the driver still present and presenting it's
   upper layer queues we have the driver relinquish it's hardware
   and then later check to see if it's hardware is still present
   and reinitialize it.

I don't know if anyone has looked at moving this to an upper layer.
Definitely a question worth asking.  The simpler we can make this
for driver authors the better.  Especially as that will make
the drivers more maintainable long term.

Eric
