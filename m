From: "Francis Moreau" <francis.moro@gmail.com>
Subject: Question about pm and tty
Date: Fri, 6 Jul 2007 10:05:38 +0200
Message-ID: <38b2ab8a0707060105o722c1460lcb422d7899ace53a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763313AbXGFIGQ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi,

I've just finished to implement an input driver for a simple custom
keyboard (only 16 keys).

I wanted to give it a test through a virtual terminal (CONFIG_VT).
Note that I'm not familiar with this at all so pardon me if I'm saying
something silly.

I noticed that as soon as the terminal is initialized, tty_init() is
called, the input device is open and thus its clock is started. It
sounds strange to me, I would have thought that the input device is
open only when /dev/tty is open. Thus the keyboard clock is started
when the keyboard is really used.

Am I missing something ?

Thanks
-- 
Francis
