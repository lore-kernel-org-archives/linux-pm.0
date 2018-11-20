From: Frank Lee <tiny.windzz@gmail.com>
Subject: Re: [PATCH v2] cpuidle: big.LITTLE: add of_node_put()
Date: Wed, 21 Nov 2018 00:08:58 +0800
Message-ID: <CAEExFWv289bsEc-2OXcVkhnHv_UsOU1YnKt6Mv-nFqM_QN+PVg@mail.gmail.com>
References: <20181120154617.20903-1-tiny.windzz@gmail.com> <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hWSCDbDUV1_iQBf-4Y=QgnBTrAqQqcCyOpv9r7yCjGiQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rafael@kernel.org
Cc: lorenzo.pieralisi@arm.com, Daniel Lezcano <daniel.lezcano@linaro.org>, rjw@rjwysocki.net, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 21, 2018 at 12:06 AM Rafael J. Wysocki <rafael@kernel.org> wrot=
e:
>
> On Tue, Nov 20, 2018 at 4:46 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> >
> > The of_node_put() is missing.So we call the of_node_put() to release
> > the refcount.
>
> I would say "of_find_node_by_path() acquires a reference to the node
> returned by it and that reference needs to be dropped by its caller.
> bl_idle_init() doesn't do that, so fix it."
>
> Thanks,
> Rafael
Hi Rafael=EF=BC=9A

You are right, I will change it right away.

Yours=EF=BC=8C
    Yangtao
