From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: PowerOP 2/3: Intel Centrino support
Date: Wed, 10 Aug 2005 15:53:05 -0700
Message-ID: <42FA8551.3010002@mvista.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>
	<20050810100133.GA1945@elf.ucw.cz>
	<20050810125848.GM852@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <20050810125848.GM852@poupinou.org>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: Bruno Ducrot <ducrot@poupinou.org>
Cc: cpufreq@lists.linux.org.uk, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

Bruno Ducrot wrote:
  > ATM I'm wondering what are the pro for those patches wrt current cpufreq
> infrastructure (especially cpufreq's notion of notifiers).
> 
> I still don't find a good one but I'm surely missing something obvious.

This is lower layer than cpufreq, intended for use by cpufreq (and 
potentially DPM and other frameworks, although moving embedded to use 
cpufreq is certainly an option) to do the actual hardware modifications 
at the lowest layer.  There are no notifiers et al because the 
higher-layer frameworks handle that portion of it.  More on that in a 
moment.

The main goal is to open up interfaces to operating points comprised of 
arbitrary power parameters, as an alternative to the "cpu frequency" 
parameter that cpufreq is designed around.  In the desktop/server world 
this may not be a high concern for two reasons: (1) although various 
folks do want to manage voltages separately (namely so-called 
"undervolting"), in most cases the safe answer is to stick with a 
voltage preprogrammed into cpufreq that matches what the silicon vendor 
as validated and supports; (2) various additional clocks, dividers, etc. 
potential power parameters might exist in the hardware, but interfaces 
for software control are often not readily available, and the associated 
parameters are typically set once by the BIOS at boot time (possibly 
with a menu to allow you override the defaults).

In the embedded world, however, silicon vendors typically produce 
hardware that are run by, and specify validated operating points that 
are comprised of, 6-7 basic parameters (clocks, voltages, dividers, 
etc.), and in many cases it is useful to manage all these parameters for 
additional battery savings at runtime (and these systems are often 
powered by much smaller batteries than the notebooks powered by 
desktop-class processors, and so more aggressive reductions in power 
consumption may be pursued).  Similar interfaces are already in use for 
managing such hardware, with benefits that largely depend on the 
capabilities of the hardware (in the case of the IBM PowerPC 405LP for 
which it was originally developed this was pretty extensively studied).

It is possible, of course, to choose operating points according to cpu 
frequency and hardcode the settings of other power parameters to match, 
restricting the choices for the other parameters.  There are, however, 
power consumption and performance (primarily latency of transition 
between operating points) advantages to being able to choose memory bus 
speeds, core PLL speeds, voltages (yes, some embedded platforms do allow 
this to be chosen within limits imposed by other clock speeds), etc. 
The embedded hardware designers could probably express this more 
eloquently than I can.

A secondary goal is to separate the code to perform platform-specific 
hardware modifications from the upper layers which by necessity carry 
various assumptions that may not be appropriate for all situations.  The 
notifiers are one example of this: DPM typically minimizes use of 
notifiers and requires notifiers to be able to operate in interrupt and 
in idle loop context, due to those additional situations in which DPM 
manages power parameters.

-- 
Todd
