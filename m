From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH V2 0/4] introduce device async actions
	mechanism
Date: Tue, 4 Aug 2009 20:44:40 +0200
Message-ID: <200908042044.41170.rjw__49516.2548650571$1249411524$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0908041330040.3102-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0908041330040.3102-100000@iolanthe.rowland.org>
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
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "dtor@mail.ru" <dtor@mail.ru>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Arjan van de Ven <arjan@linux.intel.com>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 04 August 2009, Alan Stern wrote:
> On Tue, 4 Aug 2009, Rafael J. Wysocki wrote:
> 
> > Not only that.  I'd like to simplify the design, because IMO using one async
> > domain would be much more straightforward than using multiple ones.
> 
> > If I understand the async framework correctly, the domains are only used for
> > synchronization, ie. if you want to wait for a group of async operations to
> > complete, you can put them all into one domain and then call
> > async_synchronize_full_domain() to wait for them all together.
> > 
> > You don't need multiple domains to run multiple things in parallel.
> 
> There's a basic confusion going on here.
> 
> Rui is using "async domain" to mean a collection of devices which 
> will be suspended or resumed serially.  Different domains run in 
> parallel.
> 
> Rafael is using "async domain" to mean a collection of devices which 
> will be suspended or resumed in parallel.  Different domains run 
> serially.
> 
> Once that is cleared up, you should be able to communicate a little 
> better...  :-)

Well, I tried to follow the naming convention of kernel/async.c.

Best,
Rafael
