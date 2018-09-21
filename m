From: Amit Kucheria <amit.kucheria@linaro.org>
Subject: Re: [PATCH v3 00/16] Another round of tsens cleanups
Date: Fri, 21 Sep 2018 10:48:45 -0700
Message-ID: <CAHLCerN0fjPS+3Ydak4tcxqVFzn4sSokYhiG_=2Vi6q_qmEprg@mail.gmail.com>
References: <cover.1536744310.git.amit.kucheria@linaro.org> <20180920190243.GF19253@hector.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920190243.GF19253@hector.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Gross <andy.gross@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Rajendra Nayak <rnayak@codeaurora.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Eduardo Valentin <edubezval@gmail.com>, smohanad@codeaurora.org, Douglas Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, gregkh@linuxfoundation.org, mchehab+samsung@kernel.org, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 20, 2018 at 12:02 PM Andy Gross <andy.gross@linaro.org> wrote:
>
> On Wed, Sep 12, 2018 at 03:22:45PM +0530, Amit Kucheria wrote:
> > This is another series of tsens cleanups before we add interrupt support. This applies on top of 4.19-rc2.
> >
> > Patches [1-6] can directly be applied by Eduardo.
> > Patches [9-16] can directly be applied by Andy.
>
> Eduardo,
>
> I ACKed the DTS patches for this.  Can you take 9-16 along with the 1-6 through
> your tree?
>

Thanks Andy.

Eduardo, I've send a fixup patch 07/16. If you like, I can resend the
entire series
or you can find the entire series hosted with all tags applied here:
https://git.linaro.org/people/amit.kucheria/kernel.git/log/?h=up/thermal/tsens-preirq-cleanup-v4

Regards,
Amit
