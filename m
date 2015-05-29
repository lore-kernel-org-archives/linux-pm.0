From: Martin Herkt <lachs0r@srsfckn.biz>
Subject: ASUS PU551LD, fan stuck at full speed after waking up from S3
Date: Fri, 29 May 2015 13:51:57 +0200
Message-ID: <1949840.6Csghk90X0@sakuya>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, acpi4asus-user@lists.sourceforge.net, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

My ASUS PU551LD laptop has a problem with its fan state when resuming from S3. 
In particular, the fan goes to full speed a second or two after waking up and 
cannot be reset without turning off the laptop. For example, rebooting to 
Windows and doing a suspend/resume cycle while the fan is in bad state will 
not reset it. I have observed this behavior with all kernel versions I have 
used on this laptop (oldest being 3.16, newest 4.1-rc5).

sensors(1) does not show any fans, but asus-nb-wmi exposes 
/sys/class/hwmon/hwmon2/pwm1, which shows values like 85 during normal 
operation but goes to the expected 255 when the fan is running at full speed 
after waking up from S3.

acpidump output: https://0x0.st/9Z.out

Not being a kernel dev (but knowing C), what can I do to help fix this issue?
