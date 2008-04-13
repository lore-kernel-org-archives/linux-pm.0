From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/3] PM: Introduce new top level suspend and
	hibernation callbacks (rev. 8)
Date: Mon, 14 Apr 2008 01:08:04 +0200
Message-ID: <200804140108.05447.rjw__46049.7000990019$1208128184$gmane$org@sisk.pl>
References: <200804040111.15255.rjw@sisk.pl> <200804140027.12161.rjw@sisk.pl>
	<1208126822.6958.63.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1208126822.6958.63.camel@pasglop>
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
To: benh@kernel.crashing.org
Cc: Nigel Cunningham <ncunningham@crca.org.au>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 14 of April 2008, Benjamin Herrenschmidt wrote:
> 
> > Well, I'm not sure and I'm not going to introduce the change right now, after
> > the paches have been included in -mm.
> > 
> > That would require quite some changes in the core code that I'd prefer to
> > avoid for now.  We can do something like this in a separate patch series after
> > the present one settles down a bit.
> 
> I disagree.

Okay, so we have different opinions. :-)
 
> Doing it later would introduce yet another major semantic change.
>
> I think we should get it right now. There's no hurry in pushing things
> especially if they aren't quite right.

>From my point of view, they are as right as they can be at the moment.

Besides, maintainig a set of patches like this so that it always applies to
a tree that's continuously changing under it is far from funny.  I'm not going
to do it much longer, that's for sure.

> The ability for prepare() callbacks to sync with userland,
> request_firmware, etc... is an important feature that's been needed for
> some time imho.

Well, if we put ->prepare() before the freezer, what can it actually do?
Certainly nothing that will block any (user space) task, because the freezer
won't work after that.  So, all of the significant suspend work, like blocking
tasks using the device etc., will have to be done by ->suspend().  Will that be
convenient?  I'm not sure.  I'm not even sure that would be _doable_ at all.

The point of view depends on what you think ->prepare() should be used for
and I'm sure you have some specific cases in mind.  However, are they generic
enough?

Thanks,
Rafael
