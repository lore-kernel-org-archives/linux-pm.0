From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 10/10] [RFC] sh_eth: Remove obsolete explicit clock
 handling for WoL
Date: Mon, 16 Oct 2017 22:24:35 +0300
Message-ID: <3a3fafd0-5421-5dda-35af-173f6764098b@cogentembedded.com>
References: <1508162116-5043-1-git-send-email-geert+renesas@glider.be>
 <1508162116-5043-11-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1508162116-5043-11-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
Sender: linux-clk-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>, linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello!

On 10/16/2017 04:55 PM, Geert Uytterhoeven wrote:

> Currently, if Wake-on-LAN is enabled, the SH-ETH device's module clock

    It's called Ether (or GEther) in all the manuals I have. Never saw SH-ETH, 
I think it's Nobuhiro's invention... :-)

> is manually kept running during system suspend, to make sure the device
> stays active.
> 
> Since "soc: renesas: rcar-sysc: Keep wakeup sources active during system
> suspend" and "clk: renesas: mstp: Keep wakeup sources active during
> system suspend", this workaround is no longer needed.  Hence remove all
> explicit clock handling to keep the device active.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
