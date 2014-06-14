From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2] make kASLR vs hibernation boot-time selectable
Date: Fri, 13 Jun 2014 19:31:48 -0700
Message-ID: <539BB414.9030107@zytor.com>
References: <1402602419-27934-1-git-send-email-keescook@chromium.org> <1737131.VlQuirUC3S@vostro.rjw.lan> <CAGXu5j+BTYup-9cbwSJsKNW4R1e2QY4wVubfpC3s2LVkE4Amow@mail.gmail.com> <1517175.iyVMqh7r2z@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1517175.iyVMqh7r2z@vostro.rjw.lan>
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kees Cook <keescook@chromium.org>
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, Len Brown <len.brown@intel.com>, Wei Yongjun <yongjun_wei@trendmicro.com.cn>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/13/2014 05:14 PM, Rafael J. Wysocki wrote:
> 
> How can I obtain a kernel address of the beginning of a given page
> (as represented by struct page) on x86_64 today?
> 

page_to_virt()

	-hpa


