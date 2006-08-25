From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: So, what's the status on the recent patches here?
Date: Fri, 25 Aug 2006 17:46:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0608251742220.9240-100000@netrider.rowland.org>
References: <20060825212712.GG9568@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060825212712.GG9568@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Aug 2006, Pavel Machek wrote:

> Hi!
> =

> > > The frequency of entering this state should not interfere with my act=
ive
> > > use case.
> > > =

> > > -B- After I've put down the USB device, I now can program the internal
> > > SOC bus wrapper for the USB to allow idling of the interconnect.  I a=
lso
> > > need to associate the USB remote wake interrupt with a wake up interr=
upt
> > > to restart my interconnect.  All devices on that interconnect must be=
 in
> > > the same state for the big savings to happen.
> > > =

> > > Certainly for this embedded system, not coordinating the device states
> > > means I can't get the big power savings.
> > =

> > Part of this programming has to be done in the architecture-specific
> > driver for the interconnect.  There already is code being developed to
> > suspend USB buses when they aren't in use (although determining _when_
> > they aren't in use has not yet been implemented).  However this code
> > stops
> =

> Are there some patches to test? I'd like to power down USB bus, even
> when it has device connected (I do not user fingerprint scanner that
> much).

There are some old patches.  I could update them to the current -mm kernel =

and post them next week.

The idea of the patches is that they will autosuspend a USB hub when it
has no active (i.e., unsuspended) children, and autosuspending a root hub
stops the USB controller from doing DMA.  However, non-hub devices are not
yet automatically suspended, so you will have to suspend the fingerprint
scanner by hand.

Alan Stern
