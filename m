From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: resume from ram hangs on 2.6.26+ kernels on thinkpad
	z60m
Date: Thu, 21 Aug 2008 14:43:43 +0200
Message-ID: <200808211443.43690.rjw__30252.0815785558$1219322630$gmane$org@sisk.pl>
References: <200808201602.26848.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200808201602.26848.arekm@maven.pl>
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
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 20 of August 2008, Arkadiusz Miskiewicz wrote:
> 
> I'm seeing problems with resume (using s2ram) on thinkpad z60m notebook with 
> very fresh git kernel (built yesterday). It looks like this - I get screen 
> resumed with X window running on it, I see mouse pointer but pointer doesn't 
> react to movement and sysrq keys also don't respond (tried to 
> umount+sync+reboot via sysrq).
> 
> The hangs doesn't always happen but it happens quite often (often enough to 
> get kmail trashed several times).
> 
> The problem is also happening on 2.6.26 kernels (I wasn't testing .26 too 
> much).
> 
> Now I'm back on 2.6.25 where the problem doesn't occur.
> 
> I didn't see any reports related  to that on lkml which is bad thing 8)
> 
> Any ideas?

Not really.  We must have broken something in 2.6.26, but there were not too
many suspend-specific patches in there vs .25.

What s2ram options are used?

What hardware is there in the box (chipset, graphics)?

Thanks,
Rafael
