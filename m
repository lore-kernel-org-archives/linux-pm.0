From: david singleton <dsingleton@mvista.com>
Subject: Re: PowerOp Design and working patch
Date: Fri, 28 Jul 2006 17:26:34 -0700
Message-ID: <f86e151863675b397a533c61c0b030f1@mvista.com>
References: <242d827d33807b6b46608a26ed29c273@mvista.com>
	<20060728233837.GG2140@kroah.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060728233837.GG2140@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Singleton <daviado@gmail.com>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


On Jul 28, 2006, at 4:38 PM, Greg KH wrote:

> On Fri, Jul 28, 2006 at 03:31:41PM -0700, david singleton wrote:
>> Here is a patch that implements a version of the PowerOp concept.
>
> Any chance of breaking this up into logical patches that do one thing =

> at
> a time so it can be reviewed better?

Sure.  It was so small I just put them all together:

linux-2.6.17> quilt files
kernel/power/main.c
include/linux/pm.h
kernel/power/power.h
Makefile
arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
drivers/cpufreq/cpufreq.c
include/linux/cpufreq.h
Documentation/power/powerop.txt


I'll make a core patch and an x86-centrino patch.

David
>
> thanks,
>
> greg k-h
