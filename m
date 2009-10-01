From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: WOL with flex filters, reflecting it in /sys
Date: Thu, 1 Oct 2009 23:23:15 +0200
Message-ID: <200910012323.15166.rjw__34813.3551342928$1254432177$gmane$org@sisk.pl>
References: <76FA3B279DD9DA48896E2B404944957203C09587@USA7061MS02.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <76FA3B279DD9DA48896E2B404944957203C09587@USA7061MS02.na.xerox.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: martyleisner@yahoo.com, netdev@vger.kernel.org, "Leisner,
	Martin" <Martin.Leisner@xerox.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 01 October 2009, Leisner, Martin wrote:
> I'm looking to extend the work of Mitch Williams to support flexible
> filters.
> (http://www.mail-archive.com/netdev@vger.kernel.org/msg60332.html}
> 
> Looking at the problem, would it be a good idea to reflect WOL
> characteristics in the /sys filesystem (instead of requiring ethtool to
> set them)?
> 
> Seems straightforward and easy enough.

I'm not sure about that.

The supported WoL settings seem to depend on the driver and whether WoL is
going to work also depends on the device's power/wakeup setting.

Thanks,
Rafael
