From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpuidle: poll_state: Fix default time limit.
Date: Wed, 30 Jan 2019 22:59:08 +0100
Message-ID: <CAJZ5v0iXNfn9Bn7V-XApb6A3D43hsmir0m7zCyG5Rky=qAbZmA@mail.gmail.com>
References: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548865702-3524-1-git-send-email-dsmythies@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Doug Smythies <dsmythies@telus.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 30, 2019 at 5:29 PM Doug Smythies <doug.smythies@gmail.com> wrote:
>
> The default time is declared in units of microsecnds,
> but is used as nano seconds, resulting in significant
> accounting errors for idle state 0 time when all idle
> states deeper than 0 are disabled.
>
> Under these unusual conditions, we don't really care
> about the poll time limit anyhow.
>
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
> ---
>  drivers/cpuidle/poll_state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index b17d153..23a1b27 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -21,7 +21,7 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>         local_irq_enable();
>         if (!current_set_polling_and_test()) {
>                 unsigned int loop_count = 0;
> -               u64 limit = TICK_USEC;
> +               u64 limit = TICK_NSEC;

Good catch!

>                 int i;
>
>                 for (i = 1; i < drv->state_count; i++) {
> --

Applied, thanks!
