From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: apm_emulation regression
Date: Sat, 15 Dec 2007 01:20:34 +0100
Message-ID: <200712150120.35623.rjw@sisk.pl>
References: <1197427530.8385.59.camel@pasglop>
	<1197590712.15741.197.camel@pasglop>
	<1197634708.16079.46.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org>
In-Reply-To: <1197634708.16079.46.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@ozlabs.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-pm <linux-pm@lists.osdl.org>, ralf <ralf@linux-mips.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: linux-pm@vger.kernel.org

On Friday, 14 of December 2007, Johannes Berg wrote:
> 
> > > It can use the new notifier that happens before freezing yes. Johannes,
> > > I think that's pretty much what my old powermac implementation did
> > > (using my private notifier scheme I had there), might be worth reviving
> > > that bit and sticking it into the generic apm_emu ...
> > 
> > Note that you may want to improve on it with a timeout in case userspace
> > doesn't ack...
> 
> Yeah heh. I'll take a look, shouldn't be too hard. Except I'm not
> exactly sure how to test it.

Create an artificially malicious application? ;-)

Rafael
