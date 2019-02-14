From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] devfreq: Use of_node_name_eq for node name comparisons
Date: Thu, 14 Feb 2019 08:24:07 -0600
Message-ID: <CAL_Jsq+hoRE5UG3+Z9OKDc3xmkJbGgQpUF+M4pzXJ_BSjj0kfg@mail.gmail.com>
References: <20181205195050.4759-6-robh@kernel.org> <CGME20190213161024epcas3p3acc5c074714ad1d44fb90ab3f21cfcff@epcas3p3.samsung.com>
 <CAL_Jsq+xpRPvj=UcSo+jQKX1pB=9B3SV9jB5ZVhaVsKvOqtoOg@mail.gmail.com> <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5cc4b5a3-c4ad-46a9-2856-3ed67c6755d3@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>, MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: devicetree@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, "open list:THERMAL" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Feb 13, 2019 at 9:49 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
>
> Hi Rob,
>
> On 19. 2. 14. =EC=98=A4=EC=A0=84 1:09, Rob Herring wrote:
> > On Wed, Dec 5, 2018 at 1:50 PM Rob Herring <robh@kernel.org> wrote:
> >>
> >> Convert string compares of DT node names to use of_node_name_eq helper
> >> instead. This removes direct access to the node name pointer.
> >>
> >> For instances using of_node_cmp, this has the side effect of now using
> >> case sensitive comparisons. This should not matter for any FDT based
> >> system which all of these are.
> >>
> >> Cc: Chanwoo Choi <cw00.choi@samsung.com>
> >> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> >> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> >> Cc: Kukjin Kim <kgene@kernel.org>
> >> Cc: Krzysztof Kozlowski <krzk@kernel.org>
> >> Cc: linux-pm@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-samsung-soc@vger.kernel.org
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  drivers/devfreq/devfreq-event.c     | 2 +-
> >>  drivers/devfreq/event/exynos-ppmu.c | 2 +-
> >>  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > Can someone apply this please.
>
> Myungjoo picked up this patch[1] on devfreq.git
> but has not yet sent the pull request.

Okay, thanks.

Please add that tree to linux-next or reply to patches when they've
been applied, so submitters have some way to know when their patch is
accepted.

Rob
