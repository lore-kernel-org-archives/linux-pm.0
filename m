From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: hwsusp defunct
Date: Fri, 09 Feb 2007 13:25:57 +0100
Message-ID: <45CC6855.90501@gmail.com>
References: <45C5DBBA.20502@gmail.com> <200702041452.28874.rjw@sisk.pl> <45C86405.1070902@gmail.com> <200702061855.49077.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1946407AbXBIMZz@vger.kernel.org>
In-Reply-To: <200702061855.49077.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Jiri Slaby <jirislaby@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki napsal(a):
> On Tuesday, 6 February 2007 12:18, Jiri Slaby wrote:
>> running) -- how to debug both of this? Do not suspend consoles? PM_TRACE (this 
>> won't help since it completely resumes, I guess)?
> 
> First, you can try s2ram if you haven't done it already (http://en.opensuse.org/s2ram).
> It may help to get your video back after the resume.

Yes. s2ram -a 1 with minimal -mm does the job perfectly. Now, I'm going to 
involve the rest of modules world.

> If you have a COM port, it is also possible to use a serial console throughout the
> suspend/resume cycle.

Only monitor didn't go up -- dmesg was able to be grabbed without monitor :).

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
