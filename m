From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 5/9] PM: suspend_block: Add debugfs file
Date: Sun, 25 Apr 2010 17:50:28 -0700
Message-ID: <4BD4E354.6010803__26446.8560847037$1272243426$gmane$org@oracle.com>
References: <1271984938-13920-2-git-send-email-arve@android.com>
	<1271984938-13920-3-git-send-email-arve@android.com>
	<1271984938-13920-4-git-send-email-arve@android.com>
	<1271984938-13920-5-git-send-email-arve@android.com>
	<1271984938-13920-6-git-send-email-arve@android.com>
	<20100423135853.478af057.randy.dunlap@oracle.com>
	<20100425181517.GA22676@kroah.com>
	<4BD49D9D.7020004@oracle.com> <20100426000025.GE667@thunk.org>
	<4BD4DCEA.8060602@oracle.com> <20100426004558.GA13043@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100426004558.GA13043@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu, Greg KH <greg@kroah.com>, Arve Hj?nnev?g <arve@android.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 04/25/10 17:45, tytso@mit.edu wrote:
> On Sun, Apr 25, 2010 at 05:23:06PM -0700, Randy Dunlap wrote:
>> Yeah, I think that it should be in procfs.  It's not strictly closed
>> to new files.  (IOW, I'm sure that we can find a bunch of recent files
>> added to procfs.)
> 
> That's reasonable (I think the whole /proc is evil crusade is really
> dumb) --- but at the same time, remember how frustrating it is for the
> poor embedded developer who doesn't know who to ignore and what
> "rules" to ignore.  They were told months ago /proc is evil, and so
> they moved it to /debugfs, precisely because it was billed as "it has
> no rules".  For all I know some helpful community developer may have
> even suggested that to them.
> 
> It is extremely frustrating to embedded developers when they get
> conflicting advice, especially in this case, when it was *in* /proc in
> the first place.  I'm not sure what to do about this --- my approach
> is to sometimes say, "f*ck it, that's stupid advice", and ship it to
> Linus, who tends to be *much* less of a pendant than most of the
> people who review code --- but that's because I know what I can
> ignore.  (I seriously doubt Linus cares much about whether it ends up
> the file ends up /debugfs or /proc, and would take the code either
> way.)  But for someone who doesn't understand when you can do this,
> and who tries to follow every single piece of criticism they get, the
> end result can often be a huge amount fo wasted time and frustration.
> 
> It would be nice if we could get better at this, since I'm sure this
> is not the only time when embedded code submissions have gotten what
> the submitting developers might consider to be a runaround....

Agreed, we could/should do much better.
Agreed, I'm sure that it is frustrating to the contributors.
Agreed about Linus taking it either way.  :)

Thanks for your summary and bringing it up (yet again).

> (And just to be clear, I'm not criticising your commends; my personal
> preference is slightly in favor of /proc, but more than anythign else,
> I consider it a very minor point.  I just want to point out that they
> _started_ with the file in /proc and changed it to /debugfs based on
> someone NACK'ing their patch, with a "/proc, eeeeewwww" comment.
> Sometimes I think some code reviewers get too much of a sense of power
> trip by thinking they can NACK other people's code over their own pet
> peeves.... instead of approaching it from a somewhat more collegial
> point of view trying to make the code better.  Present company
> excepted, of course.  :-)


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
