From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] hibernation: on 32-bit x86, disabled in favor of KASLR
Date: Thu, 23 Mar 2017 02:10:12 +0100
Message-ID: <CAJZ5v0j1+Fv7Kt_M9PR_Ov_vp5f-pQTvhcteVJwDP21v79=64A@mail.gmail.com>
References: <20170323002701.GA90470@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20170323002701.GA90470@beast>
Sender: linux-doc-owner@vger.kernel.org
To: Kees Cook <keescook@chromium.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Evgenii Shatokhin <eugene.shatokhin@yandex.ru>, "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 23, 2017 at 1:27 AM, Kees Cook <keescook@chromium.org> wrote:
> This is a modified revert of commit 65fe935dd238 ("x86/KASLR, x86/power:
> Remove x86 hibernation restrictions"), since it appears that 32-bit
> hibernation still can't support KASLR. 64-bit is fine. Since people have
> been running with KASLR by default on 32-bit since v4.8, this disables
> hibernation (with a warning). Booting with "nokaslr" will disable KASLR
> and enable hibernation.
>
> Reported-by: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: stable@vger.kernel.org # v4.8+

LGTM

Thanks,
Rafael
