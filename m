From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] power: supply: remove unused pointer 'dev'
Date: Wed, 29 Aug 2018 15:54:13 +0200
Message-ID: <CAJKOXPcy3emsEPRRK+sKxe51ZWPoVscwHdrVz0fw7vJfLh9HWw@mail.gmail.com>
References: <20180828162842.17503-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180828162842.17503-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: colin.king@canonical.com
Cc: sre@kernel.org, linux-pm@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, 28 Aug 2018 at 18:29, Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Pointer 'dev' is being assigned but is never used hence it is
> redundant and can be removed.
>
> Cleans up clang warning:
> variable 'dev' set but not used [-Wunused-but-set-variable]
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/power/supply/cros_usbpd-charger.c | 2 --
>  1 file changed, 2 deletions(-)
>

Maybe add cros_usbpd prefix to the subject?

Anyway:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
