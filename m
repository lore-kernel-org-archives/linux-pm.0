From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc5-mm2: suspend related BLOCK=n compile error
Date: Wed, 22 Nov 2006 12:20:55 +0100
Message-ID: <200611221220.56618.rjw@sisk.pl>
References: <20061114014125.dd315fff.akpm@osdl.org> <20061122032341.GV5200@stusta.de> <20061121193454.728e1bbd.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750991AbWKVLYn@vger.kernel.org>
In-Reply-To: <20061121193454.728e1bbd.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, Nigel Cunningham <nigel@suspend2.net>, pavel@suse.cz, linux-pm@osdl.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, 22 November 2006 04:34, Randy Dunlap wrote:
> On Wed, 22 Nov 2006 04:23:41 +0100 Adrian Bunk wrote:
> 
> > swsusp-freeze-filesystems-during-suspend-rev-2.patch causes the 
> > following compile error with CONFIG_BLOCK=n:
> > 
> > <--  snip  -->
> > 
> > ...
> >   CC      kernel/power/process.o
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'freeze_processes':
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:124: error: implicit declaration of function 'freeze_filesystems'
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: In function 'thaw_processes':
> > /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:189: error: implicit declaration of function 'thaw_filesystems'
> > make[3]: *** [kernel/power/process.o] Error 1
> 
> Yes, I sent a patch for that, but Pavel said that they will be
> removing/dropping that code anyway.

AFAICT, the swsusp-freeze-filesystems-during-suspend-rev-2.patch has been
dropped from -mm already.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
