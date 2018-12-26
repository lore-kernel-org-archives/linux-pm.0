From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] base: fix a missing check of clk_prepare
Date: Wed, 26 Dec 2018 10:37:54 +0100
Message-ID: <CAJZ5v0iK+ASbadEjj+9vgCV+1ycjp8Hs2GbEmT3dGSqjLVGbPA@mail.gmail.com>
References: <20181226024700.72318-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181226024700.72318-1-kjlu@umn.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Dec 26, 2018 at 3:47 AM Kangjie Lu <kjlu@umn.edu> wrote:
>
> clk_prepare() could fail, so let's check its status, and if it fails,
> issue an error message.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  drivers/base/power/clock_ops.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/clock_ops.c b/drivers/base/power/clock_ops.c
> index 5a42ae4078c2..cb6144fb24e2 100644
> --- a/drivers/base/power/clock_ops.c
> +++ b/drivers/base/power/clock_ops.c
> @@ -65,7 +65,9 @@ static void pm_clk_acquire(struct device *dev, struct pm_clock_entry *ce)
>         if (IS_ERR(ce->clk)) {
>                 ce->status = PCE_STATUS_ERROR;
>         } else {
> -               clk_prepare(ce->clk);
> +               if (clk_prepare(ce->clk))
> +                       dev_err(dev, "clk_prepare failed.\n");

I'm not sure that this is useful.  The code continues regardless of
the error anyway and it should at least set ce->status to
PCE_STATUS_ERROR in the failing case.

Have you seen a failure in this particular spot in practice?

> +
>                 ce->status = PCE_STATUS_ACQUIRED;
>                 dev_dbg(dev, "Clock %pC con_id %s managed by runtime PM.\n",
>                         ce->clk, ce->con_id);
> --
> 2.17.2 (Apple Git-113)
>
