From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/8] PM: Add suspend block api.
Date: Fri, 21 May 2010 00:27:31 +0200
Message-ID: <201005210027.31910.rjw__40346.1390677423$1274394416$gmane$org@sisk.pl>
References: <1272429119-12103-1-git-send-email-arve@android.com>
	<20100430172618.GA9043@redhat.com> <4BF4F31D.8070900@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4BF4F31D.8070900@kernel.org>
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
Cc: Len Brown <len.brown@intel.com>, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Oleg Nesterov <oleg@redhat.com>, Magnus Damm <damm@igel.co.jp>, linux-pm@lists.linux-foundation.org, Wu Fengguang <fengguang.wu@intel.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 20 May 2010, Tejun Heo wrote:
> Hello,
> 
> (sorry about late reply)
> 
> On 04/30/2010 07:26 PM, Oleg Nesterov wrote:
> > Currently _cpu_down() can't flush and/or stop the frozen cwq->thread.
> > 
> > IIRC this is fixable, but needs the nasty complications. We should
> > thaw + stop the frozen cwq->thread, then move the pending works to
> > another CPU.
> 
> Oh, this isn't an issue w/ cmwq.  While frozen all new works are
> collected into per-cpu delayed worklist and while frozen trustee in
> charge of the cpu will keep waiting.  Once thawed, trustee will
> execute all works including the delayed ones unbound to any cpu.

So, does it require any intrusive changes to make it possible to create
multithread freezable workqueues?

Rafael
