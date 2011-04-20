From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: /proc/acpi/wakeup regression in 2.6.39-rc3
Date: Wed, 20 Apr 2011 22:34:12 +0200
Message-ID: <201104202234.12742.rjw__33806.4623218544$1303331670$gmane$org@sisk.pl>
References: <201104150053.37037.rjw@sisk.pl> <20110419202212.GA15438@mac.home>
	<201104192328.52652.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104192328.52652.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, April 19, 2011, Rafael J. Wysocki wrote:
> On Tuesday, April 19, 2011, Tino Keitel wrote:
> > Hi,
> > 
> > I reverted some wakeup and ACPI related commits. When I reverted commit
> > 7fa69baf29de8c77a6b32c054df2abb8f11f8aa4, wakeup using the keyboard
> > worked again and /proc/acpi/wakeup behaved as expected.
> 
> Oh, I doubt that this particular one is the problem.
> 
> > So check this, I reverted the following commits to avoid conflicts and
> > build failures:
> > 
> > c19f9a84ec807da57fd75bbd9a3f2b8269611f79
> > 5190726765b40774c069e187a958e10ccd970e65
> > 2a5d24286e8bdafdc272b37ec5bdd9e977b3767c
> > f2b56bc808addb908a5bf435d9b942c02af9a7c4
> > 7fa69baf29de8c77a6b32c054df2abb8f11f8aa4
> 
> OK, thanks for narrowing this down, I'll have a look at it shortly.

I can reproduce the problem, but it seems to affect USB controllers only
and, interestingly enough, it doesn't affect the EHCI controller on my test
system.  So, it seems to be specific to USB at least to some extent.

Thanks,
Rafael
