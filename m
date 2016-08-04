From: John Stultz <john.stultz@linaro.org>
Subject: Re: [PATCH 1/2] power: reset: reboot-mode: Add managed resource API
Date: Thu, 4 Aug 2016 14:14:15 -0700
Message-ID: <CALAqxLXK1kEOY1YAnwe88RJ8Fzho+Jh-5TvUF=ojU27kuNv0XQ@mail.gmail.com>
References: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470287046-17437-1-git-send-email-bjorn.andersson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-doc@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 3, 2016 at 10:04 PM, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> Provide managed resource version of reboot_mode_register() and
> reboot_mode_unregister() to simplify implementations.
>
> Cc: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>
> John, here's a "pointer" to what I meant with my comment on your
> sram-reboot-mode patch. Only compile tested though.

Heh. Awesome. The seem to be working fine for me.

Tested-by: John Stultz <john.stultz@linaro.org>

thanks
-john
