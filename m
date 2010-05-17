From: Daniel Walker <dwalker@fifo99.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 10:57:19 -0700
Message-ID: <1274119039.25625.12.camel__34954.5443467379$1274119244$gmane$org@c-dwalke-linux.qualcomm.com>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<87hbm6cz90.fsf@deeprootsystems.com>
	<1274115885.4418.59.camel@mulgrave.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1274115885.4418.59.camel@mulgrave.site>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: James Bottomley <James.Bottomley@suse.de>
Cc: Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-05-17 at 13:04 -0400, James Bottomley wrote:

> I'm not sure this is real world, either.  Developers can fire up
> powertop from the command line when their phone isn't idling for as long
> as it should.  But a phone is a consumer device: the average smart phone
> user just wants to browse the web, get email, go to facebook and play
> with some cool apps.  If one of those cool apps is rogue, they're not
> really going to know which one or how to find it (and firing up powertop
> from the command line isn't something which will occur to them as a
> matter of routine).
> 
> One of the nice things that suspend blockers actually does is to give
> the kernel a clear name for the process blocking suspend (and thus
> consuming power).  This allows a nice way to assign power budget to the
> application and present who's using what in a nice visible form, which
> does facilitate the reporting of bad apps, even for the non-developer
> user.

If you have an idle based PM system you could get the same information
from having scheduler statistics. Since the "bad" apps are the ones that
are always either running or ready to run, and they would hardly ever
sleep. I don't know if there are specific scheduler statistics for that,
but it doesn't seem like it would be hard to make. It's even much more
natural than getting statistics from suspend blockers, since it requires
the app to be custom made to use suspend blockers.

Daniel
