From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.33-rc6 crashes on resume
Date: Wed, 10 Feb 2010 01:46:19 +0100
Message-ID: <201002100146.19955.rjw__31399.5820506991$1265762808$gmane$org@sisk.pl>
References: <4B70982F.8090208@roadwarrior3.tmr.com>
	<201002090009.50118.rjw@sisk.pl> <4B71EBD8.8070406@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B71EBD8.8070406@tmr.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Bill Davidsen <davidsen@tmr.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday 10 February 2010, Bill Davidsen wrote:
> Rafael J. Wysocki wrote:
> > On Tuesday 09 February 2010, Bill Davidsen wrote:
> >> Pretty simple to reproduce, boot, suspend, press shift
> >>
> >> Acer Aspire 1681, Celeron, 2.6.33-rc6. Trace and config attached.
> > 
> > I guess 2.6.32 didn't crash?
> > 
> Wasn't testing. 2.6.32.5 didn't crash, later Fedora kernels kill the touchpad, I 
> can dig up the old bugzilla if you can't find it.

Well, so it seems something during the 2.6.33 merge window broke things for
you.

Unfortunately there have been quite a few resume regressions of all sorts in
this cycle, so bisecting that might be difficult.  That said, bisection would
probably be the fastest way of debugging this issue.

Rafael
