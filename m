From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [RFC/RFT 05/10] i2c: zx2967: use core helper to mark adapter
 suspended
Date: Tue, 11 Dec 2018 10:12:06 +0800
Message-ID: <20181211021205.GS3987@dragon>
References: <20181210210310.12677-1-wsa+renesas@sang-engineering.com>
 <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181210210310.12677-6-wsa+renesas@sang-engineering.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-i2c@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jun Nie <jun.nie@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 10, 2018 at 10:03:03PM +0100, Wolfram Sang wrote:
> Rejecting transfers should be handled by the core. Also, this will
> ensure proper locking which was forgotten in this open coded version
> and make sure resume mark is set after enabling clocks (not before).
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Shawn Guo <shawnguo@kernel.org>
