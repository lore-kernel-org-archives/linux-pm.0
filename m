From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Freezer: Don't count threads waiting for frozen
	filesystems.
Date: Wed, 29 Oct 2008 00:59:37 +0100
Message-ID: <200810290059.38411.rjw__43410.9500413344$1225238264$gmane$org@sisk.pl>
References: <1224886068.6478.21.camel@nigel-laptop>
	<200810282321.59041.rjw@sisk.pl>
	<E1Kuxsg-0006PR-Tr@pomaz-ex.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <E1Kuxsg-0006PR-Tr@pomaz-ex.szeredi.hu>
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
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: ncunningham@crca.org.au, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 29 of October 2008, Miklos Szeredi wrote:
> On Tue, 28 Oct 2008, Rafael J. Wysocki wrote:
> > On Tuesday, 28 of October 2008, Miklos Szeredi wrote:
> > > I would prefer a freezer-less solution.  Suspend to ram doesn't need
> > > the freezer,
> > 
> > Well, yes it does.  And it will in forseeable future, AFAICS.
> 
> Umm, OK.  Last I remember everybody agreed that there's absolutely no
> reason why processes need to be frozen, and the only important thing
> is that drivers are not twiddling the hardware during suspend, and
> this can usually easily be solved on the subsystem level.

Well, this turned out not to be the case in the meantime.

In fact to handle that without the freezer we'd have to synchronize every
driver's suspend/resume callbacks with every possible way in which
applications can access the device for regular I/O (for example for PCI devices
this means any I/O other than configuration space accesses).

While this is possible in theory, I don't see this happening any time soon,
especially that we're going to keep the bar for accepting new drivers
relatively low.

Thanks,
Rafael
