From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: s2disk hang update
Date: Tue, 16 Feb 2010 11:09:32 +0000
Message-ID: <9b2b86521002160309g26d60bd2t4c19bd2294b76c28__1629.03906680203$1266318648$gmane$org@mail.gmail.com>
References: <9b2b86521001020703v23152d0cy3ba2c08df88c0a79@mail.gmail.com>
	<9b2b86521002030314s6f84b482v8cd680be556f8a4d@mail.gmail.com>
	<4B718F11.2010402@tuffmail.co.uk> <201002160008.51875.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002160008.51875.rjw@sisk.pl>
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
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel <linux-kernel@vger.kernel.org>, hugh.dickins@tiscali.co.uk, pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 2/15/10, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday 09 February 2010, Alan Jenkins wrote:
>> Perhaps I spoke too soon.  I see the same hang if I run too many
>> applications.  The first hibernation fails with "not enough swap" as
>> expected, but the second or third attempt hangs (with the same backtrace
>> as before).
>>
>> The patch definitely helps though.  Without the patch, I see a hang the
>> first time I try to hibernate with too many applications running.
>
> Well, I have an idea.
>
> Can you try to apply the appended patch in addition and see if that helps?
>
> Rafael

It doesn't seem to help.

Thanks
Alan
