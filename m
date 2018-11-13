From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [PATCH] power: supply: bq24190_charger: add support for bq24196 variant
Date: Tue, 13 Nov 2018 13:49:59 +0100
Message-ID: <8627370.m8bcYUWF9X@phil>
References: <20181109125335.1219-1-heiko@sntech.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181109125335.1219-1-heiko@sntech.de>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Am Freitag, 9. November 2018, 13:53:35 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> The bq24196 is another variant of the bq24190 charger ic.
> Its register set is identical to the bq24192 and it even reuses
> the same part number (0x5).
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>
> ---

looks like I forgot to add the compatible to the binding document.
I've send a fixed v2 just now.


Heiko
