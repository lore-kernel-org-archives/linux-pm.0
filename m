From: David Newall <davidn@davidnewall.com>
Subject: Re: Fundamental flaw in system suspend,
 exposed by freezer removal
Date: Wed, 27 Feb 2008 00:06:50 +1030
Message-ID: <47C415F2.2060905__40718.8987861902$1204041588$gmane$org@davidnewall.com>
References: <Pine.LNX.4.44L0.0802251439030.5536-100000@iolanthe.rowland.org>
	<200802252313.23399.david-b@pacbell.net>
	<47C3CD15.1060908@davidnewall.com>
	<200802260116.18142.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802260116.18142.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> On Tuesday 26 February 2008, David Newall wrote:
>   
>> Hardware can be inserted and removed while we're in a suspend state; and
>> there's nothing that we can do about it until we resume.  Is it fair to
>> say, then, that having started suspend, we could reasonably ignore any
>> device insertion and removal, and handle it on resume?
>>     
>
> "Ignore" seems a bit strong; those events may be wakeup triggers,
> which would cause the hardware to make it a very short suspend state.
>
> "Defer handling" is more to the point, be it by hardware or software.
>
>   

Of course, "defer".  The insertion has to be handled eventually.  What
I'm wondering is if we can ignore it, and catch it on the resume.


>> Presumably we need to scan for hardware changes on resume.
>>     
>
> Not on most busses I work with; the hardware issues notifications
> whenever the devices are removable.
>   

There's no notification while we're suspended.  Isn't it necessary to
scan all busses on resume, just to know what's on them?
