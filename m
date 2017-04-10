From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: power: supply: New bindings for LEGO
 MINDSTORMS EV3 battery
Date: Mon, 10 Apr 2017 10:05:53 -0500
Message-ID: <20170410150553.35pjswc7liact3pd@rob-hp-laptop>
References: <1491251029-23256-1-git-send-email-david@lechnology.com>
 <1491251029-23256-2-git-send-email-david@lechnology.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1491251029-23256-2-git-send-email-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Lechner <david@lechnology.com>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Apr 03, 2017 at 03:23:47PM -0500, David Lechner wrote:
> This add a new device tree binding for LEGO MINDSTORMS EV3 battery. The EV3
> has some built-in capability for monitoring the attached battery.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/power/supply/lego_ev3_battery.txt      | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/lego_ev3_battery.txt

Acked-by: Rob Herring <robh@kernel.org>
