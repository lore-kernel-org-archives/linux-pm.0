From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 19/33] thermal: db8500: use match_string() helper
Date: Tue, 22 May 2018 01:00:23 +0300
Message-ID: <CAHp75VfqEdoDZydwFmQaLiUN8cVtH3MbFHf3qixU8xUHXMwt1g@mail.gmail.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1526903890-35761-20-git-send-email-xieyisheng1@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Linux PM <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

> +       i = match_string((const char **)trip_point->cdev_name,

Casting looks ugly. You need to constify the variable itself.

> +                        COOLING_DEV_MAX, cdev->type);
>
> -       return -ENODEV;
> +       return (i < 0) ? -ENODEV : 0;

I would rather go with

if (ret < 0)
 return -ENODEV;

return 0;

-- 
With Best Regards,
Andy Shevchenko
