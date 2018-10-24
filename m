From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH 2/3] net: ethernet: Remove dummy runtime PM callbacks from
 Renesas drivers
Date: Wed, 24 Oct 2018 20:44:07 +0300
Message-ID: <ecf01d95-f973-5294-932f-41e2a68decf3@cogentembedded.com>
References: <20181024135134.28456-1-jarkko.nikula@linux.intel.com>
 <20181024135134.28456-3-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181024135134.28456-3-jarkko.nikula@linux.intel.com>
Content-Language: en-MW
Sender: netdev-owner@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>, linux-pm@vger.kernel.org
Cc: linux-i2c@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-renesas-soc@vger.kernel.org, linux-usb@vger.kernel.org, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
List-Id: linux-pm@vger.kernel.org

Hello!

On 10/24/2018 04:51 PM, Jarkko Nikula wrote:

> Platform drivers don't need dummy runtime PM callbacks that just return
> success in order to have runtime PM happening. This has changed since
> following commits:
> 
> 05aa55dddb9e ("PM / Runtime: Lenient generic runtime pm callbacks")
> 543f2503a956 ("PM / platform_bus: Allow runtime PM by default")
> 8b313a38ecff ("PM / Platform: Use generic runtime PM callbacks directly")

   Wow, these are old! :-)

> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Only build tested.

   Seems long overdue...

[...]

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

MBR, Sergei
