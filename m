From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Power management and ACPI fixes for v3.10-rc2
Date: Thu, 16 May 2013 15:25:35 -0700
Message-ID: <CA+55aFxhDO0D1nQgTFWSiZT9AJMSF9oOUoxWj=Y=5en0nWC92g@mail.gmail.com>
References: <68458966.ga8OpWyZtA@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <68458966.ga8OpWyZtA@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Dirk Brandewie <dirk.j.brandewie@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, May 16, 2013 at 1:07 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> - intel_pstate driver fixes and cleanups from Dirk Brandewie and
>   Wei Yongjun.

Btw, is there some fundamental reason why the pstate driver is limited
to so few models?

I've tested it on models 0x25 (i5-670) and 0x3a (i5-3427U), and it
seems to work. But neither model is listed. (only 0x2a and 0x2d are).

I understand that people want to be careful, but it's not actually
getting very much *testing* right now, is it? Are models 0x2a/0x2d
actually special in any way?

                  Linus
