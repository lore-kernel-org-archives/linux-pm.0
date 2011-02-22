From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCHv3] amba: support pm ops
Date: Tue, 22 Feb 2011 15:17:34 +0100
Message-ID: <AANLkTinDc-VH3moN7RhLiBvX7FnU7t2+n7ECPqO-8m59__19913.1113979549$1298384420$gmane$org@mail.gmail.com>
References: <201102212126.10742.rjw@sisk.pl>
	<1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1298353261-22193-1-git-send-email-rabin.vincent@stericsson.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Rabin Vincent <rabin.vincent@stericsson.com>
Cc: linux-pm@lists.linux-foundation.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

2011/2/22 Rabin Vincent <rabin.vincent@stericsson.com>:
> Support pm_ops in the AMBA bus, required to allow drivers to use runtime =
pm.
> The implementation of AMBA bus pm ops is based on the platform bus
> implementation.
>
> Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
> Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
> ---
> v3: add a missing header. don't keep an empty dev_pm_ops struct when it's
> =A0 =A0not used.

FWIW:
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
