From: Bruno Ducrot <ducrot@poupinou.org>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Wed, 10 Aug 2005 14:58:48 +0200
Message-ID: <20050810125848.GM852@poupinou.org>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
	<20050810100133.GA1945@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
Content-Disposition: inline
In-Reply-To: <20050810100133.GA1945@elf.ucw.cz>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Pavel Machek <pavel@ucw.cz>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 10, 2005 at 12:01:33PM +0200, Pavel Machek wrote:
> Hi!
> 
> > Minimal PowerOP support for Intel Enhanced Speedstep "Centrino"
> > notebooks.  These systems run at an operating point comprised of a cpu
> > frequency and a core voltage.  The voltage could be set from the values
> > recommended in the datasheets if left unspecified (-1) in the operating
> > point, as cpufreq does.
> 
> Eh? I thought these are handled okay by cpufreq already? What is
> advantage of this over cpufreq?

ATM I'm wondering what are the pro for those patches wrt current cpufreq
infrastructure (especially cpufreq's notion of notifiers).

I still don't find a good one but I'm surely missing something obvious.

-- 
Bruno Ducrot

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
