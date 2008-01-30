From: Pavel Machek <pavel@ucw.cz>
Subject: Re: sleepy linux self-test
Date: Wed, 30 Jan 2008 17:39:09 +0100
Message-ID: <20080130163909.GA5395@elf.ucw.cz>
References: <20080130131748.GA3796@elf.ucw.cz> <20080130163511.GA30797@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760243AbYA3QjI@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080130163511.GA30797@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: kernel list <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed 2008-01-30 17:35:11, Ingo Molnar wrote:
> 
> * Pavel Machek <pavel@ucw.cz> wrote:
> 
> > Hi!
> > 
> > This version should work, at least it did not fail in my testing. It 
> > does one test 5 second after bootup, then periodically once per 500 
> > seconds. Different parameters are trivial to tweak.
> 
> nice - is nohz=off still needed? (if not, what was the problem with 
> nohz?)

Not needed, but I do not know where the nohz problem was. Waiting 5
seconds means userspace comes up and problem is somehow worked around.

The nohz problem was of the "you need to press keys to get forward
progress" -- the kind I tried to debug few times already :-(.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
