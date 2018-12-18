From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [PATCH] cpuidle: New timer events oriented governor for tickless systems
Date: Tue, 18 Dec 2018 07:32:33 -0800
Message-ID: <000001d496e6$e968c8f0$bc3a5ad0$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: ZDGBgBJlZBdpLZDGGgQX53
In-Reply-To: ZDGBgBJlZBdpLZDGGgQX53
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, "'Chen, Hu'" <hu1.chen@intel.com>, 'Quentin Perret' <quentin.perret@arm.com>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

Just typos, not already pointed out by Quentin:

On 2018.12.18 03:09 Rafael J. Wysocki wrote:

> The venerable menu governor does some thigns that are quite

s/thigns/things

> time frame in which no timer wakeups are possible (becuase it knows

s/because/because

> +obtain the the *sleep length*, which is the time until the closest timer event

s/the the/the

> +increased when when the given idle state "matches" the sleep length only and the

s/when when/when

... Doug
