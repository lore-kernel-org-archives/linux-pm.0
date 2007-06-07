From: Pavel Machek <pavel@ucw.cz>
Subject: Re: 2.6.22-rc3 hibernate(?) fails totally - regression
	(xfs on raid6)
Date: Thu, 7 Jun 2007 20:12:58 +0000
Message-ID: <20070607201258.GB10323@ucw.cz>
References: <200706012342.45657.rjw@sisk.pl> <46609FAD.7010203@dgreaves.com>
	<200706020122.49989.rjw@sisk.pl> <4661EFBB.5010406@dgreaves.com>
	<alpine.LFD.0.98.0706021538360.23741@woody.linux-foundation.org>
	<4662D852.4000005@dgreaves.com> <46667160.80905@gmail.com>
	<46668EE0.2030509@dgreaves.com> <46679D56.7040001@gmail.com>
	<4667DE2D.6050903@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4667DE2D.6050903@dgreaves.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Greaves <david@dgreaves.com>
Cc: Tejun Heo <htejun@gmail.com>, Neil Brown <neilb@suse.de>, linux-pm <linux-pm@lists.osdl.org>, "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>, xfs@oss.sgi.com, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> >How hard does the machine freeze?  Can you use sysrq?  
> >If so, please
> >dump sysrq-t.
> I suspect there is a problem writing to the consoles...
> 
> I recompiled (rc4+patch) with sysrq support, suspended, 
> resumed and tried sysrq-t but got no output.
> 
> I *can* change VTs and see the various login prompts, 
> bitmap messages and the console messages. Caps/Num lock 
> lights work.
> 
> Fearing incompetence I tried sysrq-s sysrq-u sysrq-b and 
> got a reboot so sysrq is OK.

Increase console loglevel by killing klogd/sysrq-9?

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
