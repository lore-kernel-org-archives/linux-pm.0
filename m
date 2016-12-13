From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/3] power: supply: bq24735-charger: optionally poll the
 ac-detect gpio
Date: Tue, 13 Dec 2016 13:30:09 -0600
Message-ID: <20161213193009.5cqyaii3gjrttqyk@rob-hp-laptop>
References: <1481540424-19293-1-git-send-email-peda@axentia.se>
 <1481540424-19293-3-git-send-email-peda@axentia.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481540424-19293-3-git-send-email-peda@axentia.se>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 12, 2016 at 12:00:23PM +0100, Peter Rosin wrote:
> If the ac-detect gpio does not support interrupts, provide a fallback
> to poll the gpio at a configurable interval.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>
> ---
>  .../bindings/power/supply/ti,bq24735.txt           |  2 +
>  drivers/power/supply/bq24735-charger.c             | 50 +++++++++++++++++++---
>  2 files changed, 47 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> index 3bf55757ceec..59c4dde589cf 100644
> --- a/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> +++ b/Documentation/devicetree/bindings/power/supply/ti,bq24735.txt
> @@ -25,6 +25,8 @@ Optional properties :
>   - ti,external-control : Indicates that the charger is configured externally
>     and that the host should not attempt to enable/disable charging or set the
>     charge voltage/current.
> + - ti,poll-interval-ms : In case there is no interrupts specified, poll AC
> +   presense on the ti,ac-detect-gpios GPIO with this interval.

We already have poll-interval and cm-poll-interval properties. Just use 
poll-interval here.

Rob
