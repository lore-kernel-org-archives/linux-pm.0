From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: [RFC][PATCH 0/4] Rework disabling of interrupts
	during suspend-resume
Date: Fri, 6 Mar 2009 06:47:40 +0000
Message-ID: <20090306064740.GA20587__39258.3275250674$1236359329$gmane$org@silver.sucs.org>
References: <200902221837.49396.rjw@sisk.pl> <200903012321.40328.rjw@sisk.pl>
	<alpine.LFD.2.00.0903051542270.19207@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0903051542270.19207@localhost.localdomain>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Johannes Berg <johannes@sipsolutions.net>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 05, 2009 at 03:44:22PM -0800, Linus Torvalds wrote:
> 
 Side note - I've tested them on the EeePC that had trouble resuming due to 
> interrupt timings, and it suspends and resumes fine with these patches 
> (modulo some new X problems, but that's what I get for living with 
> Fedora-11 testing).

Since you have an EeePC I'm guessing your graphics card is an i9xx of
some variety. The i9xx kernel driver seems to have been recently
reworked so even those people who aren't using GEM yet are seeing issues
here and there (some with VT switching, some with suspend to ram and
others with suspend to disk). I actually don't know if the stuff poping
up is any more than usual but if so I'm hoping most new issues go away
once the dust settles...

-- 
Sitsofe | http://sucs.org/~sits/
