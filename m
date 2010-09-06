From: "M. Vefa Bicakci" <bicave@superonline.com>
Subject: Important news regarding the two different patches
Date: Mon, 06 Sep 2010 07:27:38 -0400
Message-ID: <4C84D02A.7070508__12190.143709495$1283772534$gmane$org@superonline.com>
References: <20100903105216.B65C.A69D9226@jp.fujitsu.com>
	<201009040344.42342.rjw@sisk.pl>
	<20100906090528.C8A9.A69D9226@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100906090528.C8A9.A69D9226@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>
Cc: linux-pm@lists.linux-foundation.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/09/10 10:08 PM, KOSAKI Motohiro wrote:
>>> ok, thanks. probably I've catched your point. please feel free to use my reviewed-by
>>> for your fix.
>>
>> Thanks.
>>
>> In the meantime, though, I prepared a patch that should address the issue
>> entirely.  The patch is appended and if it looks good to you, I'd rather use it
>> instead of the previous one (it is still untested).
> 
> Yeah, this one looks nicer to me :)
> 
> Thanks, rafael!

Dear Rafael Wysocki, Kosaki Motohiro and Minchan Kim,

Upon Kosaki Motohiro's kind request via an off-list e-mail,
I tested the following two patches separately with a vanilla
2.6.35.4 kernel:

Patch 1:
	http://lkml.org/lkml/2010/9/5/86

Patch 2:
	http://kerneltrap.org/mailarchive/linux-kernel/2010/9/4/4615426

The first of these was prepared by Minchan Kim, and it fixes
the issue; i.e. no hangs during hibernation with a full tmpfs.

However, the second patch, prepared by Rafael Wysocki, does *not*
fix the problem. I still experience hangs with a full tmpfs upon
hibernation.

As always, I am willing to test newer patches and help in debugging
this issue.

I really appreciate all of your help,

M. Vefa Bicakci
