From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/6] cpuidle: menu: Fixes, optimizations and cleanups
Date: Thu, 4 Oct 2018 08:55:45 +0200
Message-ID: <CAJZ5v0jYvV_C5AVMf+FhNfqsJuveYDRVOYjuOC8+yi8DPf1N6w@mail.gmail.com>
References: <3510260.hvypppS8Bs@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3510260.hvypppS8Bs@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Oct 2, 2018 at 11:51 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> Hi All,
>
> This series fixes a couple of issues with the menu governor, optimizes it
> somewhat and makes a couple of cleanups in it.  Please refer to the
> patch changelogs for details.
>
> All of the changes in the series are straightforward in my view.  The
> first two patches are fixes, the rest is optimizations and cleanups.

I'm inclined to take this stuff in for 4.20 if nobody has problems
with it, so please have a look if you care (and you should, because
the code in question is run on all tickless systems out there).

Thanks,
Rafael
