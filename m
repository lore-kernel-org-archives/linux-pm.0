From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: dev->status.power and future of DPM_
Date: Mon, 18 May 2009 10:54:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0905181052050.2981-100000@iolanthe.rowland.org>
References: <aec7e5c30905171927r7f1fca36l491fd09d3e446be6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <aec7e5c30905171927r7f1fca36l491fd09d3e446be6@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, Paul Walmsley <paul@pwsan.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 18 May 2009, Magnus Damm wrote:

> > Let's put it this way: Yes, SUSPENDED/FROZEN/OFF is software state.
> > In other words, it's really the state of the _driver_ (since the driver
> > is software). =A0It isn't the device state; that is, it's not a hardware
> > state. =A0So yes, you can keep that information -- but it's not what you
> > said you wanted; above you said you wanted to keep the state of each
> > _device_ somewhere.
> =

> I'd like to keep the state of the driver _instance_. Basically what
> struct device represents. Not struct device_driver. Sorry for being
> unclear, I mean struct device when I use the word device. Driver and
> hardware specific state and information should be kept out of common
> data structures. But that's just common sense, no? Same as keeping bus
> specific information together with the bus data structures.
> =

> So to clarify, we have many drivers with multiple driver instances on
> SuperH. A good example is the CEU platform driver, each driver
> instance (video capture) is hooked up to a hardware block located
> somewhere in io memory space. We have one struct device_driver but may
> have multiple struct devices. I'm interested in the state of struct
> device.

That's fine.  My only nit is to point out that the state of the struct =

device isn't the same thing as the state of the device itself.  So long =

as we're clear on that, there's no problem.

> How about this: "execute some struct device ->freeze() callbacks and
> take a note of this by putting driver instances in FROZEN state". Does
> it make more sense?

Yes, but you do have to be careful.  If there's a possibility that a =

user process might be running and might try to send I/O to your frozen =

driver then you wouldn't want to do this.

Alan Stern
