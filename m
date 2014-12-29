From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 6/8] hwmon: thermal: Extract __set_pwm() function to
 only modify PWM duty cycle
Date: Mon, 29 Dec 2014 04:52:45 -0800
Message-ID: <20141229125245.GB18083@roeck-us.net>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-7-git-send-email-l.majewski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1419265668-32283-7-git-send-email-l.majewski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Lukasz Majewski <l.majewski@samsung.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Mon, Dec 22, 2014 at 05:27:46PM +0100, Lukasz Majewski wrote:
> It was necessary to decouple code handling writing to sysfs from the one
> responsible for setting PWM of the fan.
> Due to that, new __set_pwm() method was extracted, which is responsible for
> only setting new PWM duty cycle.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---

Please provide the affected subsystem and the affected driver in the header.
While it may make sense to explain that the patch is to prepare the driver for
thermal use, this should be part of the descriptive text. The patch is,
however, not not a thermal subsystem related patch. The 'thermal:' in the
headline is thus misleading, and you should drop it.

Guenter
