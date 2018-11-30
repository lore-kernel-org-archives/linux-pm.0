From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: [RFC/RFT][PATCH v6] cpuidle: New timer events oriented governor for tickless systems
Date: Thu, 29 Nov 2018 23:48:57 -0800
Message-ID: <001901d48881$29ea59d0$7dbf0d70$@net>
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
References: Q8oEgsq1aDhAwQ8oJg8ZUI
In-Reply-To: Q8oEgsq1aDhAwQ8oJg8ZUI
Content-Language: en-ca
Sender: linux-kernel-owner@vger.kernel.org
To: "'Rafael J. Wysocki'" <rjw@rjwysocki.net>
Cc: 'Giovanni Gherdovich' <ggherdovich@suse.cz>, 'Srinivas Pandruvada' <srinivas.pandruvada@linux.intel.com>, 'Peter Zijlstra' <peterz@infradead.org>, 'LKML' <linux-kernel@vger.kernel.org>, 'Frederic Weisbecker' <frederic@kernel.org>, 'Mel Gorman' <mgorman@suse.de>, 'Daniel Lezcano' <daniel.lezcano@linaro.org>, 'Linux PM' <linux-pm@vger.kernel.org>, Doug Smythies <dsmythies@telus.net>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On 2018.11.23 02:36 Rafael J. Wysocki wrote:

... [snip]...

> +/**
> + * teo_find_shallower_state - Find shallower idle state matching given duration.
> + * @drv: cpuidle driver containing state data.
> + * @dev: Target CPU.
> + * @state_idx: Index of the capping idle state.
> + * @duration_us: Idle duration value to match.
> + */
> +static int teo_find_shallower_state(struct cpuidle_driver *drv,
> +				    struct cpuidle_device *dev, int state_idx,
> +				    unsigned int duration_us)
> +{
> +	int i;
> +
> +	for (i = state_idx - 1; i > 0; i--) {
> +		if (drv->states[i].disabled || dev->states_usage[i].disable)
> +			continue;
> +
> +		if (drv->states[i].target_residency <= duration_us)
> +			break;
> +	}
> +	return i;
> +}

I think this subroutine has a problem when idle state 0
is disabled.

Perhaps something like this might help:

diff --git a/drivers/cpuidle/governors/teo.c b/drivers/cpuidle/governors/teo.c
index bc1c9a2..5b97639 100644
--- a/drivers/cpuidle/governors/teo.c
+++ b/drivers/cpuidle/governors/teo.c
@@ -196,7 +196,8 @@ static void teo_update(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 }

 /**
- * teo_find_shallower_state - Find shallower idle state matching given duration.
+ * teo_find_shallower_state - Find shallower idle state matching given
+ * duration, if possible.
  * @drv: cpuidle driver containing state data.
  * @dev: Target CPU.
  * @state_idx: Index of the capping idle state.
@@ -208,13 +209,15 @@ static int teo_find_shallower_state(struct cpuidle_driver *drv,
 {
        int i;

-       for (i = state_idx - 1; i > 0; i--) {
+       for (i = state_idx - 1; i >= 0; i--) {
                if (drv->states[i].disabled || dev->states_usage[i].disable)
                        continue;

                if (drv->states[i].target_residency <= duration_us)
                        break;
        }
+       if (i < 0)
+               i = state_idx;
        return i;
 }

@@ -264,7 +267,6 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
                        if (max_early_idx >= 0 &&
                            count < cpu_data->states[i].early_hits)
                                count = cpu_data->states[i].early_hits;
-
                        continue;
                }

There is an additional issue where if idle state 0 is disabled (with the above suggested code patch),
idle state usage seems to fall to deeper states than idle state 1.
This is not the expected behaviour.
Kernel 4.20-rc3 works as expected.
I have not figured this issue out yet, in the code.

Example (1 minute per sample. Number of entries/exits per state):
    State 0     State 1     State 2     State 3     State 4    Watts
   28235143,         83,         26,         17,        837,  64.900
    5583238,     657079,    5884941,    8498552,   30986831,  62.433 << Transition sample, after idle state 0 disabled
          0,     793517,    7186099,   10559878,   38485721,  61.900 << ?? should have all gone into Idle state 1
          0,     795414,    7340703,   10553117,   38513456,  62.050
          0,     807028,    7288195,   10574113,   38523524,  62.167
          0,     814983,    7403534,   10575108,   38571228,  62.167
          0,     838302,    7747127,   10552289,   38556054,  62.183
    9664999,     544473,    4914512,    6942037,   25295361,  63.633 << Transition sample, after idle state 0 enabled
   27893504,         96,         40,          9,        912,  66.500
   26556343,         83,         29,          7,        814,  66.683
   27929227,         64,         20,         10,        931,  66.683
 
... Doug
