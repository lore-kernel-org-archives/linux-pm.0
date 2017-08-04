From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH 05/10] clk: sunxi-ng: h3: gate then ungate
 PLL CPU clk after rate change
Date: Fri, 4 Aug 2017 12:09:22 +0800
Message-ID: <CAGb2v67LWirnWuQzzkNx4MU6Z-pERJBr6vcVfdoddFwLC=FXoA@mail.gmail.com>
References: <20170723102749.17323-1-icenowy@aosc.io> <20170723102749.17323-6-icenowy@aosc.io>
 <CAGb2v66jK+iAbKVsv6=4tb0470KBdwU+AHjWDnWwKKTY+U+W6g@mail.gmail.com>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCMILY6JWQBBBCXHR7GAKGQE22TPWUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <CAGb2v66jK+iAbKVsv6=4tb0470KBdwU+AHjWDnWwKKTY+U+W6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-clk <linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:THERMAL" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 26, 2017 at 3:14 PM, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> On Sun, Jul 23, 2017 at 6:27 PM, Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org> wrote:
>> From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>>
>> This patch utilizes the new PLL clk notifier to gate then ungate the
>> PLL CPU clock after rate changes. This should prevent any system hangs
>> resulting from cpufreq changes to the clk.
>>
>> Reported-by: Ondrej Jirman <megous-5qf/QAjKc83QT0dZR+AlfA@public.gmane.org>
>> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
>> Tested-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
>
> This is missing
>
> Fixes: 0577e4853bfb ("clk: sunxi-ng: Add H3 clocks")

Applied for 4.14 with the Fixes tag and Stephen's ack.
