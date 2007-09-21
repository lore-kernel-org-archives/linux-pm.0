From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2 -mm] kexec based hibernation -v3:
	kexec jump
Date: Fri, 21 Sep 2007 11:49:08 +0200
Message-ID: <20070921094908.GB20149__23599.882485769$1190368374$gmane$org@elf.ucw.cz>
References: <1190266447.21818.17.camel@caritas-dev.intel.com>
	<20070920100941.GA12157@atrey.karlin.mff.cuni.cz>
	<200709211024.35991.nigel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200709211024.35991.nigel@nigel.suspend2.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: nigel@suspend2.net
Cc: Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, "Huang,
	Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Seems like good enough for -mm to me.

(For the record, I do not think this is going to be
hibernation-replacement any time soon. But it is functionality useful
for other stuff -- dump memory and continue -- and yes it may be able
to do hibernation in the long term.

It really comes from the other side of reliability:

* swsusp is "if your kernel is perfectly healthy, it will work"

while this, coming from kdump is

* "if your kernel is not completely trashed, it should work"

...which is why can't use swsusp to do dump memory and continue -- you
want to do dumps on "slightly broken" systems. And yes, as a
sideeffect it may be able to do hibernation... why not, lets see how
it works out).

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
