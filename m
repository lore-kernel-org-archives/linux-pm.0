From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/6] power/reset: arm-versatile: Register with kernel
 restart handler
Date: Sun, 25 Jan 2015 11:07:16 -0800
Message-ID: <54C53EE4.4070109@roeck-us.net>
References: <1422209622-31994-1-git-send-email-linux@roeck-us.net> <20150125184017.GA29704@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150125184017.GA29704@earth.universe>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 01/25/2015 10:40 AM, Sebastian Reichel wrote:
> Hi,
>
> On Sun, Jan 25, 2015 at 10:13:37AM -0800, Guenter Roeck wrote:
>> Register with kernel restart handler instead of setting arm_pm_restart
>> directly. Select high priority since the restart handler is instantiated
>> through devicetree, indicating that it should be used if configured.
>
> This does not apply clean for me. Please rebase on top of
>
> http://git.infradead.org/battery-2.6.git/
>

Hi Sebastian,

Sure, will do. I assume you mean battery/next-next since it applies cleanly
to battery/master.

Thanks,
Guenter
