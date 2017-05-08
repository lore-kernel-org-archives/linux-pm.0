From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v6 3/8] i2c: i2c-smbus: add of_i2c_setup_smbus_alert
Date: Mon, 8 May 2017 10:24:10 -0500
Message-ID: <20170508152410.rxm6hsoc4zbmvkqp@rob-hp-laptop>
References: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
 <1493716346-58517-4-git-send-email-preid@electromag.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1493716346-58517-4-git-send-email-preid@electromag.com.au>
Sender: linux-i2c-owner@vger.kernel.org
To: Phil Reid <preid@electromag.com.au>
Cc: wsa@the-dreams.de, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-pm@vger.kernel.org

On Tue, May 02, 2017 at 05:12:21PM +0800, Phil Reid wrote:
> This commit adds of_i2c_setup_smbus_alert which allows the smbalert
> driver to be attached to an i2c adapter via the device tree.
> 
> Signed-off-by: Phil Reid <preid@electromag.com.au>
> ---
>  Documentation/devicetree/bindings/i2c/i2c.txt |  4 +--

Acked-by: Rob Herring <robh@kernel.org>

>  drivers/i2c/i2c-smbus.c                       | 35 +++++++++++++++++++++++++++
>  include/linux/i2c-smbus.h                     |  9 +++++++
>  3 files changed, 46 insertions(+), 2 deletions(-)
