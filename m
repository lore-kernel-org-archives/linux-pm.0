From: Rene Herman <rene.herman@gmail.com>
Subject: Re: [PATCH] [443/2many] MAINTAINERS - HIBERNATION (aka
 Software Suspend, aka swsusp):
Date: Tue, 14 Aug 2007 20:25:43 +0200
Message-ID: <46C1F3A7.3090007__46721.7342732058$1187117562$gmane$org@gmail.com>
References: <46bffbd3.IqsNHrHU1Y9BF7Dd%joe@perches.com>
	<200708132338.25925.rjw@sisk.pl> <20070814070528.GA2903@elf.ucw.cz>
	<200708141937.06676.rjw@sisk.pl>
	<1187114231.32555.105.camel@localhost>
	<alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.0.999.0708141112110.30176@woody.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>, Joe Perches <joe@perches.com>, linux-pm@lists.linux-foundation.org, akpm@linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 08/14/2007 08:15 PM, Linus Torvalds wrote:

> Quite frankly, I think the MAINTAINERS file gets a whole lot uglier this 
> way.
> 
> There's also a rather fundamental issue: this will likely make people 
> touch the MAINTAINERS file *more*, and from a maintenance standpoint, that 
> is exactly the wrong thing to have (one central file that everybody 
> touches). It just tends to generate unnecessary merge conflicts etc. 
> 
> (We used to have that issue with the central configuration file, for 
> example).
> 
> So the more I look at these things, the more convinced I am that this is 
> not the right thing to do. These things should *not* be in one huge file, 
> and I'd much much rather have the maintainership information be carried 
> along with the subsystem itself, or the files it contains.
> 
> In other words, it would be much better to just have per-file markers, 
> along with some per-subdirectory stuff or similar.

Joe just now convinced me that rather than the per-file markers, the marker 
is meta-information that could just be stored in GIT, with the MAINTAINERS 
file turning into something generated.

git info --maintainer and such (for many possible kinds of --flags) would 
throw out the information.

Rene.
