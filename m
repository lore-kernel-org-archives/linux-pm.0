From: David Brownell <david-b@pacbell.net>
Subject: Re: [RFC 3/3] Runtime PM support for named power states
Date: Tue, 04 Oct 2005 18:31:33 -0700
Message-ID: <20051005013133.87E7BBF45E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
References: <Pine.LNX.4.44L0.0510031519290.5909-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6641353696359289=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0510031519290.5909-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: stern@rowland.harvard.edu
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============6641353696359289==
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

> > > 	  Even so, the confusion over which field in 
> > > dev->power.power_state should represent the true state remains.
> > 
> > Hmm, what confusion is that?  You may have mentioned it elsewhere.
>
> The confusion is over whether the current power state is indicated by 
> dev->power.power_state.state or dev->power.power_state.name.  (Never mind 
> the possibility that the actual power level might be indicated by 
> something else entirely, like pcidev->current_state or usbdev->state!)

Oh, that confusion.  :)


> There are many places in the PM core and in usbcore where decisions about 
> whether or not to call suspend or resume methods are based on the value of 
> dev->power.power_state.state.  For example, if power_state.state is 0, the 
> runtime_resume function in runtime.c won't do anything.

And suspend.c::device_suspend(msg) only checks for "event" nonzero...


> But with named states, it makes more sense to look at power_state.name
> instead.  The name field does a much better job of representing the state
> the device is currently in, whereas the event field really represents the
> reason for entering that state (i.e., the event that triggered the state
> transition).

Let's forget about the names for a moment (which I certainly prefer
in sysfs, especially with driver-controlled values).

The "confusion" is that there are two notions of state:

 - One of them is for system sleep transitions, and in practice it's
   nothing more than "I successfully called suspend_device()".

 - The other notion is for runtime power management, and it needs
   a richer notion.  Part of that is that the states are defined
   by the driver (or bus).

My theory is that the PM core doesn't need any notion that's more
complex than "moved device from <this> device list to <that> one".
Suspend and resume just move devices between lists.

One nice consequence of that theory is that there's nothing to
prevent completly ripping out the other notions of power state.
Or -- equivalently, but less painfully! -- repurposing all that
infrastructure to the exclusive use of runtime PM.  Which I'd
argue only really needs one cookie identifying the device state.
Be it a string constant, or whatever.


> The problem is made even worse by the way runtime_resume() and 
> runtime_suspend() assign their own values to dev->power.power_state, 
> overwriting whatever the driver may have put there.  I should have taken 
> out those assignments; they really don't do any good.

Well, virtually no drivers set that value themselves.  I think
that suspend.c::suspend_device() should probably set the value,
at least for devices that don't change it themselves, ditto with
the corresponding resume path.

(IMO it's clearly wrong to clobber a power_state value that the
driver set ... it surely knows more about itself than the pm core.)

- Dave



--===============6641353696359289==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============6641353696359289==--
