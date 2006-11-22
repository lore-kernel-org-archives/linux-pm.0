From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: 2.6.19-rc5-mm2: suspend related BLOCK=n compile error
Date: Tue, 21 Nov 2006 19:34:54 -0800
Message-ID: <20061121193454.728e1bbd.randy.dunlap@oracle.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	<20061122032341.GV5200@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20061122032341.GV5200@stusta.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, 22 Nov 2006 04:23:41 +0100 Adrian Bunk wrote:

> swsusp-freeze-filesystems-during-suspend-rev-2.patch causes the =

> following compile error with CONFIG_BLOCK=3Dn:
> =

> <--  snip  -->
> =

> ...
>   CC      kernel/power/process.o
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: =
In function 'freeze_processes':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:1=
24: error: implicit declaration of function 'freeze_filesystems'
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c: =
In function 'thaw_processes':
> /home/bunk/linux/kernel-2.6/linux-2.6.19-rc5-mm2/kernel/power/process.c:1=
89: error: implicit declaration of function 'thaw_filesystems'
> make[3]: *** [kernel/power/process.o] Error 1

Yes, I sent a patch for that, but Pavel said that they will be
removing/dropping that code anyway.

---
~Randy
