From: Thomas Renninger <trenn@suse.de>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery
	lifetime on Windows
Date: Tue, 7 Sep 2010 18:43:55 +0200
Message-ID: <201009071843.55783.trenn__41945.5574280166$1283879473$gmane$org@suse.de>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
	<AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
	<20100907152246.GA12326@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100907152246.GA12326@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, cpufreq@vger.kernel.org, Tiago Marques <tiagomnm@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday 07 September 2010 17:22:46 Matthew Garrett wrote:
> On Mon, Sep 06, 2010 at 10:47:58PM +0100, Tiago Marques wrote:
> 
> > Yes, but shouldn't it detect P-States with different voltages, as in
> > windows? (even as stupid as this sounds) I sure loved to get it always
> > stuck at the lower clock, given that I usually perform maintenance on
> > PCs I highly doubt the fan would get dust clogged to the point of
> > taking the CPU to temperatures that would cause problems.
> > This looks like it doesn't support Speedstep even though Intel says it
> > does but the fact is that Windows can work with two voltages, which
> > always improves power.
> 
> If there's only one frequency then there's no reason to have multiple 
> voltages - the voltage will already be at the minimum possible for the 
> core to be stable at that frequency. Entering C4 will typically result 
> in the voltage dropping as parts of the core are disabled.
> 
> Does your chip have the "est" flag in /proc/cpuinfo? If not, it doesn't 
> support speedstep.
That is somewhat strange. These CPUs show est support in cpuinfo, also
compare with (not only about HP, but also other OEMs):
[Bug 16072] [HP Pavilion dm1-1110ev] Cpufreq doesn't work at all ( Intel Celeron U2300 )
https://bugzilla.kernel.org/show_bug.cgi?id=16072

But Tiago digged out an Intel spec which says that the SU processors do only
run at one freq:
http://www.intel.com/design/mobile/datashts/321111.pdf
page 30, note 10, at the top of the page.

I could imagine cpuid should not export est capabilities for these and
cpufreq drivers should not complain that an est capable CPU is found for
which no frequencies get exported, but probably only Intel can tell for
sure.

     Thomas
