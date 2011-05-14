From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem
 on SB700/SB800 w/ Acer Ferrari One)
Date: Sat, 14 May 2011 12:18:07 +0200
Message-ID: <20110514101807.GA23665__9655.18399975753$1305368458$gmane$org@htj.dyndns.org>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl> <201105132244.29605.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201105132244.29605.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Jeff Garzik <jgarzik@pobox.com>, Jian Peng <jipeng2005@gmail.com>
Cc: linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

On Fri, May 13, 2011 at 10:44:29PM +0200, Rafael J. Wysocki wrote:
> On Friday, May 13, 2011, Rafael J. Wysocki wrote:
> > On Friday, May 13, 2011, Tejun Heo wrote:
> > > Hello,
> > > 
> > > Can you guys please take a look at bug#34692?  It seems to be the same problem.
> > > 
> > >   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> > 
> > Yes, same issue.
> > 
> > > The offending commit seems to be 270dac35c2.  Does reverting it
> > > resolves the problem for you guys too?
> > 
> > Yes, it does.
> 
> Would you object if I asked Linus to revert that commit?

Not at all.  I think that's the best option at this point.  I'll send
revert patch right now.

Thanks.

-- 
tejun
