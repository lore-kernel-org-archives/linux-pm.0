From: Moritz Fischer <moritz.fischer.private@gmail.com>
Subject: Re: [PATCH] power: reset: gpio-poweroff: add ability to specific
 active and inactive delays
Date: Mon, 3 Dec 2018 16:22:20 -0800
Message-ID: <CAJYdmeOyYAiN4jpKzOAepXRgSrzWgO4qWjvV+9qMMYzA2OzL6A@mail.gmail.com>
References: <20181111214538.32477-1-heiko@sntech.de> <20181203234923.GA29934@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181203234923.GA29934@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: heiko@sntech.de, sre@kernel.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, Devicetree List <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, heiko.stuebner@bq.com
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 3, 2018 at 3:49 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sun, 11 Nov 2018 22:45:38 +0100, Heiko Stuebner wrote:
> > From: Heiko Stuebner <heiko.stuebner@bq.com>
> >
> > Similar to gpio-reset allow to specify active and inactive delays
> > while keeping the 100ms defaults that were used previously all the time.
> >
> > The dt-properties are named the same as in gpio-reset but get an "-ms"
> > suffix as properties should contain such a suffix specifying its unit.
> >
> > Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> > ---
> >  .../devicetree/bindings/power/reset/gpio-poweroff.txt  |  2 ++
> >  drivers/power/reset/gpio-poweroff.c                    | 10 ++++++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> >
>
> Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
