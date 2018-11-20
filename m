From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: powernv: add of_node_put()
Date: Tue, 20 Nov 2018 16:26:09 +0100
Message-ID: <CAJZ5v0gY7kO-iZBLFSYHi57hsRUbsetJa0evjfmh2KCgkHLSRA@mail.gmail.com>
References: <20181120125731.19368-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181120125731.19368-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tiny.windzz@gmail.com
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Linux PM <linux-pm@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Nov 20, 2018 at 1:57 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> use of_node_put() to release the refcount.

Again, this changelog is as good as no changelog at all.

If you are adding a missing of_node_put(), please say that and explain
why it is necessary.

Thanks,
Rafael
