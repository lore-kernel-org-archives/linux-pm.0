From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Wed, 29 Oct 2008 23:07:26 +0100
Message-ID: <200810292307.26945.rjw__39092.2474013225$1225318123$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0810291627040.3986-100000@iolanthe.rowland.org>
	<200810292211.49021.rjw@sisk.pl>
	<1225316715.18786.1.camel@nigel-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1225316715.18786.1.camel@nigel-laptop>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Nigel Cunningham <ncunningham@crca.org.au>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 29 of October 2008, Nigel Cunningham wrote:
> Hi.
> 
> On Wed, 2008-10-29 at 22:11 +0100, Rafael J. Wysocki wrote:
> > The current design of the freezer is rather simplistic and I'm not really sure
> > it's the best one possible.  Perhaps we can redesign the freezer to work
> > differently and handle the cases like fuse.
> 
> Why redo what I've already done? In the full patch, you have the basis
> of what you're talking about. I haven't seen a failure to freeze fuse or
> anything else in a year of use.

Still, Miklos noticed some problems with it.

I'm not talking about doing things on top of the current signal-based
freezing mechanism, but rather about moving the freezer a bit closer towards
the scheduler.  Maybe this is the way to go.  I don't know.

In any case, the freezing of user space seems to be much simpler than modifying
all drivers to add suspend synchronization.

Thanks,
Rafael
