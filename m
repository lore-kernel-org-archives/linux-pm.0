From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem
	on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 22:44:29 +0200
Message-ID: <201105132244.29605.rjw__47080.3891229027$1305319536$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<201105132222.11582.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105132222.11582.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Friday, May 13, 2011, Rafael J. Wysocki wrote:
> On Friday, May 13, 2011, Tejun Heo wrote:
> > Hello,
> > 
> > Can you guys please take a look at bug#34692?  It seems to be the same problem.
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> 
> Yes, same issue.
> 
> > The offending commit seems to be 270dac35c2.  Does reverting it
> > resolves the problem for you guys too?
> 
> Yes, it does.

Would you object if I asked Linus to revert that commit?

Rafael
