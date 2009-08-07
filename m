From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Sat, 8 Aug 2009 01:42:38 +0200
Message-ID: <200908080142.38226.rjw__49875.0382605523$1249688599$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908041330040.3102-100000@iolanthe.rowland.org>
	<1249436851.2670.422.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1249436851.2670.422.camel@rzhang-dt>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

On Wednesday 05 August 2009, Zhang Rui wrote:
> On Wed, 2009-08-05 at 01:33 +0800, Alan Stern wrote:
> > On Tue, 4 Aug 2009, Rafael J. Wysocki wrote:
> > 
> > > Not only that.  I'd like to simplify the design, because IMO using one async
> > > domain would be much more straightforward than using multiple ones.
> > 
> > > If I understand the async framework correctly, the domains are only used for
> > > synchronization, ie. if you want to wait for a group of async operations to
> > > complete, you can put them all into one domain and then call
> > > async_synchronize_full_domain() to wait for them all together.
> > > 
> > > You don't need multiple domains to run multiple things in parallel.
> > 
> > There's a basic confusion going on here.
> > 
> > Rui is using "async domain" to mean a collection of devices which 
> > will be suspended or resumed serially.  Different domains run in 
> > parallel.
> > 
> > Rafael is using "async domain" to mean a collection of devices which 
> > will be suspended or resumed in parallel.  Different domains run 
> > serially.
> > 
> cool, thanks for stating the confusion so clearly, Alan. :)
> 
> Hi, Rafael,
> 
> maybe there is still some confusions about my proposal.
> 
> I re-read kernel/async.c file, and notice that Arjan calls the domain as
> *_synchronization_* domain. sorry I use the wrong word before.
> 
> And I use the synchronization domains just to keep devices dependency.
> 
> First, the general idea is to suspend/resume those slow devices in
> parallel. So we don't suspend/resume them synchronously, instead, we
> move these actions to the global domain.
> 
> Then, I found that these actions can not be run asynchronously because
> they depend on other devices.
> For example, sd depends on SATA controller, we should make sure the PM
> callbacks of sd and ahci sata controller are run serially. so a
> synchronization domain is created for them.
> This is how multiple synchronization domains come from in this proposal.

I think I understand now, thanks.

However, I'd like to avoid any naming confusion in future, so let's follow the
convention of async.c, please.

Best,
Rafael
