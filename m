From: Todd Poynor <tpoynor@mvista.com>
Subject: Re: Re: PowerOP 2/3: Intel Centrino support
Date: Wed, 10 Aug 2005 16:37:36 -0700
Message-ID: <42FA8FC0.5000700@mvista.com>
References: <20050809025419.GC25064@slurryseal.ddns.mvista.com>	<20050810100133.GA1945@elf.ucw.cz>	<20050810125848.GM852@poupinou.org>
	<20050810184445.GB14350@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050810184445.GB14350@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>, Bruno Ducrot <ducrot@poupinou.org>, Pavel Machek <pavel@ucw.cz>, cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Dave Jones wrote:
> I'm glad I'm not the only one who feels he's too dumb to see
> the advantages of this. The added complexity to expose something
> that in all cases, we actually don't want to expose seems a little
> pointless to me.
> 
> For example, most of the x86 drivers, if you set a speed, and then
> start fiddling with the voltage, you can pretty much guarantee
> you'll crash within the next few seconds.  They have to match,
> or at the least, be within a very small margin.

I've attempted to extoll the benefits of adding these interfaces in 
previous emails, and if after that it still seems mystifying why anybody 
would want to do this then I'll take the heat for doing a lousy job of 
extolling.  I've also admitted that it is primarily of use in 
embedded-specific hardware, and of less use in x86 and in desktop/server 
usage for various reasons (unless it turns out there's some fantastic 
savings to be had in modifying common x86 bus speeds independently of 
cpu speed, which seems unlikely).  In the case of x86, undervolting is 
in practice by some folks, but yes it is risky and support for it in the 
basic interfaces probably shouldn't be a high priority.

> Given how long its taken us to get sane userspace parts for cpufreq,
> I'm loathe to changing the interfaces yet again unless there's
> a clear advantage to doing so, as it'll take at least another 12 months
> for userspace to catch up.

Just to be clear, there are no cpufreq userspace interface changes 
required by this, it simply occupies the bottom layer of code that 
modifies platform power registers etc.  The same speed/policy/governor 
etc. interfaces are used to specify the cpu speed.  Interfaces to the 
power parameters can optionally be used for diagnostic purposes, and in 
the near future I'll propose alternative interfaces for setting entire 
operating points, but the existing cpufreq interfaces will work just 
fine regardless.

-- 
Todd
