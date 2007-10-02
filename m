From: Fengguang Wu <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH] writeback: avoid possible
	balance_dirty_pages() lockup on a light-load bdi
Date: Tue, 2 Oct 2007 21:27:02 +0800
Message-ID: <20071002132702.GA10967__46646.9087558382$1191331702$gmane$org@mail.ustc.edu.cn>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<391063897.19256@ustc.edu.cn> <470118EE.1020103@redhat.com>
	<391290444.23950@ustc.edu.cn>
	<20071001191457.2f7c7538.akpm@linux-foundation.org>
	<20071002121327.GA5718@mail.ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Message-ID: <20071002132702.GA10967@mail.ustc.edu.cn>
Content-Disposition: inline
In-Reply-To: <20071002121327.GA5718@mail.ustc.edu.cn>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Chakri n <chakriin5@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Chuck Ebbert <cebbert@redhat.com>, Krzysztof Oledzki <olel@ans.pl>, linux-pm <linux-pm@lists.linux-foundation.org>, richard kennedy <richard@rsk.demon.co.uk>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 02, 2007 at 08:13:27PM +0800, Fengguang Wu wrote:
[...]
> One more serious problem is, a busy writer could also drain all the
> dirty pages and make (nr_writeback == dirty_limit+1MB). In that case,
> I suspect the light-load sdb writer still have good chance to
> make progress(need confirmation).

Well it seems to be a really tricky issue without knowing the per-bdi
numbers. Maybe we could just encourage users to upgrade to 2.6.24...
