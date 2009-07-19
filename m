From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 2/8] introduce the device async action
	mechanism
Date: Mon, 20 Jul 2009 00:16:58 +0200
Message-ID: <20090719221658.GL26511__16339.9277873852$1248042002$gmane$org@elf.ucw.cz>
References: <1247643516.26272.77.camel@rzhang-dt>
	<20090715060006.71c2e2b6@infradead.org>
	<1247709910.26272.159.camel@rzhang-dt>
	<200907170312.00006.rjw@sisk.pl>
	<1247798643.26272.275.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1247798643.26272.275.camel@rzhang-dt>
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
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Arjan van de Ven <arjan@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> >  During suspend-resume we know dependencies between
> > devices beforehand, at least in theory, so we can use them.
> > 
> that's why I use multiple async domains. :)
> One domain for a device group.
> 
> > In particular, we have to make sure that parent devices will not be suspended
> > until all of their children have been suspended and children devices will not
> > be resumed before the parents.
> 
> that's not enough.
> ???For examples,
> ACPI battery and EC are independent devices, but EC must be resumed
> before battery because battery driver may access some EC address space
> during resume time.

Yes, but those dependencies should be pulled from driver tree, not
adding separate dependencies infrastructure.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
