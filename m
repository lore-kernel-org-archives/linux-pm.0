From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] cpuidle: acpi: Remove TIME_INVALID flag from acpi
Date: Fri, 21 Nov 2014 16:05:33 +0100
Message-ID: <2283319.n13QkHWkNs@vostro.rjw.lan>
References: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1416562192-14114-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org, linaro-kernel@lists.linaro.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Friday, November 21, 2014 10:29:51 AM Daniel Lezcano wrote:
> The commit 8e92b6605d introduced the TIME_VALID flag for the C1 state
> if this one is a mwait state assuming the interrupt will be enabled
> before reading the end time of the idle state.
> 
> The changelog of this commit mention a potential problem with the menu
> governor but not a real observation and I assume it described an old
> code as the commit is from 2008.
> 
> I have been digging through the code and I didn't find any place where the
> interrupts are enabled before reading the time. Moreover with the changes
> in the meantime, we moved the time measurements in the cpuidle core as well
> as the interrupts enabling making sure the time is measured before the
> interrupt are enabled again in a single place.
> 
> Remove this test as the time measurement is always valid for this
> state.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Well, I need Len to have a look at this.

> ---
>  drivers/acpi/processor_idle.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 380b4b4..7afba40 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -985,8 +985,6 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  		state->flags = 0;
>  		switch (cx->type) {
>  			case ACPI_STATE_C1:
> -			if (cx->entry_method != ACPI_CSTATE_FFH)
> -				state->flags |= CPUIDLE_FLAG_TIME_INVALID;
>  
>  			state->enter = acpi_idle_enter_c1;
>  			state->enter_dead = acpi_idle_play_dead;
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
