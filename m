From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: ASUS PU551LD, fan stuck at full speed after waking up from S3
Date: Sat, 30 May 2015 14:14:06 +0200
Message-ID: <4235637.TmQrMxa1o1@vostro.rjw.lan>
References: <1949840.6Csghk90X0@sakuya>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1949840.6Csghk90X0@sakuya>
Sender: linux-acpi-owner@vger.kernel.org
To: Martin Herkt <lachs0r@srsfckn.biz>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, May 29, 2015 01:51:57 PM Martin Herkt wrote:
> My ASUS PU551LD laptop has a problem with its fan state when resuming from S3. 
> In particular, the fan goes to full speed a second or two after waking up and 
> cannot be reset without turning off the laptop. For example, rebooting to 
> Windows and doing a suspend/resume cycle while the fan is in bad state will 
> not reset it. I have observed this behavior with all kernel versions I have 
> used on this laptop (oldest being 3.16, newest 4.1-rc5).
> 
> sensors(1) does not show any fans, but asus-nb-wmi exposes 
> /sys/class/hwmon/hwmon2/pwm1, which shows values like 85 during normal 
> operation but goes to the expected 255 when the fan is running at full speed 
> after waking up from S3.

Can you please check if applying the patch at

https://patchwork.kernel.org/patch/6451241/

on top of 4.1-rc5 makes any difference?


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
