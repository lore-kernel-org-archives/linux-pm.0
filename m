From: Matt Price <moptop99@gmail.com>
Subject: Re: [TuxOnIce-devel] [RFC] TuxOnIce
Date: Sat, 16 May 2009 22:53:22 -0400
Message-ID: <f22f52180905161953t6248e60fg3f6732a04d59b406__33241.4173790768$1242528903$gmane$org@mail.gmail.com>
References: <1241620755-22133-1-git-send-email-nigel@tuxonice.net>
	<200905162107.58677.Martin@lichtvoll.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200905162107.58677.Martin@lichtvoll.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Martin Steigerwald <Martin@lichtvoll.de>
Cc: linux-pm@lists.linux-foundation.org, tuxonice-devel@lists.tuxonice.net, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sat, May 16, 2009 at 3:07 PM, Martin Steigerwald <Martin@lichtvoll.de> wrote:
> Am Mittwoch 06 Mai 2009 schrieb Nigel Cunningham:
>> I'd like to submit TuxOnIce for review, with a view to seeking to get
>> it merged, perhaps in 2.6.31 or .32 (depending upon what needs work
>> before it can be merged) and the willingness of those who matter.
>>
>> To briefly summarise the advantages to merging TuxOnIce:
>
> As a user I support this.
>
> Why?
>
> Cause everytime I tried TuxOnIce just worked while I had various problems
> whenever I tried out any in-kernel snapshot stuff, be it hard-wired or
> userspace supported. Actually I never could have been bothered to try out
> to fix any issues with these while I just had a working solution and
> thats TuxOnIce. Might have been that issues could have been fixed - but
> exactly why should I care when I have something that just works? Honestly
> I can't even be bothered to remember those issues in detail. It was
> crashes, hangs and on the last occurence of testing mostly slowness while
> it basically worked mostly. Release versions of TuxOnIce didn't fail for
> me as long as I can remember.
>
just to amplify on this a little bit:  as a user, I found that
whatever problems I ran into with TuxOnIce I could actually get fixed.
 This has been a result of :
a) a lively user/dev community of people, obviously including Nigel
himself, who take each other's problems issues seriously; and
b) dramatically superior debugging information provided by the
tuxonice implementation.  when something fails with tuxonice, it's
quite easy to narrow down the issue.  with swsusp, my experience has
always been that there's more or less no log information to work with;
and if you do have the luck to have some usable info in your logs,
there's no one around willing to help you figure the problem out
anyway.

one of the real frustrations i've had watching this process from the
sidelines is that those with the authority to make decisions have
never taken either of these very important concerns seriously.  And
until they do, I do think it's quite likely that suspend-to-disk will
continue in its largely-broken state for quite some time to come.

matt
