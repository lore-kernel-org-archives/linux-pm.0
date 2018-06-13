From: Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v5 1/4] fixp-arith: add a linear interpolation function
Date: Wed, 13 Jun 2018 13:06:35 +0200
Message-ID: <CACRpkdaKMr0qm91Q4LyjBGyKG_H4vvMr7bnRJeai+f2Eg-9r0Q@mail.gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <20180607181306.9766-1-ctatlor97@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180607181306.9766-1-ctatlor97@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Craig Tatlor <ctatlor97@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Linux PM list <linux-pm@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 7, 2018 at 8:12 PM, Craig Tatlor <ctatlor97@gmail.com> wrote:

> Adds a function to interpolate against two points,
> this is carried arount as a helper function by tons of drivers.
>
> Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>

The linear formula seems to fit the most natural form of linear
interpolation.

I bet some John Carmack algorithm type people will soon
start to optimize this... :D

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
