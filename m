From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Date: Tue, 1 Jan 2019 15:32:50 -0800
Message-ID: <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
References: <20190101160503.GA3306@localhost.localdomain> <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
 <20190101231526.GA7944@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190101231526.GA7944@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Rui Zhang <rui.zhang@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jan 1, 2019 at 3:16 PM Eduardo Valentin <edubezval@gmail.com> wrote:
>
> > It doesn't even build cleanly.
> >
>
> Do you still have have a copy of the build error?

A plain "make allmodconfig" shows a warning.

And I refuse to add new warnings.

                 Linus
