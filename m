From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: [RFC][PATCH 00/11] Android PM extensions
Date: Tue, 03 Feb 2009 08:47:38 +1100
Message-ID: <1233611258.21871.101.camel@nigel-laptop>
References: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0902021005050.2550-100000@iolanthe.rowland.org>
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
Cc: Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org, Uli Luckas <u.luckas@road.de>
List-Id: linux-pm@vger.kernel.org

Hi.

On Mon, 2009-02-02 at 10:09 -0500, Alan Stern wrote:
> On Mon, 2 Feb 2009, Uli Luckas wrote:
> 
> > On Sunday, 1. February 2009, Alan Stern wrote:
> > > Early-suspend seems to be a completely different matter.  In fact it
> > > isn't a suspend state at all, as far as I understand it.  It's more
> > > like what you get simply by doing a runtime suspend on some collection
> > > of devices.  I don't see that the kernel needs to treat it as a special
> > > state, and in might be possible to have a user program manage the whole
> > > thing -- provided the drivers in question implement runtime power
> > > management (as USB has done).
> > >
> > > Alan Stern
> > 
> > Except you always want early-suspend and auto-suspend at the same time. The 
> > idea is, if all display of system states is off (early-suspend), we can 
> > enable or disable the cpu at will (auto-suspend) because nobody will notice. 
> 
> Why should the kernel have to get involved?  Why can't userspace manage 
> both early-suspend and auto-suspend?
> 
> That is, consider the following: Userspace initiates an early-suspend
> by using a runtime PM interface to turn off the screen and some other
> devices.  After a short time, if they are still off, then userspace can
> initiate an auto-suspend by writing "auto-mem" to /sys/power/state.
> 
> All the kernel would need to know is the difference between
> auto-suspend and normal suspend: one respects wakelocks and the other
> doesn't.

It sounds to me like all of this stuff is just power management of
individual devices, which should be done through the sysfs interface and
completely unrelated to /sys/power/state. I'm putting the talk about
suspending the CPU in this box too because it sounds like the desire is
to stop the CPU without necessarily suspending other devices such as
transmitters - sort of a CPU freq state where the frequency is 0.

That said, if suspend to ram is what they really want for 'auto-mem',
what you're suggesting sounds good to me.

Regards,

Nigel
