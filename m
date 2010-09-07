From: Thomas Renninger <trenn@suse.de>
Subject: Re: Speedstep on Celeron SU2300 - 20% more battery
	lifetime on Windows
Date: Tue, 7 Sep 2010 13:47:13 +0200
Message-ID: <201009071347.13509.trenn__29324.3277156309$1283860128$gmane$org@suse.de>
References: <AANLkTiktJ5Xgnsmq2je7T3Yc5Sf53Bu8vWMM1XT1V_vm@mail.gmail.com>
	<201009061035.03727.trenn@suse.de>
	<AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi==7HGa9OKUDq4cpexPpdPMKVgcXqONFL+UqmRe@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tiago Marques <tiagomnm@gmail.com>
Cc: discuss@lesswatts.org, linux-pm@lists.linux-foundation.org, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday 06 September 2010 23:47:58 Tiago Marques wrote:
> On Mon, Sep 6, 2010 at 9:35 AM, Thomas Renninger <trenn@suse.de> wrote:
..
> C states seem ok...ish. I get C0, C1 and C4, though not anything in
> between. Don't know how to check in windows and usually it shouldn't
> in leaps, right? That might be a problem. I'm getting around 75% in
> C4, the rest almost exclusively in C0. Perhaps the transitions are the
> problem? I think I previously saw normal rates of closer to 98% so
> I'll have to check what's going now. Too many wakeups from i915, usb
> and wlan.
> Powertop shows that the BIOS reports C1 and C4 support, hence only
> these C-stats.
Yep, I'd concentrate on this first. If idle, the system should be in deepest
C-state (nearly) all of the time. Perfect tool for this is powertop.
You could also boot into runlevel S. If the system is much more idle
there you could load drivers one by one to find out whether there is a bad
one keeping your cpu busy/awake.

C-states also should "rule-out" P-states. If you are in C4 it shouldn't matter
whether your freq is up or down, the core's freq and voltage should be
ramped down to a minimum on latest processors (I've never measured that,
but this is what I've heard from Intel guys themselves...).

Good luck,

    Thomas
