From: Chuck Ebbert <cebbert@redhat.com>
Subject: Re: [PATCH] writeback: avoid possible
 balance_dirty_pages() lockup on a light-load bdi
Date: Tue, 02 Oct 2007 14:35:49 -0400
Message-ID: <47028F85.4030708@redhat.com>
References: <92cbf19b0709272332s25684643odaade0e98cb3a1f4@mail.gmail.com>
	<391063897.19256@ustc.edu.cn> <470118EE.1020103@redhat.com>
	<391290444.23950@ustc.edu.cn>
	<20071001191457.2f7c7538.akpm@linux-foundation.org>
	<20071002121327.GA5718@mail.ustc.edu.cn>
	<391331626.16970@ustc.edu.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <391331626.16970@ustc.edu.cn>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Fengguang Wu <wfg@mail.ustc.edu.cn>
Cc: Chakri n <chakriin5@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Krzysztof Oledzki <olel@ans.pl>, Andrew Morton <akpm@linux-foundation.org>, richard kennedy <richard@rsk.demon.co.uk>, linux-pm <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 10/02/2007 09:27 AM, Fengguang Wu wrote:
> On Tue, Oct 02, 2007 at 08:13:27PM +0800, Fengguang Wu wrote:
> [...]
>> One more serious problem is, a busy writer could also drain all the
>> dirty pages and make (nr_writeback == dirty_limit+1MB). In that case,
>> I suspect the light-load sdb writer still have good chance to
>> make progress(need confirmation).
> 
> Well it seems to be a really tricky issue without knowing the per-bdi
> numbers. Maybe we could just encourage users to upgrade to 2.6.24...
> 

Yeah, and if that doesn't work there's always 2.6.25... :/
