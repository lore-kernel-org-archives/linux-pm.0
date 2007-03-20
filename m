From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] dynamic device power management proposal
Date: Tue, 20 Mar 2007 10:58:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703201049460.2772-100000@iolanthe.rowland.org>
References: <1174352775.1665.4.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174352775.1665.4.camel@sli10-conroe.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 20 Mar 2007, Shaohua Li wrote:

> > A lot of development along these lines has already been going on in
> > the
> > USB subsystem.  It isn't complete yet, but a lot of the ideas you
> > raise
> > have already been implemented.
> Ok, I'll look at the USB implementation. On the other hand, I think
> there should be a generic framework for all bus types.

I agree, but only to the extent that the concepts can usefully be shared.  =

What works for USB might very well not work for a different subsystem.  =


My approach has been first to get something that does work in one
subsystem, and then to see about moving it into other subsystems or the PM
core.  I haven't finished the first step yet.  :-)  So it may be a little =

premature to try defining a full-blown dynamic power management solution =

that can apply to everything.

> Doing suspend in the driver level isn't flexible. See in the case 'close
> console if keyboard/mouse hasn't input', it's hard to do in a driver.

I'm a little confused by this.  If you want to suspend a device, surely =

you have to ask the device's driver to do the actual work?

Maybe you mean that the _decision_ to suspend a device sometimes must be =

made by code other than the device's driver.  I agree; nothing I said =

before was meant to rule out such things.  In fact, USB already contains =

several instances where non-driver code decides to suspend a device.  For =

example, when a device's file in the usbfs filesystem is closed, the =

filesystem code attempts to suspend the device.

Alan Stern
