From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: x60 backlight Re: [discuss] 2.6.19-rc1: known regressions (v2)
Date: Sun, 08 Oct 2006 16:44:37 -0700
Message-ID: <45298D65.8090503@goop.org>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <20061007214620.GB8810@stusta.de> <20061008071254.GA5672@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20061008071254.GA5672@ucw.cz>
Sender: linux-acpi-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: Adrian Bunk <bunk@stusta.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, len.brown@intel.com, linux-acpi@vger.kernel.org, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> Strange, problem went away after reboot. I guess I'll write it off as
> an acpi glitch... there's definitely something strange going on with
> backlight around s2ram: during normal operation, backlight changes are
> fast. After s2ram, backlight change from keyboard takes 300msec or so.
>   

Yes, I'm seeing that too.  It's not just keyboard brightness changes; 
gnome does some fadeup effect, which takes ~300ms/step as well.

    J

