From: "Kim, Milo" <milo.kim@ti.com>
Subject: Re: [patch] power: supply: lp8788: remove an unneeded NULL check
Date: Mon, 17 Oct 2016 09:40:48 +0900
Message-ID: <58041E10.8020700@ti.com>
References: <20161014073328.GC15168@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161014073328.GC15168@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10/14/2016 4:33 PM, Dan Carpenter wrote:
> We checked that "pdata->chg_params" is non-NULL earlier in this function
> so when we add "i" to it, it's still non-NULL.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Milo Kim <milo.kim@ti.com>

Thanks for catching this.

Best regards,
Milo
