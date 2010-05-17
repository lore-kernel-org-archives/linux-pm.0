From: James Bottomley <James.Bottomley@suse.de>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Mon, 17 May 2010 13:04:45 -0400
Message-ID: <1274115885.4418.59.camel__43209.5543634661$1274115962$gmane$org@mulgrave.site>
References: <Pine.LNX.4.44L0.1005151716180.24645-100000@netrider.rowland.org>
	<87hbm6cz90.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87hbm6cz90.fsf@deeprootsystems.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Matthew Garrett <mjg@redhat.com>, Theodore Ts'o <tytso@mit.edu>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 2010-05-17 at 08:40 -0700, Kevin Hilman wrote:
> > Also, how does it handle the issue of ill-behaved apps?
> 
> For userspace, apps that have polling behavior or are ill-behaved must
> be found and fixed.  Thanks to tools like powertop, this is a farily
> easy task.

That's a bit glib ... powertop can detect power consumption stats on a
running system ... if you have a polling app preventing your system from
suspending, powertop isn't necessarily going to find it ... especially
if the polling interval is of the order of powertop's.  Powertop can
find the bad tens of wakeups per second, but it only takes one wakup
every few seconds or so to drain the battery significantly when
operating on suspend from idle.

> But really, I don't consider the "ill-behaved app" problem to be a
> real-world problem.  Both in maemo/meego and Android, if someone
> writes an app that kills battery life, it will get reported as a bug,
> or get bad ratings etc.  On these kinds of devices, there is a *stong*
> developer incentive to not write battery sucking apps.

I'm not sure this is real world, either.  Developers can fire up
powertop from the command line when their phone isn't idling for as long
as it should.  But a phone is a consumer device: the average smart phone
user just wants to browse the web, get email, go to facebook and play
with some cool apps.  If one of those cool apps is rogue, they're not
really going to know which one or how to find it (and firing up powertop
from the command line isn't something which will occur to them as a
matter of routine).

One of the nice things that suspend blockers actually does is to give
the kernel a clear name for the process blocking suspend (and thus
consuming power).  This allows a nice way to assign power budget to the
application and present who's using what in a nice visible form, which
does facilitate the reporting of bad apps, even for the non-developer
user.

James
