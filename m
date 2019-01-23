From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] power: domain: no need to check return value of
 debugfs_create functions
Date: Wed, 23 Jan 2019 08:44:36 +0100
Message-ID: <CAPDyKFo=6NCiAzwF2mvfuvfCApiegBBnJdPM1EypK8xO38h_DA@mail.gmail.com>
References: <20190122152151.16139-6-gregkh@linuxfoundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122152151.16139-6-gregkh@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 22 Jan 2019 at 16:23, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> When calling debugfs functions, there is no need to ever check the
> return value.  The function can work or not, but the code logic should
> never do something different based on this.

Doesn't this boils done to whether we want to care to check if memory
allocation failed?

Somewhere down the call chain from debugfs_create_dir(), we end up in
alloc_inode() and it looks like that can fail, no?

Kind regards
Uffe

>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Len Brown <len.brown@intel.com>
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/base/power/domain.c | 11 ++---------
>  1 file changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 500de1dee967..45eafe8cf7dd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2948,18 +2948,11 @@ static int __init genpd_debug_init(void)
>
>         genpd_debugfs_dir = debugfs_create_dir("pm_genpd", NULL);
>
> -       if (!genpd_debugfs_dir)
> -               return -ENOMEM;
> -
> -       d = debugfs_create_file("pm_genpd_summary", S_IRUGO,
> -                       genpd_debugfs_dir, NULL, &summary_fops);
> -       if (!d)
> -               return -ENOMEM;
> +       debugfs_create_file("pm_genpd_summary", S_IRUGO, genpd_debugfs_dir,
> +                           NULL, &summary_fops);
>
>         list_for_each_entry(genpd, &gpd_list, gpd_list_node) {
>                 d = debugfs_create_dir(genpd->name, genpd_debugfs_dir);
> -               if (!d)
> -                       return -ENOMEM;
>
>                 debugfs_create_file("current_state", 0444,
>                                 d, genpd, &status_fops);
> --
> 2.20.1
>
