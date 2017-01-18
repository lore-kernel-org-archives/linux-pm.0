From: Roger Shimizu <rogershimizu@gmail.com>
Subject: Re: [PATCH v4 1/2] power: reset: add linkstation-reset driver
Date: Wed, 18 Jan 2017 21:08:13 +0900
Message-ID: <CAEQ9gEkoKc0Yv+kLYGWgHZZW92u0tW8E9U0eT7ZhAx79yKxzLQ@mail.gmail.com>
References: <20161227070611.14852-1-rogershimizu@gmail.com>
 <20170107150451.17912-1-rogershimizu@gmail.com>
 <20170107150451.17912-2-rogershimizu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170107150451.17912-2-rogershimizu@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Ryan Tandy <ryan@nardis.ca>, linux-pm@vger.kernel.org, Herbert Valerio Riedel <hvr@gnu.org>, devicetree@vger.kernel.org, Martin Michlmayr <tbm@cyrius.com>, linux-arm-kernel@lists.infradead.org, Sylver Bruneau <sylver.bruneau@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Dear Sebastian,

On Sun, Jan 8, 2017 at 12:04 AM, Roger Shimizu <rogershimizu@gmail.com> wrote:
> Buffalo Linkstation / KuroBox and their variants need magic command
> sending to UART1 to power-off.
>
> Power driver linkstation-reset implements the magic command and I/O
> routine, which come from files listed below:
>   - arch/arm/mach-orion5x/kurobox_pro-setup.c
>   - arch/arm/mach-orion5x/terastation_pro2-setup.c

I think there's not much concern regarding to this series.
Could you kindly help to apply this patch?
Thank you!

Cheers,
-- 
Roger Shimizu, GMT +9 Tokyo
PGP/GPG: 4096R/6C6ACD6417B3ACB1
