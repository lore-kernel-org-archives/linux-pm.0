From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: sleepy linux self-test
Date: Sun, 3 Feb 2008 23:43:52 +0100
Message-ID: <200802032343.53319.rjw__34843.1542436176$1202078846$gmane$org@sisk.pl>
References: <20080130131748.GA3796@elf.ucw.cz> <200802032229.30576.rjw@sisk.pl>
	<20080203224206.8FD40166811@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080203224206.8FD40166811@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: mingo@elte.hu, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, 3 of February 2008, David Brownell wrote:
> > > See the appended; it includes more of Ingo's suggestions.
> > > 
> > > Since this is increasingly unrelated to the "sleepy linux" concept
> > > (a version of what systems like OLPC, N700, and N800 are doing), I
> > > got rid of the "sleepy.c" file.
> >
> > The changes look good to me.
> 
> They feel unfinished to me though.  :)
> 
> Like using "jiffies" instead of a clocksource, which makes trouble
> since the timing covers periods with IRQs disabled.  And the test
> mode parameter needs work.
> 
> 
> > Well, it would be nice to have this feature in as soon as reasonably possible,
> > so that people can include suspend tests in the automated testing.
> 
> Except ... "rtcwake" (from util-linux-ng) already supports such
> testing, albeit from userspace.   But not the timing tests.
> 
> What was the rationale for wanting this done in-kernel?  (Other
> than to know it can work portably.)

Ingo wants it for automated testing not involving user space modifications.

Thanks,
Rafael
