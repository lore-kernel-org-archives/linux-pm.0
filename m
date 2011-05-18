From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 2/3] PM / DEVFREQ: add example governors
Date: Wed, 18 May 2011 21:46:51 +0200
Message-ID: <201105182146.51869.rjw__35434.7721128308$1305748172$gmane$org@sisk.pl>
References: <1305100723-29161-1-git-send-email-myungjoo.ham@samsung.com>
	<201105180039.56806.rjw@sisk.pl>
	<BANLkTim0DkhcjWw7fM0e-UhyB3=GkQ7nKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTim0DkhcjWw7fM0e-UhyB3=GkQ7nKw@mail.gmail.com>
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

On Wednesday, May 18, 2011, MyungJoo Ham wrote:
> 2011/5/18 Rafael J. Wysocki <rjw@sisk.pl>:
> > On Wednesday, May 11, 2011, MyungJoo Ham wrote:
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
> >
> > Well, do you expect anyone to actually use them?  If not, it would make
> > more sense to put them into a doc.
> 
> According to our experiences of DVFS(although this "DEVFREQ" is not
> applied to them, yet) in memory-bus and GPU,
> I expect most DEVFREQ users might use "simple_ondemand" and
> expect "powersave" and "performance" will probably mostly used while
> testing and debugging.
> ("userspace"-like governor would be also useful for that purpose, but
> I'd add it later)

It would be good to have at least one in-tree user for each of them
(not necessarily from the start, but at one point in the future at least).

So if you have any _specific_ users in mind, please let me know.

Thanks,
Rafael
