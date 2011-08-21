From: Tejun Heo <tj@kernel.org>
Subject: Re: [GIT PULL pm-next] freezer: fix various bugs and
 simplify implementation
Date: Sun, 21 Aug 2011 11:12:00 +0200
Message-ID: <20110821091200.GB24151__28691.1429990598$1313917982$gmane$org@htj.dyndns.org>
References: <20110820094434.GA24151@htj.dyndns.org>
	<201108201833.39089.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201108201833.39089.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: arnd@arndb.de, paul@paulmenage.org, lizf@cn.fujitsu.com, linux-kernel@vger.kernel.org, oleg@redhat.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hello, Rafafel.

On Sat, Aug 20, 2011 at 06:33:38PM +0200, Rafael J. Wysocki wrote:
> >   ssh://master.kernel.org/pub/scm/linux/kernel/git/tj/misc.git freezer
> 
> Pulled and stored in the pm-freezer branch in my tree, and merged into
> the linux-next branch.

Cool.

> > FYI, this patchset will cause a conflict with s390 TIF flag fix patch.
> > The conflict is trivial and Stephen should be able to handle it
> > without any problem.  Also, I'm planning on doing some further work on
> > cgroup freezer and then will try to bridge it with job control.  If
> > that plan fans out, I might ask Oleg to pull from the pm tree.
> 
> I'm not sure if Linus likes it.  He generally doesn't want the trees
> that he pulls from to be entangled this way.

The job control portion has to go through Linus anyway, so let's see
how that flies.

> > This shouldn't matter too much either way but it *might* be a good idea to
> > keep this line of patches in a separate branch.
> 
> I'm going to keep it in the pm-freezer branch anyway (there may be patches
> on top of it, though)

Yeah, I'm pretty sure it will need some fix too.

Thanks.

-- 
tejun
