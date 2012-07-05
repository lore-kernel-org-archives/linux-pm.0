From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/4] cpuidle: define the enter function in the driver structure
Date: Thu, 5 Jul 2012 22:38:44 +0200
Message-ID: <201207052238.44330.rjw@sisk.pl>
References: <1341494608-16591-1-git-send-email-daniel.lezcano@linaro.org> <1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1341494608-16591-2-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linaro-dev@lists.linaro.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 05, 2012, Daniel Lezcano wrote:
> We have the state index passed as parameter to the 'enter' function.
> Most of the drivers assign their 'enter' functions several times in
> the cpuidle_state structure, as we have the index, we can delegate
> to the driver to handle their own callback array.
> 
> That will have the benefit of removing multiple lines of code in the
> different drivers.

Hmm. I suppose the cpuidle subsystem was designed the way it was for a reason.
Among other things, this was to avoid recurrence in callbacks - please see
acpi_idle_enter_bm() for example.

Now, if .enter() is moved to the driver structure, it will have to be an
all-purpose complicated routine calling itself recursively at least in
some cases.  I'm not quite convinced that would be an improvement.

On the other hand, I don't see anything wrong with setting several callback
pointers to the same routine.

Thanks,
Rafael
