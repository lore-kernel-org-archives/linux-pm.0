From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Wed, 19 May 2010 22:42:55 +0200
Message-ID: <201005192242.55706.rjw__32318.7063252137$1274301945$gmane$org@sisk.pl>
References: <1274115885.4418.59.camel@mulgrave.site>
	<1274191188.10304.5.camel@mulgrave.site>
	<20100519065934.GH12879@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100519065934.GH12879@nokia.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: felipe.balbi@nokia.com
Cc: Matthew Garrett <mjg@redhat.com>, "me@felipebalbi.com" <me@felipebalbi.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Andrew Morton <akpm@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 19 May 2010, Felipe Balbi wrote:
> On Tue, May 18, 2010 at 03:59:48PM +0200, ext James Bottomley wrote:
> >On Tue, 2010-05-18 at 09:40 +0300, Felipe Balbi wrote:
> >> On Mon, May 17, 2010 at 09:49:35PM +0200, ext James Bottomley wrote:
> >> >Right, because Firmware writers are from the rugged unresponsive uplands
> >> >of planet
> >> >ignore-user-complaints-and-eat-them-for-breakfast-if-they-file-bugs and
> >> >Software writers are from the emollient responsive groves of planet
> >> >harmony.  Obviously what would work for one wouldn't work for the other.
> >> >
> >> >As a software writer, I fully buy into that world view.  The trouble is
> >> >that when I go to dinner with hardware people, they seem to be awfully
> >> >nice chaps ... almost exactly like me, in fact ...
> >>
> >> what does this add to suspend_blockers discussion ?
> >
> >Sorry I was evidently being too subtle.
> >
> >The point is that if, as you acknowledge, that you can't train firmware
> >engineers to be responsive, there's no reason to think you can train
> >software engineers in the same quality ... they're very similar people.
> 
> I wouldn't say it's up to the engineer himself, it's more related to how 
> the company that person works for deal with such things.
> 
> >The corollary is that real world systems have to operate in the face of
> >misbehaving hardware *and* software.
> 
> I still think the kernel shouldn't deal with broken applications and we 
> shouldn't try to fix them in kernel space. We can, of course, try to 
> find them and have all sorts of bells and whistles shouting 'process 
> %s is preventing CPU from sleeping for %llu nanoseconds' or something 
> like that.

Please note that this approach is not too practical for vendors who ship
systems like cell phones to the general public.

Rafael
