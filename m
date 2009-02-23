From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during	suspend-resume
Date: Mon, 23 Feb 2009 13:45:03 +0100
Message-ID: <20090223124503.GC31427__311.416624072258$1235393285$gmane$org@elte.hu>
References: <200902221837.49396.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
	<20090223083645.GA9582@elte.hu> <200902231229.58743.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902231229.58743.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Johannes Berg <johannes@sipsolutions.net>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > > +resume_devices:
> > > +	resume_device_irqs();
> > 
> > Small style nit: labels should start with a space character. 
> > I.e. it should be:
> 
> I know, but the second label in there starts without a space 
> character and IMO keeping a uniform coding style i a single 
> file is more important than trying to adjust it to a broader 
> set of rules FWIW. [...]

Even though it's just a very small and insignificant detail 
(nowhere described in the CodingStyle), barely worth the mention 
(and i already regret having brought it up at all), what you say 
is wrong on a conceptual level and that alarms me a bit ;-)

It is exactly these kinds of "my code, my style!" world view 
that results in a crappy overall kernel style.

For a single file to look consistent is just the first (and 
required) step, what matters even more is for files to have 
similar coding patterns, to make the style as helpful to the 
general kernel developer/reviewer/bug-fixer/maintainer as 
possible.

"code with a helpful style" here means two things:

1) it should understand and adhere to basic style principles. 
   This is just an (often arbitrary) subset of the infinite set 
   of reasonable style guides. The most common-sense ones are
   written down in Documentation/CodingStyle. There's a lot of 
   leeway, as long as the basic principle of "be helpful" is
   understood and followed.

2) it should carry meta information outside of the language 
   syntax and it should build expectations about a code's 
   purpose and general structure.

   That is essential so that we can find bugs during review.

   If each file has a slightly different style to express labels 
   then that means we insert extra entropy and degrades and 
   obfuscates the true meat of the code and hurts the overall 
   reviewability of the code.

In practical terms: i noticed that weird label - otherwise i 
would not have commented on it. I noticed it because it had the 
pattern of a comment block (most comment blocks start with 
capital letters, and for that good reason).

It was completely unnecessary for me to notice that label - it 
carries no information about the patch itself. Ergo, it would be 
better in the long run if code does not raise unnecessary mental 
exceptions. We have a limited set of exceptions we are able to 
handle during review, lets make sure we use them sparingly.

Sure, there will always be borderline cases where we'll have to 
agree to disagree, even if we agree about the general principle.

But this is not one of those cases - having a "Suspend:" 
capitalized label is not something you added to enhance the 
basic coding style - it is something very uncommon and 
self-serving which you added in _spite_ of the general 
principles i believe. It has no other message beyond "I do this 
because i can!".

I.e. it is not helpful at all. When it comes to coding style the 
kernel is not a democracy at all.

> [...]  I also think that coding style changes shouldn't be 
> mixed with functional changes as far as reasonably possible.

Sure, you got that drive-by review for free, by virtue of 
context diffs ;-)

	Ingo
