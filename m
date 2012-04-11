From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC] Runtime PM for host controllers
Date: Wed, 11 Apr 2012 10:07:20 +0100
Message-ID: <20120411090720.GB32187@sirena.org.uk>
References: <CAJiQ=7AL24L2-KJ405jOkFutti5QcGfMEzp2rKbcrMY=5TuJzg@mail.gmail.com>
	<Pine.LNX.4.44L0.1204101535090.1605-100000@iolanthe.rowland.org>
	<CAJiQ=7A=744EZ1pW0vmpW=+CgdoDBYT0vc-=182Y8eU-3pZqvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAJiQ=7A=744EZ1pW0vmpW=+CgdoDBYT0vc-=182Y8eU-3pZqvg@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Cernekee <cernekee@gmail.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 10, 2012 at 03:42:33PM -0700, Kevin Cernekee wrote:
> On Tue, Apr 10, 2012 at 12:48 PM, Alan Stern <stern@rowland.harvard.edu> wrote:

> > PCI devices have two different power wells, one for normal use and one
> > for use during suspend.  As far as I know, there is no way to turn off
> > power to the auxiliary well short of turning off the entire computer.
> > Rafael may have a more complete picture.

> That may be the case on PCs, but on many embedded systems (mine
> included), entire hardware blocks can be clock-gated or power-gated
> without shutting off the rest of the system.

Do you have any numbers here?  With systems that care about power
consumption on this level you tend to find there's good enough power
management within the IP block down to the level where you need to start
suspending the system itself to make a noticable impact.

Sometimes this needs to be accomplished in conjunction with things like
pin muxing - for example, configuring the pins to wake on an edge and
then having the driver detect this edge and wake up the IP itself in
order to actually handle the event.

> Probably, but it seems a little clunky when we have a "runtime
> suspend" framework already in place...

The goal of the runtime suspend framework is to be transparent to the
end user.
