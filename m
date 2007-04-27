From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC/PATCH 2/2] kernel: don't update load average
	during snapshot/shutdown
Date: Fri, 27 Apr 2007 17:53:42 +0200
Message-ID: <200704271753.43240.rjw@sisk.pl>
References: <Pine.LNX.4.64.0704271629150.15297@sbz-30.cs.Helsinki.FI>
	<20070427150527.GQ22250@elf.ucw.cz>
	<1177686732.3565.30.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1177686732.3565.30.camel@johannes.berg>
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
Cc: Pekka J Enberg <penberg@cs.helsinki.fi>, linux-pm@lists.osdl.org, nigel@nigel.suspend2.net, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday, 27 April 2007 17:12, Johannes Berg wrote:
> On Fri, 2007-04-27 at 17:05 +0200, Pavel Machek wrote:
> 
> > I think we should track -mm for now. git tree means Linus has to
> > trust you, and if he does not, you are in _big_ trouble.
> 
> We could still generate patches from the actual git tree and send those
> on to -mm. Bit more work though. Dunno. I try to import patches I see on
> the mailing list into my own patch queue, but that seems not to be
> effective all the time (never saw the freezer changes anywhere for
> example)

The freezer patches went through the LKML.

Generally, I expect we'll have quite a lot of patches floating around in the
near future and a separate common tree would be handy, if someone has the
time to maintain it.

I can set up a quilt patch series and export it for everyone from my webserver
if that helps.

Greetings,
Rafael
