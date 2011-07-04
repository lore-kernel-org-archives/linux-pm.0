From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v3 2/3] PM / DEVFREQ: add example governors
Date: Mon, 4 Jul 2011 10:43:24 +0200
Message-ID: <201107041043.25150.rjw__5394.49794819138$1309768989$gmane$org@sisk.pl>
References: <1306471995-4048-1-git-send-email-myungjoo.ham@samsung.com>
	<201107022358.58319.rjw@sisk.pl>
	<CAJ0PZbQuiwkW-Z+1Wrqmr3r_U+LdWS312RggkkjFBGFHES4wCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJ0PZbQuiwkW-Z+1Wrqmr3r_U+LdWS312RggkkjFBGFHES4wCw@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: myungjoo.ham@gmail.com
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Monday, July 04, 2011, MyungJoo Ham wrote:
> Hello,
> 
> 2011/7/3 Rafael J. Wysocki <rjw@sisk.pl>:
> > Hi,
> >
> > On Friday, May 27, 2011, MyungJoo Ham wrote:
> >> Three CPUFREQ-like governors are provided as examples.
> >>
> >> powersave: use the lowest frequency possible. The user (device) should
> >> set the polling_ms as 0 because polling is useless for this governor.
> >>
> >> performance: use the highest freqeuncy possible. The user (device)
> >> should set the polling_ms as 0 because polling is useless for this
> >> governor.
> >>
> >> simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.
> >>
> >> When a user updates OPP entries (enable/disable/add), OPP framework
> >> automatically notifies DEVFREQ to update operating frequency
> >> accordingly. Thus, DEVFREQ users (device drivers) do not need to update
> >> DEVFREQ manually with OPP entry updates or set polling_ms for powersave
> >> , performance, or any other "static" governors.
> >>
> >> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> []
> >> +
> >> +     /* Set the desired frequency based on the load */
> >> +     a = (unsigned long long) stat.busy_time * stat.current_frequency;
> >
> > What's the purpose of the conversion?
> 
> Assuming that the work speed of a device is proportional to its
> frequency, it measures the amount of work done.
> It's time * work/time. For example, during the last 10 second, if the
> busy_time was 5 sec and frequency was 10MHz,
> it's "50M", which is same as 20MHz and 2.5 sec.

I understand that, but my question was why you're doing a forced conversion
to (unsigned long long).

Thanks,
Rafael
