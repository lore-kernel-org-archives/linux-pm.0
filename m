From: Bojan Smojver <bojan@rexursive.com>
Subject: Re: [PATCH] PM / Hibernate: Improve performance of
 LZO/plain hibernation, checksum image
Date: Thu, 29 Dec 2011 13:58:51 +1100
Message-ID: <1325127531.2029.13.camel@shrek.rexursive.com>
References: <CAGsJ_4yXU62GZ38fe7TCH8uKLHJvZ8jtFbJLywqv1kgC7y9V_A@mail.gmail.com>
	<1325115628.2029.1.camel@shrek.rexursive.com>
	<CAGsJ_4xH-9MXq8UJJFLW=upBqK+PXbWfDJhttBN=n2_M0PzMSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAGsJ_4xH-9MXq8UJJFLW=upBqK+PXbWfDJhttBN=n2_M0PzMSw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Barry Song <21cnbao@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, DL-SHA-WorkGroupLinux <workgroup.linux@csr.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2011-12-29 at 10:37 +0800, Barry Song wrote:
> i mean we can load image and decompress them in different threads when
> we reboot from hibernation. after i read codes more carefully, that
> has actually been done by lzo_decompress_threadfn().

Correct. Both hibernation and thaw are multi-threaded.

> here the problem is we didn't seem to get any faster after applying
> your compression patch when doing hibernation on SD/NAND.
> we are trying to figure out the reason.

This may depend on many factors:

- how much CPU power you have
- how many CPUs you have
- how much I/O can your disk do

Remember, there is one thread that does CRC32 as well and other threads
will have to sync with that thread.

Anyhow, it would be interesting to know where the bottleneck is on your
particular system. If you system has lots of CPU power and fast I/O, the
patch indeed may not do anything at all.

PS. I did my testing on a ThinkPad T510 laptop. It has a Core i5 M520
2.4 GHz mobile CPU (this appears to the system as 4 CPUs - it's two
physical cores with hyper-threading enabled). The disk is classic
platter based disk (Seagate ST9500420AS). There is 8 GB of RAM on this
system.

-- 
Bojan
