From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: Is it supposed to be ok to call del_gendisk while
 userspace is frozen?
Date: Tue, 25 May 2010 07:21:13 +1000
Message-ID: <4BFAEDC9.1010707__20327.2716644735$1274736116$gmane$org@crca.org.au>
References: <Pine.LNX.4.44L0.1005162219330.24400-100000@netrider.rowland.org>
	<4BF0F3FF.2010603@crca.org.au> <201005172235.37824.rjw@sisk.pl>
	<4BF1C86B.8000203@crca.org.au> <20100524190206.GL1292@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100524190206.GL1292@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Matt Reimer <mattjreimer@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi.

On 25/05/10 05:02, Pavel Machek wrote:
>
>>>> - We're dealing with the symptom, not the cause. Almost always a bad idea.
>>>
>>> I very much prefer to have a fix for a symptom than no fix at all, which is the
>>> realistic alternative in this case.
>>>
>>> So, I think we should merge the patch and if someone finds the root cause
>>> at one point in future, then we can just use the *right* approach instead of
>>> the present one.
>>>
>>> The problem is real and people in the field are affected by it, so if you don't
>>> have a working alternative patch, please just let go.
>>
>> I'm not denying that the problem is real. What I am concerned about
>> is finding a real solution, not just putting a sticky plaster over
>> the wound. It seems to me to be much wiser to deal with the issue
>> properly now instead of doing extra work later to diagnose what
>> might be a harder to reproduce symptom of the same problem. I'd
>> happily put the time in now myself, but I simply don't have the time
>> this week.
>>
>> Would it be possible to apply the patch, adding some sort of new tag
>> that can be used to say "This needs further attention", perhaps
>> including an enduring reference to this conversation. Later, the
>> 'real' fix could include another special tag that says "Proper fix
>> for the symptom addressed in commit 5e94f810"?
>
> WARN_ON() whenever patch triggers?

I suppose that would do. I was thinking of a more generic git tag that 
could perhaps be searched for later, but .. okay.

Nigel
