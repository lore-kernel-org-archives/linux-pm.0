From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date: Mon, 14 Jan 2019 08:51:59 +0100
Message-ID: <CAJKOXPfvR6vATPiWbef_JiSJX78PkJxRXjF2xK7EYr5B3e8HbA@mail.gmail.com>
References: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pawe=C5=82_Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Cc: kgene@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, 13 Jan 2019 at 20:58, Pawe=C5=82 Chmiel
<pawel.mikolaj.chmiel@gmail.com> wrote:
>
> There is possibility, that when probing driver, regulators are not yet
> initialized. In this case we should return EPROBE_DEFER and wait till
> they're initialized, since they're required currently for cpufreq driver
> to work. Also move regulator initialization code at beginning of probe,
> so we can defer as fast as posibble.
>
> Signed-off-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
> Changes from v3:
>   - Zero dmc_base pointers after unmapping them
>   - If getting vddarm regulator fails just return, no need to do goto
>     jump which would do the same
>
> Changes from v2:
>   - Handle all error paths in probe
>
> Changes from v1:
>   - Fix compilation error
>   - Reorganize code so it's smaller

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
