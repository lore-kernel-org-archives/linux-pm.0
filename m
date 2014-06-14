From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Sat, 14 Jun 2014 09:41:19 -0700
Message-ID: <539C7B2F.9070800@zytor.com>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <1517175.iyVMqh7r2z@vostro.rjw.lan> <CAGXu5jJSqV2MeuofJP4OEiDytQBqKMgC3cj+tguiwTmpRX1wSQ@mail.gmail.com> <13135927.OjVm86GPrt@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <13135927.OjVm86GPrt@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/13/2014 05:39 PM, Rafael J. Wysocki wrote:
>  
> -#define RESTORE_MAGIC	0x0123456789ABCDEFUL
> +#define RESTORE_MAGIC	0x0123456789ABCDF0UL
>  

<bikeshed>

Please don't pick numbers like this for magic numbers... *everyone else
does, too.*  In general, picking a random number is a good starting
point; for extra bonus make sure it has at least one invalid UTF-8
sequence in it (so it cannot be confused with either ASCII or UTF-8 text.)

</bikeshed>

	-hpa

