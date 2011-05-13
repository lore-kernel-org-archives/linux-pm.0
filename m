From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem
	on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 22:20:08 +0200
Message-ID: <201105132220.08760.rjw__7180.05724852464$1305318026$gmane$org@sisk.pl>
References: <201105120025.34531.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
	<20110513215413.3480d6b5@xenia.leun.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110513215413.3480d6b5@xenia.leun.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michael Leun <lkml20100708@newton.leun.net>
Cc: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, May 13, 2011, Michael Leun wrote:
> On Fri, 13 May 2011 19:39:51 +0200
> Tejun Heo <tj@kernel.org> wrote:
> 
> > Can you guys please take a look at bug#34692?  It seems to be the
> > same problem.
> > 
> >   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> > 
> > The offending commit seems to be 270dac35c2.  Does reverting it
> > resolves the problem for you guys too?
> 
> - Does not happen with 2.6.38.6
> 
> - Happens 100% of cases with 2.6.39-rc7 (connect ac adapter or suspend
>   to ram with ac connected and resume with ac disconnected)
> 
> - Reverting 270dac35c26433d06a89150c51e75ca0181ca7e4 fixes issue

I can confirm that.

Thanks,
Rafael
