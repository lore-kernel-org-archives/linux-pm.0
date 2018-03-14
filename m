From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH/RFC 1/2] PM / wakeup: Add callback for wake-up change
 notification
Date: Wed, 14 Mar 2018 18:57:51 +0300
Message-ID: <b2fbba62-72c9-f21a-5aa1-f96291fddb3e@cogentembedded.com>
References: <1521026785-26456-1-git-send-email-geert+renesas@glider.be>
 <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1521026785-26456-2-git-send-email-geert+renesas@glider.be>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marek Vasut <marek.vasut+renesas@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 03/14/2018 02:26 PM, Geert Uytterhoeven wrote:

> Add a callback to inform a device that his wake-up setting has been

   s/his/its/.

> changed.  This allows a device to synchronize device configuration with
> an external user action.
> 
> E.g. on systems using a Rohm BD9571MWV PMIC and a toggle accessory power
> switch, the system suspend procedure is:
>   1. Configure PMIC for DDR backup mode, which changes the role of the
>      accessory power switch from a power to a wake-up switch,
>   2. Switch accessory power switch off, to prepare for system suspend,
>   3. Suspend system.
> 
> Hence step 1 cannot be done in the PMIC's suspend callback, but it can
> be done in the new callback, in response to the user writing "enabled"
> to the PMIC's wakeup virtual file in sysfs.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergei
