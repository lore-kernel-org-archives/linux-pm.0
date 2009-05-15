From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hibernate vs. WoL
Date: Fri, 15 May 2009 17:15:53 +0200
Message-ID: <200905151715.54123.rjw__48690.1895762005$1242400947$gmane$org@sisk.pl>
References: <1242396160.5799.92.camel@johannes.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1242396160.5799.92.camel@johannes.local>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday 15 May 2009, Johannes Berg wrote:
> Hi,

Hi,

> According to pm.h one should enable wakup events in the suspend() and
> poweroff() callbacks.
> 
> However, poweroff is not called for the 'shutdown' or 'restart'
> hibernate methods. This seems problematic, since then with proper
> drivers platforms that have no 'platform' suspend method then cannot WoL
> or anything like that (well, for 'restart' that isn't very relevant).

I think the solution for these platforms is to define hibernation operations
(struct platform_hibernation_ops) that do nothing and use the 'platform' mode.

WoL is not really supported in the 'shutdown' mode due to drivers that
don't have a ->shutdown() method setting up WoL.  Also, on ACPI systems we
often need to do some ACPI magic for the WoL to really work and this is not
done in the 'platform' mode.

> The only way to hack around that seems to be to implement the
> dev->driver->shutdown method, but I don't think that is intended? On the
> other hand calling both ->shutdown and ->poweroff seems problematic.
> 
> Right now what I'm trying to do is preserve a wireless connection across
> hibernate. This is possible by telling the AP that we're asleep, in
> which case it will buffer frames for us (it may eventually kick us off
> anyway, but that's ok, without telling it we're asleep I don't even
> survive a 'reboot' method cycle).
> 
> Also, shouldn't it be possible to WoL while your machine is shut down?
> How do you program that?

Set up WoL in ->shutdown(), like e1000 for example.

In fact I don't like it too, because IMO we clearly seem to need to split
the current ->shutdown() into non-PM and PM parts, but that's how it goes
at the moment.

Thanks,
Rafael
