From: Michael Leun <lkml20100708@newton.leun.net>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem
 on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 21:54:13 +0200
Message-ID: <20110513215413.3480d6b5__15519.2207465463$1305564305$gmane$org@xenia.leun.net>
References: <201105120025.34531.rjw@sisk.pl>
	<20110513143758.33f68a77@xenia.leun.net>
	<201105131856.44250.rjw@sisk.pl>
	<BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q@mail.gmail.com>
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
Cc: linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 13 May 2011 19:39:51 +0200
Tejun Heo <tj@kernel.org> wrote:

> Can you guys please take a look at bug#34692?  It seems to be the
> same problem.
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=34692
> 
> The offending commit seems to be 270dac35c2.  Does reverting it
> resolves the problem for you guys too?

- Does not happen with 2.6.38.6

- Happens 100% of cases with 2.6.39-rc7 (connect ac adapter or suspend
  to ram with ac connected and resume with ac disconnected)

- Reverting 270dac35c26433d06a89150c51e75ca0181ca7e4 fixes issue

-- 
MfG,

Michael Leun
