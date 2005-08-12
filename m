From: Nikolay Pelov <ns@pelov.name>
Subject: Re: [linux-pm] Re: PowerOP 2/3: Intel Centrino support
Date: Fri, 12 Aug 2005 14:38:43 +0200 (MEST)
Message-ID: <Pine.GSO.4.10.10508121406280.26851-100000@billie.cs.kuleuven.ac.be>
References: <20050810184445.GB14350@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk>
In-Reply-To: <20050810184445.GB14350@redhat.com>
List-Unsubscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.linux.org.uk/mailman/private/cpufreq>
List-Post: <mailto:cpufreq@lists.linux.org.uk>
List-Help: <mailto:cpufreq-request@lists.linux.org.uk?subject=help>
List-Subscribe: <http://lists.linux.org.uk/mailman/listinfo/cpufreq>,
	<mailto:cpufreq-request@lists.linux.org.uk?subject=subscribe>
Sender: cpufreq-bounces@lists.linux.org.uk
Errors-To: cpufreq-bounces+glkc-cpufreq=m.gmane.org@lists.linux.org.uk
To: cpufreq@lists.linux.org.uk
Cc: Dave Jones <davej@redhat.com>, Bruno Ducrot <ducrot@poupinou.org>, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, 10 Aug 2005, Dave Jones wrote:

> 
> For example, most of the x86 drivers, if you set a speed, and then
> start fiddling with the voltage, you can pretty much guarantee
> you'll crash within the next few seconds.  They have to match,
> or at the least, be within a very small margin.
> 
> Given how long its taken us to get sane userspace parts for cpufreq,
> I'm loathe to changing the interfaces yet again unless there's
> a clear advantage to doing so, as it'll take at least another 12 months
> for userspace to catch up.
> 

I'm one of those x86 folks undervolting their Pentium M laptops,
so let me share my experience/opinion. About a week after I bought my
laptop (Acer Aspire 1690, Intel Pentium M 740 at 1.7GHz), I was at the
point of returning it to the dealer because the fan was constantly on
and making too much noise even when running at 800MHz. Then I discovered
that in the windows world, folks are routinely undervolting their CPUs and
obtaining significant improvements in reduced heat and battery life.
There are a number of howto's and software tools on the topic. 
After I did the excercise myself I ended up with an almost 30% reduction
in voltage for every frequency. I didn't make measurments how much this
extends the battery life but the fan certainly spins less often.

When I wanted to do this excersise on linux I discovered that there
wasn't any support for changing voltages on centrino - only some patches
flying around on this mailing list, many of them for AMD. So, I wrote
a very simple patch myself which works as follows. Currently, there is a
table with avaliable frequencies which the cpu governors use for dynamic
frequency switching. In this table every frequency is paired with a voltage
setting so whenever someone sets a frequency, the driver also sets the
corresponding voltage. I guess that this pair is what you refer to as a
power point. The patch I wrote simply overrides the default voltages in
this pair. I may send the patch in the coming days but its just a quick
hack and not a serious solution.

To summarize, undervolting the cpu of your laptop is becoming an important
task and it would be nice to have support for it in one way or another.

Nik.
