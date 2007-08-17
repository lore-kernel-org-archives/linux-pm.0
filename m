From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: Re: Storing Maintainers info around the kernel tree
Date: Fri, 17 Aug 2007 08:25:20 +0200
Message-ID: <46C53F50.9040107@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0708162156550.9927-100000@netrider.rowland.org>
	<46C5057C.5010602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <46C5057C.5010602@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Salikh Zakirov <salikh@gmail.com>, LKML Kernel <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Junio C Hamano <gitster@pobox.com>, Joe Perches <joe@perches.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, git@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Rene Herman wrote:
> On 08/17/2007 03:58 AM, Alan Stern wrote:
> 
>> On Fri, 17 Aug 2007, Rene Herman wrote:
>>
>>> On 08/16/2007 11:39 PM, Stefan Richter wrote:
>>>> Rene Herman wrote:
> 
>>>>> I personally don't think there's a whole lot wrong with more and
>>>>> more expecting people who submit patches (for whom this automation
>>>>> is intended) to be using git.
>>>>
>>>> You mean "people who frequently submit patches for various different
>>>> subsystems".
>>>
>>> Erm, I guess. Is that agreeing or disagreeing with me?
>>
>> Don't forget also that the MAINTAINERS information is (or should be!)
>> used by people who want to submit bug reports, not just by people who
>> submit patches.  Bug reporters shouldn't need to use Git.

Yes, problem reporters and people who infrequently (or for their first
time) submit patches, and even people who frequently submit patches but
most of the time only to the same one or two subsystems need an obvious,
tool-independent way to get contact information.

> Like I said:
> 
>>> If it's about non-developer users, I suspect it would to a fairly large
>>> degree be an "in theory" thing to expect that said user does want the
>>> information in a downloaded releases, but not in git, and not online
>>> where git-web could also easily display all the information right
>>> alongside the files.
> 
> And again, generating the MAINTAINERS file/info into releases is fine as
> well.

Good.  This generated data will be used by almost everyone except for a
certain special group of submitters.
-- 
Stefan Richter
-=====-=-=== =--- =---=
http://arcgraph.de/sr/
