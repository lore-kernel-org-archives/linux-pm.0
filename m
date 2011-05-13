From: Tejun Heo <tj@kernel.org>
Subject: Re: AHCI driver problem on ICH (Re: AHCI driver problem
 on SB700/SB800 w/ Acer Ferrari One)
Date: Fri, 13 May 2011 19:39:51 +0200
Message-ID: <BANLkTimqxmbpP1-+HxhPQS-YoLTh=bHd1Q__1039.58283220908$1305308552$gmane$org@mail.gmail.com>
References: <201105120025.34531.rjw@sisk.pl>
	<20110513143758.33f68a77@xenia.leun.net>
	<201105131856.44250.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105131856.44250.rjw@sisk.pl>
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
Cc: linux-ide@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Michael Leun <lkml20100708@newton.leun.net>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hello,

Can you guys please take a look at bug#34692?  It seems to be the same problem.

  https://bugzilla.kernel.org/show_bug.cgi?id=34692

The offending commit seems to be 270dac35c2.  Does reverting it
resolves the problem for you guys too?

Thanks.

--
tejun
